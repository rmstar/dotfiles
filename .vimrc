""" Search settings """
set ignorecase " Ignore case by default
set incsearch " Enable incremental search
set hlsearch " highlight searched for phrases

""" UI settings """
if has("mouse")
        set mouse=a
    endif

    """ Text editing """
    set nocompatible    " Use Vim defaults (much better!)
    set bs=indent,eol,start     " allow backspacing over everything in insert mode
    set history=50
    set viminfo='100

    """ Visual cues """
    syntax on " syntax highlighting on
    set ruler " show the cursor position
    set showmatch " show matching brackets
    set matchtime=5 " how many tenths of a second to blink matching brackets for
    set scrolloff=5 " Keep 5 lines (top/bottom) for scope
    set sidescrolloff=5 " Keep 5 lines at the size
    set novisualbell " don't blink
    set nu           " use line numbers

    """ Color settings """
    highlight Normal ctermfg=Black ctermbg=White
    highlight Normal ctermfg=White ctermbg=Black
    highlight Search ctermfg=Black

    """ Indenting settings """
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set nosmartindent " smartindent (filetype indenting instead)
    set autoindent
    set cindent
    set cinoptions=g0:0 " No indent for public: or case:
    set copyindent " but above all -- follow the conventions laid before us
    filetype plugin indent on " load filetype plugins and indent settings

    """ File type detection """
    augroup filetypedetect
            au! BufRead,BufNewFile *.t setfiletype perl
        augroup END

        augroup Makefile
                au!
                    au BufReadPre Makefile set noexpandtab
                augroup END

                """ Ease of use """
                " When editing a file, always jump to the last cursor position
                autocmd BufReadPost *
                            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                            \   exe "normal! g'\"" |
                            \ endif

                set tags=./tags;

                cs add cscope.out
                nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>

                " --- OmniCppComplete ---
                " -- required --
                set nocp " non vi compatible mode
                filetype plugin on " enable plugins

                " -- optional --
                " auto close options when exiting insert mode
                autocmd InsertLeave * if pumvisible() == 0|pclose|endif
                set completeopt=menu,menuone

                " -- configs --
                let OmniCpp_MayCompleteDot = 1 " autocomplete with .
                let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
                let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
                let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
                let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
                let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window

                " -- ctags --
                " map <ctrl>+F12 to generate ctags for current folder:
                map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>

                map <C-K> :pyf ~/scripts/clang-format.py<CR>
                imap <C-K> <ESC>:pyf ~/scripts/clang-format.py<CR>i
