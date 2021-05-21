" don't continue comment on o/O operation
set formatoptions-=o

set tabstop=2
set softtabstop=2
set shiftwidth=2

" only folds classes inner content
set foldlevel=1

" do not align arrows on multi-lined chained calls
let g:PHP_noArrowMatching = 1

" indent code inside switch/case statements
let g:PHP_vintage_case_default_indent = 1

" do not align block braces with code inside block
let g:PHP_BracesAtCodeLevel = 0
