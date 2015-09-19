# [ItamaeでNodebrewが入るレシピを書いた](/2015/09/20/published-itamae-plugin-recipe-nodebrew-gem.html)


[itamae-plugin-recipe-nodebrew | RubyGems.org | your community gem host](https://rubygems.org/gems/itamae-plugin-recipe-nodebrew)

[toihrk/itamae-plugin-recipe-nodebrew](https://github.com/toihrk/itamae-plugin-recipe-nodebrew)

スターお願いします。

## Special Thanks

[rutan/itamae-plugin-recipe-rtn_rbenv](https://github.com/rutan/itamae-plugin-recipe-rtn_rbenv)

というか、モロパクリでVagrantのボックスのイメージも利用の許可を頂きました。

## Itamaeのレシピを書く

DSLを定義していくイメージで、いろいろなものをItamaeが提供してくれてるので簡単に書ける。

HubotでChatopsをしようっていう思惑でNode.jsが動く環境をAWS上に立てたくて、開発環境でも使ってるNodebrewが使えたら楽だな〜という感じで作った。

## Nodebrew悩みどころ

[hokaccha/nodebrew](https://github.com/hokaccha/nodebrew)

そもそもシングルユーザーで使われることを想定しているようでREADMEには`$HOME`以下に本体である`.nodebrew` が作られるようなインストールの方法が目に入る。

できれば今回のレシピではシングルユーザー用のレシピとは別に本番で使うためにシステムにrbenvみたいなイメージで`/usr/local`以下にインストールするレシピも書きたかった。一応環境変数でインストール先のディレクトリを変更できるようになってるみたいで、それでもどういう挙動をするのかわからなかったのでそこを検証するところから始めた。

ひとまず動いてるようには確認できたけれど、バージョンの切り替えにはパーミッションが必要なようで、そこには`sudo`を使うようにserverspecで書いた。

rbenvみたいに細かな設定ができないようだけれど、そこはいいかなって印象で、ひとまず自分の使いたいように書けたので何か困ったらプルリクくれって感じ。

## VagrantとBundlerでハマる

テストにはVagrantを使っていて、Vagrantの`1.7.4`ではBundlerの`1.10.6`は使えない。

[Bundler 1.10.6 · Issue #6072 · mitchellh/vagrant](https://github.com/mitchellh/vagrant/issues/6072)

次のアップデートいつだよみたいな感じで、ひとまず動くようにと思ってBundlerの`1.10.5`をインストールしてテストは以下のように実行した。

```
$ bundle _1.10.5_ exec rake spec	
```

そこでとりあえずgemspecのdependencyのバージョンも下げた。

[modify gemspec bundler version · toihrk/itamae-plugin-recipe-nodebrew@a22ce3c](https://github.com/toihrk/itamae-plugin-recipe-nodebrew/commit/a22ce3c7bbf4569402ac8ca139066625e55f62e5)

## 所感

VagrantのVMを4つも立ち上げたり殺したりしながらテストをしてたから思ったより時間がかかってしまったけれど、ちゃんとrubygemsに出せて良かった。
