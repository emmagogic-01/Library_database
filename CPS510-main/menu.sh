#!/bin/sh
PrintMenu()
{
    echo " $IS_SELECTEDM M) View Manual"
    echo " "
    echo " $IS_SELECTED1 1) Drop Tables"
    echo " $IS_SELECTED2 2) Create Tables"
    echo " $IS_SELECTED3 3) Populate Tables"
    echo " $IS_SELECTED4 4) Query Tables"
    echo " "
    echo " $IS_SELECTEDE E) End/Exit"
    echo " "
}

MainMenu()
{
    while [ 1 ] 
    do
    
        echo "================================================================="
        echo "| Oracle All Inclusive Tool |"
        echo "| Main Menu - Select Desired Operation(s): |"
        echo "-----------------------------------------------------------------"
        PrintMenu
        echo "Choose: "
        read CHOICE
        
        if [ "$CHOICE" = "M" ] 
        then
            PrintMenu
        elif [ "$CHOICE" = "1" ] 
        then
            ./drop.sh
        elif [ "$CHOICE" = "2" ] 
        then
            ./create.sh
        elif [ "$CHOICE" = "3" ] 
        then
            ./insert.sh
        elif [ "$CHOICE" = "4" ] 
        then
            ./queries.sh
        elif [ "$CHOICE" = "E" ] | [ "$CHOICE" = "e" ] 
        then
            exit
        else
            echo "Command not found"
        fi
    done
}


ProgramStart()
{
    MainMenu
}
ProgramStart

