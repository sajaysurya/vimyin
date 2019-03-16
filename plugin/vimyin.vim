" 我的妹妹很漂亮

function! GetVisualSelection()
    " Thanks to https://stackoverflow.com/a/6271254
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    elseif len(lines) > 1
        return 'Multiline selection is not supported'
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! GetPinyin(sel_flag)
    if a:sel_flag
        let l:han = GetVisualSelection()
    else
        let l:han = matchstr(getline('.'), '\%' . col('.') . 'c.')
    endif
    let l:shell_command = 'pypinyin '."'".l:han."'"
    echomsg l:shell_command
    echomsg system(l:shell_command)[:-2]
endfunction

command! -range VimyinDispPinyinChar call GetPinyin(0)
command! -range VimyinDispPinyinSelection call GetPinyin(1)
