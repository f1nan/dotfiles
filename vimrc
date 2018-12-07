" ~/.vimrc - Vim configuration file


" Plugins --------------------------------------------------------------

" Surround.vim is all about 'surroundings': parentheses, brackets, quotes, XML
" tags, and more. The plugin provides mappings to easily delete, change and add
" such surroundings in pairs.
packadd! vim-surround

" Comment stuff out. Use gcc to comment out a line (takes a count), gc to
" comment out the target of a motion (for example, gcap to comment out a
" paragraph), gc in visual mode to comment out the selection, and gc in
" operator pending mode to target a comment.
packadd! vim-commentary

" Makes plugin maps repeatable with '.'.
packadd! vim-repeat

" ALE (Asynchronous Lint Engine) is a plugin for providing linting in NeoVim
" and Vim 8 while you edit your text files.
"packadd! ale
"Run linters only when I save a file
"let g:ale_lint_on_text_changed = 'never'
" Don't run linters right after I open a file
"let g:ale_lint_on_enter = 0
" Specify linters to check files with
"augroup Linters
"    autocmd!
"    autocmd FileType python let b:ale_linters = ['flake8']
"    autocmd FileType c let b:ale_linters = ['gcc']
"augroup END


" Generate Documentation (all plugins have to be loaded before this line)
silent! helptags ALL


" General Settings -----------------------------------------------------

" Load Decent default settings
runtime! defaults.vim

" Turn on filetype magic
filetype plugin indent on

" Enable syntax highlighting
syntax enable

" Make backspace behave like in every other editor
set backspace=2

" Hide buffers. Don't be forced to save or close a buffer because of unsaved
" changes.
set hidden

" Write the contents of the file, if it has been modified, on each :next,
" :rewind, :last, :first, :previous, :stop, :suspend, :tag, :!, :make, CTRL-]
" and CTRL-^ command; and when a :buffer, CTRL-O, CTRL-I, '{A-Z0-9}, or
" `{A-Z0-9} command takes one to another file.
set autowrite

" When a file has been detected to have been changed outside of Vim and it has
" not been changed inside of Vim, automatically read it again.
set autoread

" Use a dialog when an operation has to be confirmed
set confirm

" Number of screen lines to use for the command-line
set cmdheight=2

" Show (parial) command in the last line of the screen
set showcmd

" Show the line and column number of the cursor position, separated by a comma.
set ruler

" Folds are indicated by markers
set foldmethod=marker

" Folds can only be nested four times
setlocal foldnestmax=4

" Search down into subfolders. Provides tab-completion for all file-related
" tasks. Hit tab to :find by partial match. Use * to make it fuzzy.
set path+=**

" Bash like command-line completion
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.pyc,*.o

" Highlight search results
set hlsearch

" If the 'ignorecase' option is on, the case of normal letters is ignored.
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case
" characters.
set smartcase

" While typing a search command, show where the pattern, as it was typed
" so far, matches. The matched string is highlighted.
set incsearch

" Show line numbers.
set number

" Show the line number relative to the line with the cursor in front of
" each line.
set relativenumber

" Indent with 4 spaces. To insert a real tab when 'expandtab' is on, use
" CTRL-V<Tab>.
set shiftwidth=4
set softtabstop=4
set expandtab

" Disable swap and backup files
set nobackup
set nowritebackup
set noswapfile

" Mapleader is comma
let mapleader = ','

" Maximum textwidth is 79 characters
set textwidth=79

" Where it makes sense, remove a comment leader when joining lines
set formatoptions+=j

" Don't insert two spaces after a '.', '?' and '!' with a join command.
set nojoinspaces

" Prevent certain movements from always going to the start of the line
set nostartofline

" When on, splitting a window will put the new window right of the current one.
set splitright

" When on, splitting a window will put the new window below the current one.
set splitbelow

" Toggle 'paste' options with <F2>
set pastetoggle=<F2>

" Highlight the screen line of the cursor
set cursorline

" Colorschme
colorscheme desert

" Show cursorline only in active window
augroup CursorlineOnlyInActiveWindow
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Automatically close the preview window
augroup ClosePreview
    au!
    au InsertLeave * if pumvisible() | pclose! | endif
augroup END


" Statusline -----------------------------------------------------------

" Alwasys show the statusline
set laststatus=2

" Reset status line
set statusline=

" Add path to file
set statusline+=\ %f

" Add modified flag
set statusline+=\ %m

" Add filetype
set statusline+=\ %y

" Switch to the right side
set statusline+=%=

" Add number of current line
set statusline+=%l

" Add number of total lines
set statusline+=/%L

" Add status of linter
"set statusline+=\ -\ %{ALEGetStatusLine()}\ 


" Mappings -------------------------------------------------------------

" Yank until the end of the line
map Y y$

" Quick save
map <Leader>s :update<CR>

" Get rid of search highlight
nnoremap <CR> :nohl<CR><CR>

" Smash escape
inoremap jj <ESC>
inoremap Jj <ESC>
inoremap jJ <ESC>
inoremap JJ <ESC>

" Easier moving between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open / close the netrw (Vim's default project drawer)
nnoremap <C-n> :Lexplore<CR>

" Navigate the location-list
nnoremap <Leader>ll :ll<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprevious<CR>
nnoremap <Leader>lr :lrewind<CR>

function! Run()
    if &filetype == 'python'
        execute '!python3 %'
    endif
endfunction

" Execute current file
nnoremap <F5> :call Run()<CR>


" Filetype specific settings -------------------------------------------

augroup PythonSettings
    " Clear autocommands for this group
    autocmd!

    " Textwidth for docstrings and block comments
    autocmd FileType python setlocal textwidth=72

    " Don't autoformat code
    autocmd FileType python setlocal formatoptions-=t

    " Automatically remove trailing white space
    autocmd BufWritePre *.py :%s/\s\+$//e
augroup END

augroup CSettings
    " Clear autocommands for this group
    autocmd!

    " textwidth for docstrings and block comments
    autocmd FileType c setlocal textwidth=79

    " automatically remove trailing white space
    autocmd BufWritePre *.c,*.cpp,*.h :%s/\s\+$//e
augroup END
