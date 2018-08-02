if exists('GuiLoaded')
    GuiFont! DejaVuSansMono NF:h7
    if @% == ""
        bd
    endif
endif
set background=light
if exists('GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'DejaVuSansMono NF 7')
endif
hi IndentGuidesOdd  guibg='#ebdbb2'
hi IndentGuidesEven guibg='#fbf1c7'
