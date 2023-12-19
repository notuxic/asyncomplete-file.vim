let s:pathsep = has('unix') ? '/' : '\\'


function! asyncomplete#sources#file#get_source_options(opts)
	return extend(extend({}, a:opts), {'triggers': {'*': [s:pathsep]}})
endfunction


function! asyncomplete#sources#file#completor(opt, ctx)
	let l:asyncomplete_file_respect_wildignore = get(g:, 'asyncomplete_file_respect_wildignore', 1)
	let l:path = matchstr(a:ctx['typed'], '\m\f\+$')
	if strlen(l:path) == 0
		call asyncomplete#complete(a:opt['name'], a:ctx, a:ctx['col'] - strlen(l:path), [])
		return
	endif

	let l:matches = getcompletion(l:path, 'file', l:asyncomplete_file_respect_wildignore)
	call asyncomplete#complete(a:opt['name'], a:ctx, a:ctx['col'] - strlen(l:path), l:matches)
endfunction
