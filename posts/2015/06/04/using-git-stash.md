# [git stashを使う](/2015/06/04/using-git-stash.html)


[Git - 作業を隠す](https://git-scm.com/book/ja/v1/Git-%E3%81%AE%E3%81%95%E3%81%BE%E3%81%96%E3%81%BE%E3%81%AA%E3%83%84%E3%83%BC%E3%83%AB-%E4%BD%9C%E6%A5%AD%E3%82%92%E9%9A%A0%E3%81%99)
> ある作業が中途半端な状態になっているときに、ブランチを切り替えてちょっとだけ別の作業をしたくなることがあります。中途半端な状態をコミットしてしまうのはいやなので、できればコミットせずにしておいて後でその状態から作業を再開したいものです。そんなときに使うのが git stash コマンドです。

使う。

```
$ git stash -h
usage: git stash list [<options>]
   or: git stash show [<stash>]
   or: git stash drop [-q|--quiet] [<stash>]
   or: git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
   or: git stash branch <branchname> [<stash>]
   or: git stash [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
		       [-u|--include-untracked] [-a|--all] [<message>]]
   or: git stash clear
```

変更したファイルをステージングした。

```
$ git status
On branch git-stash
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   posts/2015/06/04/using-git-stash.md

```

この状態で、`stash`をしてみる。

```
$ git stash
Saved working directory and index state WIP on git-stash: 8335724 Merge pull request #19 from toihrk-me/rspec-let
HEAD is now at 8335724 Merge pull request #19 from toihrk-me/rspec-let
```

そうすると、`git status`は以下のようになる。

```
$ git status
On branch git-stash
nothing to commit, working directory clean
```

また、`stash`で隠した作業の状態を元に戻して作業を再開したい場合は以下のようにする。

```
$ git stash pop
On branch git-stash
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   posts/2015/06/04/using-git-stash.md

Dropped refs/stash@{0} (c4335febdf8530ec6fa96caf52666bef6a5779b6)
```


以下によく使うであろうコマンドを示す。

- スタックする状態にコメントを加える

```
$ git stash save "Comment"
```


- スタックしたstashを一覧で表示する

```
$ git stash list
```
`git stash -p`とすれば変更内容も見れる。


- スタックした中でstashを指定して作業を再開する

```
$ git stash pop <stash名>
```
`<stash名>`は`stash@{0}`や`stash@{1}`などの名前。`stash list`とかで確認する。

`<stash名>`を省略すると直近のstashが適用される。

- スタックしたstashを消さずに変更を適用する

```
$ git stash apply <stash名>
```

`stash pop`ではスタックしていた`stash`から変更を適用し削除してしまうので、stashを保持しておきたいときに使う。

`<stash名>`を省略すると直近のstashが適用される。

- スタックしたstashを変更を適用せずに削除する

```
$ git stash drop <stash名>
```
`<stash名>`を省略すると直近のstashが適用される。

- スタックした全てのstashを削除する

```
$ git stash clear
```

