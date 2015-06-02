# [Githubでforkしたリポジトリでオリジナルリポジトリの変更を追従する](/2015/06/02/github-fork-usage.html)

Githubでforkしたリポジトリで、オリジナルリポジトリの変更を追従する。

リモートリポジトリとしてオリジナルのリポジトリを`upstream`という名前で設定する。

```
$ git remote add upstream git://github.com/#{USERNAME}/#{REPO}.git
```

設定した状態で、以下のように`fetch`するとオリジナルでの変更がローカルリポジトリでも参照できる。

```
$ git fetch upstream
```

例えば以下のようになる。

```
$ git branch -a
* develop
  master
  remotes/origin/develop
  remotes/origin/master
  remotes/upstream/master
```

`upstream/master`を作業を行っている`develop`ブランチにマージする。

```
$ git branch
* develop
  master

$ git merge upstream/master
```

これでオリジナルのリポジトリの変更を作業をしているブランチに取り込むことができる。

ちなみに`rebase`する場合は以下のような感じ。

```
$ git rebase upstream/master
```

