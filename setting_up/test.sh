#!/bin/bash

function test () {
    echo -e "\n\n\n\e[1;36m------------------------[ERROR HANDLER]------------------------\n\e[0m"; sleep 0.1

    echo -e "\n\e[1;33m-----[Robustness - Opening valid file]-----\n\e[0m"; sleep 0.05

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

    echo -e "\n\e[1;33m-----[Robustness - Generating valid board]-----\n\e[0m"; sleep 0.1

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

    echo -e "\n\n\n\e[1;36m------------------------[ALGORITHM APP]------------------------\n\n\e[0m"; sleep 0.1

    echo -e "\n\e[1;33m-----[Opening map (no timout, carful of infinite loop)]-----\n\e[0m"; sleep 0.1

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

    echo -e "\e[1;37mtest n°11 (intermediate_map_100_100) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_100_100 > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_100_100
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°12 (intermediate_map_187_187_empty) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_187_187_empty > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_187_187_empty
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°13 (intermediate_map_187_187_filled) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_187_187_filled > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_187_187_filled
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°14 (intermediate_map_187_187_with_obstacles_25pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_187_187_with_obstacles_25pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_187_187_with_obstacles_25pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°15 (intermediate_map_187_187_with_obstacles_50pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_187_187_with_obstacles_50pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_187_187_with_obstacles_50pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°16 (intermediate_map_187_187_with_obstacles_75pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_187_187_with_obstacles_75pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_187_187_with_obstacles_75pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°17 (intermediate_map_200_200) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_200_200 > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_200_200
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°18 (intermediate_map_500_500) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_500_500 > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_500_500
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°19 (intermediate_map_500_500_2) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_500_500_2 > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_500_500_2
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°20 (intermediate_map_500_500_3) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_500_500_3 > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_500_500_3
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°21 (intermediate_map_1000_1000) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_1000_1000 > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_1000_1000 > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
        echo -e "\e[0;31mNote : I volontary don't print the diff for 1000x1000 map\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°22 (intermediate_map_1000_1000_2) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_1000_1000_2 > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_1000_1000_2 > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
        echo -e "\e[0;31mNote : I volontary don't print the diff for 1000x1000 map\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°23 (intermediate_map_empty_corners) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_empty_corners > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_empty_corners
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°24 (intermediate_map_filled_corners) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_filled_corners > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_filled_corners
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°25 (intermediate_map_one_column_with_obstacles_25pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_column_with_obstacles_25pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_column_with_obstacles_25pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°26 (intermediate_map_one_column_with_obstacles_50pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_column_with_obstacles_50pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_column_with_obstacles_50pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°27 (intermediate_map_one_column_with_obstacles_75pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_column_with_obstacles_75pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_column_with_obstacles_75pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°28 (intermediate_map_one_empty_box) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_empty_box > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_empty_box
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°29 (intermediate_map_one_empty_column) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_empty_column > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_empty_column
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°30 (intermediate_map_one_empty_line) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_empty_line > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_empty_line
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°31 (intermediate_map_one_filled_box) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_filled_box > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_filled_box
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°32 (intermediate_map_one_filled_column) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_filled_column > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_filled_column
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°33 (intermediate_map_one_filled_line) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_filled_line > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_filled_line
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°34 (intermediate_map_one_line_with_obstacles_25pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_line_with_obstacles_25pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_line_with_obstacles_25pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°35 (intermediate_map_one_line_with_obstacles_50pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_line_with_obstacles_50pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_line_with_obstacles_50pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°36 (intermediate_map_one_line_with_obstacles_75pc) :"; sleep 0.1
    ./setting_up example_files/maps/intermediate_map_one_line_with_obstacles_75pc > test_bash_log.txt
    sdiff -s test_bash_log.txt example_files/solved/intermediate_map_one_line_with_obstacles_75pc
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\n\e[1;33m-----[Generating map (solved + optimisation)]-----\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mtest n°1 (Generating 100x100 map (5s max)) :"; sleep 0.1
    timeout 5s ./setting_up 100 ....o.o... > test_bash_log.txt
    sdiff -s test_bash_log.txt bash_test/generating_100x100_map.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
        echo -e "\e[0;31mTrouble with generating time ?\nNote : don't use your putchar in the loop of your putstr\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°2 (Generating 500x500 map (10s max)) :"; sleep 0.1
    timeout 10s ./setting_up 500 ....o.o...o.........o.o > test_bash_log.txt
    sdiff -s test_bash_log.txt bash_test/generating_500x500_map.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
        echo -e "\e[0;31mTrouble with generating time ?\nNote : don't use your putchar in the loop of your putstr\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°3 (Generating 1000x1000 map (15s max)) :";
    timeout 15s ./setting_up 1000 ....o.o...o.........o.o..o > test_bash_log.txt
    sdiff -s test_bash_log.txt bash_test/generating_1000x1000_map.txt > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
        echo -e "\e[0;31mTrouble with generating time ?\nNote : don't use your putchar in the loop of your putstr\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°4 (Generating 5000x5000 map (25s max)) :";
    timeout 25s ./setting_up 5000 ....o.o...o.........o.o...o....o > test_bash_log.txt
    sdiff -s test_bash_log.txt bash_test/generating_5000x5000_map.txt > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
        echo -e "\e[0;31mTrouble with generating time ?\nNote : don't use your putchar in the loop of your putstr\n(PS : Your so bad i have 5s on this test)n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mtest n°5 (Generating 10000x10000 map (40s max)) :";
    timeout 40s ./setting_up 10000 ....o.o...o.........o.o..o..o........ > test_bash_log.txt
    sdiff -s test_bash_log.txt bash_test/generating_10000x10000_map.txt > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
        echo -e "\e[0;31mTrouble with generating time ?\nNote : don't use your putchar in the loop of your putstr\n(PS : Your so bad i have 10s on this test)\n\e[0m"
    fi
    rm test_bash_log.txt
}

make re
test
make fclean