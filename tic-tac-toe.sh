#!/bin/bash

# Initialize the game board
board=(" " " " " " " " " " " " " ")

# Function to display the board
print_board() {
    clear
    echo " ${board[0]} | ${board[1]} | ${board[2]} "
    echo "---|---|---"
    echo " ${board[3]} | ${board[4]} | ${board[5]} "
    echo "---|---|---"
    echo " ${board[6]} | ${board[7]} | ${board[8]} "
}

# Function to check if someone has won
check_winner() {
    # Winning combinations
    win_combinations=(
        "0 1 2"
        "3 4 5"
        "6 7 8"
        "0 3 6"
        "1 4 7"
        "2 5 8"
        "0 4 8"
        "2 4 6"
    )

    for combo in "${win_combinations[@]}"; do
        set -- $combo
        if [[ ${board[$1]} != " " && ${board[$1]} == ${board[$2]} && ${board[$2]} == ${board[$3]} ]]; then
            echo "Player ${board[$1]} wins!"
            exit 0
        fi
    done
}

# Function to check for a draw
check_draw() {
    for cell in "${board[@]}"; do
        if [[ $cell == " " ]]; then
            return
        fi
    done
    echo "It's a draw!"
    exit 0
}

# Main game loop
player="X"

while true; do
    print_board

    echo "Player $player, enter your move (0-8):"
    read -r move

#    if [[ ! $move =~ ^[0-8]$ ]] || [[ ${board[$move]} != " " ]]; then
     if [[ ! $move =~ ^[0-8]$ ]] || [[ ${board[$move]} == "X" || ${board[$move]} == "O" ]]; then
        echo "Invalid move. Try again."
        sleep 1
        continue
    fi

    board[$move]=$player

    check_winner
    check_draw

    # Switch player
    if [[ $player == "X" ]]; then
        player="O"
    else
        player="X"
    fi

done
