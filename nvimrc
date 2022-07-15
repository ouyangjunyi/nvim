" vim:ts=4:sw=2:et
" @author: ouyangjunyi <zldark@126.com>

if has("win64") || has("win32") || has("win16")
  let g:platform="Windows"
else
  let g:platform=substitute(system('uname'), '\n', '', '')
endif

set nocompatible

" to insert space characters whenever the tab key is pressed C-V<Tab> for real
" tab character
set number
"set relativenumber
set showmode        " show mode info in the right bottom
set ruler           " always show current position
set mat=2
set showmatch       " show matching bracets when text indicator is over them
"set autoindent     " cindent and smartindent do better
                    " after set all the thing about the tab, type :retab to change the existing tab
set wrap
set textwidth=99
set smarttab
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4   " <BS> will delete tabstop spaces from now on
set backspace=indent,eol,start  " enable the backspace in the insert mode wherever you hit it
set linebreak       " break a line between the words
set mousemodel=popup " a popup menu will appear when you press mouse 3
" set mouse=a
set hidden          " from now on, you can change buffer without saving it

set formatoptions+=m

set autowriteall    " autowrite the file when do some other actions. when you hide some buffers,
                    " and they are modified, they become hidden without typing [!]
set incsearch       " move the cursor to the matched word

set hlsearch        " highlight the searched result in current document, use :nohlsearch to disable
                    " it temporarily
" set ignorecase
set smartcase
set history=700     " how many lines of history VIM has to remember
set shortmess=a     " short message mode
set cmdheight=1     " where the hell change my default value
set wildmenu
set wildmode=full
set splitright      ""set splitbelow " make the new window appears below the current window
                    " make the new window appears in right(only 6.0+ version can do a vsplit
set noerrorbells novisualbell t_vb=     " turn the beeping and visual bell off
set autoread        " set to autoread when a file is changed from the outside
set magic
set laststatus=2    " always show statusline
" set list            " show trailing whitespace
" set cursorline

if !&scrolloff
  set scrolloff=3
endif

if !&sidescrolloff
  set sidescrolloff=5
endif

" Restore things from viminfo while vim starting up:
" - '10  : Marks will be remembered for up to 10 previously edited files
" - "100 : Saves up to 100 lines for each register
" - :20  : Remebers up to 20 lines of command-line history
" - %    : Saves and restores the buffer list
" - n... : Where to save the viminfo files
set viminfo=\'10,\"100,:20,n~/.nviminfo

set encoding=utf-8
let &termencoding=&encoding
set fileencodings=utf-8,cp936,ucs-bom
set t_Co=256                            " 256 colors in terminal
set laststatus=2

syntax on
filetype on
filetype plugin on
filetype indent on

function ExtraOptionsForCPP()
  iab #i #include
  iab #d #define
  iab #e #endif
  iab #p #pragma
  "setlocal nowrap cinoptions=:0g0t0(0U1W4
endfunction

autocmd FileType *                  set colorcolumn=+1,+2,+3,+4,+5,+6,+7,+8,+9,+10
autocmd FileType zsh,vim,cmake      set shiftwidth=2 tabstop=2 softtabstop=2 nowrap
autocmd FileType sh                 set shiftwidth=4 tabstop=4 softtabstop=4 nowrap
autocmd FileType gitcommit          set textwidth=72
autocmd FileType gitconfig          set shiftwidth=4 tabstop=4 softtabstop=4 nowrap
autocmd FileType c,cpp              call ExtraOptionsForCPP()

autocmd BufRead,BufNewFile *.mm set filetype=objc

