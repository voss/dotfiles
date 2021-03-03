" Let's start by installing vim-plug and the plugins I need
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif



" Plugins **********************************************

call plug#begin("~/.vim/plugged")

" Add Airline for nice status bar, and some themes for it
Plug 'vim-airline/vim-airline'
Plug 'enricobacis/vim-airline-clock'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-markdown' "markdown syntax
Plug 'ap/vim-css-color' "displays the actual colour of the css color picked
Plug 'morhetz/gruvbox' "some colour theme
Plug 'NLKNguyen/papercolor-theme' "another colour theme - seems like gruvbox doesn't really work with spelling

" Paint css colors with the real color
" Plug 'lilydjwg/colorizer'

" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
" Plug 'myusuf3/numbers.vim'


call plug#end()

"****************************************

" Install plugins the first time vim runs with this .vimrc file

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif




" VIM SETTINGS AND MAPPINGS ****************************************

" enter the current millenium
set nocompatible


"""" enable syntax and plugins (for netrw)
syntax on
set background=dark
filetype plugin on
filetype indent on
colorscheme PaperColor


" Always show status bar
set ls=2

" enable incremental search
set incsearch

" highlight search results
set hlsearch

" but turn off highlight for previous search
nohls

" highlight the current line
set cursorline

" it's kinda magic. I've no idea what this does, but it sounds promising
set magic

"reload .vimrc on write
au BufWritePost .vimrc so ~/.vimrc


" better backup, swap and undos storage for vim (nvim has nice ones by 
" " default)
    set directory=~/.vim/dirs/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/dirs/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo
    " create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif


" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4

" show line numbers
set nu

" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" maps capital Q to rewrap lines in text. This is a holdover from my days using
" slrn/tin to read/write usenet posts.
map Q gq

" My abbr for inserting the current date or time or date and time in the document.
iab xdati <c-r>=strftime("%d/%m/%Y %H:%M:%S") <cr>
iab xtime <c-r>=strftime("%H:%M:%S") <cr>
iab xdate <c-r>=strftime("%d/%m/%Y") <cr>

" FINDING FILES: ************************************************

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" " - Hit tab to :find by partial match
" " - Use * to make it fuzzy
"
" " THINGS TO CONSIDER:
" " - :b lets you autocomplete any open buffer
"
"
" TAG JUMPING ***************************************************
"
" " Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
"
" " NOW WE CAN:
" " - Use ^] to jump to tag under cursor
" " - Use g^] for ambiguous tags
" " - Use ^t to jump back up the tag stack
"
" " THINGS TO CONSIDER:
" " - This doesn't help if you want a visual list of tags

" AUTOCOMPLETE **************************************************
"
" " The good stuff is documented in |ins-completion|
"
" " HIGHLIGHTS:
" " - ^x^n for JUST this file
" " - ^x^f for filenames (works with our path trick!)
" " - ^x^] for tags only
" " - ^n for anything specified by the 'complete' option
"
" " NOW WE CAN:
" " - Use ^n and ^p to go back and forth in the suggestion list
"
" FILE BROWSING *************************************************
"
" " Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"
" " NOW WE CAN:
" " - :edit a folder to open a file browser
" " - <CR>/v/t to open in an h-split/v-split/tab
" " - check |netrw-browse-maps| for more mappings
"
" SNIPPETS *******************************************************
"
" " Read an empty HTML template and move cursor to title
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a
"
" " NOW WE CAN:
" " - Take over the world!
" "   (with much fewer keystrokes)
"
"
" BUILD INTEGRATION **********************************************
"
" " Steal Mr. Bradley's formatter & add it to our spec_helper
" " http://philipbradley.net/rspec-into-vim-with-quickfix
"
" " Configure the `make` command to run RSpec
" set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter
"
" " NOW WE CAN:
" " - Run :make to run RSpec
" " - :cl to list errors
" " - :cc# to jump to error by number
" " - :cn and :cp to navigate forward and back

" SPELLING ********************************************************

" only enable it on buffers containing files with potential prose
autocmd FileType latex,tex,md,markdown,txt,text,html setlocal spell
set spelllang=en,da




" PLUGIN-SPECIFIC SETTTINGS **************************************

""""" Airline settings *******************************************


let g:airline_powerline_fonts = 0
" let g:airline_theme = 'bubblegum'
let g:airline_theme = 'distinguished'
" let g:airline_theme = 'solarized'
" let g:airline_solarized_bg='dark'

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#clock#format = '%H:%M'

" Move clock to a different section of the statusline, copied from https://github.com/enricobacis/vim-airline-clock
let g:airline#extensions#clock#auto = 0
function! AirlineInit()
  let g:airline_section_z = airline#section#create(['clock', g:airline_symbols.space, g:airline_section_z])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

