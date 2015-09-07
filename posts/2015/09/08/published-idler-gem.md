# [idlerってGemを作った](/2015/09/08/published-idler-gem.html)

[idler | RubyGems.org | your community gem host](https://rubygems.org/gems/idler)

[toihrk/idler](https://github.com/toihrk/idler)

初めてのRubyGemsです。スターお願いします！！！

## 開発した経緯

社内で今携わっているプロジェクトでCIツールとして[drone](https://github.com/drone/drone)を採用した。

Jenkinsにはあまり触りたくなくて、前のプロジェクトでも採用実績があり、社内にDockerレジストリがあるからという安直な理由での採用で、あんまり不便なく使えている。

今回のプロジェクトでは、ビルドだけでなくデプロイも行いたく、されどブランチ毎にコマンドの切り替えをどうしようかと悩んでいたところで、ブランチ毎にスクリプトを実行させるコマンドを作った。

## 開発期間

ほぼ3日くらい

## 開発

ブロックめっちゃ使って少しだけ`Proc`オブジェクトと仲良くなれた気がする。

ずさんなテストだけど、そこそこ書けたんじゃないかと思う。

[idler/branch.rb at master · toihrk/idler](https://github.com/toihrk/idler/blob/master/lib/idler/branch.rb#L11)

ここやばいと思う。

`DSL`モジュールなんて名前だけで、結局`Branch`クラス呼んでるだけっていうお茶目さも感じて欲しい。

英語が不自由なので、変な英語たくさんあると思うし、PRたくさん欲しい。

## オチ

[drone/drone - Gitter](https://gitter.im/drone/drone/archives/2015/01/02)

シェルスクリプトの知識が少しあれば、Gemを作らずに解決した。