# REST WebAPI サービス設計（基本）

## URIの設計

- 短く入力しやすい（冗長なパスを含まない）
- 人間が読んで理解できる（省略しない）
- 大文字小文字が混在しない（全て小文字）
- 単語はハイフンでつなげる
- 単語は複数形を利用する
- エンコードを必要とする文字を使わない
- サーバー側のアーキテクチャが反映されていない
- 改造しやすい（Hackable）
- ルールが統一されている

### 短く入力しやすい（冗長なパスを含まない）
シンプルで覚えやすいものにするこどで入力ミスを防ぐ

#### NG例)

```http
GET http://api.example.com/service/api/search

```

#### 改善例)

```http
GET http://api.example.com/search

```

### 人間が読んで理解できる（省略しない）

国や文化が変わっても普遍な表記にすることで誤認識を防ぐ


#### NG例)

```http
GET https://api.expample.com/sv/u
```

#### 改善例)

```http
GET https://api.expample.com/users

```


### 大文字小文字が混在しない（全て小文字）

APIをわかりやすく、間違いにくくするためには統一が必要


#### NG例)

```http
GET https://api.expample.com/Users
```

#### 改善例)

```http
GET https://api.expample.com/users

```


### 単語はハイフンでつなげる

アンダースコアはタイプライターで下線を引くためのもの。ハイフンは単語を繋ぐためのもの

#### NG例)

```http
GET https://api.expample.com/popular_users
```

#### 改善例)

```http
GET https://api.expample.com/popular-users
```


```http
GET https://api.expample.com/users/popular
```


### 単語は複数形を利用する

URIで表現しているのは「リソースの集合」

#### NG例)

```http
GET https://api.expample.com/user/1000
```

#### 改善例)

```http
GET https://api.expample.com/users/1000
```




### エンコードを必要とする文字を使わない

URIから意味が理解できない

#### NG例)

```http
GET https://api.expample.com/%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC
```

#### 改善例)

```http
GET https://api.expample.com/users
```


### サーバー側のアーキテクチャが反映されていない

悪意あるユーザに脆弱性をつかれる危険を回避する

#### NG例)

```http
GET https://api.expample.com/cgi-bin/get_user.php?id=12345
```

#### 改善例)

```http
GET https://api.expample.com/users/12345
```


### 改造しやすい（Hackable）

システム依存の設計は意味が理解できない

#### NG例)

```http
GET https://api.expample.com/items/alpha/12345
```
```http
GET https://api.expample.com/items/beta/12345
```

#### 改善例)

```http
GET https://api.expample.com/items/12345
```

### ルールが統一されている

一定のルールに従って、設計することで間違いを防ぐ

#### NG例)

- 友達情報取得
```http
GET https://api.expample.com/friends?id=12345
```
- メッセージ投稿
```http
GET https://api.expample.com/friends/12345/message
```

#### 改善例)

- 友達情報取得
```http
GET https://api.expample.com/friends/12345
```
- メッセージ投稿
```http
GET https://api.expample.com/friends/12345/message
```


## HTTPメソッドの適用

### HTTPメソッドとURI

URIがリソースを示すのに対し、
HTTPメソッドはリソースに対する操作を示す


#### 例) ユーザ情報を取得

```http
GET /v1/users/123 HTTP/1.1
host: api.example/com

```

### HTTP/1.1 メソッド（主要なもの）

メソッドの復習

|メソッド|説明|
|---|---|
|GET|リソースの取得|
|POST|リソースの新規登録|
|PUT|リソースの更新／リソースの新規登録|
|DELETE|リソースの削除|


### URI と HTTPメソッドの組み合わせ例

|操作|API実装例|
|---|---|
|ユーザー情報一覧を取得する|GET  http://api.expamle.com/users|
|ユーザーの新規登録|POST  http://api.expamle.com/users|
|特定ユーザーの所得|GET http://api.expamle.com/users/12345|
|ユーザーの更新|PUT http://api.expamle.com/users/12345|
|ユーザーの削除|DELETE http://api.expamle.com/users/12345|


