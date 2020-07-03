#!/bin/bash

#number of desktops
wmctrl -n 4

# launch applications
firefox &
atom &
gnome-terminal&
spotify &
sleep 15
#sleep to give the apps a chance to create GUI

#move window   to specified desktop
wmctrl -r firefox -t 0
wmctrl -r atom -t 0
wmctrl -r terminal -t 1
wmctrl -r spotify -t 2

#focus on terminal
wmctrl -a terminal
