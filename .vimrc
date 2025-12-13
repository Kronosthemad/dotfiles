source $VIMRUNTIME/defaults.vim

if has("vms")
	  set nobackup
	else
	  set backup
	  if has('persistent_undo')
	    set undofile
	  endif
	endif

	if &t_Co > 2 || has("gui_running")
	  set hlsearch
	endif


		augroup vimrcEx
	  au!
	  autocmd FileType text setlocal textwidth=78
	augroup END

	if exists('skip_defaults_vim')
	  finish
	endif
	set nocompatible

set backspace=indent,eol,start

set ruler

	set showcmd


	
	if has('mouse')
	  set mouse=a
	endif


	augroup RestoreCursor
      autocmd!
      autocmd BufReadPost *
        \ let line = line("'\"")
        \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
        \      && index(['xxd', 'gitrebase'], &filetype) == -1
        \      && !&diff
        \ |   execute "normal! g`\""
        \ | endif
    augroup END

			    \

packadd! matchit
	packadd! editorconfig
	packadd nohlsearch
	packadd hlyank



	packadd hlyank
if &t_Co > 1
	   syntax enable
	endif