## クエリとパスの使い分け

### リソースを特定するパラメータ
絞り込み方法（パラメータ指定）には2種類ある

|種類|概要|具体例|
|---|---|---|
|クエリパラメータ|URLの末尾にある「?」に続くキーバリュー|GET http://api.example.com/users?page=3|
|パスパラメータ|URL中に埋め込まれるパラメータ|GET http://api.example.com/users/123|

### クエリパラメータを採用するかどうかの判断基準

- 一意なリソースを表すのに必要かどうか  
=> パスパラメータを利用
- 省略可能かどうか  
=> クエリパラメータを利用

#### 例) 検索条件（絞り込み条件）はパスに含めない

検索条件の指定パラメータが複数あったり、その内で使わないパラメータは省略可能にしたい場合など

```http
GET http://api.example.com/users?name=tanaka

```

## ステータスコード

処理結果の概要を把握する

### ステータスコードの分類

ステータスコード

|ステータスコード|概要|
|---|---|
|100番台|情報|
|200番台|成功|
|300番台|リダイレクト|
|400番台|クライアントサイドに起因するエラー|
|500番台|サーバーサイドに起因するエラー|


### 1xx : 情報

|ステータスコード|種類|説明|
|---|---|---|
|100|Continue|サーバーがリクエストの最初の部分を受け取り、まだサーバーから拒否されていないことを示す|
|101|Switching Protocol|プロトコルの切り替え要求を示す|


### 2xx : 成功

|ステータスコード|種類|説明|
|---|---|---|
|200|OK|リクエストが成功したことを示す。<br>本文にデータが含まれる|
|201|Created|リクエストが成功し、新しいリソースが作成されたことを示す。<br>ヘッダーのLocationに新しいリソースへのURLを含める|
|202|Accepted|非同期ジョブを受け付けたことを示す。<br>実際の処理結果は別途受け取る|
|204|No Content|リクエストは成功したが、レスポンスデータがないことを示す。<br>クライアント側のビューを変更する必要がないことを意味する。|



### 3xx : リダイレクト

API利用者はリダイレクトを実装していないことが多いので、  
*REST APIでは300番台は利用しない*

|ステータスコード|種類|説明|
|---|---|---|
|300|Multiple Choices|リクエストに対して複数のレスポンスがあることを示す<br>選択肢へリンクするHTMLが提示され、ユーザーエージェントやユーザーはそれらからひとつを選択する|
|301|Moved Permanently|リクエストされたリソースのURLが恒久的に移動されたことを示す<br>レスポンスヘッダーにLocationを設定する|
|302|Found|リクエストされたリソースのURLが一時的に変更されたことを示す<br>Locationに移動先のURLを設定する|
|303|See Other|リクエストされたリソースを別のURIで取得できることを示す<br>Locationヘッダに移動先のURLが示されGETメソッドで取得が可能であることを示す|
|304|Not Modified|リクエストされたリソースを再送する必要がないことを示します。更新されていないことを示します。|
|307|Temporary Redirect|一時的リダイレクトで、Locationヘッダに移動先のURLが示される。ユーザーエージェントは使用するHTTPメソッドを変更してはならない|
|308|Permanent Redirect|恒久的リダイレクトで、Locationヘッダに移動先のURLが示される。ユーザーエージェントは使用するHTTPメソッドを変更してはならない|

### 4xx : クライアントサイドに起因するエラー

|ステータスコード|種類|説明|
|---|---|---|
|400|Bad Request|その他エラー|
|401|Unauthorized|認証されていない|
|403|Forbidden|リソースに対するアクセス許可がされていない。<br>リソースの存在を隠したい場合など、403で返えざすに404で返す方法がある|
|404|Not Found|リクエストされたリソースが存在しない|
|409|Conflict|リソースが競合して処理が完了できなかったことを示す|
|429|Too Many Requests|アクセス回数が制限回数を超えたため処理できなかったことを示す|


