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
command! Tabber call Tabber()
if exists('g:tabberMapping')
    exe 'nnoremap '. g:tabberMapping .' :call Tabber()<cr>'
endif
" -----------------------------------------------------------------------
function! Tabber()
    redir @t
    silent tabs
    redir END
    let s:tags = trim(@t)
    let s:tags = substitute(s:tags,"[^ ]\\+/","","g")
    let s:tags = substitute(s:tags,"Tab page \\(\\d*\\)","\\1","g")
    let s:tags = substitute(s:tags,"[> ]\\{2}[+ ]\\{2}","    ","g")
    let s:tags = substitute(s:tags,"\\d\\@<!\\n   "," |","g")
    let s:tags = substitute(s:tags,"\\n   ","","g")
    let s:tags = substitute(s:tags,"[^ ]*VOOM\\d*","VOOM |","g")
    let s:tablist = split(s:tags,"\\n")
    function! TabberGo(id, result)
        let s:tabnogo = tabpagenr()
        let s:tabgo = a:result
        if s:tabgo == "-1"
            let s:tabgo = s:tabnogo
        endif
        exe 'normal '. s:tabgo .'gt'
    endfunction
    let tabber = popup_menu(s:tablist, 
                \ #{ title: " [ T A B B E R ] ", callback: 'TabberGo',
                \ line: g:tabberMargin, col: (g:tabberMargin*3), wrap:'false',
                \ border: [], dragall: 1, resize:1, pos: g:tabberPosition, 
                \ padding: [(g:tabberPadding/3),g:tabberPadding,(g:tabberPadding/2),g:tabberPadding]} )
    call win_execute(tabber, 'hi! PmenuSel gui=bold cterm=bold')
    call win_execute(tabber, 'call cursor('.tabpagenr().', 1)')
endfunction
" -----------------------------------------------------------------------
