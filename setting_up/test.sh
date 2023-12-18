#!/bin/bash

function test () {
    echo -e "\n\n\n\e[1;36m---------[ERROR MANAGER]---------\n\e[0m"; sleep 0.1

    echo -e "\n\e[1;0m--[Robustness - Opening valid file]--\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 (Bad character) :" ; sleep 0.05
    ./setting_up bash_test/bad_caracter_map
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt

    echo -e "\e[1;37mTest n°2 (Different line sizes) :" ; sleep 0.05
    ./setting_up bash_test/different_line_size
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt

    echo -e "\e[1;37mTest n°3 (Empty map) :" ; sleep 0.05
    ./setting_up bash_test/empty_map
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt

    echo -e "\e[1;37mTest n°4 (Existing file) :" ; sleep 0.05
    ./setting_up no_file_exist
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt

    echo -e "\e[1;37mTest n°5 (Less lines) : " ; sleep 0.05
    ./setting_up bash_test/less_lines
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt

    echo -e "\n\n\n\e[1;0m--[Robustness - Generating valid board]--\n\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mTest n°1 (Alpha-numeric size) :" ; sleep 0.05
    ./setting_up a ..o..o
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt

    echo -e "\e[1;37mTest n°2 (Empty pattern) :" ; sleep 0.05
    ./setting_up 12 ""
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt

    echo -e "\e[1;37mTest n°3 (Invalid argument number) :" ; sleep 0.05
    ./setting_up 10 ..o..o invalid_argument
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt

    echo -e "\e[1;37mTest n°4 (Invalid pattern character) :" ; sleep 0.05
    ./setting_up 10 ..o.a.o
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt

    echo -e "\e[1;37mTest n°5 (Negative size) :" ; sleep 0.05
    ./setting_up -6 ..o..o..oo
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt

    echo -e "\n\n\n\e[1;36m---------[ALGORITHM APP]---------\n\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mtest n°1 (intermediate_map_34_137_empty) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_34_137_empty > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_34_137_empty
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°2 (intermediate_map_34_137_filled) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_34_137_filled > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_34_137_filled
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°3 (intermediate_map_34_137_with_obstacles_25pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_34_137_with_obstacles_25pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_34_137_with_obstacles_25pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°5 (intermediate_map_34_137_with_obstacles_50pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_34_137_with_obstacles_50pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_34_137_with_obstacles_50pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°6 (intermediate_map_34_137_with_obstacles_75pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_34_137_with_obstacles_75pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_34_137_with_obstacles_75pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°7 (intermediate_map_97_21_empty) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_97_21_empty > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_97_21_empty
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°8 (intermediate_map_97_21_filled) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_97_21_filled > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_97_21_filled
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°8 (intermediate_map_97_21_with_obstacles_25pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_97_21_with_obstacles_25pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_97_21_with_obstacles_25pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°9 (intermediate_map_97_21_with_obstacles_50pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_97_21_with_obstacles_50pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_97_21_with_obstacles_50pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°10 (intermediate_map_97_21_with_obstacles_75pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_97_21_with_obstacles_75pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_97_21_with_obstacles_75pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°10 (intermediate_map_100_100) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_100_100 > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_100_100
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt
}

make re
test
make fclean