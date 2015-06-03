# [Gitで誤ってaddしたファイルをステージ対象から取り除く](/2015/06/03/git-reset-head.html)

Gitは`working directory`, `staging area`, `git directory (repository)`という概念があり、これによりプロジェクトを管理してる。

![Local Operations 作業ディレクトリ、ステージング・エリア、Gitディレクトリ](https://git-scm.com/figures/18333fig0106-tn.png)

画像引用: [Git - Gitの基本](https://git-scm.com/book/ja/v1/%E4%BD%BF%E3%81%84%E5%A7%8B%E3%82%81%E3%82%8B-Git%E3%81%AE%E5%9F%BA%E6%9C%AC)

`working directory`で作業を行い、`staging area`で次のコミットにどんな変更が含まれるかという情報を蓄積し、コミットによりスナップショットを`git directory`に格納する。

`working directory`から`staging area`にファイルを追加する際、普通以下のようにする。

```
$ git add <File or Directory>
```

ここで誤って次のコミットに含めないファイルをステージングしてしまったとき以下のようにして`staging area`から除外する。

```
$ git reset HEAD <File or Directory>
```

除外されたファイルは変更された状態のまま、`staging area`から除外される。

そもそもステージングしてしまったファイルを全て`staging area`から除外したいときは以下のようにする。

```  
$ git reset HEAD
```

