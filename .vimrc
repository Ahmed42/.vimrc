
"colorscheme jellybeans
set number
set relativenumber
set ruler
set expandtab
set tabstop=4
set shiftwidth=4
syntax on
"autocmd vimenter * ++nested 
" colorscheme gruvbox

colorscheme jellybeans
" set background=light
set background=dark

set foldmethod=syntax
set nofoldenable
set foldlevel=1

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" gruvbox configs
let g:gruvbox_contrast_light = "soft"

filetype plugin indent on



" vim-javascript configs
let g:javascript_conceal_arrow_function       = "⇒"
" let g:javascript_plugin_jsdoc = 1
" let g:javascript_plugin_flow = 1
set conceallevel=0

" syntastic configs
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_c_checkers = ['gcc']
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler_options = '-std=c++17'
let g:syntastic_python_checkers = ['python']
let g:syntastic_ocaml_checkers = ['merlin']

" let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']
" let g:syntastic_javascript_checkers = ['eslint']

"let g:coc_disable_startup_warning = 1

" Merlin
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" ocp-indent
set rtp+=/home/ahmed/.opam/4.14.0/share/ocp-indent/vim/indent/ocaml.vim 

" indent guides
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_guide_size=1

let g:asyncrun_open = 15



" mappings
nmap <F8> :TagbarToggle<CR>

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"


map <C-b> :b
map <C-b>n :bn<CR>
map <C-b>p :bp<CR>

"set <F13>=^[[19;5~ 
"set <F8>=^[[19~
"set <F9>=^[[20~

map <F9> :GoDebugStart<CR>
map <S-F8> :GoDebugBreakpoint<CR>
map <F8> :GoDebugNext<CR>
" inoremap { {}<Esc>i
" inoremap ( ()<Esc>i
" inoremap [ []<Esc>i


"autocmd VimEnter *.csv "CocDisable"
"autocmd BufEnter *.csv "CocDisable"
"autocmd VimLeave *.csv "CocEnable"
"autocmd BufLeave *.csv "CocEnable"

"autocmd VimEnter *.go "CocDisable"
"autocmd BufEnter *.go "CocDisable"
"autocmd VimLeave *.go "CocEnable"
"autocmd BufLeave *.go "CocEnable"
"
" autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" TODO automatically identify main function filename for -o
function MakeIfExists()
    if filereadable("Makefile")
        AsyncRun make
    elseif expand("%:e") == "c"
        AsyncRun cc *.%:e -o %<
    elseif expand("%:e") == "cpp"
        AsyncRun c++ *.%:e -o %<
    endif
endfunction

autocmd BufWritePost *.c,*.cpp call MakeIfExists()

call plug#begin()
"Plug 'eslint/eslint'
"Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
"Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
"Plug 'valloric/youcompleteme'
"Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-surround'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc-tsserver', {'do': 'npm i package.json && npm i'}
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'joerdav/templ.vim'
call plug#end()


