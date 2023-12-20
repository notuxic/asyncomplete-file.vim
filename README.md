asyncomplete-file.vim
=====================

Filename completion source for [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim).


Install
-------

With [vim-plug](https://github.com/junegunn/vim-plug):

```
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'notuxic/asyncomplete-file.vim'
```


Register
--------

The completion source also needs to be registered to be used by [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim):

```
call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
\ 'name': 'file',
\ 'allowlist': ['*'],
\ 'completor': function('asyncomplete#sources#file#completor')
\ }))
```


Configure
---------

By default, *asyncomplete-file.vim* will ignore files specified in `wildignore`. To also list these files, the following option needs to be set:

```
let g:asyncomplete_file_respect_wildignore = 0
```

*asyncomplete-file.vim* also supports fuzzy-matching:

```
let g:asyncomplete_file_fuzzymatch = 1
```
