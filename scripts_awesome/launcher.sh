!/bin/bash

sleep 1

if ! pgrep -u $UID -x pasystray ; then pasystray ; else echo 'pasystray já lançado' ; fi

sleep 5

if ! pgrep -u $UID -x gammastep ; then sleep 1 ; gammastep-indicator ; else echo 'gammastep-indicator já lançado' ; fi
