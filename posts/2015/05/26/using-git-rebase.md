# [git rebaseを使う](/2015/05/26/using-git-rebase.html)

チーム開発をしていてGithub上でPRを送る際に

- レビューのしやすいPRを送る
- 意味のあるコミットを心がける

という点を指摘された。

PRを出すときに、そのPRに関係のない差分とか作業上でコミットはしたが、コミットに(タイポを直しただけなど)意味が無く複数のコミットを1つのコミットにまとめたいときなどに「Gitには`rebase`という便利機能があるから使うと良い」みたいなアドバイスをもらった。

Gitはそこそこ使ってたつもりだったけど、`rebase`はあまり使ったことが無かったし、ちゃんと使い方を知ってどんどん使っていく。

`rebase`は、コミット履歴がわかりやすくなる。

`merge`すると以下のようになるコミット履歴が
![merge](https://git-scm.com/figures/18333fig0328-tn.png)

`rebase`すると以下のようになる。
![rebase](https://git-scm.com/figures/18333fig0329-tn.png)


画像引用: [Git - リベース](https://git-scm.com/book/ja/v1/Git-%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E6%A9%9F%E8%83%BD-%E3%83%AA%E3%83%99%E3%83%BC%E3%82%B9)

## レビューのしやすいPRを送る

今の開発はdevelopブランチからどんどんブランチを切ってPRを送る感じなのだけれど、今回は分岐したブランチにdevelopブランチを`pull`したときのマージコミットがPRに含まれていてレビューのしにくいPRになってしまっていた。

今回、developブランチでは原則として作業をしないみたいな感じで、developブランチ上での`pull`でマージコミットを残さないべきで以下のようにする。

```
$ git pull --rebase
```

今回のようにdevelopブランチでは常に`pull --rebase`するときは以下のように設定すると間違えて`pull`したときでも`pull --rebase`される。

```
$ git config branch.develop.rebase true
```

常に`pull --rebase`するときは以下の用に設定すると`~/.gitconfig`に以下の記述が入る。

```
$ git config --global pull.rebase preserve
$ cat ~/.gitconfig
[pull]
	rebase = preserve
```


## 意味のあるコミットを心がける

typoを修正しただけのコミットは無意味で、可能であれば対象のファイルを変更したコミットにtypoを修正したコミットを含めるべきだ。

コミットメッセージにも気をつかい、そのコミットがなんのためのコミットか、どのような変更をしたかということを記述する。

このようなことを考えると、今までのコミットを修正したくなってくる。
`git rebase -i`を使う。

```
$ git rebase -i HEAD~~
```

テキストエディタが起動しHEADからHEAD~~までのコミットが以下の様に表示される。

```
pick 31cd74a Add README.md
pick 77bda38 typo README

# Rebase bca98b5..77bda38 onto bca98b5 (2 command(s))
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```

試しに、`77bda38 typo README`というコミットのコミットメッセージを`typo README.md`に変更してみる。

```
e 77bda38 typo README
```
と変更し、エディタを終了する。

```
Stopped at 77bda38be1de80bd37e456b647295581742dc899... typo README
You can amend the commit now, with

	git commit --amend

Once you are satisfied with your changes, run

	git rebase --continue
```

と表示されるので従うとコミットメッセージが修正される。
再度、`rebase -i`を実行する。

```
pick 31cd74a Add README.md
pick c209f7d typo README.md
```
やはりtypoを修正したコミットは無意味でREADME.mdを追加したコミットに含めたいとき`squash`を使う。

```
s c209f7d typo README.md
```
と変更し、エディタを終了する。
エディタが再び起動しコミットメッセージを編集する。
エディタを終了するとコミットが1つになっている。

```
$ git log
commit 54b156a11a7385f3593f48ad580a2107c3c8c4f6
Author: toihrk <toihrk@me.com>
Date:   Thu May 28 19:23:02 2015 +0900

    Add README.md

    typo README.md

commit bca98b59c2692ae68b07cf5724778c62d8f56e5c
Author: toihrk <toihrk@me.com>
Date:   Thu May 28 19:21:31 2015 +0900

    Initial commit
```

こんな調子になるので、コミットの履歴が綺麗になり、自然にPRもレビューのしやすいものになる。


参考 : [Git - リベース](https://git-scm.com/book/ja/v1/Git-%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E6%A9%9F%E8%83%BD-%E3%83%AA%E3%83%99%E3%83%BC%E3%82%B9)