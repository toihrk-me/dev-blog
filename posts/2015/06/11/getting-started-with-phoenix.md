# [Phoenixを触ってみる](/2015/06/11/getting-started-with-phoenix.html)

Elixirに入門してみたくて、とりあえず文法とか眺めてると眠くなってしまうのでWebフレームワークのPhoenixを触ってみる。

Elixirについては

- homebrewでElixirはインストールしてみた
- mixはRubyのbundlerとrakeをいい感じにしたヤツ
- elixirの文法についはまったく知らない

な感じで、本来ならばちゃんと文法から勉強すべきだけれど動くモノが作りたいので今回はWebフレームワークであるPhoenixで遊ぶ。

[phoenixframework/phoenix](https://github.com/phoenixframework/phoenix)

[Phoenix](http://www.phoenixframework.org/)

`v0.13.1`の[Getting Started with Phoenix · Phoenix](http://www.phoenixframework.org/v0.13.1/docs/getting-started)を参照しながら入門する。

## Getting Started with Phoenix

> Requirements
Elixir v1.0.2+

Elixirの`v1.0.2`以上が必要になるらしい。

Homebrewでインストール済みなのでインストール方法は割愛する。

```
$ elixir -v
Elixir 1.0.4
```

現時点で最新バージョンの`v1.0.4`を使う。

ElixirにPhoenixをインストールする。
[Getting Started with Phoenix · Phoenix](http://www.phoenixframework.org/v0.13.1/docs/getting-started)だと`git checkout v0.11.0`となってるが今回は`git checkout v0.13.1`としてPhoenixの`v0.13.1`を使う。

```
$ git clone https://github.com/phoenixframework/phoenix.git \
&& cd phoenix && git checkout v0.13.1 && mix do deps.get, compile
```

実行すると`mix phoenix`が実行できるようになる。

`hello_phoenix`という名前で雛形を作る。

```
$ mix phoenix.new hello_phoenix && cd hello_phoenix
```

とりあえず、サーバを起動してみる。

```
$ mix phoenix.server 
...
== Compilation error on file web/views/layout_view.ex ==
** (CompileError) web/views/layout_view.ex:2: module Phoenix.HTML is not loaded and could not be found
    (elixir) expanding macro: Kernel.use/1
    web/views/layout_view.ex:2: HelloPhoenix.LayoutView (module)
    expanding macro: HelloPhoenix.Web.__using__/1
    web/views/layout_view.ex:2: HelloPhoenix.LayoutView (module)
    (elixir) expanding macro: Kernel.use/2
    web/views/layout_view.ex:2: HelloPhoenix.LayoutView (module)


== Compilation error on file web/views/page_view.ex ==
** (CompileError) web/views/page_view.ex:2: module Phoenix.HTML is not loaded and could not be found
    (elixir) expanding macro: Kernel.use/1
    web/views/page_view.ex:2: HelloPhoenix.PageView (module)
    expanding macro: HelloPhoenix.Web.__using__/1
    web/views/page_view.ex:2: HelloPhoenix.PageView (module)
    (elixir) expanding macro: Kernel.use/2
    web/views/page_view.ex:2: HelloPhoenix.PageView (module)


== Compilation error on file web/views/error_view.ex ==
** (CompileError) web/views/error_view.ex:2: module Phoenix.HTML is not loaded and could not be found
    (elixir) expanding macro: Kernel.use/1
    web/views/error_view.ex:2: HelloPhoenix.ErrorView (module)
    expanding macro: HelloPhoenix.Web.__using__/1
    web/views/error_view.ex:2: HelloPhoenix.ErrorView (module)
    (elixir) expanding macro: Kernel.use/2
    web/views/error_view.ex:2: HelloPhoenix.ErrorView (module)
```

めっちゃコンパイルが走ってエラーが出る。

`Phoenix.HTML`というモジュールが見つからないらしい。

`mix.exs`を確認してみる。

```elixir
defmodule HelloPhoenix.Mixfile do
  ### 
  defp deps do
    [{:phoenix, "~> 0.11"},
     {:phoenix_ecto, "~> 0.3"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_live_reload, "~> 0.3"},
     {:cowboy, "~> 1.0"}]
  end
  ###
end
```

この配列内に`{:phoenix_hrml, "~> 1.0"}`を追加する。

```
[{:phoenix, "~> 0.11"},
     {:phoenix_ecto, "~> 0.3"},
     {:phoenix_html, "~> 1.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_live_reload, "~> 0.3"},
     {:cowboy, "~> 1.0"}]
```

依存関係を解決する。

```
$ mix deps.get
```

再度サーバを起動する。

```
$ mix phoenix.server
```

http://localhost:4000/ にアクセスすると「Welcome to Phoenix!」と大きく表示される。

![hello_phoenix.png](http://i.gyazo.com/9fd5850af11416a0c6710a342a640834.png)

## Adding Pages

ページを追加する前に `/` でアクセスされるページを編集してみたいと思う。

```
web
├── channels
├── controllers
├── models
├── router.ex
├── templates
│   ├── layout
│   └── page
│       └── index.html.eex
└── views
```

プロジェクトルートのwebディレクトリ以下、`templates/page/index.html.eex`というのが怪しい。

それっぽいので編集して保存してみるとブラウザがオートリロードされる。

![auto-load-demo.gif](http://i.gyazo.com/a161a9440f6d26f342b87a5bbdae2d01.gif)

### ページを追加する
ルーティングは `router.ex`っていうのがどう見てもそれっぽい。

```
defmodule HelloPhoenix.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloPhoenix do
  #   pipe_through :api
  # end
end
```

`scope "/", HelloPhoenix`ブロックに以下のような行を追加する。

```
get "/hello", PageController, :hello
```

`web/controllers/page_controller.ex`を以下のように編集する。

```
defmodule HelloPhoenix.PageController do
  use HelloPhoenix.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def hello(conn, _params) do
    render conn, "hello.html"
  end
end
```
`web/templates/page/`以下に `hello.html.eex`を追加して以下のように編集する。

```
<h1>Hello</h1>
```
http://localhost:4000/hello で動作を確認する。

ページが追加できた。

### コントローラも追加する

`web/controllers`以下に`hello_controller.ex`を追加して以下のように編集する。

```
defmodule HelloPhoenix.HelloController do
  use HelloPhoenix.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
```

`web/templates`以下に`hello`ディレクトリを追加し`web/templates/page/hello.html.eex`をリネームして`web/templates/hello/index.html.eex`に変更する。

`scope "/", HelloPhoenix`ブロックに以下に先程追加した行も以下のように編集する。

```
get "/hello", HelloController, :index
```

`web/views`以下に`hello_view.ex`を追加して以下のように編集する。

```
defmodule HelloPhoenix.HelloView do
  use HelloPhoenix.Web, :view
end
```

http://localhost:4000/hello で動作を確認する。

### URLからパラメータを取得してViewに表示する

ルーティングを追加する。

`router.ex`の`scope "/", HelloPhoenix`ブロックに以下の行を追加する。

```
get "/hello/:message", HelloController, :message
```

`hello_controller.ex`に以下のメソッドを追加する。

```
def message(conn, %{"message" => message}) do
  render conn, "message.html", message: message
end
```

`web/templates/hello`以下に`message.html.eex`を追加し、以下のように編集する。

```
<div class="jumbotron">
  <h2>Hello <%= @message %></h2>
</div>
```

とりあえず http://localhost:4000/hello/hoge で動作を確認する。

![hello-hoge.gif](http://i.gyazo.com/c53104380be53783c834eb35871f47aa.gif)

## Mix Tasks

ふと思い立って、phoenixの提供しているmixのタスクを見てみた。

[Mix Task](http://www.phoenixframework.org/v0.13.1/docs/mix-tasks)

```
$ mix help | grep -i phoenix
mix phoenix.digest      # Digests and compress static files
mix phoenix.gen.channel # Generates a Phoenix channel
mix phoenix.gen.html    # Generates controller, model and views for an HTML-based resource
mix phoenix.gen.json    # Generates a controller and model for an JSON-based resource
mix phoenix.gen.model   # Generates an Ecto model
mix phoenix.new         # Create a new Phoenix v0.13.1 application
mix phoenix.routes      # Prints all routes
mix phoenix.server      # Starts applications and their servers
```
なるほど、まるでRailsだ。


## Ecto Models

英語が読めないので以下のコマンドをとりあえず実行してみる。

```
$ mix phoenix.gen.html Note notes title:string body:text
```

`router.ex`の`scope "/", HelloPhoenix`ブロックに以下の行を追加する。

```
resources "/notes", NoteController
```

以下のコマンドを実行する。

```
$ mix ecto.create
$ mix ecto.migrate
```

http://localhost:4000/notes にアクセスしてみる。

![create note](http://i.gyazo.com/8f75fa120186dc3aa99280dedae30a2d.gif)

Railsのscaffoldっぽい。


## 所感

- Railsより良さそう
- Twitter Bootstrapが初期状態から組み込まれていて良さそう
- ERBっぽいPhoenixHTMLだけれど調べてみたらhamlみたいなテンプレートエンジンみたいなのもあって良さそう

DBにデータを永続化してよしなにできそうな気がしてきたので、趣味で使い始めようと思う。

Elixirの文法については全然理解が及ばないけれど「習うより慣れろ」「百聞は一見にしかず」なにかやりたいことができたらドキュメント読む感じで進めようと思う。












