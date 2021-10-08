"  ____________
" / phil02e's  \
" |  awesome   |
" \   vimrc    /
"  ------------
"       \                    / \  //\
"        \    |\___/|      /   \//  \\
"             /0  0  \__  /    //  | \ \
"            /     /  \/_/    //   |  \  \
"            @_^_@'/   \/_   //    |   \   \
"            //_^_/     \/_ //     |    \    \
"         ( //) |        \///      |     \     \
"       ( / /) _|_ /   )  //       |      \     _\
"     ( // /) '/,_ _ _/  ( ; -.    |    _ _\.-~        .-~~~^-.
"   (( / / )) ,-{        _      `-.|.-~-.           .~         `.
"  (( // / ))  '/\      /                 ~-. _ .-~      .-~^-.  \
"  (( /// ))      `.   {            }                   /      \  \
"   (( / ))     .----~-.\        \-'                 .~         \  `. \^-.
"              ///.----..>        \             _ -~             `.  ^-`  ^-_
"                ///-._ _ _ _ _ _ _}^ - - - - ~                     ~-- ,.-~
"                                                                   /.-~
" ==================== Vim Plug ==================== {{{
call plug#begin('~/.vim/plugged')
" vim-plug plugins
"Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neovim/nvim-lspconfig'
"Plug 'folke/lsp-colors.nvim'
"Plug 'nvim-lua/completion-nvim'
"Plug 'hrsh7th/cmp-vsnip'
"Plug 'hrsh7th/vim-vsnip'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/nvim-cmp'

Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-highlightedyank'
Plug 'easymotion/vim-easymotion'
Plug 'ryanoasis/vim-devicons'
Plug 'vimwiki/vimwiki'
Plug 'unblevable/quick-scope'
Plug 'luochen1990/rainbow'
Plug 'cespare/vim-toml'

Plug 'peitalin/vim-jsx-typescript'
" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end() "}}}
" ==================== Plugin settings ==================== {{{
" Rainbow
let g:rainbow_active = 1
" Syntastic
set nocompatible
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1

" FZF
command! F :Files
command! GF :GFiles
command! B :Buffers
command! L :Lines
command! BL :BLines
command! M :Marks
command! H :History

" Ignore those files when searching
set wildignore+=*.pdf,*.jpeg,*.jpg,*.png,*.tif,*.doc,*.docx,*.ods,*.kdbx,*.kdb
set wildignore+=*.mp3,*.wav,*.mp4
set wildignore+=*.zip,*.7z,*.jar,*.tar,*.gz,*.iso,*.lz4,*.exe
set wildignore+=node_modules,*venv*

" Highlighted yank
let g:highlightedyank_highlight_duration = 300

" ycm
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_auto_hover = 1

" coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gh :call CocActionAsync('doHover')<cr>

"nmap <silent> gh <Plug>(YCMHover) " Currently not supported by nvim
"nmap <silent> gh :YcmCompleter GetDoc<cr>
"nmap <silent> gd :YcmCompleter GoToDefinition<cr>

" vimwiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]

" lightline
set laststatus=2
function! Trailing_whites()
	let pos = search('\s$', 'nw')
	if pos>0
		return '»Trailing[' . pos . ']'
	else
		return ''
	endif
endfun

function! Branch()
	let head = FugitiveHead()
	if head != ''
		return '⎇ ' . head
	else
		return ''
	endif
endfun

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
	\'colorscheme': 'gruvbox',
	\'active': {
	\    'left': [ [ 'mode', 'paste' ],
	\        ['gitbranch', 'readonly', 'filename', 'modified'], ['cocstatus'] ],
	\    'right': [ ['trailing_whites'], ['lineinfo' ],
	\        [ 'percent' ],
	\        [ 'fileformat', 'fileencoding', 'filetype'] ]
	\},
	\'component_function': {
	\    'gitbranch': 'Branch',
	\    'cocstatus': 'coc#status',
  	\    'currentfunction': 'CocCurrentFunction'
	\},
	\'component_expand': {
	\    'trailing_whites': 'Trailing_whites',
	\},
	\'component_type': {
    \    'trailing_whites': 'warning'
    \}
\}
"reevaluate component_expand
autocmd BufWritePost,FileWritePost * call lightline#update()
" }}}
" ==================== Config ==================== {{{
filetype plugin on
syntax on
set nu
set relativenumber
set tabstop=4
set smarttab
set shiftwidth=4
set noexpandtab " Use tabs as default for indentation!
set autoindent
set ignorecase
set smartcase
set hlsearch
set incsearch
set background=dark
set termguicolors " disable when using urxvt!
set foldmethod=syntax
set nofoldenable
set noshowmode " because lightline already shows mode
set spell
set spelllang=en_us,de_de

" \ is hard to reach, so set <leader> to -
let mapleader = "-"
" netrw hide dotfiles as default, toggle with gh
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex

colorscheme gruvbox
" }}}
" ==================== Mappings ==================== {{{
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
map Y y$
" Move between splits with Ctrl+movement keys
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Also start CtrlPMixed with ,p
nnoremap <leader>p :CtrlPMixed<CR>
" Start CtrlPFunky
nnoremap <leader>f :CtrlPFunky<CR>
" Start CtrlP on Buffers
nnoremap <leader>b :CtrlPBuffer<CR>
" Open CtrlPLine
nnoremap <leader>l :CtrlPLine<CR>
" Esc to stop highlighting
nnoremap <silent> <Esc><Esc> :nohl<CR>
" Quicksave with <leader>w
nmap <leader>w :w<cr>
" }}}
" ==================== Extended Settings ==================== {{{
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
" Make the whitespace remover function accessible via two commands
command! TrimWhitespace call <SID>StripTrailingWhitespaces()
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
" }}}
" ==================== Filetype specific settings ==================== {{{
" Remove trailing whitespaces for specific files on save
autocmd BufWritePre *.h,*.c,*.java,*.py,*.rs,*.toml,*.cpp,*.yaml,*.yml,*vimrc,.gitignore,*.md :call <SID>StripTrailingWhitespaces()
" Use foldmethod marker on vim files to automatically fold vimrc
" To toggle fold use za. To open all folds use zR and to close all folds use ZM.
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal foldenable
augroup END

augroup filetype_python
	autocmd!
	" Indentation according to pep8
	autocmd FileType python setlocal expandtab sw=4 ts=4
augroup END

augroup filetype_sh
	autocmd!
	" display tabs as two spaces
	autocmd FileType sh setlocal expandtab sw=4 ts=4
augroup END

augroup filetype_yaml
	autocmd!
	" Indentation two spaces
	autocmd FileType yaml setlocal expandtab sw=2 ts=2
augroup END

augroup filetype_php
	autocmd!
	" Indentation according to pep8
	autocmd FileType php setlocal expandtab sw=4 ts=4
augroup END

augroup filetype_tsx
	autocmd!
	" Indentation two spaces
	autocmd FileType typescript.tsx setlocal expandtab sw=2 ts=2
augroup END

augroup filetype_css
	autocmd!
	" Indentation two spaces
	autocmd FileType css setlocal expandtab sw=2 ts=2
augroup END
