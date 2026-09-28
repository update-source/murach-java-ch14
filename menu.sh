#!/bin/bash
# Menu shown in the browser terminal to pick which chapter 14 exercise to run.

while true; do
    clear
    echo "==============================================="
    echo "  Murach's Java Programming - Chapter 14"
    echo "==============================================="
    echo "  1) Exercise 14-1: Create Account"
    echo "  2) Exercise 14-2: Hangman"
    echo "  q) Quit"
    echo
    read -r -p "Choose an option: " choice
    echo

    case "$choice" in
        1) (cd /app/createaccount && java CreateAccountApp) ;;
        2) (cd /app/hangman && java HangmanApp) ;;
        q|Q) echo "Bye!"; exit 0 ;;
        *) echo "Invalid option." ;;
    esac

    echo
    read -r -p "Press Enter to return to the menu..." _
done
