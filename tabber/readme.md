# Tabber

Summon a workspace overview to quickly navigate tabs!

## Installation

Just one small plugin file.

## Usage

Invoke a simple popup with the command `:Tabber`

Here's a remarkable life-like facsimile!

            ╔ [ T A B B E R ]═════════════════════════╗
            ║                                         ║
            ║   1 [No Name]                           ║
            ║   2 commonmark.vim                      ║
            ║   3 storytime | snow-white-story.md     ║
            ║   4 storytime | snow-white-vampire.md   ║
            ║   5 research | medieval-dresses.md      ║
            ║   6 plugin | popup.txt | tabber.vim     ║
            ║                                         ║
            ╚═════════════════════════════════════════╝

- Go up and down with j/k then select your destination
- YOU ARE HERE: Your current tab is selected by default
- Each line lists all the open windows in each tab
- The popup can be dragged and resized with the mouse
- Use x or escape to close the window without leaving the current tab

## Mapping for writers

As customary in vim, use j/k (just/kidding) to traverse lines, or ctrl-n/ctrl-p (next/previous). Vim purists sneer at arrow keys. But vim purists also sneer at tabs. It's all about the buffers! So you're among friends.

Writers interested in more traditional editor behavior can add these mappings to their VIMRC. This will allow using the up/down arrow keys as well.

    nnoremap <Down> gj
    nnoremap <Up> gk
    vnoremap <Down> gj
    vnoremap <Up> gk

These and other settings will be found in an upcoming system for writers called Papermark.

VIMRC can be accessed with `e $MYVIMRC`or `tabnew $MYVIMRC`.

## Configuration

Optionally place these settings in your VIMRC. Defaults are set (except mapping), so you're already good to go.

    let g:tabberPosition = 'topleft'
    let g:tabberMargin = 5
    let g:tabberPadding = 3
    let g:tabberMapping = "<Leader>x" 

You have only three options for g:tabberPosition. Default is topleft.

- center
- topleft
- botright

Margin and padding should be self explanatory. The bigger the number, the bigger the margins and padding.

## Mapping the shortcut

To map your shortcut, you can indicate your preferred shortcut with g:tabberMapping or define it directly:

    nnoremap <Leader>, :call Tabber()<cr>

This may sound silly, but I suggest mapping `<Leader><Leader>` so you can just double-tap to access your workspace super-quick. The following seems to actually work.

    let g:tabberMapping = "<Leader><Leader>" 

Anyway, it's up to you. Just remember, default is NO KEYMAPPING. Use the command `:Tabber` if no mapping is set.

## Custom colors

Tabber politely adheres to the user's chosen color scheme, except we presume to embolden the selection. If you want to customize the popup box, add lines like this to your VIMRC.

    hi! Pmenu fg=skyblue bg=navy ctermfg=skyblue ctermbg=navy
    hi! PmenuSel fg=white bg=purple gui=bold ctermfg=white ctermbg=purple cterm=bold

Using your preferred colors, of course. There are other highlighting options for popup menus that don't apply to Tabber. For more information on popup schematics, go to `:help Pmenu`

## Known issues

If the text cursor is behind the popup, you can still see it blinking. Suggested fixes haven't panned out.

## Troubleshooting

Well, I can only guess what might go wrong.

The tab list is created by editing the internal tab list with regex, and every tab must reside on one line only. If the lines are broken for any reason, the selection will be thrown off.

Access Vim's tab list by typing `:tabs`.

