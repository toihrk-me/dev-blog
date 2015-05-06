# [uninitialized constant Sprockets::SassCacheStoreってエラーメッセージが表示される](/2015/05/07/uninitialized-constant-Sporkets::SassCacheStore.html)

compass-railsを使おうとしたらステータスコード500と共に

```
NameError - uninitialized constant Sprockets::SassCacheStore:
...
```
と出る。

環境は関連ありそうなところを抜粋すると

```
$ bundle | grep rails
Using compass-rails 2.0.1
Using sprockets-rails 2.2.4
Using rails 4.2.1
```
こんな感じ。


調べてみる。

[uninitialized constant Sprockets::SassCacheStore when upgrading to latest · Issue #324 · rails/sass-rails](https://github.com/rails/sass-rails/issues/324)


> Hi, I manage to solve the issue by fix the gem compass-rails to version 2.0.2 or more
There's this fix
Compass/compass-rails@f2a1450
Please correct me if I'm wrong xD

compass-railsの2.0.4が引けてないみたいだから、GemfileでGitHubのリポジトリを参照してみる。

```ruby:Gemfile
gem 'compass-rails', github: "Compass/compass-rails", branch: "master"
```

```
$ bundle | grep compass-rails
Using compass-rails 2.0.4 from git://github.com/Compass/compass-rails.git (at master)
```

これで解決した。