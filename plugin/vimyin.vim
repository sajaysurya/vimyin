" Define custom commands
command! -range VimyinDispPinyinChar call vimyin#utils#GetPinyin(0)
command! -range VimyinDispPinyinSelection call vimyin#utils#GetPinyin(1)
command! -range VimyinDispHanziCraft call vimyin#utils#GetHanziCraft()

" Map commands
nnoremap <silent><Leader>cc :VimyinDispPinyinChar <CR>
vnoremap <silent><Leader>cc :VimyinDispPinyinSelection <CR>
nnoremap <silent><Leader>cx :VimyinDispHanziCraft <CR>
