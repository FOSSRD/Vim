set nocompatible " Esto sirve para poder apagar la compatibilidad con vi.
" y si, ya sabemos que nocompatible se activa por defecto al tener .vimrc
syntax on " Syntax highlight, claro que yes.
set timeout timeoutlen=2000 " Cuando uses comandos multicaracter (y5j) tendras
" un total de 2 segundos para escribir entre una letra y otra, cambialo a
" antojo

set tabstop=4 softtabstop=4 " No te preocupes demasiado por esta linea y la
" siguiente, tabstop, softtabstop y shiftwidth todas a 4 resultan en que darle
" a tab pone cuatro espacios y cada 4 eespacios se usan como indentacion y la
" autoindentacion va a ser en 4 espacios y todo en 4 espacios, solo disfruta
" :)
set shiftwidth=4

set smarttab " un poco mas de magia de tabs
set expandtab " ya casi acabamos con los tabs, tranquilo
set smartindent " va a hacer automaticamente el indnetado en lenguajes C-like

set termguicolors " Activa colores de 24 bits y asi tu tema va a funcionar bien

set number " Activa los numeros de linea
set relativenumber " Hace que los numeros sean relativos a la linea actual, Cuando
" aprendas motions de vim entenderas el valor de estos, pero si no te gustan
" pues no queda de otra que apagarlos.
set ignorecase " cuando busques con / la busqueda no sera sensible a mayusculas
set smartcase " si usas mayusculas en la busqueda entonces si sera sensible
set nohlsearch " cuando haces una busqueda no se mantienen resaltados los resultados
set incsearch " si se resaltara la busqueda mienras la estas haciendo
" Esta combinacion de nohlsearchy incsearch es normalmente la mas util y menos
" molesta para casi todos los casos de busqueda
set hidden " esto sirve para que puedas abrir mas archivos con :e mientras aun
" tienes cambios sin guardar en el archivo que tienes abierto, este
" comportamiento es el mas util para la mayoria de usuarios.
set noerrorbells " Si haces algo mal, no habra uin beep indicandotelo :)

set scrolloff=8 " cuando empieces a bajar por un documento, el documento empezara
" a hacer scroll cuando estes a 8 lineas del borde de abajo, asi el cursor
" siempre estara mas o menos centrado y sera mas facil ubicarse en el archivo
set cmdheight=2 " La linea donde esta el CMD ahora sera dos lineas de alto, esto
" para poder leer mejor los mensajes que te pueda arrojar el editor y en
" general una mejor experiencia visual, cambialo de acuerdo a lo que necesites
set updatetime=300 " luego de esta cantidad de milisegundos sin escribir se
"guarda la copia de seguridad al disco
set shortmess+=c " Mostrarte menos mensajes molestos que no necesitas ver

"FOR FINDING FILES:
"esto nos va a ayudar a encontrar mas facilmente archivos en los subfolders
set path+=**
set wildmenu
"una nota importante es que podemos simplemente usar ":b nombre" para
"cambiar entre los buffers que tenemos abiertos, los que podemos ver
"con el comando ":ls" que nos deja ver todos los buffer

"REMAPS:
" Usar ctrl-[hjkl] para moverse entre los paneles abiertos
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" escribe jk en sucesion rapida estando en modo insertar y te llevara al modo
" normal, puede ser un poco molesto para algunos asi que podrias quitarlo
" si eso es tu caso
inoremap jk <ESC>

" Ctrl-s para guardar, justo como en tu notepad!
nnoremap <C-s> :w<CR>

" un poco de magia para que puedas moverte por las lineas ultra largas que se
" ven como multiples lineas en vim como si de verdad fueran multiples lineas y
" no se salte todo, ayuda mucho a navegar por el texto.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" con \v abres un panel vertical y von \h uno horizontal, sin TMUX!
nnoremap <leader>v :Vex<CR>
nnoremap <leader>h :Sex<CR>

"searcher function, solo te pide que buscar dentro del texto y el directorio y
"te da un menu interactivo con las opciones para que saltes directo a esa
"linea! y mas rapido que en tu vscode mas cercano, solo escribe \g
function! Grepper()
    call inputsave()
    let replacement = input('RegExp: ')
    let workdir = input('Directory: ')
    call inputrestore()
    execute 'grep! -Irn '.replacement.' '.workdir
endfunction
nnoremap <silent> <leader>g  :call Grepper()<CR>:copen<CR>



" Con esto tienes numeros relativos en modo normal y normales en modo insertar
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


"PARA CREAR TAGS EN UN PROYECTO:
command! MakeTags !ctags -R .
" ahora al hacer ":MakeTags" podremos hacer un tags file
" esto nos permite hacer lo siguiente:

" COMANDOS PARA TAGS:
" usar "^]" para saltar a la definicion
" usar "g^]" para tags ambiguos
" usar "^t" para devolverse en el stack
" tambien para autocompletar tenemos
" "^x^n" para algo en el archivo actual
" "^x^f" para filenames
" "^x^]" para tags
" "^n" para cosas que estan en el 'complete'


"FILE BROWSING:
let g:netrw_banner=0
"let g:netrw_browse_split=4
"let g:netrw_altv=1
"let g:netrw_liststyle=3
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_dide=',\(^\|\s\s\)\zs\.\S\+'


" Esto es para automaticamente borrar los espacios en blanco al final de las
" lineas al guardar el archivo
"My_autocmds:
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup AUTOBORRADO
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
