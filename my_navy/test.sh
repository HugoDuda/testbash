#!/bin/bash

function test () {

    echo -e "\n\n\n\e[1;36m------------------------[BUILD CHECKING]------------------------\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mBuild :" ; sleep 0.05
    make re > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
        exit 0
    fi

    echo -e "\n\e[1;36m------------------------[ERROR HANDLER]------------------------\n\e[0m"; sleep 0.1

    echo -e "\n\e[1;33m-----[Robustness - Opening valid file]-----\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 :" ; sleep 0.05
    timeout 0.5s ./my_navy bash_test/valid_pos/pos1
    if [ $? -eq 124 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°2 :" ; sleep 0.05
    timeout 0.5s ./my_navy bash_test/valid_pos/pos2
    if [ $? -eq 124 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°3 :" ; sleep 0.05
    timeout 0.5s ./my_navy bash_test/valid_pos/pos3
    if [ $? -eq 124 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi

    echo -e "\n\e[1;33m-----[Robustness - Opening invalid file]-----\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 (bad_format) :" ; sleep 0.05
    timeout 0.5s ./my_navy bash_test/invalid_pos/bad_format
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°2 (bad_limit_pos) :" ; sleep 0.05
    timeout 0.5s ./my_navy bash_test/invalid_pos/bad_limit_pos
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°3 (boat_size) :" ; sleep 0.05
    timeout 0.5s ./my_navy bash_test/invalid_pos/boat_size
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°4 (not_enough_element) :" ; sleep 0.05
    timeout 0.5s ./my_navy bash_test/invalid_pos/not_enough_element
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°5 (too_many_element) :" ; sleep 0.05
    timeout 0.5s ./my_navy bash_test/invalid_pos/too_many_element
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°6 (too_many_line) :" ; sleep 0.05
    timeout 0.5s ./my_navy bash_test/invalid_pos/too_many_line
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi

}

test
make fclean