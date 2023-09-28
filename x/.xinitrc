exec xinput set-prop "Synaptics TM3276-022" "libinput Tapping Enabled" 1 &
exec xinput set-prop "Synaptics TM3276-022" "libinput Natural Scrolling Enabled" 1 &
exec setxkbmap -option ctrl:swapcaps -option altwin:swap_lalt_lwin &
exec awesome
