" packages
set packpath=~/.vim
packadd! fzf.vim
packadd! lsp
packadd! vim-commentary
packadd! vim-dark
packadd! vim-easymotion
packadd! vim-fugitive
packadd! vim-graphql
packadd! vim-highlightedyank
packadd! vim-sleuth
packadd! vim-surround
packadd! vim-vinegar

"
set nocompatible
set encoding=utf-8
set cursorline
filetype plugin on
syntax on

" Add folders to runtime path (rtp)
set rtp+=~/.fzf

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
set signcolumn=yes

" Use new regular expression engine, required for faster syntax highlight for TypeScript
set re=0

" Do not try to be smart about TypeScript names
let g:typescript_host_keyword = 0

" Colorscheme
set termguicolors
set background=dark
colorscheme vim-dark

" Sane backspace
set backspace=indent,eol,start

" Highlight search term
set hlsearch
nnoremap <c-l> :nohlsearch<cr><c-l>

" Highlight yanked text
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
function! GFilesFallback()
  let output = system('git rev-parse --show-toplevel') " Is there a faster way?
  let prefix = get(g:, 'fzf_command_prefix', '')
  if v:shell_error == 0
    exec "normal :" . prefix . "GFiles\<cr>"
  else
    exec "normal :" . prefix . "Files\<cr>"
  endif
  return 0
endfunction
nnoremap <silent> <leader>ff <cmd>call GFilesFallback()<cr>
nnoremap <silent> <leader>fg <cmd>execute 'GGrep ' input('Search: ')<cr>
nnoremap <silent> <leader>fw <cmd>execute 'GGrep ' expand('<cword>')<cr>
" TODO: Add a <leader>fn or <leader>f. to repeat last GGrep
nnoremap <silent> <leader>fb <cmd>Buffers<cr>
let g:fzf_vim = {}
let g:fzf_vim.preview_bash = 'bash'
let g:fzf_preview_window = []
let g:fzf_layout = { 'down' : '35%' }
command! -bang -nargs=* GGrep
\ call fzf#vim#grep(
\   'git grep --line-number -- '.fzf#shellescape(<q-args>),
\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" LSP
" LSP Servers are configured on vimrc_win / vimrc_mac
let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)
nnoremap <silent> [g :LspDiag prev<cr>
nnoremap <silent> ]g :LspDiag next<cr>
nnoremap <silent> <leader>q :LspDiag show<cr>
nnoremap <silent> gd :LspGotoDefinition<cr>zt
nnoremap <silent> gr :LspShowReferences<cr>
nnoremap <silent> K :LspHover<cr>
nnoremap <leader>rn :LspRename<cr>
xnoremap <leader>f :LspFormat<cr>
nnoremap <leader>f :LspFormat<cr>
nnoremap <leader>ca :LspCodeAction<cr>

" Navigation
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
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

" Copy current file path to system's clipboard (bc = buffer copy)
nnoremap <leader>bc <cmd>let @*=@%<cr><cmd>echo 'Copied file path: ' . @%<cr>

" F4 will show the highlight group of word under cursor
nnoremap <F4> :echo 'hi<' . synIDattr(synID(line('.'), col('.'), 1), 'name') . '> ' .
            \       'trans<' . synIDattr(synID(line('.'), col('.'), 0),'name') . '> ' .
            \       'lo<' . synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name') . '>'<cr>

" F5 reloads vimrc
nnoremap <F5> :so $MYVIMRC<cr>

" Detect file types
augroup filetypedetect
au BufNewFile,BufRead *.git/COMMIT_EDITMSG setf gitcommit
augroup END

