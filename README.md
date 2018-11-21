# Java アプリケーションのデプロイ
簡単な Java アプリケーションを Pivotal Cloud Foundry へデプロイします。

## 概要 / 説明
ここでは、簡単な Java のアプリケーションを作成し、デプロイを **cf push** コマンドで行ってみます。
そして実際にデプロイされたアプリケーションを **Pivotal Cloud Foundry Apps Manager** (アプリケーションの管理ダッシュボード) から確認してみます。

Java のアプリケーションは、[Spring Boot](http://projects.spring.io/spring-boot/)を使い、とてもシンプルなWebアプリケーションを作成します。
作ったアプリケーションを cf コマンドを使って PCF へデプロイを行います。
また、デプロイする時に使用される Buildpack についても見てみます。

## 前提 / 環境
- [事前作業](https://github.com/shinyay/pcf-workshop-prerequisite/blob/master/README.md) 実施済み

## 手順 / 解説
### プロジェクトの作成
GitHub 上に作成済みの Spring Boot プロジェクトをクローン(`git clone`)しプロジェクトを作成します。

- https://github.com/shinyay/pcf-workshop-deploy-java-code.git

任意のディレクトリで、以下のコマンドを実行します。

```
$ mkdir pcf-workshop
$ cd pcf-workshop
$ git clone https://github.com/shinyay/pcf-workshop-deploy-java-code.git hello-pcf
$ cd hello-pcf
```

### アプリケーションの修正
クローンしたプロジェクトに含まれている次のソースコードを編集します。

- src/main/java/com/example/hellopcf/HelloPcfApplication.java

#### 編集内容
- GET アクセスでの "Hello, World!" の表示
  - `RestController` アノテーションの追加
  - `GetMapping` アノテーションを持つ処理の追加

<details><summary>編集済みソースコード</sammary>

```java
package com.example.hellopcf;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class HelloPcfApplication {

    @GetMapping("/")
    String hello() {
        return "Hello, World!";
    }

	public static void main(String[] args) {
		SpringApplication.run(HelloPcfApplication.class, args);
	}
}
```

</details>

## まとめ / 振り返り

