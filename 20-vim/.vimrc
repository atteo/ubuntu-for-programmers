" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible

" Change leader to comma
let mapleader=","
let maplocalleader=",,"

" 24 bit colors
if (has("termguicolors"))
	set termguicolors
endif
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
set t_8b=[48;2;%lu;%lu;%lum
set t_8f=[38;2;%lu;%lu;%lum

""" Plugins {{{
" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
	execute '!mkdir -p ~/.vim/autoload'
	execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" vim-one color theme
Plug 'rakr/vim-one'

" Suport for http://editorconfig.org/
Plug 'editorconfig/editorconfig-vim'

" Automatically adds endings to commands or tags
Plug 'tpope/vim-endwise'

" Better repeat for last command
Plug 'tpope/vim-repeat'

" Handles Ctrl-A/Ctrl-Z incrementing/decrementing also for dates 
Plug 'tpope/vim-speeddating'

" Change surroundings
Plug 'tpope/vim-surround'
	" cs'"   -- change surrounding ' to "
	" cs"<a> -- change surrounding " to <a>...</a>
	" cst'   -- change surrounding tags to '
	" ds'    -- delete surrounding '
	" yss]   -- add surrounding [ and ] for the entire line
	" ysw]   -- add surrounding [ and ] from current position to the end of current word
	" ysiw]  -- add surrounding [ and ] for the current word

" After p use <c-p> to switch to previous yank, <c-P> - next
Plug 'maxbrunsfeld/vim-yankstack'
	let g:yankstack_map_keys = 0
	let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']
	nmap <c-p> <Plug>yankstack_substitute_older_paste
	xmap <c-p> <Plug>yankstack_substitute_older_paste
	imap <c-p> <Plug>yankstack_substitute_older_paste
	nmap <c-P> <Plug>yankstack_substitute_newer_paste
	xmap <c-P> <Plug>yankstack_substitute_newer_paste
	imap <c-P> <Plug>yankstack_substitute_newer_paste

Plug 'tpope/vim-eunuch'
	" :Remove: Delete a buffer and the file on disk simultaneously.
	" :Unlink: Like :Remove, but keeps the now empty buffer.
	" :Move: Rename a buffer and the file on disk simultaneously.
	" :Rename: Like :Move, but relative to the current file's containing directory.
	" :Chmod: Change the permissions of the current file.
	" :Mkdir: Create a directory, defaulting to the parent of the current file.
	" :Find: Run find and load the results into the quickfix list.
	" :Locate: Run locate and load the results into the quickfix list.
	" :SudoWrite: Write a privileged file with sudo.
	" :SudoEdit: Edit a privileged file with sudo.
	" Also:
	" New files created with a shebang line are automatically made executable.
	" New init scripts are automatically prepopulated with /etc/init.d/skeleton.

"Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

" Custom text objects
"Plug 'kana/vim-textobj-user'

" %   -- go to matching element
" [%  -- previous matching group
Plug 'vim-scripts/matchit.zip'

" Fancy status bar
Plug 'vim-airline/vim-airline'
	" Font installation for airline:
	" https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation
	" But we use Nerd font which contain powerline symbols
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1

Plug 'tpope/vim-fugitive'
	nmap <leader>g :Ggrep
	nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>

" Shows Git diffs in a bar on the left
" Plug 'airblade/vim-gitgutter'
" 	" ]c - Jump to next hunk
" 	" [c - Jump to previous hunk
" 	" <Leader>hs - Stage hunk
" 	" <Leader>hu - Undo stage hunk
" 	" <Leader>hp - Preview hunk stages
" 	" ic - text object consisting of all lines in hunk
" 	" ac - the same as above plus any trailing empty lines
" 
" 	let g:gitgutter_sign_added = '▌'
" 	let g:gitgutter_sign_modified = '▌'
" 	let g:gitgutter_sign_modified_removed = '▌_'
" 	let g:gitgutter_sign_removed_first_line = '¯'
" 	let g:gitgutter_max_signs = 2000

" VIM Table Mode
" ,tm - Toggle Table Mode
" i| & a| - inner and around cell
" ,tfa - add formula
" ,tfe - evaluate formulas
Plug 'dhruvasagar/vim-table-mode'

" Write HTML quickly
" div.align-left#header   ==>   <div id="header" class="align-left"></div>
Plug 'rstacruz/sparkup'

" Line Commenting
Plug 'preservim/nerdcommenter'
	let g:NERDCreateDefaultMappings = 0
	map <m-c> <plug>NERDCommenterToggle

" *.otl file support
Plug 'vimoutliner/vimoutliner'

" Draw with mouse
Plug 'vim-scripts/sketch.vim'
	nnoremap <silent> <F2> :call ToggleSketch()<CR>

" Zeal support
" <leader>z
Plug 'KabbAmine/zeavim.vim'

" Expand Region
" + - expand
" _ - shrink
Plug 'terryma/vim-expand-region'

Plug 'jamessan/vim-gnupg'

Plug 'benmills/vimux'
Plug 'jtdowney/vimux-cargo', { 'branch': 'main' }
	map <m-w> :wa<CR> :CargoUnitTestFocused<CR>

" Change current dir to root directory of the project
Plug 'airblade/vim-rooter'

"Plug 'equalsraf/neovim-gui-shim'
	" GuiFont Monaco:h13
	" GuiLinespace 8

" Move seemlesly between vim and tmux windows
"Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Move seemlesly between vim and kitty windows
Plug 'knubie/vim-kitty-navigator'

" Completion engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
	inoremap <silent><expr> <c-space> coc#refresh()
	nmap <silent><m-d> <Plug>(coc-definition)
	nmap <silent><m-i> <Plug>(coc-implementation)
	nmap <silent><m-u> <Plug>(coc-references)
	nmap <silent><m-r> <Plug>(coc-rename)
	nmap <silent><m-R> <Plug>(coc-refactor)
	nmap <silent><m-J> <Plug>(coc-codeaction-line)
	nmap <silent><m-j> <Plug>(coc-fix-current)
	nmap <silent>]e <Plug>(coc-diagnostic-next)
	nmap <silent>[e <Plug>(coc-diagnostic-prev)
	nmap <silent><m-o> :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

	nnoremap <silent> <m-y> :CocCommand explorer<CR>

	" Make sure tabs are moved to the right when explorer is opened
	autocmd User CocExplorerOpenPre lua require'bufferline.state'.set_offset(41, 'FileTree')
	autocmd User CocExplorerQuitPre lua require'bufferline.state'.set_offset(0)

	nnoremap <silent> <m-e> :<C-u>CocList diagnostics<cr>

	" navigate chunks of current buffer
	nmap [g <Plug>(coc-git-prevchunk)
	nmap ]g <Plug>(coc-git-nextchunk)
	" navigate conflicts of current buffer
	nmap [c <Plug>(coc-git-prevconflict)
	nmap ]c <Plug>(coc-git-nextconflict)
	" show chunk diff at current position
	nmap gs <Plug>(coc-git-chunkinfo)
	" show commit contains current position
	nmap gc <Plug>(coc-git-commit)
	" create text object for git chunks
	omap ig <Plug>(coc-git-chunk-inner)
	xmap ig <Plug>(coc-git-chunk-inner)
	omap ag <Plug>(coc-git-chunk-outer)
	xmap ag <Plug>(coc-git-chunk-outer)

	nnoremap <silent> <m-h> :call <SID>show_documentation()<CR>

	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	  else
		call CocAction('doHover')
	  endif
	endfunction

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

Plug 'vimwiki/vimwiki'
	let g:vimwiki_key_mappings = { 'all_maps': 0, }
	let g:vimwiki_list = [{'path': '~/wiki/'}]
	map <F1> <Plug>VimwikiIndex
	"map <m-d> <Plug>VimwikiFollowLink


" tagbar
Plug 'liuchengxu/vista.vim'
	nmap <m-l> :Vista!!<CR>
	let g:vista#renderer#enable_icon = 1

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
	nnoremap <m-f> :Files<CR>
	nnoremap <m-q> :Ag<CR>
	imap <m-f> <plug>(fzf-complete-path)

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'puremourning/vimspector'
	nmap <F4> <Plug>VimspectorToggleBreakpoint
	nmap <F5> <Plug>VimspectorContinue
	nmap <F7> <Plug>VimspectorStepInto
	nmap <F8> <Plug>VimspectorStepOver
	nmap <F12> <Plug>VimspectorReset
	let g:vimspector_install_gadgets = [ 'vscode-bash-debug', 'vscode-cpptools', 'CodeLLDB', 'vscode-java-debug' ]

Plug 'Asheq/close-buffers.vim'
	nnoremap <silent> <leader>b :b1 \| :Bdelete hidden<CR>

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" Syntax support

" Common language pack
Plug 'sheerun/vim-polyglot'

Plug 'OmniSharp/omnisharp-vim'

Plug 'dylon/vim-antlr'
	au BufRead,BufNewFile *.g set filetype=antlr3
	au BufRead,BufNewFile *.g4 set filetype=antlr4
Plug 'adimit/prolog.vim'

Plug 'ekalinin/Dockerfile.vim'

Plug 'ap/vim-css-color'

Plug 'terminalnode/sway-vim-syntax'

Plug 'github/copilot.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/spellsitter.nvim'

Plug 'romgrk/barbar.nvim'

Plug 'pocco81/auto-save.nvim'

Plug 'rcarriga/nvim-notify'
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
	nmap <silent><m-k> :SnipRun<CR>
	vmap <silent><m-k> :'<,'>SnipRun<CR>

Plug 'ggandor/lightspeed.nvim'


"Plug 'rust-lang/rust.vim'
	let g:rustfmt_autosave = 1
	let g:rustfmt_emit_files = 1
"Plug 'hashivim/vim-terraform'
	" Support for vim-commentary for terraform files
	autocmd FileType terraform setlocal commentstring=#%s
"Plug 'fatih/vim-go'
	function GoMode()
		setlocal noexpandtab
		"nnoremap <F5> :GoRun<CR>
	endfunction
	autocmd FileType go call GoMode()

" Neovim
let g:gonvim_start_fullscreen = 1
if exists('g:GuiLoaded')

endif

call plug#end()
"
""" }}} Plugins

