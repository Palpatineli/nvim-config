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
