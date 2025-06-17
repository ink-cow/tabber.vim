" tabber.vim
" DESCRIPTION:      Simple popup for navigating tabs
" MAINTAINER:       Ink Cow
" WEBSITE:          https://www.github.com/ink-cow
" INITIAL RELEASE:  14 June 2025
" VERSION:          1.3
" UPDATED:          16 June 2025
" -----------------------------------------------------------------------
" TABBER
" Summon a workspace overview to quickly navigate tabs!
" -----------------------------------------------------------------------
if !exists('g:tabberPosition')
    let g:tabberPosition = "topleft"
endif
if !exists('g:tabberMargin')
    let g:tabberMargin = 5
endif
if !exists('g:tabberPadding')
    let g:tabberPadding = 3
endif
" -----------------------------------------------------------------------
command! Tabber call Tabber('tabber')
if exists('g:tabberMapping')
    exe "nnoremap ". g:tabberMapping ." :call Tabber('tabber')<cr>"
endif
inoremap <expr> <C-n> pumvisible() ? "\<Del>" : ":call Tabber('clobber')"
" -----------------------------------------------------------------------
function! Tabber(mode)
    redir @t
    silent tabs
    redir END
    let s:delnum = (tabpagenr('$') + 1)
    let s:tags = trim(@t)
    let s:tags = substitute(s:tags,"[^ ]\\+/","","g")
    let s:tags = substitute(s:tags,"Tab page \\(\\d*\\)","\\1","g")
    let s:tags = substitute(s:tags,"[> ]\\{2}[+ ]\\{2}","    ","g")
    let s:tags = substitute(s:tags,"\\d\\@<!\\n   "," |","g")
    let s:tags = substitute(s:tags,"\\n   ","","g")
    let s:tags = substitute(s:tags,"[^ ]*VOOM\\d*","VOOM |","g")
    let s:tablist = split(s:tags,"\\n")
    if a:mode == "tabber"
        call add(s:tablist,'    Close tabs >>')
        let tabber = popup_menu(s:tablist, 
                    \ #{ title: " [ T A B B E R ] ", callback: 'TabberGo',
                    \ line: g:tabberMargin, col: (g:tabberMargin*3), wrap:'false',
                    \ border: [], dragall: 1, resize:1, pos: g:tabberPosition, 
                    \ padding: [(g:tabberPadding/3),g:tabberPadding,(g:tabberPadding/2),g:tabberPadding]} )
        call win_execute(tabber, 'hi! PmenuSel gui=bold cterm=bold')
        call win_execute(tabber, 'call cursor('.tabpagenr().', 1)')
    elseif a:mode == "clobber"
        call add(s:tablist,'    << Tab selection')
        let clobber = popup_menu(s:tablist, 
                    \ #{ title: " [ CLOSE TABS ] ", callback: 'TabberClose',
                    \ line: g:tabberMargin, col: (g:tabberMargin*3), wrap:'false',
                    \ border: [], dragall: 1, resize:1, pos: g:tabberPosition,
                    \ padding: [(g:tabberPadding/3),g:tabberPadding,(g:tabberPadding/2),g:tabberPadding]} )
        call win_execute(clobber, 'hi! PmenuSel gui=bold cterm=bold')
        call win_execute(clobber, 'call cursor('.tabpagenr().', 1)')
    endif
endfunction
function! TabberGo(id, result)
    let s:tabstay = tabpagenr()
    let s:tabgo = a:result
    echo a:result
    if s:tabgo == "-1"
        let s:tabgo = s:tabstay
    elseif s:tabgo == s:delnum
        call Tabber('clobber')
    else
        exe 'normal '. s:tabgo .'gt'
    endif
endfunction
function! TabberClose(id, result)
    let s:tabstay = tabpagenr()
    let s:tabgo = a:result
    echo a:result
    if s:tabgo == "-1"
        let s:tabgo = s:tabstay
    elseif s:tabgo == s:delnum
        call Tabber('tabber')
    else
        exe ':'.s:tabgo .'tabclose'
        call Tabber('clobber')
    endif
endfunction
" -----------------------------------------------------------------------
