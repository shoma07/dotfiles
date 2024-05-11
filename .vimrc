" shoma07 .vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" init
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vi互換モードをオフにする
"" .vimrcがある時点でオフになるが一応設定しておく
if &compatible
 set nocompatible
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deni.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" プラグイン管理
"" "@see https://github.com/Shougo/dein.vim
"" Vim起動完了時にインストール
augroup PluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END
"" プラグインをインストールするディレクトリ
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
  "" タイムアウトを600秒にする
  let g:dein#install_process_timeout =  600
  " ここにプラグインを追加
  "" vimでgit操作を可能にする ヘルプ :help fugitive
  "" @see https://github.com/tpope/vim-fugitive
  call dein#add('tpope/vim-fugitive')
  "" gitの差分を左に表示させる
  "" @see https://github.com/airblade/vim-gitgutter
  call dein#add('airblade/vim-gitgutter')
  "" ステータスラインをカスタマイズ
  "" @see https://github.com/vim-airline/vim-airline
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  "" NERDTree ディレクトリツリーを表示・操作
  "" @see https://github.com/scrooloose/nerdtree
  call dein#add('scrooloose/nerdtree')
  call dein#add('jistr/vim-nerdtree-tabs')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  "" テキスト整形
  "" @see https://github.com/junegunn/vim-easy-align
  call dein#add('junegunn/vim-easy-align')
  "" Fuzzy Finder
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  "" テーマ
  "" @see http://colorswat.ch/vim/list?cat=all&o=star
  """ SublimeText風
  call dein#add('tomasr/molokai')
  "" @see https://github.com/Yggdroot/indentLine
  call dein#add('Yggdroot/indentLine')
  "" 不要な全角と半角の空白文字を赤くハイライト
  "" @see https://github.com/bronson/vim-trailing-whitespace
  call dein#add('bronson/vim-trailing-whitespace')
  "" 自動でキーワード補完候補を表示
  "" @see https://github.com/vim-scripts/AutoComplPop
  "" 結構古いプラグインなので使用しないことにした
  "" call dein#add('vim-scripts/AutoComplPop')
  "" 括弧補完
  "" @see https://github.com/cohama/lexima.vim
  call dein#add('cohama/lexima.vim')
  "" @see https://github.com/editorconfig/editorconfig-vim
  call dein#add('editorconfig/editorconfig-vim')
  "" @see https://github.com/dense-analysis/ale
  "" call dein#add('dense-analysis/ale')
  "" 言語ごとのプラグイン
  call dein#add('fatih/vim-go', { 'do': ':GoInstallBinaries' })
  call dein#add('posva/vim-vue')
  call dein#add('rust-lang/rust.vim')
  call dein#add('pangloss/vim-javascript')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('dart-lang/dart-vim-plugin')
  call dein#add('hashivim/vim-terraform' , { 'for': 'terraform' })
  "" @see https://github.com/neoclide/coc.nvim
  "" @see https://github.com/neoclide/coc-rls
  "" call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })
  "" LSP
  "" call dein#add('prabirshrestha/vim-lsp')
  "" call dein#add('prabirshrestha/asyncomplete.vim')
  "" call dein#add('prabirshrestha/asyncomplete-lsp.vim')
  "" call dein#add('mattn/vim-lsp-settings')
  "" call dein#add('mattn/vim-lsp-icons')
  "" !プラグイン追加
  call dein#end()
  call dein#save_state()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mouse
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" マウスの有効無効
command M call ToggleMouse()
function! ToggleMouse()
  if &mouse == ''
    set mouse=a
  elseif &mouse == 'a'
    set mouse=
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ステータスラインの設定
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {'0': '0 ', '1': '1 ', '2': '2 ', '3': '3 ', '4': '4 ', '5': '5 ', '6': '6 ', '7': '7 ', '8': '8 ', '9': '9 '}
let g:airline_theme='onedark'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTreeの設定
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"" :NT で表示非表示を切り替えられるようにする
command NT NERDTreeToggle
let g:NERDTreeGitStatusIndicatorMapCustom = {
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gitgutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vim_gitgutter
  autocmd!
  autocmd BufWritePost * GitGutter
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tpope/vim-fugitive
"" editor configの設定
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" ペースト設定 クリップボードからペーストする時だけインデントしないようにする
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_vim = {}
let g:fzf_command_prefix = 'Fzf'
let $FZF_DEFAULT_OPTS="--layout=reverse"
"" brew install ripgrep
let $FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
let g:fzf_layout = { 'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp'  } }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ale_sign_column_always = 1
" "" 変更のたびにチェックしない
" let g:ale_lint_on_text_changed = 0
" "" use QuickFix
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
" let g:ale_open_list = 1
"
" let g:ale_fixers = {
"       \ 'javascript' : ['prettier', 'eslint']
"       \ }
" let g:ale_fix_on_save = 1
" let g:ale_javascript_prettier_use_local_config = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rust.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 保存時に自動でrustfmt
let g:rustfmt_autosave = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-lsp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" let g:lsp_settings_filetype_ruby = ['ruby-lsp', 'steep']
"" let g:lsp_log_verbose = 1  " デバッグ用ログを出力
"" let g:lsp_log_file = expand('~/.cache/tmp/vim-lsp.log')  " ログ出力のPATHを設定
"" function! s:on_lsp_buffer_enabled() abort
""     setlocal omnifunc=lsp#complete
""     setlocal signcolumn=yes
""     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
""     " nmap <buffer> <C-l>d <plug>(lsp-definition)
""     " nmap <buffer> <C-l>s <plug>(lsp-document-symbol-search)
""     " nmap <buffer> <C-l>S <plug>(lsp-workspace-symbol-search)
""     " nmap <buffer> <C-l>r <plug>(lsp-references)
""     " nmap <buffer> <C-l>i <plug>(lsp-implementation)
""     " nmap <buffer> <C-l>t <plug>(lsp-type-definition)
""     " nmap <buffer> <leader>rn <plug>(lsp-rename)
""     " nmap <buffer> [g <plug>(lsp-previous-diagnostic)
""     " nmap <buffer> ]g <plug>(lsp-next-diagnostic)
""     " nmap <buffer> K <plug>(lsp-hover)
""     " nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
""     " nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
""
""     let g:lsp_format_sync_timeout = 1000
""     autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
""
""     " refer to doc to add more commands
"" endfunction
""
"" augroup lsp_install
""     au!
""     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
""     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
"" augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" grep
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" grepコマンド(:vimgrep, :Ggrep等)で結果をQuickFixに表示
augroup grep
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" 表示系の設定
"" 行番号を表示する
set number
"" カーソルラインをハイライト
set cursorline
"" カレントタブをハイライト
hi TabLineSel ctermbg=1
"" 80文字目にラインを表示
set colorcolumn=100
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
"" 行末に ↲ を挿入
set list
set listchars=eol:↲

" 検索の設定
"" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
"" 検索パターンに大文字小文字を区別しない
set ignorecase
"" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
"" 検索結果をハイライト
set hlsearch

" 編集の設定
"" 編集中のファイルが変更されたら自動で読み直す
set autoread
"" バックスペースを有効にする
set backspace=indent,eol,start
"" ファイルが外部で変更された際に自動で読み込む
set autoread
"" ファイル変更中に他のファイルを表示可能にする
set hidden

" 移動の設定
"" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore

" 補完
"" 補完候補が一つの場合でも補完メニューを表示する
set completeopt=menuone
"" 補完メニューの高さ
set pumheight=10

" OSとクリップボードを共有する
set clipboard=unnamed,autoselect
" 更新時間 ミリ秒
set updatetime=100
" 常時vim-gitgutterの列を表示する
set signcolumn=yes

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

" 新しいウィンドウを右に開く
set splitright
" 新しいウィンドウを下に開く
set splitbelow

" スワップファイルを作らない
set noswapfile

"" ステータスラインを常に表示
set laststatus=2
"" 現在のモードを表示
set showmode
"" 打ったコマンドをステータスラインの下に表示
set showcmd
"" ステータスラインの右側にカーソルの現在位置を表示する
set ruler

" ファイルタイプの自動検出
filetype plugin indent on

autocmd FileType vue syntax sync fromstart
" jbuilderをRubyのシンタックスで表示
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" シンタクッスクをリセットにする
if exists("syntax_on")
  syntax reset
endif
set t_Co=256
colorscheme molokai
let g:molokai_original=1
let g:rehash256=1
function! ToggleSyntax()
  if exists("g:syntax_on")
    syntax off
    hi clear
  else
    syntax enable
    "" vim-gitgutterのハイライト
    hi GitGutterAdd term=bold ctermfg=114 ctermbg=235
    hi GitGutterChange term=bold ctermfg=180 ctermbg=235
    hi GitGutterDelete term=bold ctermfg=204 ctermbg=235
    hi GitGutterChangeDelete term=bold ctermfg=3 ctermbg=darkgray
    hi GitGutterAddLine term=bold ctermfg=235 ctermbg=114
    hi GitGutterChangeLine term=bold ctermfg=235 ctermbg=180
    hi GitGutterDeleteLine term=bold ctermfg=235 ctermbg=204
    hi GitGutterChangeDeleteLine term=bold ctermfg=235 ctermbg=180
  endif
endfunction
" シンタックス有効化
call ToggleSyntax()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 画面サイズ変更 垂直方向
nmap <silent>> <C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>>
nmap <silent>< <C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><
"" 画面サイズ変更 水平方向
nmap <silent>+ <C-w>+<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+
nmap <silent>_ <C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-
"" ESCキー2度押しでハイライトの切り替え
nmap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
"" airblade/vim-gitgutterのコマンドにショートカットを設定
nmap gG :Ggrep<Space>
nmap gs :G<CR><C-w>J
"" git blame
nmap gb :Git blame<CR>
"" git logをグラフで出力する
nmap gl :!git<Space>log<Space>--graph<Space>--all<Space>--pretty=format:'\%Cred\%h\%Creset<Space>-\%C(yellow)\%d\%Creset<Space>\%s<Space>\%Cgreen(\%cr)<Space>\%C(bold<Space>blue)<\%an>\%Creset'<Space>--abbrev-commit<Space>--date=relative<CR>
"" git commitのショートカット(Gcommitではない)
nmap gc :!git<Space>commit<CR>
"" 差分を更新した上で行のハイライトを切り替え
nmap <silent>gh :GitGutterLineHighlightsToggle<CR>
"" vim-easy-align
map <silent>ga :LiveEasyAlign<space>*
"" スクロールが遅い時に,fでシンタックスを切り替えれるようにする
noremap <silent>,f :call ToggleSyntax()<CR>
"" fzf ファジーファインダー
nnoremap <silent> ff :FzfFiles<CR>
nnoremap <silent> fg :FzfGFiles<CR>
nnoremap <silent> fG :FzfGFiles?<CR>
nnoremap <silent> fb :FzfBuffers<CR>
nnoremap <silent> fh :FzfHistory<CR>
nnoremap <silent> fr :FzfRg<CR>
"" インサートモードの際の移動
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
"" Quit, Write
nnoremap <silent> ;w :w<CR>
nnoremap <silent> ;q :q<CR>
nnoremap <silent> ;wq :wq<CR>
