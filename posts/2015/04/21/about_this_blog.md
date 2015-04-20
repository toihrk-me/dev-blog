# [このブログについて](/2015/04/21/about_this_blog.html)

このブログは**[jgsme/dev](https://github.com/jgsme/dev)**にインスパイアされて、もともとはクローンしたものに手を加えて作成した。

手を加えたとは言え主にレイアウトだけの修正で、`gulpfile.coffee`とか`wercker.yml`とかには全く手を出せず、`Gulp`は初めて使うし`Wercker`なるサービスも初めて使った。

クローンしてから、このブログが公開されるまでのハマりポイントを列挙する

- [github-markdown-css](https://github.com/sindresorhus/github-markdown-css)がsubmoduleで追加されてること
	- Githubでコード眺めてりゃ一目瞭然
```
git submodule add　git@github.com:sindresorhus/github-markdown-css.git
```

- アーカイブページでページが1枚のみだと**prev**ページングリンクが表示されてしまう
	- [b838ac6](https://github.com/toihrk-me/dev-blog/commit/b838ac612292fb4d9b9c8016ccde954693769ae6#diff-6a2b91a0310e4628676e6da9e727d3e9) 何も考えずに書いた

- Werckerでデプロイできない
	- Werckerってサービス自体を知らな過ぎた
		- [http://wercker.com/](http://wercker.com/)
		- GithubへのコードのPushをフックしてアプリケーションのテスト，ビルド，デプロイができる便利屋さん
		- 今回はビルドとデプロイの機能を使う
	- `wercker.yml`を読む
		- 解説サイトに翻弄されDEPLOY TARGETで指定できる変数の意味を取り違えてた
			- Githubにpushするんだから、変数名は適当でも大丈夫だろって思ってたけどそうでもない(当たり前だ)
			- 今回の場合は`$github_remote`を使ってるようなので、変数名には`github_remote`にアクセストークン込みのリポジトリのURLを渡す ([dev-blog/wercker.yml at master · toihrk-me/dev-blog](https://github.com/toihrk-me/dev-blog/blob/master/wercker.yml#L23))

		- 最終的には`master`ブランチにコミットがあったらオートデプロイするようになった
			- 環境変数名は`github_remote`で、値には`https://{GithubのPersonal access token}@github.com/{アカウント名}/{リポジトリ名}`
				- 今回、この[toirk-me/dev-blog](https://github.com/toihrk-me/dev-blog)だと、github.com/toihrk-me/dev-blogみたいな感じになる

ただ単純にもってくるだけではパクリになってしまうので、今この状態でも十分パクリブログだけれど、スタイルシートをいじった。イメージはGithub。

それだけじゃ面白くなくて、コメント機能なんかもGithub上のissueでやってもらおうかな〜と思い、[github:buttons](https://buttons.github.io/)でボタンを吐き出して使った。

パーマリンクを踏んでもらった後の記事単体のページでのissueボタンの挙動は、そのまま[https://github.com/toihrk-me/dev-blog/issues/new](https://github.com/toihrk-me/dev-blog/issues/new)に飛んでもらうようになってる。ここでクエリパラメータに`title=hogehoge&body=fugafuga`みたいにやるとGithubがよしなにやってくれるので便利。

記事の書き方は、やっぱり[このブログのアップデートをした - Kaihatsu](http://dev.jgs.me/2015/01/16/updated-blog.html)に則る感じ

	1. 書く
	2. Push
	3. PR
	4. masterにマージ
	5. deploy

でやっていこうと思う。

せっかくGithubでやってるんだしWatchすると、このブログの更新情報が手に取るようにわかりますのでよろしくお願いします！


		