" shoma07 .vimrc

" vi互換モードをオフにする
"" .vimrcがある時点でオフになるが一応設定しておく
if &compatible
 set nocompatible
endif

" プラグイン管理
"" deni.vim
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
  "" タグジャンプ
  "" @see https://github.com/szw/vim-tags
  call dein#add('shoma07/vim-tags')
  "" 関数やクラスを一覧させる Ctagsが必要
  "" @see https://github.com/majutsushi/tagbar
  call dein#add('majutsushi/tagbar')
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
  "" @see https://github.com/neoclide/coc.nvim
  "" @see https://github.com/neoclide/coc-rls
  call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })
  "" !プラグイン追加
  call dein#end()
  call dein#save_state()
endif

" ファイルタイプの自動検出
filetype plugin indent on

autocmd FileType vue syntax sync fromstart

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

" マウスの有効無効
command M call ToggleMouse()
function! ToggleMouse()
  if &mouse == ''
    set mouse=a
  elseif &mouse == 'a'
    set mouse=
  endif
endfunction

" vim-easy-align
nmap <silent>ga :LiveEasyAlign<space>*
xmap <silent>ga :LiveEasyAlign<space>*

" majutsushi/tagbar
nmap <silent>tb :TagbarToggle<CR>

" カラースキーマ
"" シンタクッスクをリセットにする
if exists("syntax_on")
  syntax reset
endif
set t_Co=256
colorscheme molokai
let g:molokai_original=1
let g:rehash256=1
"" スクロールが遅い時に,fでシンタックスを切り替えれるようにする
noremap <silent>,f :call ToggleSyntax()<CR>
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

" grepコマンド(:vimgrep, :Ggrep等)で結果をQuickFixに表示
augroup grep
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

" airblade/vim-gitgutterのコマンドにショートカットを設定
"" 更新時間 ミリ秒
set updatetime=100
"" 常時vim-gitgutterの列を表示する
set signcolumn=yes
"" 差分を更新した上で行のハイライトを切り替え
nmap <silent>gh :GitGutterLineHighlightsToggle<CR>
augroup vim_gitgutter
  autocmd!
  autocmd BufWritePost * GitGutter
augroup END
" tpope/vim-fugitive
nmap gs :Gstatus<CR><C-w>J
" git logをグラフで出力する
nmap gl :!git<Space>log<Space>--graph<Space>--all<Space>--pretty=format:'\%Cred\%h\%Creset<Space>-\%C(yellow)\%d\%Creset<Space>\%s<Space>\%Cgreen(\%cr)<Space>\%C(bold<Space>blue)<\%an>\%Creset'<Space>--abbrev-commit<Space>--date=relative<CR>
" git commitのショートカット(Gcommitではない)
nmap gc :!git<Space>commit<CR>
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

" aleの設定
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

" rust.vim
"" 保存時に自動でrustfmt
let g:rustfmt_autosave = 1

""""""""""""" coc.nvim
"" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
"" Give more space for displaying messages.
""" set cmdheight=2
"" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"" delays and poor user experience.
""" set updatetime=300
"" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
"" Always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
""" if has("nvim-0.5.0") || has("patch-8.1.1564")
"""   " Recently vim can merge signcolumn and number column into one
"""   set signcolumn=number
""" else
"""   set signcolumn=yes
""" endif
"" Use tab for trigger completion with characters ahead and navigate.
"" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()
"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"" Use `[g` and `]g` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
"" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
"" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
"" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
"" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
"" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)
"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
"" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
"" Use CTRL-S for selections ranges.
"" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
"" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
"" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
"" Add (Neo)Vim's native statusline support.
"" NOTE: Please see `:h coc-status` for integrations with external plugins that
"" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"" Mappings for CoCList
"" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
""""""""""""" coc.nvim

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
"" ESCキー2度押しでハイライトの切り替え
nmap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

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

" 画面サイズ変更
"" 垂直方向
nmap <silent>> <C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>>
nmap <silent>< <C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><
"" 水平方向
nmap <silent>+ <C-w>+<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+
nmap <silent>_ <C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-

" インサートモードの際の移動
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" 日本語入力モードのままでも一定の操作ができるようにする
nmap ：w :w<CR>
nmap ：q :q<CR>
nmap ：wq :wq<CR>
nmap ：bd :bd<CR>
nmap あ a
nmap い i
nmap う u
nmap お o
nmap っd dd
nmap っy yy

" シンタックス有効化
call ToggleSyntax()