" rakr/vim-one configuration
let g:one_allow_italics = 1 " italic for comments
let g:airline_theme='one'
colorscheme one
set background=dark " for the dark version

" Make sign column transparent
highlight SignColumn ctermbg=0


""" Settings {{{

" When switching buffers jump to the existing window, if the buffer is already
" opened there
set switchbuf=usetab


" Show completion menu with description
set completeopt=menuone,preview

" When wrapping paragraphs, don't end lines with 1-letter words (looks stupid)
set formatoptions+=1

" Adds g to :substitute automatically, for example, instead of :%s/foo/bar/g you just type :%s/foo/bar/
set gdefault

" Always show menu
set guioptions=mt

" Hide the buffer instead of closing it. When using :e,
" it won't ask to write changes in current buffer.
set hidden

" ignore case when searching
set ignorecase

" Keep at lest 2 lines of context when scrolling
set scrolloff=2

"ignore case if search pattern is all lowercase, case-sensitive otherwise
set smartcase

" Show the mode in status line
set showmode

" Show partially entered commands in status line
set showcmd

" Use 4 space tab, do not change tabs into spaces
set tabstop=4 shiftwidth=4

" Fixes the problem with timeout after pressing ESC key
" First configure the terminal to send two 'ESC ESC' sequence instead of
"  single 'ESC' after Escape key is pressed
set timeoutlen=500 ttimeoutlen=0

" CursorHold event trigger after 1 second instead of default 4
set updatetime=500

" Move to the next and previous line when using cursor keys 
set whichwrap=b,s,<,>,[,]

" <tab> shows all possible commands
set wildmode=longest,list

" :split should open at the bottom
set splitbelow
set splitright

" Maximum number of lines saved on exit for each register set to 10000
set viminfo='100,<10000,s10,h

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes:2
"if has("patch-8.1.1564")
"  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

" Do not add new line automatically
set nofixendofline

" Reread changed files automatically
set autoread

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

""" }}} Settings


