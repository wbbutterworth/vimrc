"
" Vim Config
"
" :: Settings
" :: Mappings
" :: Plugins

"
" Settings
"

set autoread
set autoindent
set backspace=indent,eol,start
set complete=.,w,b,u,t,k
set dictionary=/usr/share/dict/words
set encoding=utf-8
set expandtab shiftwidth=4 softtabstop=4
set fillchars+=vert:\ 
set foldenable foldmethod=indent foldlevelstart=99
set hidden
set incsearch
set ignorecase smartcase
set laststatus=2
set lazyredraw
set list listchars=tab:│\ ,trail:·
set noswapfile
set nojoinspaces
set nowrap
set number relativenumber
set signcolumn=yes
set splitbelow splitright
set statusline=%!StatusLine()
set tabline=%!TabLine()
set undofile undodir=/tmp//,.
set wildmenu wildignorecase wildmode=full

augroup Formatting
    autocmd!
    autocmd bufenter * setlocal formatoptions-=o
augroup END

augroup Completion
    autocmd!
    autocmd filetype html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd filetype css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd filetype javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd filetype php setlocal omnifunc=phpcomplete#CompletePHP
augroup END

let s:git_branch = substitute( system(
            \ 'git rev-parse --git-dir > /dev/null 2>&1 && git rev-parse --abbrev-ref HEAD'
            \ ), '\n', '', 'g' )

let s:file_permissions = substitute( system(
            \ 'ls -la ' . expand( '%:h' ) .
            \ ' | grep ' . expand( '%:t' ) .
            \ ' | cut -d " " -f1'
            \ ), '\n', '', 'g' )

function! StatusLine() abort
    let output  = ' '
    let output .= !empty( s:git_branch ) ? s:git_branch . ' ' : ''
    let output .= '%f%m%=%c:%l|%L %{&ff}'
    let output .= filereadable( expand( '%:p' ) ) ? ' %{&fenc}' : ''
    let output .= !empty( s:file_permissions ) ? ' ' . s:file_permissions : ''
    return output . ' '
endfunction

