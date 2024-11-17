# REST WebAPI　サービス設計（応用）

## APIバージョンの表現

### APIバージョンを含めるかどうか

- メリット:  
特定のバージョン指定でアクセスできるので、クライアント側で突然エラーにはならない
- デメリット:  
複数のバージョンを並列稼働させるため、ソースコードやデータベースの管理が複雑になる

広く世間一般に公開するようなサービスを展開するのであれば、利用者の利便性を考慮してAPIバージョンを含めたURLの設計を行う。

### バージョンを入れる場所

- パス:  
```http
http://api.example.com/v1/users/
```
- クエリ:  
```http
http://api.example.com/users?version=1
```

- ヘッダー:(非推奨)  
```http
GET http://api.example.com/users
X-Api-Version: 1
```

### バージョンの付け方

APIは後方互換しなくなったタイミングでバージョンをつけるのがおすすめ。  
つまり、メジャーバージョンのみを利用

#### セマンティックバージョニング
```
メジャー.マイナー.パッチ
```

|位置|ルール|
|---|---|
|メジャー|後方互換しない修正|
|マイナー|後方互換する機能追加|
|パッチ|後方互換するバグ修正|

#### サンプル

```
1.2.3

```


## OAuth と OpenID Connect

### 認証と認可

- 認証: 「本人を特定」すること
- 認可: 「アクセス制御」すること

### OAuth と OpenID Connect の違い

OAuthもOpenIDも認可の仕組みなので「アクセス制御の仕組み」

- OAuth = 認可するためのプロトコル (ただし、アプリやシステムが認可するのではなく、ユーザがアプリやシステムに認可するためもの)
- OpenID = OAuth(認可)  + 本人情報取得

### OAuth

### Authorization Code
OAuthにはいくつかフローがあるが最もオースドックスなフローとして、`Authorization Code`があります。

![Authorization Code](../images/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f3130363034342f64393131396632312d373336642d643565642d393634642d3330363861663066636465392e706e67.png)



### OpenID Connect


///


## JSON Web Token (JWT)

### 特徴
- 署名による改ざんチェック
- URL-safeなデータ
- データの中身はJSON形式

### 用語
- 認証結果をサーバサイドで保存せずに、クライアントサイドで保存（ステートレスな通信の実現）

### 基本構造

```
base64UrlEncode(ヘッダー).base64UrlEncode(ペイロード).base64UrlEncode(署名)

```

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.t42p4AHef69Tyyi88U6+p0utZYYrg7mmCGhoAd7Zffs
```

### ヘッダー

署名で利用するアルゴリズムなどを定義

```json
{
	"typ": "JWT",
	"alg": "ES256"
}

```

|項目|名称|概要|
|---|---|---|
|"typ"|Type| "JWT" 固定|
|"alg"|Algorithm|HS256: HMAC using SHA-256<br>RS256: RASASSA-PKCS1-V1 using SHA-256<br>ECDSA using P-256 and SHA-256<br>none: 暗号なし|


### ペイロード

保存したいデータの実態

```json
{
	"sub": "1234567890",
	"name": "John Doe",
	"iat": 1516239022
}

```

#### 予約済みクレーム

|項目|名称|概要|
|---|---|---|
|"iss"|Issuer|「JWTを発行」しているサービス、システムの識別子|
|"sub"|Subject|同一Issuer内での識別子（該当サービスにおけるユーザIDなど）|
|"aud"|Audience|「JWTを利用」しているサービス、システムの識別子|
|"exp"|Expiration Time|JWTの有効期限|
|"jti"|JWT ID|JWTの再利用を防ぐために利用する一意識別子|

### 署名

改竄されていないか確認するための署名

```json
ALGORITHM(
	base64UrlEncode(ヘッダー).base64UrlEncode(ペイロード),
	SECRET
)
```

|項目|概要|
|---|---|
|ALGORITHM|ヘッダーの"alg"に指定したアルゴリズム|
|SECRET|アルゴリズムに合わせた鍵（秘密鍵or共通鍵）|


[JWT Debugger](https://jwt.io)

## 大量アクセス対策

WebアプリをAPI化することで、簡単に大量アクセスするプログラムが描けるようになる。意図しないプログラマの不注意で大量アクセスが発生する懸念がある。

### レートリミット

時間あたりのアクセス制限を設ける

### レートリミットで考慮すること

|観点|設定例|
|---|---|
|誰に対して|APIキー、ユーザID|
|何に対して|単一機能、機能群、API全体...|
|制限回数|10回、100回、1000回...|
|単位時間|10分、1時間、1日...|


### レートリミットアルゴリズム
- Fixed Window
- Sliging Log
- Sliding Window


#### Fixed Window

例）
30回/10分のレートリミットの場合

10分間に30回以上のアクセスは拒否されるが、次の10分からはカウントが0になり新たにアクセスが可能

##### 問題点: 
切り替わる時間の前後の数分以内に30回x2などのアクセスが可能

#### Sliging Log
例）
30回/10分のレートリミットの場合

過去10分間のログを取得して確認する


##### 問題点: 
過去ログを大量に保存する必要がある

#### Sliding Window

例）
30回/10分のレートリミットの場合


### アクセス制御の緩和処置

- サービス利用が多く、自社にとって優良顧客である場合
- キャンペーンなど、一時的に負荷増大がある場合

## キャッシュ制御

### キャッシュ制御に利用するヘッダー

|分類|ヘッダー|
|:---:|---|
|有効期限による制御|Expires|
|〃|Cache-Control + Date|
|検証による制御|Last-Modified + ETag|

### Expiresヘッダー

```http
Expires: Sun, 03 May 2020 12:30:00: GMT