""" Directories {{{

" Make backups in ~/.vim/tmp
set backup
set backupdir=~/.vim/tmp

" Make swap files in ~/.vim/tmp
set dir=~/.vim/tmp
"
" Allow undo to work even after exit from vim
" You must create the directory ~/.vim/undodir manually!
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer

""" }}} Directories


" map ; to :
nnoremap ; :

" Use css when exporting as HTML
let g:html_use_css = "1"

" Script to show man pages from inside VIM
" ,K - show man page for keyword under the cursor
"runtime ftplugin/man.vim


" Cursor shape

" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes

" For KDE konsole
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" The same for Gnome Terminal
"let &t_SI = "\<Esc>[6 q"
"let &t_SR = "\<Esc>[4 q"
"let &t_EI = "\<Esc>[2 q"

" combined
let &t_SI = "\<Esc>[6 q\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>[2 q\<Esc>]50;CursorShape=0\x7"
let &t_SR = "\<Esc>[4 q"
""""

" set dark gray cursorline
set cursorline
hi CursorLine term=none cterm=none ctermbg=233

" Highlight current line, command: ,l
"nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>

" Highlight current column, command: ,c
"nnoremap <silent> <Leader>c :execute 'match Search /\%'.virtcol('.').'v/'<CR>

" Show trailing whitespace and spaces before a tab
" But when opening terminal inside VIM don't touch spaces after '➤'
let c_space_errors = 1
let java_space_errors = 1
highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd Syntax * syn match ExtraWhitespace /\(➤\)\@<!\s\+$\| \+\ze\t/
"syn match ExtraWhitespace /\(➤\)\@<!\s\+$\| \+\ze\t/

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Toggle show/hide invisible chars
nnoremap <silent><leader>i :set list!<cr>
set listchars=tab:▸\ ,trail:-,eol:¬,extends:>,precedes:<,nbsp:+

" Paste mode switching
set pastetoggle=<F6>


" Enable mouse support
set mouse=a
set mousemodel=popup_setpos

" Spell checking
setlocal spell spelllang=en_us,pl
hi clear SpellBad
hi SpellBad cterm=italic
" Ignore words containing upper case letters when spell checking
fun! IgnoreCamelCaseSpell()
	syn match CamelCase /\<\l\{-}\(\u\|\d\).\{-}\>/ contains=@NoSpell transparent
	syn cluster Spell add=CamelCase
endfun
autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()

" Toggle line numbers
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber
		set number
	else
		set number!
	endif
endfunc
nnoremap <silent><leader>N :call NumberToggle()<cr>

function! RelativeNumberToggle()
	if(&relativenumber == 1)
		setlocal norelativenumber
		setlocal nonumber
		highlight LineNr ctermfg=yellow
	else
		setlocal relativenumber
		setlocal number
		highlight LineNr ctermfg=green
	endif
endfunc
nnoremap <silent><leader>n :call RelativeNumberToggle()<cr>

" URL encode/decode selection
vnoremap <leader>eu :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <leader>du :!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>
vnoremap <leader>ex :!python -c 'import sys;from xml.sax.saxutils import escape; print escape(sys.stdin.read().strip())'<cr>
vnoremap <leader>dx :!python -c 'import sys;from xml.sax.saxutils import unescape; print unescape(sys.stdin.read().strip())'<cr>

" Map Ctrl<movement> into :cprev and :cnext
noremap <silent> <C-h> :cprev<CR>
noremap <silent> <C-l> :cnext<CR>

" :W - writes through sudo
command! W w !sudo tee % > /dev/null

" Add \v when searching, see also: http://www.vim.org/scripts/script.php?script_id=4849
nnoremap / /\v
vnoremap / /\v

" Ctrl-O goes back

" Go to the previous file position on open
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Send visual selection to gist.github.com as a private, filetyped Gist
" Requires the gist command line too, apt install gist
vnoremap <leader>G :w !gist-paste -p -t %:e \| xclip -selection c<cr>

" Space to toggle folds.
nnoremap <space> za
vnoremap <space> za

" highlight last inserted text
nnoremap gV `[v`]

" Jumps
" :jumps to see history of locations
" <number> Alt-Left - jump to previous
" <number> Alt-Right - jump forward
nnoremap <A-left> <c-o>
nnoremap <A-right> <c-i>

" Make Y yank till end of line
nnoremap Y y$

" Make < to not remove selection
vnoremap < <gv
vnoremap > >gv

nmap <leader>x :!xdg-open %<cr><cr>

" Jenkinsfile support
au BufReadPost Jenkinsfile* set syntax=groovy

try
	source ~/.vimrc.local
catch
	" No such file? No problem; just ignore it.
endtry

" yaml cannot use tabs
autocmd FileType yaml setlocal expandtab
autocmd FileType docker-compose setlocal expandtab
