#!/bin/bash

# Initialize the game board
board=("\e[90m0\e[0m" "\e[90m1\e[0m" "\e[90m2\e[0m" "\e[90m3\e[0m" "\e[90m4\e[0m" "\e[90m5\e[0m" "\e[90m6\e[0m" "\e[90m7\e[0m" "\e[90m8\e[0m")

# Function to display the board
print_board() {
    clear
    echo -e " ${board[0]} | ${board[1]} | ${board[2]} "
    echo -e "---|---|---"
    echo -e " ${board[3]} | ${board[4]} | ${board[5]} "
    echo -e "---|---|---"
    echo -e " ${board[6]} | ${board[7]} | ${board[8]} "
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
            print_board
            echo && echo "Player ${board[$1]} wins!" && echo
            exit 0
        fi
    done
}

# Function to check for a draw
check_draw() {
    for cell in "${board[@]}"; do
        if [[ $cell != "X" && $cell != "O" ]]; then
            return
        fi
    done
    print_board
    echo && echo "It's a draw!" && echo
    exit 0
}

# Main game loop
player="X"

while true; do
    print_board

    echo && echo "Player $player, enter your move (0-8):" && echo
    read -r move

    if [[ ! $move =~ ^[0-8]$ ]] || [[ ${board[$move]} == "X" || ${board[$move]} == "O" ]]; then
        echo && echo "Invalid move. Try again." && echo
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