```

- キャッシュとしていつまで利用可能かの期限を指定
- 過去日を指定すると「リソースが有効期限切れ」であることを意味する
- Cache-Controlヘッダーが同時に指定された場合は無視される


### Cache-Control + Date ヘッダー

```http
Cache-Control: public, max-age=604800
Date: Sun, 03 May 2020 12:30:00: GMT

```

- Cache-Controlでキャッシュの「可否」と「期限」を指定する
    - キャッシュ可否
        - `public` : 通信経路上のどこでも保存できる
        - `private` : クライアント端末のみ保存できる
        - `no-cache` : クライアントに保存されるが、必ず有効性の確認が必要
        - `no-store` : 保存不可
    - キャッシュ期限
        - `max-age=`<秒> : 新しいとみなせる時間（秒）

#### Last-Modified + ETag

```http
Last-Modified: Sun, 03 May 2020 12:30:00: GMT
ETag: "33a64df551425fcc55e4d42a148795d9f25f89d4"

```

- Last-Modifiedにリソースの最終更新日時を指定
- ETagに特定バージョンを示す文字列を指定
    - コンテンツのハッシュ
    - バージョン番号
    - 最終更新日時のハッシュ
    - etc...

### キャッシュさせる単位

```http
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 212
Cache-Control: public
Content-Language: ja
Date: Sun, 03 May 2020 13:29:56 GMT
Server: api.expample.com
Vary: Content-Language
......
...

```

`Vary`でキャッシュさせる単位（例の場合は言語単位）を指定する



## セキュリティ

### APIはどこから呼ばれるのか

APIにもWebサービスと同じセキュリティ対策が必要

#### 呼び出し元

- スマフォアプリ
- Webページ
    - scriptタグ
    - JavaScript
- 外部システム（バッチ）


### 代表的な脆弱性対策

- XSS
- CSRF
- HTTP
- JSON Web Token


#### XSS

##### 脆弱性
悪意あるユーザが正規サイトに不正なスクリプトを挿入することで、正規ユーザの情報を不正に引き出したり操作できてしまう問題

##### 対策
- レスポンスヘッダーの追加  
`X-SS-Protection` : `1`でXSSフィルタリング有効化する  
`X-Frame-Options` : `DENY`でframeタグ呼び出しを拒否
`X-Content-Type-Options` : `nosniff`でIE脆弱性対応

#### CSRF

##### 脆弱性
本来拒否しなければいけないアクセス元（許可しないアクセス元）からくるリクエストを処理してしまう問題

##### 対策
- 許可しないアクセス元からのリクエスト拒否  
`X-API-Key` : システム単位で実行可否判断 （独自ヘッダー）
`Authentication` : ユーザー単位で実行可否判断
- 攻撃者に推測されにくいトークンの発行／照合処理を実装
- `X-CSRF-TKEN` : トークンを使って実行可否判断（独自ヘッダー）

#### HTTP

##### 脆弱性
通信経路が暗号化されていないので盗聴されてやすい

##### 対策

- 常時HTTPSを利用した通信にする

#### JSON Web Token

##### 脆弱性
クライアント側で内容の確認／編集が簡単にできるため、サーバー側の検証が不十分だと改竄された情報を正規として受け入れてしまう

##### 対策

- ヘッダーの`alg`に`none`以外を指定して、署名を暗号化する
```json
{
	"typ": JWT,
	"alg": "ES256"
}

```
- ペイロードの `aud`に想定する利用者を指定して受信時に検証する
```json
{
	"sub": "123456789",
	"name": "John Doe",
	"aud": "https://api.example.com/" 
}

```
