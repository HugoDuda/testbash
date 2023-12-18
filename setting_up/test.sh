#!/bin/bash

function test () {

    i=0

    echo -e "\n\n\n\e[1;36m-------------------------[BASE TEST]-------------------------\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mTest n°1 (add_one_material) :"; sleep 0.1
    cat bash_test/add_one_material.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/add_one_material_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°2 (add_serval_material) :"; sleep 0.1
    cat bash_test/add_serval_material.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/add_serval_material_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°3 (del_one_material) :"; sleep 0.1
    cat bash_test/del_one_material.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/del_one_material_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°4 (del_serval_material) :"; sleep 0.1
    cat bash_test/del_serval_material.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/del_serval_material_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°5 (disp_one_material) :"; sleep 0.1
    cat bash_test/disp_one_material.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/disp_one_material_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°6 (disp_serval_material) :"; sleep 0.1
    cat bash_test/disp_serval_material.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/disp_serval_material_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\n\n\e[1;36m-------------------------[ALGORITM APP]-------------------------\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mTest n°1 (sort_name) :"; sleep 0.1
    cat bash_test/sort_name.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/sort_name_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°2 (sort_type) :"; sleep 0.1
    cat bash_test/sort_type.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/sort_type_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°3 (sort_ID) :"; sleep 0.1
    cat bash_test/sort_id.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/sort_id_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

        echo -e "\e[1;37mTest n°4 (sort_name_reverse) :"; sleep 0.1
    cat bash_test/sort_name_reverse.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/sort_name_reverse_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°5 (sort_type_reverse) :"; sleep 0.1
    cat bash_test/sort_type_reverse.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/sort_type_reverse_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°6 (sort_ID_reverse) :"; sleep 0.1
    cat bash_test/sort_id_reverse.txt | timeout 1s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/sort_id_reverse_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\n\n\e[1;36m-------------------------[OPTIMISATION]-------------------------\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mTest n°1 (100 material) :"; sleep 0.1
    cat bash_test/check100.txt | timeout 0.5s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/check100_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°2 (500 material) :"; sleep 0.1
    cat bash_test/check500.txt | timeout 0.5s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/check500_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°3 (1000 material) :"; sleep 0.1
    cat bash_test/check1000.txt | timeout 0.5s ./organized > test_bash_log.txt 
    sdiff -s test_bash_log.txt bash_test/check1000_solved.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\n\n\e[1;36m-------------------------[ROBUSTNESS]-------------------------\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mTest n°1 (error_add_no_argument) :" ; sleep 0.1
    echo add | timeout 1s ./organized > test_bash_log.txt 
    echo $? > return.txt
    sdiff -s return.txt bash_test/echo_error.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm return.txt
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°2 (error_add_bad_type) :" ; sleep 0.1
    echo add bad_type name | timeout 1s ./organized > test_bash_log.txt 
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°3 (error_add_missing_argument) :" ; sleep 0.1
    echo add WIRE | timeout 1s ./organized > test_bash_log.txt
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°4 (error_del_no_argument) :" ; sleep 0.1
    echo del | timeout 1s ./organized > test_bash_log.txt
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°5 (error_del_bad_id) :" ; sleep 0.1
    echo del a | timeout 1s ./organized > test_bash_log.txt 
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°6 (error_del_unknown_id) :" ; sleep 0.1
    echo del 999 | timeout 1s ./organized > test_bash_log.txt
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    echo -e "\e[1;37mTest n°7 (error_sort_bad_type) :" ; sleep 0.1
    echo sort bad_type | timeout 1s ./organized > test_bash_log.txt 
    if [ $? -eq 84 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm test_bash_log.txt

    p=$((i * 100 / 22))
    echo -e "\n\n\e[1;23m----------------------------------------------------------------[$p%]----------------------------------------------------------------\n\n\n\e[0m"
}

make re
test
make fclean
