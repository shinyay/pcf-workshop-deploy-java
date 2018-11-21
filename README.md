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

## まとめ / 振り返り

