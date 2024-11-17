# OpenAPI & Swwager 実践入門

## OpenAPI と Swagger

### OpenAPIとは

WSDLやXMLと比較されるような「フォーマット」を意味する。このフォーマットを使うと「機械可読なREST API仕様」が記述できる.
JSONまたはYAMLで記述する。

### OpenAPI Specification

OpenAPIを記述するための「書式ルール」

### Swagger

OpenAPIを作成、表示、利用するツール群

- Swagger Editor : OpenAPI自体を記述するためのエディッタ
- Swagger Codegen : Swagger Editorで作成されたOpenAPIを読み取って、スタブやクライアントソースを生成するツール
- Swagger UI : OpanAPI 仕様を読み取り、ビジュアライズ（仕様書を作成）するツール

### OpenAPIとSwaggerの歴史

- 2010年 :  
Swaggerの開発開始 => OpenAPIはSwaggerフレームワークの一部だった。  
元はSawgger Specificationという名前
- 2015年 :  
OpenAPI Initiative設立  
以降はOpenAPI Initiativeがメンテナンス
- 2016年 :  
GitHubで管理が移管
このタイミングで、OpanAPI Specificationに名称変更


## OpenAPI Specification

- [Swagger にある仕様書](https://swagger.io/specification/)
- [OpenAPI Initiativeにある仕様書](https://spec.openapis.org/oas/v3.0.3)
- [GitHubにある仕様書](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.0.3.md)


## Swagger Editor

### Swagger Editor の特徴
- オートコンプリート
- リアルタイムにエラーチェックされる
- リアルタイムにUI表示される

### Swagger Editor の画面構成

- 左: Editor
- 右: Viewer（Swagger UIで表示されるものと同じ）
- 上部メニューのGenrate Server、Generate Client:  
Swgger Codegenと同じ機能

https://editor.swagger.io/

### Gitリポジトリのソースを使った起動

1. リポジトリのクローン

```bash
git clone htttps://github.com/swagger-api/swagger-editor.git

```

### Docker を使った起動


0. Docker Hubでコンテナ名とTagを確認
`https://hub.docker.com/r/swaggerapi/swagger-editor/`

1. コンテナ起動

```bash
docker run -d -p 80:8080 --name editor swagger-api/swagger-editor:latest

```
2. ブラウザでアクセス

```
http://localhost:80
```


## Visual Studio Code 拡張機能

1. Visual Studio Code に SwaggerViewerを入れる
2. openaapi.yamlを作成し、Shift + Command + p で Preview Swaggerを選択しビューアを起動する
（macだと Shitf + Alt + pでは起動しなかった: 2回目以降は上手くいく）

## Hello World!

- `GET /message`を実行すると、`Hello World!`が返ってくるAPI


### `openapi.yaml`を記述

```yaml
openapi: "3.0.3"

info:
  title: "Sample API"
  version: "1.0.0"

paths:
  "/message":
    get:
      summary: "Sample API get operation"
      description: "Sample API get Operation"
      responses:
        "200":
          description: "Success operation"
          content:
            application/json:
              schema:
                type: string
                example: "Hello World!"

```

### Shift + Alt + p で仕様書を表示

![Sample API 仕様書](../images/sample-helloWorld.png)

## 速習YAML

### ハッシュ（キー・バリュー）

#### YAML

```yaml
key: value
```

#### JSON

```json
{ key: value}

```

### 配列

#### YAML

```yaml
key:
	- value1
	- value2
	-
```

#### JSON

```json
key: [value1, valeu2, ...]

```


###  ハッシュ（キー・バリュー）のネスト

#### YAML

```yaml
parent_key:
	child_key1: child_value1
	child_key2: child_value2

```

#### JSON

```json
parent_key: {	
	child_key1: child_value1,
	child_key2: child_value2
}

```

### 配列のネスト

#### YAML
```yaml
parent_key:
	-
		- value1
		- value2
	-
		- valueA
		- valueB

```

#### JSON
```json
parent_key: [
	[value1,value2],
	[valueA,valueB],
]
```

### 配列内のハッシュ（キー・バリュー）

#### YAML

`-`の有無に気を付ける

```yaml
parent_key:
	- child_key: value1
	  child_key: value2
```

#### JSON
```json
parent_key: [{
	child_key: value1,
	child_key: value2
}]
```

### 長文

#### YAML
```yaml
key: |
	hoge
	foo
	bar
```

#### JSON
```json
{
	key: `hoge
foo
bar`
}

```

### 1ファイルに封数のYAMLを含めてい場合

#### YAML
```yaml
key1: child_value1
---
key2: value2

```

#### JSON
```json
{ key1: value1}

{ key2: value2}
```


## データ型（基本）

### 基本となるデータ型

データ型はSchemaオブジェクトに定義する

|type|説明|
|---|---|
|integer|整数|
|number|浮動少数|
|string|文字列|
|boolean|真偽値|
|object|オブジェクト|
|array|配列|


### フォーマット

- integer
    - `int32`: 符号付き32ビット整数
    - `int64`: 浮動付き64ビット整数
- number
    - `float`: 浮動小数
    - `doblue`: 倍精度浮動小数
- string
    - `-` 文字列
    - `byte`: Base64エンコードされた文字列
    - `binary`: バイナリ
    - `date`: 日付（YYYY-MM-DD形式）の文字列 [RFC3339]
    - `date-time`: 日時（YYYY-MM-DDThh:mm:ssTZD形式）の文字列 [RFC3339]
    - `email`: メールアドレスを示す文字列 [RFC5322]
    - `hostname`: ホスト名を示す文字列 [RFC1123]
    - `ipv4`: `.`（ピリオド）区切られたIPv4アドレス文字列 [RFC2673]
    - `uri`: URIフォーマットに従った文字列 [RFC3986]
    - `uuid`: UUID文字列 [RFC4122]

### Schemaオブジェクト基本

```yaml
components:
		schemas:
				SampleString:
						type: string
						format: email

```

### サンプルSchema定義

例)
- 符号つき32ビット整数
- 日付を表す文字列

openapi.yaml

```yaml
openapi: "3.0.3"

info:
  title: "Sample API"
  version: "1.0.0"

paths:
  {}

components:
  schemas:
    SampleInt32:
      type: integer
      format: int32
    SampleDateString:
      type: string
      format: date
```

![サンプルスキーマ](../images/sample-type-schema.png)

## ルートオブジェクト

主要なオブジェクトは７種あり、内３種類が必須項目

```yaml
openapi: "3.0.3"

info:
  title: "Sample API"
  version: "1.0.0"

servers: []

tags: []

paths: {}

security: []

components: {}
```

- `openapi`: 利用するOpenAPIのバージョンを指定（必須）
- `info`: APIのメタデータを定義する（必須）
- `servers`: APIを提供するサーバーを定義する
- `tags`: APIを分類するタグとを定義する
- `paths`: APIとして利用可能なパス及び操作を定義する（必須）
- `security`: API全体にかかるセキュリティ要件
- `components`: OpenAPIの中で利用する様々なオブジェクトをコンポーネント化して再利用可能にする

```yaml

```

## メタデータ

APIのメタデータはInfoオブジェクトで定義します。

### Infoオブジェクト


```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  description: |
    # Features
    - Get reviews.
    - Post review.
  version: "1.0.0"
  termsOfService: "https;//tasylog.com/terms/"
  contact:
    name: "Coustomer Support"
    url: "https://tasylog.com/support"
    email: "support@tasylog.com"
  license:
    name: "MIT license"
    url: "https://opensource.org/licenses/MIT"


paths: {}

```

- `title`: APIのタイトル（必須)
- `description` : APIの詳細説明（Markdown形式で記述できる）
- `termsOfService`: 「サービス利用規約」のURL
- `contact`: 連絡先情報を定義する（カスタマーサポートなど）
- `lacense`: ライセンス情報を定義（ライセンス名は[SPDX](https://spdx.org/licenses/)を参考にするのが推奨）
- `version`: 対象のAPIのバージョン情報


![](../images/sample-metadata.png)


## サーバー

### Serversオブジェクト
```yaml
servers:
	- url: "https://api.sample.com/{version}"
	description: "Production Enviroment"
	variables:
			version:
				description: "API version"
				enum: ["v1", "v2"]
				default: "v2"

```

- `url`: 接続先URLを指定します（必須）
- `description`: 接続先に関する説明
- `variables`: 接続先URLで指定したテンプレート変数の内容を定義
- `version`: 
- `description`: 
- `enum`: 
- `default`: デフォルト値は必須

### Serversオブジェクトの定義例


```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  version: "1.0.0"

servers:
  - url: "http://localhost:{port}"
    description: "Local Enviroment"
    variables:
      port:
        enum: ["3000", "8080"]
        default: "3000"
  - url: "https:/it1.tastylog.com"
    description: "Integration Test"
  - url: "https:/stg.tastylog.com"
    description: "Staging"
  - url: "https:/api.tastylog.com"
    description: "Production"
 
paths: {}
```

![](../images/sample-servers.png)

## パス

### パスの全体像

```yaml
paths:
  "/users/{userId}/message":                        # パス
    get:                                            # メソッド
      summary: "Send neww message."                 # メタデータ
      description: "Send neww message."             #    〃
      tags: ["users"]                               #    〃
      deprecated: false                             #    〃
      parameters:                                   # リクエストパラメーター
      - name: "userId"                              #      〃
        in: "path"                                  #      〃
        required: true                              #      〃
        schema: { type: string }                    #      〃
      requestBody:                                  # リクエスト
        content:                                    #    〃
          application/json: {}                      #    〃
      responses:                                    # レスポンス
        "200":                                      #    〃
          description: "Success operation"          #    〃
      security:                                     # セキュリティ
        - sample_oauth2_auth: ["create_review"]     #    〃
```

### 操作のメタデータ 

```yaml
      summary: "Send neww message."                 # 操作の概要説明
      description: "Send neww message."             # 操作の詳細説明
      tags: ["users"]                               # タグの付与（ルートオブジェクトで定義したタグ、または任意のタグ）
      deprecated: false                             # 操作が廃止かどうか
```

- `summary`:  操作の概要説明
- `description`: 操作の詳細説明
- `tags`: タグの付与（パスとメソッドの組み合わせで付与される。ルートオブジェクトで定義したタグ、または任意のタグ）
- `deprecated`: 操作が廃止かどうか


### レビュー情報取得／投稿APIの作成（演習）
以下のようなAPIを作ってみましょう

`GET /shops/{shopId}/rebiews`

```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  version: "1.0.0"

paths:
  "/shops/{shopId}/reviews":
    get:
      summary: "Get specified shop reviews"
      description: "(discription): Get specified shop reviews"
      tags: ["shops"]
      deprecated: false
      parameters:
        - name: shopId
          in: path
          required: true
          schema: { type: string }
      responses:
        "200":
          description: "Success operation"

```

![](../images/sample-shopreviewapi-path.png)



## クリエストパラメーター


```yaml
      parameters:                                   # リクエストパラメーター
      - name: "userId"                              # パラメータ名
        in: "path"                                  # パラメータの場所()
        required: true                              # 必須かどうか指定
        schema: { type: string }                    # パラメータの型情報を定義

```

- `name`: パラメータ名
- `in`: パラメータの場所
    - `query`: クエリーパラメータ
    - `header`: リクエストパラメータ
    - `path`: パスパラメータ
    - `cookie`: クッキー
- `required`: 必須かどうか指定。（デフォルトfalse。in:pathパラメータの場合は必ずtrue）
- `schema`: パラメータの型情報を定義する
- `example`: パラメータで指定できるものがどんなものかのサンプルを提示


### レビュー情報取得／投稿APIの作成（演習）

- 以下のようなAPIを作成してみましょう  
    `POST /shops/{shopId}/reviews`
    - APIキーをヘッダーに要求する
    - ワンタイムトークンをクッキーに要求する

想定としては、店舗レビューの登録する。
その際ユーザーの識別情報としてヘッダーにX-Api-Key（APIキー）を指定すること。
また発行したワンタイムトークンもCookieにて送信すること。


```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  version: "1.0.0"

paths:
  "/shops/{shopId}/reviews":
    post:
      summary: "Create review"
      parameters:
      - name: shopId
        in: path
        required: true
        schema: { type: string }
        example: "abcdefg"
      - name: X-Api-Key
        in: header
        description: "Request user's idettifier"
        required: false
        schema: {type: string}
        example: "XXX-XXXX-XXXX-XXXX"
      - name: token
        in: cookie
        description: "One time token"
        schema: {type: string}
        example: "XXX-XXXX-XXXX-XXXX"
      responses:
        "201":
          description: "Sccess operation"

```

![](../images/sample-shopreviewapi-request-parameters.png)

## リクエストボディ

```yaml
      requestBody:
        descfription: "Message body"
        required: true
        content:
          application/json:
            schema: {type: string}
            example: "Hello World"
```

- `requestBody`: リクエストボディ
    - `descfription`: リクエストボディの説明
    - `required`: リクエストボディが必須かどうか（デフォルトはfalse）
    - `content`: リクエストボディの内容
        - `application/json`: メディアタイプ
            - `schema`: データ内容の型定義
            - `example`: サンプルデータ


### レビュー情報取得／投稿APIの作成（演習）

- 以下のようなAPIを作成してみましょう  
    `POST /shops/{shopId}/reviews`  
    投稿データは以下のようなJSONデータ
    ```json
    {
      sore:3,
      comment: "Delicious"
    }
    
    ```

```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  version: "1.0.0"

paths:
  "/shops/{shopId}/reviews":
    post:
      summary: "Create review"
      parameters:
      - name: shopId
        in: path
        required: true
        schema: { type: string }
      requestBody:
        description: "Contents of review"
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                score: { type: integer, example: 3}
                commnet: { type: string, example: "Delicious"}
      responses:
        "201":
          description: "Success operation"

```


![](../images/sample-ShopReviewAPI-request-body.png)

## レスポンス

```yaml
        responses:
            "201":
              description: "Success response"
              headers:
                x-rate-limit-remaining: 
                  description: "Number of remaining requests"
                  schema: { type: integer }
              content:
                application/json:
                  schema:
                    type: object
                    properties:
                      score: { type: integer }
                      comment: { type: string }
                      created: { type: string, format: date-time }
```

レスポンスの定義はステータスコードごとに定義する

- `responses`: レスポンス
    - `”200"`: ステータスコード(JSON<=>YAML互換性のため`"`ダブルクォートで囲む。"4XX"などまとめて記載することも可能。また成功ステータスは最低限定義する)
        - `discription`: レスポンスの説明
        - `headers`: レスポンスヘッダー
            - `x-rate-limit-remaining`: レスポンスヘッダー名
                - `description`: レスポンスヘッダーの説明
                - `schema`: レスポンスヘッダーのデータ型の定義
        - `content`: レスポンスボディ
            - `application/json`: メディアタイプを指定
                - `schema`: データ型を定義
                    - `type`:
                    - `properties`:
                        - `score`:
                        - `comment`:
                        - `created`:

### レビュー情報取得／投稿APIの作成（演習）

- 以下のようなAPIのレスポンスを作成してみましょう
    `POST /shops/{shopId}/reviews`
    - 201  
    locasionヘッダーで新しいURLを通知
    - 400
    以下のようなエラー詳細をレスポンスボディに表現
    ```json
    {
      code: "1234",
      type: "InvalidDataformat",
      message: "Invalid data",
      errors: [{
        field: "comment",
        code: "1234-001"
      }]
    }
    
    ```

#### 定義

```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  version: "1.0.0"

paths:
  "/shops/{shopId}/reviews":
    post:
      summary: "Create review"
      parameters:
      - name: shopId
        in: path
        required: true
        schema: { type: string }
      requestBody:
        description: "Contents of review"
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                score: { type: integer, example: 3 }
                comment: { type: string, example: "delicious" }
      responses:
        "201":
          description: "Success opeation"
          headers:
            location:
              description: "New URL of created"
              schema: {type: string, format: url }
        "400":
          description: "Invalid Error"
          content:
            application/json:
              schema:
                type: object
                properties:
                  code: { type: string, example: "1234" }
                  type: { type: string, example: "InvalidDataformat" }
                  message: { type: string, example: Invalid data }
                  errors:
                    type: array
                    items:
                      type: object
                      properties:
                        field: { type: string, example: "commnet" }
                        code: { type: string, example: "1234-001" }
                  
```

#### 結果

![](../images/sample-ShopReviewAPI-responses.png)


## データ型(schemaオブジェクトの表現)

### 共通プロパティ

```yaml
components:
  schemas:
    SampleString:
        type: string
        format: email
        description: "str" # 共通:データ型の説明
        default: "hoge"    # 共通:デフォルト値
        nullable: true     # 共通:null許容するかどうか
        example: "abc"     # 共通:サンプル
        deprecated: false  # 共通:廃止かどうか

```

- `description`: データ型の説明
- `default`: デフォルト値
- `nullable`: null許容するかどうか
- `example`: サンプル
- `deprecated`: 廃止かどうか

### integer, number

```yaml
components:
  schemas:
    SampleInt:
        type: integer
        format: int32
        multipleOf: 10          # 指定された数の倍数になっているかどうか
        maximum: 100            # 最大値
        exclusiveMaximum: false # 最大値を含まないかどうか（true: <100, false: <=100）
        minimum: 0              # 最小値
        exclusiveMinimum: false # 最小値を含まないかどうか（true: 0<, false: 0<=）

```

- `multipleOf`: 指定された数の倍数になっているかどうか
- `maximum`: 最大値
- `exclusiveMaximum`: 最大値を含まないかどうか（true: <100, false: <=100）
- `minimum`: 最小値
- `exclusiveMinimum`: 最小値を含まないかどうか（true: 0<, false: 0<=）

### string

```yaml
components:
  schemas:
    SampleString:
        type: string
        format: email
        minLength: 0    # 最小文字数
        maxLength: 100  # 最大文字数

```

- `minLength`: 最小文字数
- `maxLength`: 最大文字数


### boolean

```yaml
components:
  schemas:
    SampleBoolean:
      type: boolean # 真偽型を定義

```


### object

```yaml
components:
  schemas:
    SampleObject:
      type: object                          # typeをobjectに指定
      properties:                           # プロパティ定義
        name: { type: string }　　　　　　　　# プロパティのスキーマを定義（type:objectだとネストする事になる）
        dob: { type: string, format: date } #     〃
      additionalProperties: true            # スキーマ以外のプロパティを許すかどうか（例だと、name、dob以外のプロパティの許可）
      required:                             # 必須プロパティの定義
        - name
      minProperties: 2　　　　　　　　　　　　 # 最少プロパティ数（例だと、name + dob または、name + ?となる）
      maxProperties: 2                      # 最大プロパティ数

```

- `type`:
- `properties`: プロパティ定義　
- `additionalProperties`: スキーマ以外のプロパティを許すかどうか
- `required`: 必須プロパティの定義
- `minProperties`: 最少プロパティ数
- `maxProperties`: 最大プロパティ数

### array


```yaml
components:
  schemas:
    SampleArray:
      type: array              # typeをarrayに指定
      items: { type: string }  # 配列内に入れられるスキーマを指定
      minItems: 0              # 最小個数
      maxItems: 5              # 最大個数
      uniqueItems: true        # 配列内で値の重複を許すかどうか

```

- `items`: 配列内に入れられるスキーマを指定
- `minItems`: 最小個数
- `maxItems`: 最大個数
- `uniqueItems`: 配列内で値の重複を許すかどうか

### enum

```yaml
components:
  schemas:
    SampleEnum:
      type: string                    # 型を指定
      enum: ["red", "blue", "yellow"] # 指定した型で選択可能な値を列挙する

```

- `type`:  型を指定
- `enum`: 定した型で選択可能な値を列挙する


### サンプルSchemaの作成1
以下のデータ型を定義してみましょう

- 0以上10未満の整数
- null許容する10文字〜20文字の文字列
- 真偽値

#### 定義

```yaml
openapi: "3.0.3"

info:
  title: "Sample Schema Case 1"
  version: "1.0.0"

paths: {}

components:
  schemas:
    SampleInteger:
      type: integer
      #format: int32
      minimum: 0
      exclusiveMinimum: false
      maximum: 10
      exclusiveMaximum: true
    SampleString:
      type: string
      nullable: true
      minLength: 10
      maxLength: 20
    Sampleboolean:
      type: boolean

```


#### 結果
![](../images/sample-schema-case1.png)



### サンプルSchemaの作成1
以下のデータ型を定義してみましょう

```json
{
  shop: {
    name: "Sample Cafe", // 文字列
    place: "xxxx"        // 文字列
  },
  reviews: [{             // オプジェクトの配列
    score: 3,             // 1,2,3,4,5から選択
    comment: "Delicious!" // 文字列
  }]
}

```

#### 定義

```yaml
openapi: "3.0.3"

info:
  title: "Sample Schema Case2"
  version: "1.0.0"

paths:
  {}

components:
  schemas:
    SampleObject:
      type: object
      properties:
        shop:
          type: object
          properties:
            name: { type: string, example: "Sample Cafe" }
            place: { type: string, example: "xxxx" }
        reviews: 
          type: array
          items:
            type: object
            properties:
              score:
                type: integer
                example: 3
                enum: [ 1, 2, 3, 4, 5 ]
              comment: { type: string, example: "Delicious!" }
```

#### 結果
![](../images/sample-schema-case2.png)


## タグ

### ルートオブジェクト直下の `tags`
定義する

```yaml
tags:
- name: "users"
  description: "User operation"
```

### `paths`内のメソッド定義内の `tags`
どのパスとメソッドで使うか指定する

```yaml
paths:
  "/users":
    get:
      summary: "Get user list"
      description: "Get user list"
      tags: ["users"]
      deprecated: false
      responses:
        "200":
          description: "Success operation"
          content: {}

```
### tagの定義
- `name`: タグ名称
- `description`: タグの説明



### レビュー情報取得／投稿APIの作成（演習）
以下のようなAPIを作成してみましょう

- 作成するAPI  
  `GET /shops/{shopId}/reviews`  
  `POST /shops/{shopId}/reviews`
- 付与するタグ  
  `rebiews`

#### 定義

```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  version: "1.0.0"

tags:
- name: "reviews"
  description: "Reviews of Shop"

paths:
  "/shops/{shopId}/reviews":
    parameters:    # パスは一緒で違うメソッド同士で、同じパスパラメータを使って場合など、共通化できる。
    - name: shopId
      in: path
      required: true
      schema: { type: string, example: "12345" }
    get:
      summary: "Get Reviews List"
      description: "Get Revies List"
      tags: ["reviews"]
      # parameters:
      #   - name: shopId
      #     in: path
      #     required: true
      #     schema: { type: string, example: "12345" }
      responses:
        "200":
          description: "Success operation"
    post:
      summary: "Create new Review"
      description: "Create new Review"
      tags: ["reviews"]
      # parameters:
      #   - name: shopId
      #     in: path
      #     required: true
      #     schema: { type: string, example: "12345" }
      responses:
        "201":
          description: "Success operation"
```

#### 結果
![](../images/sample-Tags.png)


## コンポーネント

二重管理を避けるために、API間で重複実装を避け、再利用可能にする仕組み

コンポーネントはルートオブジェクト直下に定義する。

### コンポーネントオブジェクト化できる要素

- `schemas`:
- `parameters`:
- `requestBodies`:
- `responses`:
- `headers`:
- `securitySchemes`:

### コンポーネントの定義


#### 例

```yaml

components:
    schemas:
      Book:   #　コンポーネント名を定義（英数字、ピリオド、アンアースコア、ハイフン）
        type: object
          properties:
              title: { type: string }
              author: { type: string }
              published: { type: string }

```

### コンポーネントの利用

`$ref: "[{ファイルパス}]#/components/{コンポーネントタイプ}}/{定義したコンポーネント名}"`

同一ファイルなら`[{ファイルパス}]`を省略する。

#### 例

```yaml
paths:
  "/book/{id}"
    get:
        summary: "Get specified book"
        parameters:
          - named: id
            in: path
            required: true
            schema: { type: string }
        responses:
          "200":
            description: "Success operation"
            content:
              application/json:
                schema:
                  $ref: "#/components/schemas/Book" # コンポーネント定義の場所を$refで指定


```


### レビュー情報取得／投稿APIの作成（演習）
以下のようなAPIを作成してみましょう

- 作成するAPI  
  `GET /shops/{shopId}/reviews`  
  `POST /shops/{shopId}/reviews`

- 共通化するコンポーネント
    - 種類
        - schema
            - Review
            - ClientError
        - parameters
            - ShopId
        - responses
            - 400-BadRequest

#### 定義

```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  version: "1.0.0"

tags:
  - name: "reviews"
    description: "Review of Shop"

paths:
  "/shops/{shopId}/reviews":
    parameters:
      - $ref: "#/components/parameters/ShopId"
    get:
      summary: "Get Reviews List"
      description: "Get Reviews List"
      tags: ["reviews"]
      responses:
        "200":
          description: "Success operation"
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: "#/components/schemas/Review"
    post:
      summary: "Create new Review"
      description: "Create new Review"
      tags: ["reviews"]
      requestBody:
        description: "Contens of review"
        required: true
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/Review"
      responses:
        "201":
          description: "Success operaton"
          headers:
            location:
              description: "New URL of created review"
              schema: { type: string, format: url }
        "400":
          $ref: "#/components/responses/400-BadREquest"
        

components:
  schemas:
    Review:
      type: object
      properties:
        score: { type: integer }
        comment: { type: string }
    ClientError:
      type: object
      properties:
        code: { type: string }
        type: { type: string }
        message: { type: string }
        errors:
          type: array
          items:
            type: object
            properties:
              field: { type: string }
              code: { type: string }
  parameters:
    ShopId:
      name: shopId
      in: path
      description: "Shop identifier"
      required: true
      schema: { type: string }
  responses:
    400-BadREquest:
      description: "Client side error"
      content:
        application/json:
          schema:
            $ref: "#/components/schemas/ClientError"


```

#### 結果
![](../images/sample-ShopReviewAPI-component-1.png)
![](../images/sample-ShopReviewAPI-component-2.png)
![](../images/sample-ShopReviewAPI-component-3.png)


## セキュリティ

### 定義可能な認証認可

- `http`
    - `Basic`: Basic認証
    - `Vearer`: JWTなどを利用した認可
- `apiKey`
    - `header`: API Keyを利用した認可
    - `cookie`: ログインセッション
- `oauth2`: OAuth2.0 (認可)
- `openIdConnect`: OpenID Connect (認可+ユーザ情報)


### セキュリティ定義概要

1. 利用するスキームの定義を行う
    - 利用するスキームは`components`に定義する
2. APIに適用する
    - PAIの適用する方法が２種類
        - 個別に適用
        - 全体に適用して個別に解除

### 利用するスキームの定義

```yaml
components:
  securitySchemes:
    sample_auth:                           # セキュリティスキーム名
      description: "Sample authentication"
      type: http                           # 利用するセキュリティスキームの種別

```

#### Basec認証

```yaml
components:
  securitySchemes:
    sample_basic_auth:
      description: "Basic authentication"
      type: http
      scheme: basic

```


#### JWTなどを利用した認可

```yaml
components:
  securitySchemes:
    sample_jwt_auth:
      description: "JWT authentication"
      type: http
      scheme: bearer
      bearerFormat: JWT

```

#### API Keyを利用した認可

```yaml
components:
  securitySchemes:
    sample_apikey_auth:
      description: "API-Key authentication"
      type: apiKey
      in: header
      name: X-Api-Key

```

#### ログインセッション

```yaml
components:
  securitySchemes:
    sample_cookie_auth:
      description: "Login Session authentication"
      type: apiKey
      in: cookie
      name: JSESSIONID # 利用するcookie名を指定
```

#### OAuth2.0 

```yaml
components:
  securitySchemes:
    sample_oauth2_auth:
      description: "OAuth2"
      type: oauth2
      flows:
        authorizationCode:
          authorizationUrl: "https://oauth.sample.com/auth"
          tokenUrl: "https://oauth.sample.com/token"
          scopes:
            "create_review": "Post new review."
```

#### OpenID Connect


```yaml
components:
  securitySchemes:
    sample_oidc_auth:
      description: "OpenID Connect"
      type: openIdConnect
      openIdConnectUrl: "https://oidc.sample.com/signin"
```

### 個別にAPIに適用する方法

```yaml
paths:
  "/samples":
    get:
      summary: "Get all sample data"
      responses:
        "200":
          description: "Success operation"
      security:
      - sample_jwt_auth: []  # security に必要な認証（securitySchemesにて定義したもの）を指定。scopeがない場合は空配列を指定し、scopeがあるならスコープ名を指定
components:
  securitySchemes:
    sample_jwt_auth:         # components に securitySchemesにて定義
      type: http
      description: "JWT Auth."
      scheme: bearer
      bearerFormat: JWT

```

### 全体に適用して個別に解除する方法


```yaml
paths:
  "/samples":
    get:
      summary: "Get all sample data"
      responses:
        "200":
          description: "Success operation"
      security: []  # 解除したいAPIにはsecurity項目に空配列を指定
security:
- sample_jwt_auth: [] # 全体に適用する認証・認可方法を指定 
components:
  securitySchemes:
    sample_jwt_auth:
      type: http
      description: "JWT Auth."
      scheme: bearer
      bearerFormat: JWT

```

### レビュー情報取得／投稿APIの作成（演習）
以下のようなAPIを作成してみましょう

- 作成するAPI  
  `GET /shops/{shopId}/reviews`  
  `POST /shops/{shopId}/reviews` 
- 必要とするセキュリティ要件  
  POSTする際にAPI Keyを必要とすること 


#### 定義

```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  version: "1.0.0"

tags:
- name: "reviews"
  description: "Reciew of Shop"

paths:
  "/shops/{shopId}/reviews":
    parameters:
      - $ref: "#/components/parameters/ShopId"
    get:
      summary: "Get Reviews List"
      description: "Get Reviews List"
      tags: ["reviews"]
      responses:
        "200":
          description: "Success operation"
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: "#/components/schemas/Review"
    post:
      summary: "Create new Review"
      description: "Create new Review"
      tags: ["reviews"]
      requestBody:
        description: "Contens of review"
        required: true
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/Review"
      responses:
        "201":
          description: "Success operaton"
          headers:
            location:
              description: "New URL of created review"
              schema: { type: string, format: url }
        "400":
          $ref: "#/components/responses/400-BadREquest"
      security:
        - apiKey_auth: []

components:
  schemas:
    Review:
      type: object
      properties:
        score: { type: integer }
        comment: { type: string }
    ClientError:
      type: object
      properties:
        code: { type: string }
        type: { type: string }
        message: { type: string }
        errors:
          type: array
          items:
            type: object
            properties:
              field: { type: string }
              code: { type: string }
  parameters:
    ShopId:
      name: shopId
      in: path
      description: "Shop identifier"
      required: true
      schema: { type: string }
  responses:
    400-BadREquest:
      description: "Client side error"
      content:
        application/json:
          schema:
            $ref: "#/components/schemas/ClientError"
  securitySchemes:
    apiKey_auth:
      type: apiKey
      description: "ApiKey Authentication"
      in: header
      name: X-Api-Key

```

#### 結果
![](../images/sample-ShopReviewAPI-security-1.png)


#### 定義

```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  version: "1.0.0"

tags:
- name: "reviews"
  description: "Reciew of Shop"

paths:
  "/shops/{shopId}/reviews":
    parameters:
      - $ref: "#/components/parameters/ShopId"
    get:
      summary: "Get Reviews List"
      description: "Get Reviews List"
      tags: ["reviews"]
      responses:
        "200":
          description: "Success operation"
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: "#/components/schemas/Review"
      security: []
    post:
      summary: "Create new Review"
      description: "Create new Review"
      tags: ["reviews"]
      requestBody:
        description: "Contens of review"
        required: true
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/Review"      
      responses:
        "201":
          description: "Success operaton"
          headers:
            location:
              description: "New URL of created review"
              schema: { type: string, format: url }
        "400":
          $ref: "#/components/responses/400-BadREquest"
      # security:
      #   - apiKey_auth: []
      
security:
  - apiKey_auth: []

components:
  schemas:
    Review:
      type: object
      properties:
        score: { type: integer }
        comment: { type: string }
    ClientError:
      type: object
      properties:
        code: { type: string }
        type: { type: string }
        message: { type: string }
        errors:
          type: array
          items:
            type: object
            properties:
              field: { type: string }
              code: { type: string }
  parameters:
    ShopId:
      name: shopId
      in: path
      description: "Shop identifier"
      required: true
      schema: { type: string }
  responses:
    400-BadREquest:
      description: "Client side error"
      content:
        application/json:
          schema:
            $ref: "#/components/schemas/ClientError"
  securitySchemes:
    apiKey_auth:
      type: apiKey
      description: "ApiKey Authentication"
      in: header
      name: X-Api-Key

```

#### 結果
![](../images/sample-ShopReviewAPI-security-1.png)


## スタブ作成／実行

### スタブコードの生成

Swagger Editorの上部メニューからサーバ、クライアント両方のコードを生成する

### スタブの実行

node.jsの場合

1. 解凍したコードフォルダー内で`npm start`を実行

### スタブの動作確認

1. ブラウザで`http://localhost:880/docs`にアクセスする
2. 各APIの`Try it out`からスタプ実行

### スタブ実行①

#### 定義

##### 1) Swagger Editorで定義

```yaml
openapi: "3.0.3"

info:
  title: "Shop Review API"
  description: |
    # Features
    - Get reviews.
    - Post review.
  termsOfService: "https://tastylog.com/terms/"
  contact:
    name: "Customer Support"
    url: "https://tastylog.com/support/"
    email: "support-desk@tastylog.com"
  license:
    name: "MIT License"
    url: "https://opensource.org/licenses/MIT"
  version: "1.0.0"

servers: 
- url: "http://localhost:{port}"
  description: "Local Development"
  variables:
    port:
      enum: ["3000", "8080"]
      default: "3000"
- url: "https://it1.tastylog.com/v1"
  description: "Integration Test"
- url: "https://stg.tastylog.com/v1"
  description: "Staging"
- url: "https://api.tastylog.com/v1"
  description: "Production"

tags:
- name: "reviews"
  description: "Shop review operation"

paths:
  "/shops/{shopId}/reviews":
    get:
      summary: "Get shop review"
      description: "Get specified shop's reviews"
      tags: ["reviews"]
      parameters:
      - name: shopId
        in: path
        required: true
        schema: { type: string }
      - name: order
        in: query
        description: "Sort order"
        schema:
          type: string
          enum: ["asc", "desc"]
      responses:
        "200":
          description: "Success operation"
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: "#/components/schemas/Review"
    post:
      summary: "Create new review"
      description: "Create specified shop's new review"
      tags: ["reviews"]
      parameters:
      - name: shopId
        in: path
        description: "Shop identifier"
        required: true
        schema: { type: string }
      requestBody:
        description: "Contents of review"
        required: true
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/Review"
      responses:
        "201":
          description: "Success operation"
          headers:
            location:
              description: "New URL of created review"
              schema: { type: string, format: url }
        "400":
          $ref: "#/components/responses/400-BadRequest"
      security:
      - apikey_auth: []

components:
  schemas:
    Review:
      type: object
      properties:
        score: { type: integer, example: 3 }
        comment: { type: string, example: "Delicious" }
    ClientError:
      type: object
      properties:
        code: { type: string }
        type: { type: string }
        message: { type: string }
        errors:
          type: array
          items:
            type: object
            properties:
              field: { type: string }
              code: { type: string }
  responses:
    400-BadRequest:
      description: "Client side error"
      content:
        application/json:
          schema:
            $ref: "#/components/schemas/ClientError"
  securitySchemes:
    apikey_auth:
      description: "API Key authorization"
      type: apiKey
      name: "X-Api-Key"
      in: header

```


##### 2) Swagger Editorでコードジェネレート

1. `Swagger Editor`の上部メニュー`Generate Server`の`nodejs-server`を選択して、コードを生成しダウンロードする。
2. ダウンロードした`nodejs-server-server-generated.zip`展開
3. 展開したディレクトリにターミナルで入り、`npm start`を実行

```bash
% npm start

> shop-review-api@1.0.0 prestart
> npm install


added 127 packages, and audited 128 packages in 9s

7 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities

> shop-review-api@1.0.0 start
> node index.js

body-parser deprecated undefined extended: provide extended option node_modules/oas3-tools/dist/middleware/express.app.config.js:22:33
  Mock mode: disabled
Your server is listening on port 8080 (http://localhost:8080)
Swagger-ui is available on http://localhost:8080/docs

```

##### 3) API docsにアクセスしスタブ実行

1. ブラウザから`http://localhost:8080/docs`にアクセス
2. 実行したいAPIを開き`Try it out`を実行

#### 結果
![](../images/sample-ShopReviewAPI-stub-1.png)

