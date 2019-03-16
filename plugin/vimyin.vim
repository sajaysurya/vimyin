" Define custom commands
command! -range VimyinDispPinyinChar call vimyin#utils#GetPinyin(0)
command! -range VimyinDispPinyinSelection call vimyin#utils#GetPinyin(1)

" Map commands
nnoremap <silent><Leader>z :VimyinDispPinyinChar <CR>
vnoremap <silent><Leader>z :VimyinDispPinyinSelection <CR>