### 5xx : サーバーサイドに起因するエラー

|ステータスコード|種類|説明|
|---|---|---|
|500|Internal Server Error|サーバ側に何らかの異常が発生し正常なレスポンスが返せない<br>サーバーサイドのアプリケーションエラーが発生したことを示す|
|503|Service Unavailable|サービスが一時的に利用できないことを示す。<br>メンテナンス期間や負荷で対応できないケース|

## HTTPメソッドとステータスコード

|ステータスコード|GET|POST|PUT|DELETE|
|---|:---:|:---:|:---:|:---:|
|200 OK|○|○|○|○|
|201 Created||○|○||
|202 Accepted||○|○|○|
|204 No Content|||○|○|
|304 Not Modified|○||||
|400 Bat Request|○|○|○|○|
|401 Unauthorized|○|○|○|○|
|403 Forbidden|○|○|○|○|
|404 Not Found|○||○|○|
|409 Conflict||○|○||
|429 Too Many Requests|○|○|○|○|
|500 Internal Server Error|○|○|○|○|
|503 Service unavailable|○|○|○|○|

### GET

データ取得

#### 成功
- `200 OK`: リソース取得成功
- `304 Not Modified`: 変更がないことを伝え、キャッシュを利用

#### 失敗
- `400 Bat Request`: クライアント側のリクエスト不備 
- `401 Unauthorized`: 認証エラー (リクエストが誰のものか確認できていない未認証の状態) 
- `403 Forbidden`: 許可エラー （リクエストが誰のものか確認できているが、アクセス権などがない）
- `404 Not Found`: 該当データなし
- `429 Too Many Requests`: レートリミット制限を超えた場合
- `500 Internal Server Error`: サーバー側でエラーが発生したケース
- `503 Service unavailable`: 高負荷で対応不可

### POST

データ登録

#### 成功
- `200 OK`: データ登録に成功し、レスポンスに登録済みデータを含み返却する
- `201 Created`: レスポンスボディーが空で、Locationに新しいリソースへのURLを記載し返却する
- `202 Accepted`: 非同期処理の受付が完了

#### 失敗
- `400 Bat Request`: クライアント側のリクエスト不備 
- `401 Unauthorized`: 認証エラー (リクエストが誰のものか確認できていない未認証の状態) 
- `403 Forbidden`: 許可エラー （リクエストが誰のものか確認できているが、アクセス権などがない）
- `409 Conflict`: データが衝突（複数端末から同時に同じ場所に更新されるケースが想定される場合がある）
- `429 Too Many Requests`: レートリミット制限を超えた場合
- `500 Internal Server Error`: サーバー側でエラーが発生したケース
- `503 Service unavailable`: 高負荷で対応不可


### PUT
データ更新／データ登録

#### 成功

- `200 OK`: データ登録に成功し、レスポンスに登録済みデータを含み返却する
- `201 Created`: データ登録でレスポンスボディーが空で、Locationに新しいリソースへのURLを記載し返却する
- `204 No Content`: データ更新で、レスポンスボディーは空（クライアント側で画面変更する必要がないなどデータを返さない、もしくはデータ更新内容が同じ）

#### 失敗
- `400 Bat Request`: クライアント側のリクエスト不備 
- `401 Unauthorized`: 認証エラー (リクエストが誰のものか確認できていない未認証の状態) 
- `403 Forbidden`: 許可エラー （リクエストが誰のものか確認できているが、アクセス権などがない）
- `404 Not Found`: データ更新時に、該当データなし
- `409 Conflict`: データ登録時、データが衝突（複数端末から同時に同じ場所に更新されるケースが想定される場合がある）
- `429 Too Many Requests`: レートリミット制限を超えた場合
- `500 Internal Server Error`: サーバー側でエラーが発生したケース
- `503 Service unavailable`: 高負荷で対応不可


### DELETE
データ削除

