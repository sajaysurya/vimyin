function! GetPinyin()
    # TODO: get the text from selection
    let han = '"hello 你好"'
    echomsg system('pypinyin '.han)[:-2]
endfunction
