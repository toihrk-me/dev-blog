# [vimに入門する](/2015/07/18/lesson-vim.html)

仕事がひとまず片付いたのでプライベートでVimに入門してみようと思う。

エディターは仕事ではAtomとEmacsを使っていて、Atomを採用しているのも「21世紀になってスクリーンエディタなんか使ってられるかよ」みたいな感じで、いざスクリーンエディタをGitかなんかで起動されるとEmacsが起動するようになっている。Emacsも本来GNU Emacsが起動される前提で設定を作っているのでターミナル上で起動されると素のEmacsになってしまう。

Emacsで全部できれば良いのだけれど、それも無理な話で、設定肥やすのにもelispがどうにもこうにもアレなので、この際Vimに入門してみようと思う。

目標は、この際AtomもEmacsも捨てて基本的にプライベートも仕事もVimでコードなりなんなりが書けるようになること。時間があったら、「22世紀のエディタってこうなってるよね」みたいなエディタを自作してみたい、Electronで。

## 環境

- OS X 10.10.2
- zsh
- vim 7.4.712

vimはbrewでインストールした。

## 前準備
いたずら心というかなんというか、zshで以下のような設定をしていたので、コメントアウトする。

```
alias vi="emacs"
alias vim="emacs"
```

## 事始め

Vimのことを何にも知らないので少し調べる。
学生時代、3つだか4つだか上の先輩は、「キーの同時押しができなかった時代のエディタだからEmacsより高尚なエディタだ」とかって言ってたけれど、今は2015年だしキーバインドはEmacsの方が優れていると思う。

ただ、思ったところにカーソルが動かせるVimmerにはすごく憧れる。

**ちなみに宗教戦争をする気は毛頭ない。本当に不毛な話題なのでみんな好きなエディタ使えばいいと思う。**

[Vim Cheat Sheet](http://vim.rtorr.com/lang/ja/)

当分の間はこれを見ながらやっていくと思う。


## vimrcをつくる

早速Vimを使う。

```
$ vim ~/.vimrc
```

ネットから拾ってきたものをインサートモード(i)にしてコピペする。

```
filetype plugin indent on

syntax on

set nowrap

set hlsearch
set ignorecase
set smartcase

set autoindent

set ruler
set number
set list
set wildmenu
set showcmd

set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
set smarttab

set clipboard=unnamed
```

`:w`として保存し、`:source ~/.vimrc`とすると設定が反映する。


## NeoBundleを導入する

[Shougo/neobundle.vim](https://github.com/Shougo/neobundle.vim)

便利そうなので導入する。

```
 $ curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
 $ sh ./install.sh
```

## NeoBundleでなんかいれてみる

以下のように書いた。

```
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'grep.vim'
NeoBundle 'Shougo/neocomplcache'


call neobundle#end()
```

特に設定は書いてないので、ちょこちょこいじっていく。

### altercation/vim-colors-solarized

[altercation/solarized](https://github.com/altercation/solarized)

カラースキームをいれた。

```
syntax enable
set background=dark
colorscheme solarized
```

### scrooloose/nerdtree

[scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)

ディレクトリをツリー表示できるやつ。
入れるだけで特に設定は必要ないっぽいけれど起動するたびに`:NERDTreeToggle`とタイプするのは面倒なので、キーマップを書く。

```
nnoremap <silent><C-e> :NERDTreeToggle<CR>
```

`Control+e`で起動できるようになる。


### Townk/vim-autoclose

[Townk/vim-autoclose](https://github.com/Townk/vim-autoclose)

括弧とかを自動で閉じてくれるやつ。特に設定の必要はない。


### grep.vim

[vim-scripts/grep.vim](https://github.com/vim-scripts/grep.vim)

grepしてくれるやつ。GithubのリポジトリのREADMEに使い方が詳しく書いてある。  


### Shougo/neocomplcache

[Shougo/neocomplcache.vim](https://github.com/Shougo/neocomplcache.vim)

入力補完するやつ。

[e-jigsaw/dotfiles/blob/master/.vimrc](https://github.com/e-jigsaw/dotfiles/blob/master/.vimrc)
を参考にした。

```
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
```

## VimでRailsアプリを書く

仕事でもプライベートでもここ最近はRailsアプリ、もといRubyのコードしか書いていないので、とりあえずRubyが書けてかつRailsアプリを書く上でも便利な感じにしたい。

2年前の記事だけど、参考にした。

[vim使っているrubyistで、これ入れていないのはヤバいプラグインまとめ 9個 (2013-10-04更新) - Qiita](http://qiita.com/alpaca_taichou/items/ab2ad83ddbaf2f6ce7fb)


## 最終的なvimrc

[https://gist.github.com/65cd4cbfa691b06b578e.git](https://gist.github.com/65cd4cbfa691b06b578e.git)

ちょこちょこエラーを直していこうと思ってる。

整理してちゃんと管理してるリポジトリにも早く加えたい。

[toihrk/dotfiles](https://github.com/toihrk/dotfiles)

