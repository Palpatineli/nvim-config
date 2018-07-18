" Vim syntax file
" Language: Latex 
" Maintainer: Keji Li 
" Latest Revision: Nov 02 2012 

syn region latexCommentPackageComment start="\\begin{comment}" end="\\end{comment}" fold transparent containedin=ALL
hi def link latexCommentPackageComment texComment
