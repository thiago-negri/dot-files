" packages
set packpath=~/.vim
packadd! fzf.vim
packadd! lsp
packadd! simple-dark
packadd! vim-commentary
packadd! vim-easymotion
packadd! vim-fugitive
packadd! vim-graphql
packadd! vim-highlightedyank
packadd! vim-sleuth
packadd! vim-vinegar

"
set nocompatible
set encoding=utf-8
filetype plugin on
syntax on

" Add folders to runtime path (rtp)
"set rtp+=~/.vim
set rtp+=~/.fzf

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
set signcolumn=yes

" Use new regular expression engine, required for faster syntax highlight for TypeScript
set re=0

" Colorscheme
set termguicolors
set background=dark
colorscheme simple-dark

" Sane backspace
set backspace=indent,eol,start

" Highlight search term
set hlsearch
nnoremap <c-l> :nohlsearch<cr><c-l>

" Highlight yanked tex
let g:highlightedyank_highlight_duration = 100

" Disable bell sounds
set belloff=all

" Number of lines to keep above/below cursor while scrolling
set scrolloff=10

" Show actual tabs as 8 spaces
set tabstop=8

" Use 4 spaces when typing <TAB>
set softtabstop=4
set shiftwidth=4
set expandtab

" No temporary files
set noundofile
set noswapfile
set nobackup

" Show whitespace
set list
set listchars+=tab:»\ 
set listchars+=trail:·
set listchars+=nbsp:␣
set listchars-=eol:$

" Always use block cursor
set guicursor=a:block-nCursor

" Set leader as space
let mapleader = ' '

" FZF
nnoremap <silent> <leader>ff :FZF<cr>
nnoremap <silent> <leader>fb :Buffers<cr>
nnoremap <silent> <leader>fg :Rg<cr>
let g:fzf_vim = {}
let g:fzf_vim.preview_bash = 'bash'
let g:fzf_preview_window = []
let g:fzf_layout = { 'down' : '35%' }

" LSP
" LSP Servers are configured on vimrc.win / vimrc.mac
let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)
nnoremap <silent> [g :LspDiag prev<cr>
nnoremap <silent> ]g :LspDiag next<cr>
nnoremap <silent> <leader>q :LspDiag show<cr>
nnoremap <silent> gd :LspGotoDefinition<cr>
nnoremap <silent> gy :LspGotoDefinition<cr>
nnoremap <silent> gi :LspGotoImpl<cr>
nnoremap <silent> gr :LspShowReferences<cr>
nnoremap <silent> K :LspHover<cr>
nnoremap <leader>rn :LspRename<cr>
xnoremap <leader>f :LspFormat<cr>
nnoremap <leader>f :LspFormat<cr>
nnoremap <leader>ca :LspCodeAction<cr>

" Navigation
nnoremap H ^
nnoremap L $
nnoremap <c-u> <c-u>zz
nnoremap <c-d> <c-d>zz
nnoremap G Gzz
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Duplicate and comment
nnoremap yc yy<cmd>normal gcc<cr>p

" Easy Motion
nnoremap <c-j> <plug>(easymotion-j)
nnoremap <c-k> <plug>(easymotion-k)