function! TabLine() abort
    let output = ''

    for index in range( tabpagenr( '$' ) )
        let tab_index      = index + 1
        let buflist        = tabpagebuflist( tab_index )
        let winnr          = tabpagewinnr( tab_index )
        let tab_name       = fnamemodify( bufname( buflist[ winnr - 1 ] ), ':t' )
        let tab_highlight  = ( tab_index == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#' )
        let output        .= tab_highlight . ' ' . tab_name . ' '
    endfor

    return output . '%#TabLineFill#%T'
endfunction

"
" Mappings
"

let mapleader = ' '

nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap <bs> <c-^>
nnoremap c* *``cgn
nnoremap c# #``cgN
nnoremap d* *``dgn
nnoremap d# #``dgN
nnoremap g= mmgg=G`m
nnoremap gs :%s//g<left><left>
vnoremap gs :s//g<left><left>
vnoremap gr y:%s/<c-r>"//g<left><left>
vnoremap ;; :s/\v(.)$/\=submatch(1) == ';' ? '' : submatch(1) . ';'<cr>
vnoremap ,, :s/\v(.)$/\=submatch(1) == ',' ? '' : submatch(1) . ','<cr>
inoremap ;; <esc>m`:s/\v(.)$/\=submatch(1) == ';' ? '' : submatch(1) . ';'<cr>``a
inoremap ,, <esc>m`:s/\v(.)$/\=submatch(1) == ',' ? '' : submatch(1) . ','<cr>``a

nnoremap ]<bs> :bnext<cr>
nnoremap [<bs> :bprevious<cr>
nnoremap ]<space> o<esc>'[k
nnoremap [<space> O<esc>j
nnoremap <silent><expr> ]e ':<c-u>m+' . v:count1 . '<cr>=='
nnoremap <silent><expr> [e ':<c-u>m-' . ( v:count1 + 1 ) . '<cr>=='
vnoremap <silent><expr> ]e ":<c-u>'<,'>m'>+" . v:count1 . '<cr>gv=gv'
vnoremap <silent><expr> [e ":<c-u>'<,'>m-" . ( v:count1 + 1 ) . '<cr>gv=gv'

nnoremap <leader>s :so ~/.vimrc<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>W :wq<cr>
nnoremap <leader>e :e<cr>
nnoremap <leader>E :e!<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q!<cr>
nnoremap <leader>n :tabn<cr>
nnoremap <leader>p :tabp<cr>
nnoremap <leader>N :tabm +1<cr>
nnoremap <leader>P :tabm -1<cr>
nnoremap <leader>h <c-w>10<
nnoremap <leader>j <c-w>10-
nnoremap <leader>k <c-w>10+
nnoremap <leader>l <c-w>10>
nnoremap <leader>oh :set hlsearch!<cr>
nnoremap <leader>ol :set list!<cr>
nnoremap <leader>or :set relativenumber!<cr>
nnoremap <leader>os :set spell!<cr>
nnoremap <leader>ow :set wrap!<cr>

"
" Plugins
"

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'andrewradev/splitjoin.vim'
Plug 'andrewradev/sideways.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'ludovicchabant/vim-gutentags'
Plug 'michaeljsmith/vim-indent-object'
Plug 'raimondi/delimitmate'
Plug 'sheerun/vim-polyglot'
Plug 'sirver/ultisnips'
Plug 'suy/vim-context-commentstring'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'

call plug#end()

" GitGutter

let g:gitgutter_map_keys = 0

nnoremap ]h <plug>GitGutterNextHunk
nnoremap [h <plug>GitGutterPrevHunk

omap ih <plug>GitGutterTextObjectInnerPending
omap ah <plug>GitGutterTextObjectOuterPending
xmap ih <plug>GitGutterTextObjectInnerVisual
xmap ah <plug>GitGutterTextObjectOuterVisual

" SplitJoin

let g:splitjoin_trailing_comma                    = 1
let g:splitjoin_curly_brace_padding               = 1
let g:splitjoin_html_attributes_brack_on_new_line = 1

" Sideways

nnoremap ]a :SidewaysRight<cr>
nnoremap [a :SidewaysLeft<cr>

omap ia <plug>SidewaysArgumentTextobjI
omap aa <plug>SidewaysArgumentTextobjA
xmap ia <plug>SidewaysArgumentTextobjI
xmap aa <plug>SidewaysArgumentTextobjA

" Nord

let g:nord_italic                  = 1
let g:nord_underline               = 1
let g:nord_uniform_diff_background = 1

colorscheme nord

" FZF

set runtimepath+=~/.zplug/repos/junegunn/fzf

let git_commit_format         = '%C(red)%C(bold)%h%d%C(reset) %s %C(blue)%cr'
let rg_command = 'rg --column --line-number --no-heading --color=always --smart-case'
let g:fzf_commits_log_options = '--graph --color=always --format="' . git_commit_format . '"'
let g:fzf_tags_command        = 'ctags -R'

command! -bang -nargs=? -complete=dir Files call fzf#vim#files( <q-args>, { 
            \ 'options': [ '--preview', system( 'echo $FZF_PREVIEW_OPTS' ) ]
            \ }, <bang>0 )

command! -bang -nargs=* Rg call fzf#vim#grep( rg_command . ' ' . shellescape( <q-args> ), 1,
            \ <bang>0
            \ ? fzf#vim#with_preview( 'up:60%' )
            \ : fzf#vim#with_preview( 'right:50%:hidden', '?' ),
            \ <bang>0 )

nnoremap <leader><space> :Files<cr>
nnoremap <leader><bs> :Buffers<cr>
nnoremap <leader><cr> :Rg<cr>
nnoremap <leader><tab> :Snippets<cr>
nnoremap <leader>gf :GFiles?<cr>
nnoremap <leader>gc :Commits<cr>
nnoremap <leader>G :BLines<cr>
nnoremap <leader>h :Helptags<cr>
nnoremap <leader>] :Tags<cr>
nnoremap <leader>: :History:<cr>
nnoremap <leader>/ :History/<cr>
nnoremap <leader>` :Marks<cr>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-j> <plug>(fzf-complete-file)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" EasyAlign

nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)

" GutenTags

let g:gutentags_enabled       = system( 'command -v ctags' )
let g:gutentags_project_root  = [ '.git' ]
let g:gutentags_ctags_tagfile = '.git/tags'

" DelimitMate

let g:delimitMate_expand_cr    = 1
let g:delimitMate_expand_space = 1

" Polyglot

let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required        = 0

autocmd filetype vue syntax sync fromstart

" UltiSnips

let g:UltiSnipsSnippetDirectories  = [ $HOME.'/.dotfiles/snips' ]
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsEditSplit           = 'horizontal'

nnoremap <leader><s-tab> :UltiSnipsEdit<cr>

" Commentary

nnoremap gp mmyyP:Commentary<cr>`m
xnoremap gp ygv:Commentary<cr>`>p

" Fugitive

nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gx :Gdiff<cr>
nnoremap <leader>gv :Gvdiff<cr>