#### 成功
- `200 OK`: データ削除成功（削除の場合は、レスポンスにデータを含めないのが通常なので、あまり利用するケースはない）
- `202 Accepted`: 非同期処理の受付が完了
- `204 No Content`: 削除成功（できるだけ200ではなくこちらを返す。ボディにデータは含めない）

#### 失敗
- `400 Bat Request`: クライアント側のリクエスト不備 
- `401 Unauthorized`: 認証エラー (リクエストが誰のものか確認できていない未認証の状態) 
- `403 Forbidden`: 許可エラー （リクエストが誰のものか確認できているが、アクセス権などがない）
- `404 Not Found`: 該当データなし（403を隠したいときに返却するケース）
- `429 Too Many Requests`: レートリミット制限を超えた場合
- `500 Internal Server Error`: サーバー側でエラーが発生したケース
- `503 Service unavailable`: 高負荷で対応不可




## データフォーマット

### 主要なデータフォーマット

|フォーマット|サンプル|
|---|---|
|XML|`<user><name>tanaka</name></user>`|
|JSON|`{ user : { name: "tanaka"}}`|
|JSONP|`callback({user: {name: "tanaka"}})`|


### XML

#### サンプル

```http
Content-Type: application/xml

```

```xml
<user>
  <name lang="ja">
    <first>tasuyahi</first>
    <last>tanaka</last>
  </name>
  <dob>1994/03/30</dob>
</user>

```

#### 特徴
- テキスト形式
- タグで記述
- タグは入れ子にできる
- タグに属性が付けられる

### JSON
#### サンプル

```http
Content-Type: application/json

```

```json
{
	name: {
		first: "tsuyoshi",
		last: "tanaka"
	},
	dob: "1994/03/30"
}
```

#### 特徴
- テキスト形式
- JavaScriptを元にしたフォーマット
- XMLに比べてデータ量が減らせる
- オブジェクトは入れ子にできる


### JSONP

#### サンプル

```http
Content-Type: application/javascript

```

```javascript
callback({
	name: {
		first: "tsuyoshi",
		last: "tanaka"
	},
	dob: "1994/03/30"
});
```

#### 特徴
- テキスト形式
- データフォーマットのように見えるが、JavaScriptのコード
- クロスドメインでデータを受け渡すことができる

### データフォーマットの指定方法

|フォーマット|サンプル|
|---|---|
|クエリパラメータ|`http://api.sample.com/v1/users?format=json`|
|拡張子|`http://api.sample.com/v1/users.json`|
|リクエストヘッダー|`GET http:// api.sample.com/v1/users`<br>`Host: api.sample.com`<br>`Accept: application/json`|


## データの内部構造

### エンベロープは使わない

エンベロープとはレスポンスボディ内のメタ情報で、ヘッダー情報と役割が被るので無駄が生じる。
そのため、エンベロープは使わないようにする。

#### NG例

```http
HTTP/1.1 200 OK
Content-Type: text/html
...省略...
{
	"header": {
		"status": "success",
		"erorCode": 0,
	},
	"response": {
		name: "Tanaka Tsuyoshi"
	}
}

```

#### 改善例
```http
HTTP/1.1 200 OK
Content-Type: text/html
...省略...
{
	name: "Tanaka Tsuyoshi"
}
```

### オブジェクトはできるだけフラットにする

JSONはネストが可能です。ですが、レスポンス容量を減らすためにできるだけフラットな状態で利用する

#### NG例

```json
{
	"id": "12345",
	"name": "Tsuyoshi Tanaka",
	"profile": {
		"birthday": "3/23",
		"gender": "male"
	}
}
```

#### 改善例

```json
{
	"id": "12345",
	"name": "Tsuyoshi Tanaka",
	"birthday": "3/23",
	"gender": "male"
}
```
### ページネーションをサポートする情報を返す

情報更新される可能性があるため、ページネーションをサポートする情報を返す必要がある

#### NG例