" path for looking for header files
set path+=.,,../**,/usr/include/**,/usr/local/include/**

" automatic suffix for `gf`
"set suffixesadd+=.py,.rb,.lua

"" Vim builtin configurations for tags
" For python
" Configurations for ctags is in '~/.ctags'
" $ ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./.tags .
" $ ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./.tags \
"   $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""}  plugins {
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""  Vim-Plug {{{
" Auto-install vim-plug if necessary
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
" nvim
silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" vim
"  silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs
"        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('$HOME/.nvim/bundle')
let g:plug_shallow = 0

"" ---------Begining of plugins managed by Vim-Plug --------------

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" 让互联网上的设备可以访问
let g:mkdp_open_to_the_world = 1
" 回显预览地址链接，方便跳转
let g:mkdp_echo_preview_url = 1
" 设置云服务器的ip，根据实际设置
let g:mkdp_open_ip = 'localhost'
" 指定端口号
let g:mkdp_port = '216'
nmap <leader>m <Plug>MarkdownPreview


Plug 'mg979/vim-visual-multi', {'branch': 'master'}  "多光标


Plug 'junegunn/goyo.vim' " 专注模式
map <LEADER>gy :Goyo<CR>

Plug 'vim-autoformat/vim-autoformat'
noremap <F3> :Autoformat<CR>

Plug 'airblade/vim-gitgutter' "git block code
" let g:gitgutter_signs = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>


Plug 'kshenoy/vim-signature' " bookmark

Plug 'mg979/vim-xtabline'  " 顶部栏  :h xtabline.txt
nmap <leader>tb :XTabMode<CR>

Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<CR>

Plug 'puremourning/vimspector' " debug tool
let g:vimspector_enable_mappings = 'HUMAN'
Plug 'itchyny/calendar.vim'

"" github gist
Plug 'mattn/vim-gist'
Plug 'mattn/webapi-vim'
let g:gist_detect_filetype = 1
let github_user = 'ouyangjunyi'
let g:gist_token = 'xxx'
let g:gist_post_private = 1

" https://github.com/settings/tokens

"" AI

Plug 'neoclide/coc.nvim', {'branch': 'release'}
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)


" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


"Plug 'github/copilot.vim'    "not support vim8; need neovim
"
"Tabnine   :CocInstall coc-tabnine
"
Plug 'preservim/tagbar' " a class outline viewer
nmap <leader>tt :TagbarToggle<CR>

"" snippets
Plug 'honza/vim-snippets'
imap <C-l> <Plug>(coc-snippets-expand)
" CocInstall coc-snippets
"CocConfig 'snippets.userSnippetsDirectory': '/root/.config/nvim/snippets' todo backup sync

"" Themes and styles
Plug 'tomasr/molokai'                     " Theme molokai
Plug 'altercation/vim-colors-solarized'   " Theme solarized
Plug 'morhetz/gruvbox'                    " Theme gruvbox
Plug 'raphamorim/lucario'                 " Theme lucario
Plug 'kyoz/purify', { 'rtp': 'vim' }      " Theme purify
Plug 'godlygeek/csapprox'                 " Make GVim-Only colorschemes work transparently in terminal Vim
Plug 'jacoborus/tender.vim'               " Theme tender
Plug 'ryanoasis/vim-devicons'             " File type icons to Vim plugins

"" Language Syntax
Plug 'uarun/vim-protobuf'                 " Vim syntax highlighting for Google's Protocol Buffers
Plug 'sheerun/vim-polyglot'               " Lang syntax and color themes
Plug 'chr4/nginx.vim'                     " Improved nginx vim plugin
Plug 'glench/vim-jinja2-syntax'           " An up-to-date jinja2 syntax file

"" Enhanced Action
Plug 'godlygeek/tabular'                  " Vim script for text filtering and alignment
Plug 'tpope/vim-surround'                 "
Plug 'tpope/vim-speeddating'              "
Plug 'vim-scripts/a.vim'                  " :A
Plug 'wellle/targets.vim'                 " Provides additional text objects
Plug 'michaeljsmith/vim-indent-object'    " Defines a new text object based on indentation levels: iI
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'                 " A git wrapper
nnoremap <silent> <Leader>gb  :Git blame<CR>
Plug 'tpope/vim-repeat'                   " Enable repeating supported plugin maps with .

"" Window Enhancement
Plug 'yssl/qfenter'                       " Open a quickfix item in a window you choose
Plug 'tpope/vim-vinegar'                  " Extended netrw
Plug 'mtth/scratch.vim'                   " Scratch window automatically hides when inactive

Plug 't9md/vim-choosewin'
" invoke with '-'
nmap -  <Plug>(choosewin)

"" A tree explorer plugin for vim
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>c :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1

"" vim-maximizer
Plug 'szw/vim-maximizer'
" Default toggle key binding: <F3>

"" Vim support for Bazel
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'
Plug 'bazelbuild/vim-ft-bzl'
let g:no_google_python_indent=1

"" minibufexpl
Plug 'fholgado/minibufexpl.vim'
nnoremap <F12>               <ESC>:MBEToggle<CR>
let g:miniBufExplorerAutoStart = 0
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplSplitBelow =1
let g:miniBufExplVSplit = 32
let g:miniBufExplModSelTarget = 1

"" listtoggle
Plug 'valloric/listtoggle'
let g:lt_location_list_toggle_map = '<Leader>l'
let g:lt_quickfix_list_toggle_map = '<Leader>q'
let g:lt_height = 30
""" Quickfix vs. Location List
""
"" A location list is similar to a quickfix list and contains a list of
"" positions in files. A loctaion list is asscociated with a window and
"" each window can have a separate location list...The location list commands
"" are similar to the quickfix commands, replacing the 'c' prefix in the
"" quickfix command with 'l'.

"" matchit provided by vim
runtime macros/matchit.vim

"" python-mode
Plug 'python-mode/python-mode', { 'do': 'git submodule update --init --recursive', 'branch': 'develop' }
let g:pymode = 1
let g:pymode_syntax = 1
let g:pymode_python = "python3"
let g:pymode_debug = 0
let g:pymode_indent = 1
let g:pymode_warnings = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_folding = 0
let g:pymode_motion = 1
let g:pymode_options = 1
let g:pymode_options_max_line_length = 79
let g:pymode_options_colorcolumn = 0
let g:pymode_lint = 1
let g:pymode_lint_on_write = 0
let g:pymode_lint_unmodified = 0
let g:pymode_lint_on_fly = 0
let g:pymode_lint_message = 1
let g:pymode_lint_ignore = ["E501", "E402"]
let g:pymode_virtualenv = 0
let g:pymode_run = 0
let g:pymode_run_bind = "<Leader>r"
let g:pymode_breakpoint = 0
let g:pymode_breakpoint_bind = "<Leader>b"
autocmd FileType python nnoremap <silent> <F6> :PymodeLint<CR>

"" ALE (async lint engine)
Plug 'w0rp/ale'
"
let g:ale_linters = {
      \ "python": [],
      \ "lua": ["luacheck"],
      \ "rust": ["cargo"],
      \ "sh": [""],
      \ "c": ["clangcheck", "clang", "cppcheck", "gcc"],
      \ "cpp": ["clangcheck", "clang", "cppcheck", "g++"],
      \}
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
" vim-airline integrates with ALE for displaying error information in the status bar.
let g:airline#extensions#ale#enabled = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
"
autocmd FileType rust,c,cpp,sh nnoremap <silent> <F6> :ALELint<CR>

"" vim-better-whitespace
Plug 'ntpeters/vim-better-whitespace'     " Highlight and strip trailing whitespace characters
let g:better_whitespace_enabled = 1
let g:strip_only_modified_lines = 1
let g:strip_whitespace_confirm = 0
let g:better_whitespace_filetypes_blacklist = []
let g:strip_whitespace_on_save = 1

"" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"let g:airline_theme = 'minimalist'
let g:airline_theme = 'tender'
let g:airline_powerline_fonts = 1

"" vim-gutentags
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'skywind3000/gutentags_plus'
" let g:gutentags_enabled = 1                   " Use :GutentagToggleEnabled to enable it again
" let g:gutentags_define_advanced_commands = 1  " To define :GutentagToggleEnabled
" let g:gutentags_debug = 1
" let g:gutentags_trace = 0
" let g:gutentags_project_root = ['setup.py', 'configure.ac', '.rootmarker', '.root', '.svn', '.git', '.hg', '.project']
" let g:gutentags_add_default_project_roots = 0
" let g:gutentags_ctags_tagfile = ".tags"
" let g:gutentags_generate_on_empty_buffer = 0
" let g:gutentags_generate_on_missing = 0
" let g:gutentags_generate_on_write = 0
" let g:gutentags_generate_on_new = 0
" let g:gutentags_ctags_extra_args = [
"       \'--fields=+niazS', '--extra=+q', '--c++-kinds=+px', '--c-kinds=+px'
"       \]
" let g:gutentags_modules = ['ctags', 'gtags_cscope']
" let g:gutentags_cache_dir = expand('$HOME/.cache/gutentags')
" "
" nnoremap <silent> <F5> <ESC>:GutentagsUpdate!<CR>
" "
" let g:gutentags_auto_add_gtags_cscope = 0     " Let gutentags_plus do this
" " Gutentags_plus wraps around vim+cscope commands, and provides a easy way to search GTAGS/GRTAGS
" " through gtags-cscope.
" "
" "     :GscopeFind -> cscope-keymap (cs find, etc.) -> gtags-cscope -> GTAGS/GRTAGS
" "
" " Focus on quickfix window after search (optional)
" if has("cscope") && executable("gtags-cscope")
"   set cscopeprg=gtags-cscope
" endif
" let g:gutentags_plus_switch = 1
" let g:gutentags_plus_nomap = 1
" " :GscopeFind {querytype} {symbol}
" "             0 or s: Find this symbol
" "             1 or g: Find this definition
" "             2 or d: Find functions called by this function
" "             3 or c: Find functions calling this function
" "             4 or t: Find this text string
" "             6 or e: Find this egrep pattern
" "             7 or f: Find this file
" "             8 or i: Find files #including this file
" "             9 or a: Find places where this symbol is assigned a value
" nnoremap <silent> <Leader>gs  :GscopeFind 0 <C-R><C-W><CR>
" nnoremap <silent> <Leader>gd  :GscopeFind 1 <C-R><C-W><CR>
" nnoremap <silent> <Leader>gc  :GscopeFind 2 <C-R><C-W><CR>
" nnoremap <silent> <Leader>gr  :GscopeFind 3 <C-R><C-W><CR>
" nnoremap <silent> <Leader>gt  :GscopeFind 4 <C-R><C-W><CR>
" nnoremap <silent> <Leader>ge  :GscopeFind 6 <C-R><C-W><CR>
" nnoremap <silent> <Leader>gf  :GscopeFind 7 <C-R><C-W><CR>
" nnoremap <silent> <Leader>gi  :GscopeFind 8 <C-R><C-W><CR>
" nnoremap <silent> <Leader>ga  :GscopeFind 9 <C-R><C-W><CR>
" "" GNU global
" " MiniHOWTO:
" "   1. Install gtags.vim from global into `~/.vim/plugin`;
" "   2. Copy /path/to/share/gtags/gtags.conf to ~/.globalrc;
" " NOTE:
" "   When gutentags is enabled with 'gtags_cscope' module, it will set environments
" "   GTAGSDBPATH and GTAGSROOT with corrent values. So, gtags.vim works well with it.
" " Keybindings:
" " :Gtags -r func      " To go to the referenced point of func
" " :Gtags -s lbolt     " To locate symbols which are not defined in GTAGS
" " :Gtags -g int args  " To locate strings
" " :Gtags -f main.c    " To get a list of tags in specified files
" " :Gtags ^put_        " Use POSIX regex
" " :GtagsCursor        " brings you to the definition or reference of the
" "                     " current token under cursor
" " :Gozilla
" let g:Gtags_Close_When_Single = 1
" nnoremap <silent> <Leader>]    :GtagsCursor<CR>
" nnoremap <silent> <Leader>[    :Gtags -r <C-r><C-w><CR>
" nnoremap <Leader>gg            :Gtags<Space>
" " If the specified tags is not found in the project, global also searches in these paths.
" if g:platform == 'Linux'
"   let $GTAGSLIBPATH="/usr/include"
" endif

"" previm
Plug 'kannokanno/previm'
" Set g:previm_open_cmd if open-browser is not installed
" Run :PrevimOpen to open browser to preview

"" Highlighting and navigating through different works in a buffer.
Plug 'lfv89/vim-interestingwords'
" Shortcut is modified to <Leader>h and <Leader>H directly in source code.

"" ack.vim
Plug 'mileszs/ack.vim'
" It relies on Perl package `App::Ack`. Install it with
"   cpan install App::Ack.
if executable("rg")
  let g:ackprg = "rg -F --vimgrep"
  let g:grepprg = "rg -F --vimgrep"
endif
" To grep word under cursor
nnoremap <Leader>F :Ack! <C-r><C-w><CR>
nnoremap <Leader>f :Ack<Space>

"file内搜索visual选中文本
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

vnoremap <Leader>V y:Ack! "<C-r>0"<CR>

"" vim-cargo
Plug 'timonv/vim-cargo'
let g:cargo_command = "!cargo {cmd}"

"" vim-eunuch
Plug 'tpope/vim-eunuch'                   " UNIX shell commands for VIM
" Vim sugar for the UNIX Shell commands that need it the most.

"" vim-lastplace
Plug 'farmergreg/vim-lastplace'           " Reopen files at your last edit postion
let g:lastplace_open_folds = 0

"" vim-workspace
Plug 'thaerkh/vim-workspace'
let g:workspace_session_directory = expand('$HOME/.cache/sessions.vim/')
let g:workspace_session_disable_on_args = 1
let g:workspace_persist_undo_history = 0
"" NOTE: This options make my last search pattern disappears. Very annoying.
let g:workspace_autosave = 0

"" vim-polyglot
"" rust.vim use this option to enable vim indentation and textwidth settings
" to conform to style convertions of the rust standard library (i.e. use 4
" spaces for indents and sets 'textwidth' to 99).
let g:rust_recommended_style = 1

"" Vim configuration for Rust
Plug 'rust-lang/rust.vim'

"" Modern C++ syntax
Plug 'bfrg/vim-cpp-modern'
let g:c_no_curly_error = 1
let g:cpp_no_function_highlight = 1
let g:cpp_simple_highlight = 0
let g:cpp_named_requirements_highlight = 1

"" Additional Vim syntax highlighting for C++
Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1

"" vim-autoformat`
"Plug 'chiel92/vim-autoformat'             " Easy code formatting
" Remember that when no formatprograms exists for a certain filetype, vim-autoformat falls back by
" default default to indenting, retabbing and removing trailing whitespace. This will fix at least
" the most basic things, according to vim's indentfile for that filetype.
"
" For each filetype, vim-autoformat has a list of applicable formatters. If you have multiple
" formatters installed that are supported for some filetype, vim-autoformat tries all formatter in
" this list of applicable formatters, until one succeeds.
"
" * clang-format: C, C++, OC, vim-autoformat checks whether there exists a '.clang-format' file up
"   to in the current directory's ancestry. Based on that it either uses that file or tries to
"   match Vim options as much as possible.
" * astyle: C#, C++, C and Java. .astylerc; ~/.astylerc
" * autopep8: Python
" * yapf: Python. .style.yapf; setup.cfg
" * rustfmt: Rust
"let g:autoformat_verbosemode = 1
"noremap <F4>                          <ESC>:Autoformat<CR>

"" vim-lua-inspect
Plug 'xolox/vim-misc'                     " As a dependency for lua-inspect
Plug 'xolox/vim-lua-inspect'
let g:lua_inspect_events = ''
autocmd FileType lua nnoremap <silent> <F6> :LuaInspect<CR>

"" unimpaired
Plug 'tpope/vim-unimpaired'               " Pairs of handy bracket mappings
" Pairs of handy bracket mappings
" :h unimpaired

"" vim-signify
Plug 'mhinz/vim-signify'                  " Show a diff using Vim sign column :SignifyDiff

"" leaderf
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" https://retzzz.github.io/dc9af5aa/
" brew install global
" pip3 install pygments
"let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
" don't show the help in normal mode
let g:Lf_WindowHeight = 0.20
let g:Lf_GtagsSource = 1
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
" let g:Lf_WindowPosition = 'popup'
" let g:Lf_PreviewInPopup = 1
" let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
" let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

noremap <leader>fg :Leaderf gtags --update<CR><CR>

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>fc :<C-U><C-R>=printf("LeaderfHistoryCmd %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

" rg help
" rg -i:  无视大小写
" rg -F: 纯文本匹配
" rg -e: 正则

noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap fv :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_ShortcutF = '<C-p>'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

let g:Lf_GtagsAutoUpdate = 1


"" vim-sneak - Jump to any location specified by two characters.
Plug 'justinmk/vim-sneak'
let g:sneak#prompt = 'sneak> '

"" neomake - Asynchronous linting and make framework.
Plug 'neomake/neomake'

""
Plug 'pboettch/vim-cmake-syntax'
Plug 'vhdirk/vim-cmake'                   " Vim plugin to make working with CMake a little nicer
if g:platform == "Darwin"
  let g:cmake_cxx_compiler = "/opt/local/bin/g++-mp-8"
  let g:cmake_c_compiler = "/opt/local/bin/gcc-mp-8"
endif

"" undotree - the undo history visualizer for VIM
Plug 'mbbill/undotree'
noremap <F2>                          <ESC>:UndotreeToggle<CR>

"" Preview Quickfix
Plug 'ronakg/quickr-preview.vim'
" To preview, hit <Leader><space>; To open, hit <Enter>
" To close builtin Preview window
nnoremap <silent> <Leader>p  :pclose<CR>

"" Text outlining and task management for Vim based on Emacs' Org-Mode
Plug 'jceb/vim-orgmode'

Plug 'embear/vim-localvimrc'
" In .lvimrc
"   setlocal noexpandtab
"   setlocal shiftwidth=8
"   setlocal tabstop=8
let g:localvimrc_persistent = 1
let g:localvimrc_debug = 1
let g:localvimrc_sandbox = 1

"" This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically
"" based on the current file, or, in the case the current file is new, blank, or
"" otherwise insufficient, by looking at other files of the same type in the current
"" and parent directories. In lieu of adjusting 'softtabstop', 'smarttab' is enabled.
Plug 'tpope/vim-sleuth'

"" Toggles between hybrid and absolute line numbers automatically
Plug 'jeffkreeftmeijer/vim-numbertoggle'
set number relativenumber

"" Comment stuff out
Plug 'tpope/vim-commentary'               " gcc/gc<motion>/{visual}gc

"" Vim text objects
Plug 'kana/vim-textobj-user'              " Create your own text objects
Plug 'kana/vim-textobj-entire'            " Text object for entire buffer
Plug 'kana/vim-textobj-function'          " Text object for function

"" A Vim alignment plugin
Plug 'junegunn/vim-easy-align'
" Align GitHub-flavored Markdown tables
autocmd FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

"" Vim plugin that shows the context of the currently visible buffer contents
"Plug 'wellle/context.vim'

" Vim plugin to synchronize the cursor position with Sourcetrail
Plug 'CoatiSoftware/vim-sourcetrail'
let g:sourcetrail_autostart = 1
nnoremap <Leader>sr :SourcetrailRefresh<CR>
nnoremap <Leader>s :SourcetrailActivateToken<CR>

"" Vim plugin for automated bullet lists
Plug 'dkarter/bullets.vim'
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]
let g:bullets_enable_in_empty_buffers = 0

"" Plug for easy resizing of your Vim windows
Plug 'simeji/winresizer'
" Ctrl + E to start, Enter to finish
let g:winresizer_start_key = '<C-T>'

"" ---------Ending of plugins managed by Vim-Plug ---------------
noremap <F11>                       <ESC>:PlugUpdate<CR>
call plug#end()
"""}}}


""" Plugin Shortcuts --- {{{
" <F1>                                    -- Disabled
" <F2>                                    -- Undotree
" <F3>                                    -- Maximizer
" <F4>                                    -- FormatCode
" <F5>                                    -- Update CTags/GTags, Refresh LeaderF Cache
" <F6>                                    -- LintTool
" <F7>                                    --
" <F8>                                    --
" <F9>                                    --
" <F10>                                   --
" <F11>                                   -- :PlugUpdate
" <F12>                                   -- MiniBufferExploer

"" Shortcuts for Build and Run
autocmd FileType rust         nnoremap <Leader>b <ESC>:CargoBuild<CR>
autocmd FileType rust         nnoremap <Leader>r <ESC>:CargoRun<CR>
autocmd FileType c,cpp        nnoremap <Leader>b <ESC>:make<CR>
" python-mode
" '<Leader>' r to run and '<Leader>b' to set breakpoint
""" }}}


""" Plugins Using Vim8 Plugin Mechanism .vim/pack {{{
"""}}}

"" Default <leader> is '\'
" Windows manipulations
nnoremap      <silent><Leader>vs        <C-w>v<C-w>l
nnoremap      <silent><Leader>hs        <C-w>s<C-w>j
nnoremap      <silent><Leader>wr        <C-w>r
nnoremap      <silent><Leader>wc        <C-w>c
nnoremap      <silent><Leader>wo        <C-w>o
nnoremap      <silent><Leader>w=        <C-w>=
nnoremap      <silent><Leader>wl        <ESC>:MBEToggle<CR>
nnoremap      <silent><Leader>nw        <ESC>:set nowrap<CR>

map           <C-h>                     <C-w>h
map           <C-j>                     <C-w>j
map           <C-k>                     <C-w>k
map           <C-l>                     <C-w>l

" Shortcuts for windows resizing
nnoremap      <Leader>=                 :resize +5<CR>
nnoremap      <Leader>-                 :resize -5<CR>
nnoremap      <Leader>0                 :vertical resize +5<CR>
nnoremap      <Leader>9                 :vertical resize -5<CR>

" Register copy and paste
vmap          <silent><Leader>y         "+y
"vmap          <silent><Leader>d         "+d
"nmap          <silent><Leader>p         "+p
"nmap          <silent><Leader>P         "+P
"vmap          <silent><Leader>p         "+p
"vmap          <silent><Leader>P         "+P
"
"vmap          <silent> y                y`]
"vmap          <silent> p                p`]
"nmap          <silent> p                p`]

" Disable F1
inoremap      jk                        <ESC>
map           <silent> <F1>             <ESC>
imap          <silent> <F1>             <ESC>
noremap       <silent> <F1>             <ESC>
imap          <silent> <C-D><C-D>       <C-R>=strftime("%e %b %Y")<CR>
imap          <silent> <C-T><C-T>       <C-R>=strftime("%l:%M %p")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""} guiopts {
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_running")
  "unmenu ToolBar     " Deactive the toolbar
  "unmenu! ToolBar     " Hide the toolbar icons
  set guioptions-=T   " Remove the toolbar
  "set guioptions-=m  " The menu bar, Or -=M for more complete
  set guioptions+=b
  set guifont=Courier\ New\ 11
  set lines=30
  set columns=110
  set guitablabel=\%t\ [%N]%M
else
  set termguicolors
endif

" set background=dark
" colorscheme lucario
"colorscheme desert
colorscheme gruvbox
" colorscheme molokai
" colorscheme purify
" colorscheme tender

set bg=dark
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"} epilogue {
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Server

" clipper
" @0 is yank buffer 0
" nnoremap <leader>Y y:call system('nc -N localhost 8377', @0)<CR>

" Customized highlights
augroup CustomizedHighlights
  autocmd!
  autocmd Syntax * syn match MyTodo /\v<(NOTE)>/ containedin=.*Comment,vimCommentTitle
augroup END

highlight def link MyTodo Todo


" neovim don't need
" set term=xterm-256color


set ic

" code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" cd?  |" project vim的路径
nmap cdp :echo @%<CR>
":echo @%                |" directory/name of file
nmap cdn :echo expand('%:t')<CR>
":echo expand('%:t')     |" name of file ('tail')
nmap cdfp :echo expand('%:p')<CR>
":echo expand('%:p')     |" full path
":echo expand('%:p:h')   |" directory containing file ('head')
"
"
"" typewriter mode
noremap <leader>To :set scrolloff=999<CR>
noremap <leader>Tc :set scrolloff=0<CR>

set scrolloff=999

" cross curosr
noremap <leader>Co :set cursorline cursorcolumn<CR>
noremap <leader>Cc :set nocursorline nocursorcolumn<CR>

set cursorline cursorcolumn

