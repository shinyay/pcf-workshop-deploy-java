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

<details><summary>編集済みソースコード</summary>

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

### アプリケーションのビルド
以下のコマンドでアプリケーションをビルドします。
```
$ ./gradlew build -x test
```

### アプリケーションのローカル実行
以下のコマンドでビルドした Spring Boot アプリケーション を実行します。

```
$ java -jar build/libs/hello-pcf-0.0.1-SNAPSHOT.jar
```

```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.0.RELEASE)

2018-11-21 14:26:56.348  INFO 2598 --- [           main] c.example.hellopcf.HelloPcfApplication   : Starting HelloPcfApplication on syanagihara.local with PID 2598 (/Users/shinyay/workspace/workshop/pcf-workshop-deploy-java/build/libs/hello-pcf-0.0.1-SNAPSHOT.jar started by shinyay in /Users/shinyay/workspace/workshop/pcf-workshop-deploy-java)
2018-11-21 14:26:56.352  INFO 2598 --- [           main] c.example.hellopcf.HelloPcfApplication   : No active profile set, falling back to default profiles: default
2018-11-21 14:26:57.610  INFO 2598 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2018-11-21 14:26:57.632  INFO 2598 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2018-11-21 14:26:57.632  INFO 2598 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet Engine: Apache Tomcat/9.0.12
2018-11-21 14:26:57.643  INFO 2598 --- [           main] o.a.catalina.core.AprLifecycleListener   : The APR based Apache Tomcat Native library which allows optimal performance in production environments was not found on the java.library.path: [/Users/shinyay/Library/Java/Extensions:/Library/Java/Extensions:/Network/Library/Java/Extensions:/System/Library/Java/Extensions:/usr/lib/java:.]
2018-11-21 14:26:57.722  INFO 2598 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2018-11-21 14:26:57.722  INFO 2598 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 1323 ms
2018-11-21 14:26:57.970  INFO 2598 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'characterEncodingFilter' to: [/*]
2018-11-21 14:26:57.970  INFO 2598 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'webMvcMetricsFilter' to: [/*]
2018-11-21 14:26:57.971  INFO 2598 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'hiddenHttpMethodFilter' to: [/*]
2018-11-21 14:26:57.971  INFO 2598 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'formContentFilter' to: [/*]
2018-11-21 14:26:57.971  INFO 2598 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'requestContextFilter' to: [/*]
2018-11-21 14:26:57.971  INFO 2598 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'httpTraceFilter' to: [/*]
2018-11-21 14:26:57.971  INFO 2598 --- [           main] o.s.b.w.servlet.ServletRegistrationBean  : Servlet dispatcherServlet mapped to [/]
2018-11-21 14:26:58.223  INFO 2598 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2018-11-21 14:26:58.483  INFO 2598 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 2 endpoint(s) beneath base path '/actuator'
2018-11-21 14:26:58.568  INFO 2598 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2018-11-21 14:26:58.572  INFO 2598 --- [           main] c.example.hellopcf.HelloPcfApplication   : Started HelloPcfApplication in 2.527 seconds (JVM running for 2.945)
```

実行したら、[http://localhost:8080](http://localhost:8080) にアクセスします。
"Hello, World!" の表示が確認できます。

![local access](images/access-local.png)



## まとめ / 振り返り

