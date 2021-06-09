" Disable inserting comment leader after hitting o or O
set formatoptions-=o

" Disable inserting comment leader after hitting <Enter> in insert mode
set formatoptions-=r

" Only define following variable if Auto-pairs plugin is used
if match(&runtimepath, 'auto-pairs') != -1
  let b:AutoPairs = AutoPairsDefine({'<' : '>'})

  " Do not use `"` for vim script since `"` is also used for comment
  let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '`':'`', '<':'>'}
endif
