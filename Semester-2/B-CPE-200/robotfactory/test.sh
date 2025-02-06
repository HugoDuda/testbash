#!/bin/bash

function test () {

    i=0
    t=1

    echo -e "\n\e[1;36m------------------------[BUILD CHECKING]------------------------\n\e[0m"; sleep 0.05

        echo -e "\e[1;37mBuild :" ;
        make re > /dev/null 2> /dev/null
        if [ $? -eq 0 ]; then
            echo -e "\e[1;32mSUCESS\n\e[0m"
        else
            echo -e "\e[1;31mFAILURE\n\e[0m"
            exit 0
        fi

    echo -e "\n\e[1;36m------------------------[ERROR HANDLING]------------------------\n\e[0m"; sleep 0.05

    commands=("" "abuceauocezczjicoazxjza" "bashtest" "bashtest/error_handling/no_name.s" "bashtest/error_handling/name_more_129.s" "bashtest/error_handling/comment_more_2049.s" "bashtest/error_handling/no_point_name.s" "bashtest/error_handling/no_point_comment.s" "bashtest/error_handling/invalid_instruction.s" "bashtest/error_handling/invalid_name.s" "bashtest/error_handling/invalid_comment.s")
    descriptions=("Try no arg" "Try to open nofile" "Try to open directory" "no_name" "name_more_than_129" "comment_more_than_2049" "no_point_name_line" "no_point_comment_line" "invalid_instruction" "invalid_comment" "invalid_name")

        for ((index=0; index<${#commands[@]}; index++)); do
            echo -e "\e[1;37mTest n°$t (${descriptions[index]}) :"; sleep 0.05
            ./asm ${commands[index]}
            if [ $? -eq 84 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            ((t++))
        done
}
make re
test
make fclean
