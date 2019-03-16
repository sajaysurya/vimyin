function! s:GetVisualSelection()
    " Thanks to https://stackoverflow.com/a/6271254
    " TODO: make selection boundary is compatilble with ascii
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    elseif len(lines) > 1
        return 'Multiline selection is not supported'
    endif
    if &selection == 'inclusive'
        let line = lines[0][column_start-1 : column_end+1]
    else
        let line = lines[0][column_start-1 : column_end-2]
    endif
    return line
endfunction

function! vimyin#utils#GetPinyin(sel_flag)
    if a:sel_flag
        let l:han = s:GetVisualSelection()
    else
        let l:han = matchstr(getline('.'), '\%' . col('.') . 'c.')
    endif
    let l:shell_command = 'pypinyin '."'".l:han."'"
    redraw
    echomsg system(l:shell_command)[:-2]
endfunction
