" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match start '^\S*'
syn match seperator ' - '
syn match filename '(\(.*\.py\))$'

" Levels
"---------------------------------------------------------------------------
syn keyword logLevelDebug DEBUG
syn keyword logLevelInfo INFO
syn keyword logLevelWarning WARNING
syn keyword logLevelError ERROR
syn keyword logLevelCritical CRITICAL

hi def link logLevelInfo Repeat
hi def link logLevelDebug Debug
hi def link logLevelWarning WarningMsg
hi def link logLevelError ErrorMsg
hi def link logLevelCritical ErrorMs
hi def link filename String
hi def link seperator Operator
hi def link start Identifier

let b:current_syntax = 'lol'
