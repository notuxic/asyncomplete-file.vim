let s:pathsep = has('unix') ? '/' : '\\'


function! asyncomplete#sources#file#get_source_options(opts)
	return extend(extend({}, a:opts), {'triggers': {'*': [s:pathsep]}})
endfunction


function! asyncomplete#sources#file#completor(opt, ctx)
	let l:asyncomplete_file_respect_wildignore = get(g:, 'asyncomplete_file_respect_wildignore', 1)
	let l:asyncomplete_file_fuzzymatch = get(g:, 'asyncomplete_file_fuzzymatch', 0)

	let l:path = matchstr(a:ctx['typed'], '\m\f\+$')
	if strlen(l:path) == 0
		call asyncomplete#complete(a:opt['name'], a:ctx, a:ctx['col'] - strlen(l:path), [])
		return
	endif

	if l:asyncomplete_file_fuzzymatch
		let l:base = fnamemodify(l:path, ':h') . s:pathsep
		if l:base == '//'
			let l:base = '/'
		endif
		let l:files = getcompletion(l:base, 'file', l:asyncomplete_file_respect_wildignore)->map({_, val -> substitute(val, '\V' . escape(l:base, '\'), '', '')})

		let l:path_without_base = substitute(l:path, '\V' . escape(l:base, '\'), '', '')
		if strlen(l:path_without_base) == 0
			let l:matches = l:files->map({_, val -> l:base . val})
		else
			let l:matches = matchfuzzy(l:files, l:path_without_base)->map({_, val -> l:base . val})
		endif
	else
		let l:matches = getcompletion(l:path, 'file', l:asyncomplete_file_respect_wildignore)
	endif
	call asyncomplete#complete(a:opt['name'], a:ctx, a:ctx['col'] - strlen(l:path), l:matches)
endfunction
