" Shoma Ohara .vimrc

if &compatible
 set nocompatible
endif

" プラグイン deni.vim
"" Vim起動完了時にインストール
augroup PluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END
"" 各プラグインをインストールするディレクトリ
let s:plugin_dir = expand('~/.vim/dein/')
"" dein.vimをインストールするディレクトリをランタイムパスへ追加
let s:dein_dir = s:plugin_dir . 'repos/github.com/Shougo/dein.vim'
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
"" dein.vimがまだ入ってなければ 最初に`git clone`
if !isdirectory(s:dein_dir)
  silent execute printf('!git clone %s %s', 'https://github.com/Shougo/dein.vim', s:dein_dir)
endif
if dein#load_state(s:plugin_dir)
    call dein#begin(s:plugin_dir)
    call dein#add('Shougo/dein.vim')
    "" ここにプラグインを追加
    """ git
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')
    """ ステータスライン
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    """ NERDTree
    call dein#add('scrooloose/nerdtree')
    call dein#add('jistr/vim-nerdtree-tabs')
    call dein#add('Xuyuanp/nerdtree-git-plugin')
    """ Atom
    call dein#add('joshdick/onedark.vim')
    """ Yggdroot/indentLine インデントをわかりやすする
    call dein#add('Yggdroot/indentLine')
    """ bronson/vim-trailing-whitespace 末尾の全角と半角の空白文字を赤くハイライト
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('vim-scripts/AutoComplPop')
    "" !プラグイン追加
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on

" エンコード設定
set encoding=utf-8
scriptencoding utf-8
"" 保存時の文字コード
set fileencoding=utf-8
"" 読み込み時の文字コードの自動判別. 左側が優先される
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
"" 改行コードの自動判定・左側が優先される
set fileformats=unix,dos,mac
"" 文字が崩れる問題を解決
set ambiwidth=double

" netrw.vimの設定
"" 上部に表示される情報を非表示
let g:netrw_banner = 0
"" netrwは常にtree view
let g:netrw_liststyle = 3
"" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
"" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1
"" 分割で開いたときに85%のサイズで開く
let g:netrw_winsize = 85

" NERDTree
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
command NT NERDTreeToggle
let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "✹",
  \ "Staged"    : "✚",
  \ "Untracked" : "✭",
  \ "Renamed"   : "➜",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "✖",
  \ "Dirty"     : "✗",
  \ "Clean"     : "✔︎",
  \ 'Ignored'   : '☒',
  \ "Unknown"   : "?"
\ }


set splitright
set splitbelow

" git
autocmd QuickFixCmdPost *grep* cwindow
nnoremap gh :GitGutterLineHighlightsToggle<CR>
nnoremap gs :Gstatus<CR><C-w>J
nnoremap gd :Gwrite
nnoremap gl :!git<Space>log<Space>--graph<Space>--all<Space>--pretty=format:'\%Cred\%h\%Creset<Space>-\%C(yellow)\%d\%Creset<Space>\%s<Space>\%Cgreen(\%cr)<Space>\%C(bold<Space>blue)<\%an>\%Creset'<Space>--abbrev-commit<Space>--date=relative<CR>
nnoremap gc :!git<Space>commit<CR>

" カラースキーマ
highlight clear
"" シンタクッスクハイライトをオンにする
syntax enable
if exists("syntax_on")
  syntax reset
endif
set t_Co=256
let g:colors_name="onedark"
let g:onedark_termcolors=256
set background=dark
"" スクロールが遅い時に,fでシンタックスを切り替えれるようにする
noremap <silent> ,f :if exists("g:syntax_on")\|syntax off\|else\|syntax enable\|endif<CR>

" vim-airline ステータスラインの設定
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {'0': '0 ', '1': '1 ', '2': '2 ', '3': '3 ', '4': '4 ', '5': '5 ', '6': '6 ', '7': '7 ', '8': '8 ', '9': '9 '}
let g:airline_theme='onedark'
"" ステータスラインを常に表示
set laststatus=2
"" 現在のモードを表示
set showmode
"" 打ったコマンドをステータスラインの下に表示
set showcmd
"" ステータスラインの右側にカーソルの現在位置を表示する
set ruler

" マウス操作を有効にする
set mouse=a

" 表示系の設定
"" 行番号を表示する
set number
hi LineNr cterm=NONE ctermfg=grey ctermbg=darkgray
"" カーソルラインをハイライト
set cursorline
hi clear CursorLine
"" カレントタブをハイライト
hi TabLineSel ctermbg=1
"" 対応括弧に<と>のペアを追加
set matchpairs& matchpairs+=<:>
"" 対応括弧をハイライト表示する
set showmatch
"" 対応括弧の表示秒数を3秒にする
set matchtime=3
"" 不可視文字を表示
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
"" 全角括弧関連
set matchpairs+=「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”

" タブの設定
"" タブ入力を複数の空白入力に置き換える
set expandtab
"" 画面上でタブ文字が占める幅
set tabstop=2
"" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=2
"" 改行時に前の行のインデントを継続する
set autoindent
"" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
"" smartindentで増減する幅
set shiftwidth=2

" 検索の設定
"" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
"" 検索パターンに大文字小文字を区別しない
set ignorecase
"" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
"" 検索結果をハイライト
set hlsearch
"" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" 編集の設定
"" バックスペースを有効にする
set backspace=indent,eol,start
"" ファイルが外部で変更された際に自動で読み込む
set autoread
"" ファイル変更中に他のファイルを表示可能にする
set hidden

" 補完
set completeopt=menuone

" OSとクリップボードを共有する
set clipboard=unnamed,autoselect

" キーバインド・エイリアス設定
"" 画面サイズ変更
nnoremap <C-w>, <C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>>
nnoremap <C-w>. <C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><
"" バッファ
nnoremap <C-s>b :ls<CR>:buf
"" インサートモードの際の移動
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"" 辞書
if isdirectory(expand('~/.vim/dict'))
  autocmd FileType rb   :set dictionary=~/.vim/dict/ruby.dict
  autocmd FileType rake :set dictionary=~/.vim/dict/ruby.dict
endif
