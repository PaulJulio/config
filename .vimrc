syntax on
" set cindent
set autoindent
set number
set splitbelow
set splitright
set cursorline
"set expandtab
set tabstop=4
set sw=4
set noeol
filetype plugin indent on
autocmd BufNewFile,BufRead *.module set filetype=php
autocmd BufNewFile,BufRead *.js.php set filetype=javascript
autocmd BufNewFile,BufRead *.css.php set filetype=css
autocmd BufNewFile,BufRead *.css set nocindent
autocmd BufNewFile,BufRead *.css.php set nocindent
cnoremap sudow w !sudo tee % >/dev/null
highlight ConsoleLog ctermbg=red guibg=red
match ConsoleLog /console\.log/
highlight ErrorLog ctermbg=red guibg=red
match ErrorLog /error_log/
autocmd BufWinEnter * match ConsoleLog /console\.log/
autocmd InsertLeave * match ConsoleLog /console\.log/
autocmd BufWinEnter * match ErrorLog /error_log/
autocmd InsertLeave * match ErrorLog /error_log/
autocmd BufWinLeave * call clearmatches()
" Clean up when saving
"autocmd BufWritePre * :%s/\s\+$//e
"autocmd BufWritePre * :%s/\t/   /e
" Higlight evil tabs
"highlight TabsAreEvil ctermbg=red guibg=red
"match TabsAreEvil /\t/
"autocmd BufWinEnter * match TabsAreEvil /\t/
"autocmd InsertLeave * match TabsAreEvil /\t/
"autocmd BufWinLeave * call clearmatches()
" Converting between decimals and hexadecimals
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction

command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction
