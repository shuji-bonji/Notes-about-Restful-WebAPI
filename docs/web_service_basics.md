# Webサービスの基本

## Web APIとは

### Webとは
HTTPなどのインターネット関連技術を利用してメッセージ送受信を行う「技術」、またはそれら技術を適用して展開された「サービス」

### APIとは
Appication Programming Interface

機能やデータを外部から呼び出して利用できるように定めた「規約」

### Web APIとは

HTTPなどのインターネット関連技術を利用して、「プログラムが読み書きしやすい」形でメッセージ送受信を行えるように定義した「規約」、または規約を実装して展開される「サービス」

## Webサイト、Webサービス、WebAPI


|名称|内容|
|---|---|
|Webサイト|静的コンテンツ。運営者からの情報提供が目的。ユーザはサイト内を巡回することで目的を果たす。|
|Webサービス|動的コンテンツ。ユーザが抱える課題を解決することが目的。ユーザはサービスに対して情報を溜め込む／引き出すといった操作を能動的に行うことで目的を果たす。|
|WebAPI|Webサービスで提供している機能やデータを外からプログラムが読み取りやすい形で利用できるように定めた規約またはその実装|

## HTTPリクエスト

### リクエスト内容

- リクエストライン
- ヘッダー
- ボディ

### リクエストライン

- メソッド
- url
- HTTPバージョン

```http
POST https://www.post.japanpost.jp/cgi-zip/zipcode.php HTTP/1.1

```

### HTTP リクエストメソッド

|メソッド|意味|
|---|---|
|OPTIONS|サーバ側が提供する機能の確認|
|GET|リソース取得|
|HEAD|リソースヘッダー（メタ情報）取得|
|POST|従属リソースの作成|
|PUT|新規リソースの作成、リソースの更新|
|DELETE|リソース削除|
|TRACE|通信経路の確認|
|CONNECT|プロキシのトンネル接続|

### CRUD

|操作|メソッド|
|---|---|
|Create(作成)|POST: リソース名が未定   <br>PUT: リソース名が決まっている|
|Read(読み取り)|GET|
|Update(更新)|PUT|
|Delete(削除)|DELETE|


## HTTP リクエストヘッダー
```http
POST /cgi-zip/zipcode.php HTTP/1.1
Host: www.post.japanpost.jp
Connection: keep-alive
Content-Length: 31
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
Origin: https://www.post.japanpost.jp
Content-Type: application/x-www-form-urlencoded
User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Sec-Fetch-Site: same-origin
Sec-Fetch-Mode: navigate
Sec-Fetch-User: ?1
Sec-Fetch-Dest: document
Referer: https://www.post.japanpost.jp/index.html
Accept-Encoding: gzip, deflate, br
Accept-Language: ja,en-US;q=0.9,en;q=0.8
Cookie: ac=16321905074330; __ulfpc=202109211115075674; _ga=GA1.2.1631501575.1632190508; _gid=GA1.2.1038014212.1632190508; _gat_gtag_UA_128949246_1=1

```

## HTTPボディ

```http
pref=13&addr=%E6%B8%AF%E5%8C%BA

```

## HTTPレスポンス

### レスポンスの内容

- ステータスライン
- ヘッダー
- ボディ

### ステータスライン

- HTTPバージョン
- ステータスコード
- フレーズ

```http
HTTP/1.1 200 OK

```

### ステータスコード

ステータスコードは大きく5種類

|ステータスコード|分類|内容|
|---|---|---|
|1xx|Infomational|リクエストは受け入れられたので処理を続行|
|2xx|Success|リクエストが受け入れられて正常処理された|
|3xx|Redirection|リクエスト完了のために追加操作が必要|
|4xx|Client Error|リクエストに誤りがある|
|5xx|Server Error|サーバ処理失敗|



### HTTPレスポンスヘッダー

```http
HTTP/1.1 200 OK
Date: Tue, 21 Sep 2021 02:15:37 GMT
Server: Apache
X-Frame-Options: SAMEORIGIN
X-Content-Type-Options: nosniff
Transfer-Encoding: chunked
Content-Type: text/html

```

### HTTPレスポンスボディ
```http
!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>東京都 港区の郵便番号 - 日本郵便</title>
<meta name="description" content="東京都 港区の郵便番号検索はこちらから。地図、住所から郵便番号を検索できます。">
<meta name="keywords" content="ゆうびん,日本郵便,郵便,町域別,一覧,住所変更,変更">
<!-- assets no-font no-swiper -->

<!-- ssi:analytics.inc -->

・・・・省略

```

## 安全性と冪等性

### 副作用
リソース（データ）が改変されること

- 副作用があるケース:  
データの更新
- 副作用がないケース:  
データの取得（厳密にはアクセスログが出力されるため、リソース変化はあるがデータの改変は行われない）

### 安全

副作用がないこと。リソースの状態を変化させない読み取り専用である。

- GET
- HEAD

### 冪等

何度実行しても同じ状態が再現される

- 副作用がある
    - PUT
    - DELETE
- 副作用がない
    - GET
    - HEAD

### 安全でも冪等でもない操作

- POST(登録)


### 

|メソッド|安全|冪等|
|---|---|---|
|GET| ○ | ○ |
|HEAD| ○ | ○ |
|POST| × | × |
|PUT| × | ○ |
|DELETE|  ×  |  ○  |
