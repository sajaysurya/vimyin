function! s:GetVisualSelection()
    " Adapted from https://stackoverflow.com/a/6271254
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
    " sel_flag=0 operates on the current characted
    " sel_flag=1 operated on the selection
    " TODO: check if pypintin is installed and raise appropriate errors
    " TODO: make it compatible with both python 2&3 versions of pypinyin
    if a:sel_flag
        let l:han = s:GetVisualSelection()
    else
        let l:han = matchstr(getline('.'), '\%' . col('.') . 'c.')
    endif
    let l:shell_command = 'pypinyin '."'".l:han."'"
    redraw
    echomsg system(l:shell_command)[:-2]
endfunction

function! vimyin#utils#GetHanziCraft()
    " TODO: Check vim version before using async
    " TODO: Make it compatible with windows and mac apart from linux
    " TODO: Gracefully handle when the job is a failure
    let l:han = matchstr(getline('.'), '\%' . col('.') . 'c.')
    let l:url = 'https://hanzicraft.com/character/'.l:han
    " set options for the async job
    let l:options = {}
    let l:options.in_io = 'null'
    let l:options.out_io = 'null'
    let l:options.err_io = 'null'
    let job = job_start('/usr/bin/xdg-open '.l:url, l:options)
endfunction
