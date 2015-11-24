# ExtendEntryFieldFilter

## プラグインの概要

```MTEntries```で記事を出力する際、カスタムフィールドの値をさまざまな条件で指定して記事を抽出できるようにするものです。

## 開発の経緯

[MTQの質問](communities.movabletype.jp/2015/10/mtentries-limit.html)がきっかけで（※）、カスタムフィールドについて調査・実験した結果をプラグイン化したものです。調査・実験に使用したコードは[GistのMTカスタムフィールドの研究](https://gist.github.com/hideki-a/96a12cdb7a1be98ce060)に掲載しています。

プラグイン化にあたっては、昨日（2015年11月23日）に見つけた「[細かすぎて伝わらない FieldIsNotEmpty プラグインの実装](http://www.powercms.jp/blog/2015/02/super_handler.html)」を参考にさせて頂きました。

詳細は、[Movable Type Advent Calendar 2015](http://www.adventar.org/calendars/1035)の記事にする予定です。基本的には学習目的で、需要があるか・案件で利用できるかは深く考えていません。

※チェックボックスにチェックが入っていないものを抽出するために、必要記事数以上のループを回すことを回避してみたかったため。

## 使用方法

次のカスタムフィールドを用意しているものとします。

| ベースネーム | 内容 | 型 | フィールド値の例
|--------------|--------------|--------------|--------------
| data_aircraft_type | 旅客機の機種 | 文字 | B787
| data_int_number_of_employees | 社員数 | 整数 | 12500

### LIKE検索による抽出

```
<mt:Entries field:data_aircraft_type="LIKE","B%">
```

旅客機の機種が「B」から始まる記事を出力します。

### 数値比較検索による抽出

```
<mt:Entries field:data_int_number_of_employees="[比較条件]","[数値]">
```

次の例の場合、社員数が10,000人以上の記事を出力します。

```
<mt:Entries field:data_int_number_of_employees=">=","10000">
```

対象のカスタムフィールドは数値型である必要があります。

### OR検索による抽出

```
<mt:Entries field:data_aircraft_type="B787","A350">
```

旅客機の機種が「B787」または「A350」の記事を出力します。なお、これはプラグインがなくても抽出できるようです。

### NOT検索による抽出

例えば値があるものだけを抽出することはできます。しかし、チェックボックスがチェックされていないもの…つまり値が0もしくはレコードが存在しないものを抽出することはできないのではないかと考えています。SQLで表現するとGistの[not_exist_cf.sql](https://gist.github.com/hideki-a/96a12cdb7a1be98ce060#file-not_exist_cf-sql)の通りです。既存記事にもチェックなしの0を反映するプラグインを書く、という解決方法もあるかもしれません。