```json
{
	"users": [
		{
			"id": "12345",
			"name": "Tsuyoshi Tanaka"
		},
		...
	],
	"nextPage": 1
}
```

#### 改善例

```json
{
	"users": [
		{
			"id": "12345",
			"name": "Tsuyoshi Tanaka"
		},
		...
	],
	"hasNext": true,
	"nextPageToken": "FqTt82Cp"
}
```

### プロパティの命令規則はAPI全体で統一する

利用者が混乱しないように、命名規則は統一する

|種類|サンプル|
|---|---|
|スネークケース|snake_case|
|キャメルケース|camelCase|
|パスカルケース|PascalCase|



### 日付はRFC3339（W3C-DTF）形式を使う

日付は、インターネットで標準的に使われているRFC3339を利用する

#### NG例

|種類|サンプル|
|---|---|
|RFC822(RFC1123)| Thu, 29 Mar 2018 08:00:00 GMT|
|RFC850|Thursday, 29-Nar-2018 08:00:00: GMT|
|Unixタイムスタンプ|1521781500|


#### 改善例

|種類|サンプル|
|---|---|
|RFC3339| 2018-03-29T17:00:00:+09:00|


### 大きな数値（64bit整数）は文字列で返す

JavaScriptで扱える演算可能最大整数は(2**53-1) 9,007,188,254,740,991でまであるため、通常の整数は32bitで整数で返し、64bit整数は文字列で返します。
[Number.MAX_SAFE_INTEGER](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Number/MAX_SAFE_INTEGER)

#### NG例

```json
{
	"val": 123456789012345678
}
```

#### 改善例
```json
{
	"val_str": "123456789012345678"
}
```

## エラー表現

### エラー詳細はレスポンスボディに入れる
足りない情報はレスポンスボディに追加する

#### NG例

```http
HTTP/1.1 400 Bad Request
Server: api.example.com
Data: Sat, 28 Mar 2020 01:57:25 GMT
Content-Type: application/json
Content-Length: 0

```

#### 改善例
```http
HTTP/1.1 400 Bad Request
Server: api.example.com
Data: Sat, 28 Mar 2020 01:57:25 GMT
Content-Type: application/json
Content-Length: 77

{
	"code": "1234567890",
	"message": "不正な検索条件です。"
}

```

### エラーの際にHTMLが返らないようにする

APIからのレスポンスは通常JSON形式です。HTMLを返却してはいけません。レスポンス形式が変化してしまうことは避けましょう。

#### NG例

```http
HTTP/1.1 404 Not Found
Server: api.example.com
Data: Sat, 28 Mar 2020 01:57:25 GMT
Content-Type: text/html
Content-Length: 17707

<!DOCTYPE html>
<html lang="ja">
<head>
....
```

#### 改善例
```http
HTTP/1.1 404 Not Found
Server: api.example.com
Data: Sat, 28 Mar 2020 01:57:25 GMT
Content-Type: application/json
Content-Length: 74

{
	"code": "1234567890",
	"message": "リソースが存在しません"
}

....
```

### サービス閉塞時は「503」+「Rety-After」 

サービス閉塞時には、`404 Not Found`を返すと、クライアントからみていつ再開したら良いか確認できないため、`503 Service Temporary`を返し、レスポンスヘッダーにて`Retry-After`を指定しましょう。

#### NG例

```http
HTTP/1.1 404 Not Found
Server: api.example.com
Data: Sat, 28 Mar 2020 01:57:25 GMT
Content-Type: text/html
Content-Length: 17707

<!DOCTYPE html>
<html lang="ja">
<head>
....
```

#### 改善例
```http
HTTP/1.1 503 Service Temporary
Server: api.example.com
Data: Sat, 28 Mar 2020 01:57:25 GMT
Content-Type: application/json
Content-Length: 74
Retry-After: Mon, 6 Apr 2020 01:00:00 GMT

{
	"code": "1234567890",
	"message": "サービス利用できません"
}

```
