#!/bin/sh

main() {
    caps=$(xset q | grep LED | awk -F"0000000" '{print $2 }')
    if [ $caps -eq 1 ]
    then
        echo "CAPS LOCK"
    else
        echo ""
    fi
}

main "$@"
