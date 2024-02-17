#!/bin/bash

function test () {

    i=0
    echo -e "\n\n\e[1;36m------------------------[BUILD CHECKING]------------------------\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mBuild :" ;
    make re > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
        exit 0
    fi

    echo -e "\n\n\e[1;36m------------------------[VALGRIND CHECKING]------------------------\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 (nothing) :";
    echo -e "" | valgrind --leak-check=full --show-leak-kinds=all ./mysh > bashtest/valgrind_output/nothing.txt 2>&1
    if grep -q "ERROR SUMMARY: 0 errors" bashtest/valgrind_output/nothing.txt; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE (Check output in valgrind_output)\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°2 (ls) :";
    echo -e "ls" | valgrind --leak-check=full --show-leak-kinds=all ./mysh > bashtest/valgrind_output/ls.txt 2>&1
    if grep -q "ERROR SUMMARY: 0 errors" bashtest/valgrind_output/ls.txt; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE (Check output in valgrind_output)\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°3 (pwd) :";
    echo -e "ls" | valgrind --leak-check=full --show-leak-kinds=all ./mysh > bashtest/valgrind_output/pwd.txt 2>&1
    if grep -q "ERROR SUMMARY: 0 errors" bashtest/valgrind_output/pwd.txt; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE (Check output in valgrind_output)\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°4 (cd) :";
    echo -e "cd" | valgrind --leak-check=full --show-leak-kinds=all ./mysh > bashtest/valgrind_output/cd.txt 2>&1
    if grep -q "ERROR SUMMARY: 0 errors" bashtest/valgrind_output/cd.txt; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE (Check output in valgrind_output)\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°5 (env) :";
    echo -e "env" | valgrind --leak-check=full --show-leak-kinds=all ./mysh > bashtest/valgrind_output/env.txt 2>&1
    if grep -q "ERROR SUMMARY: 0 errors" bashtest/valgrind_output/env.txt; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE (Check output in valgrind_output)\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°6 (setenv) :";
    echo -e "setenv a" | valgrind --leak-check=full --show-leak-kinds=all ./mysh > bashtest/valgrind_output/setenv.txt 2>&1
    if grep -q "ERROR SUMMARY: 0 errors" bashtest/valgrind_output/setenv.txt; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE (Check output in valgrind_output)\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°7 (unsetenv) :";
    echo -e "unsetenv PATH" | valgrind --leak-check=full --show-leak-kinds=all ./mysh > bashtest/valgrind_output/unsetenv.txt 2>&1
    if grep -q "ERROR SUMMARY: 0 errors" bashtest/valgrind_output/unsetenv.txt; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE (Check output in valgrind_output)\n\e[0m"
    fi

    echo -e "\n\n\e[1;36m-------------------------[BASE TEST]-------------------------\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°0 (nothing) :"; sleep 0.05
    echo -e "" | ./mysh > bashtest/mysh.txt
    echo -e "" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°1 (ls) :"; sleep 0.05
    echo -e "ls" | ./mysh > bashtest/mysh.txt
    echo -e "ls" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°2 (ls -l -a -t) :"; sleep 0.05
    echo -e "ls -l -a -t" | ./mysh > bashtest/mysh.txt
    echo -e "ls -l -a -t" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°3 (pwd) :"; sleep 0.05
    echo -e "pwd" | ./mysh > bashtest/mysh.txt
    echo -e "pwd" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°4 (./executable) :"; sleep 0.05
    echo -e "./bashtest/executable" | ./mysh > bashtest/mysh.txt
    echo -e "./bashtest/executable" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°5 (Segmentation fault (core dump)) :"; sleep 0.05
    echo -e "./bashtest/segv" | ./mysh 2> bashtest/mysh.txt
    echo -e "./bashtest/segv" | tcsh 2> bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°6 (Floating execption (core dump)) :"; sleep 0.05
    echo -e "./bashtest/float" | ./mysh 2> bashtest/mysh.txt
    echo -e "./bashtest/float" | tcsh 2> bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\n\n\e[1;36m-------------------------[BUILTIN CD]-------------------------\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 (cd) :"; sleep 0.05
    echo -e "cd" | ./mysh
    ls > bashtest/mysh.txt
    echo -e "cd" | tcsh 
    ls > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°2 (cd ..) :"; sleep 0.05
    echo -e "cd .." | ./mysh
    ls > bashtest/mysh.txt
    echo -e "cd .." | tcsh 
    ls > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°3 (cd /) :"; sleep 0.05
    echo -e "cd /" | ./mysh
    ls > bashtest/mysh.txt
    echo -e "cd /" | tcsh 
    ls > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\n\n\e[1;36m-------------------------[BUILTIN EXIT]-------------------------\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 (exit) :"; sleep 0.05
    echo -e "exit" | ./mysh > bashtest/mysh.txt
    echo -e "exit" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°2 (exit 84) :"; sleep 0.05
    echo -e "exit 84" | ./mysh
    echo $? > bashtest/mysh.txt
    echo -e "exit 84" | tcsh 
    echo $? > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\n\n\e[1;36m-------------------------[BUILTIN ENV]-------------------------\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 (env) :"; sleep 0.05
    echo -e "env" | ./mysh | grep -v "^_" | sort > bashtest/mysh.txt
    env | grep -v "^_" | sort > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\n\n\e[1;36m-------------------------[BUILTIN UNSETENV]-------------------------\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 (unsetenv) :"; sleep 0.05
    echo -e "env" | ./mysh | grep -v "^_" | sort > bashtest/mysh.txt
    env | grep -v "^_" | sort > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        rm bashtest/tcsh.txt
        rm bashtest/mysh.txt
        (echo -e "unsetenv OLDPWD" && echo -e "env") | ./mysh > bashtest/mysh.txt
        grep "OLDPWD=" bashtest/mysh.txt
        if [ $? -eq 0 ]; then
            echo -e "\e[1;31mFAILURE\n\e[0m"
            ((i++))
        else
            echo -e "\e[1;32mSUCESS\n\e[0m"
        fi
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°2 (unsetenv and exeve) :"; sleep 0.05
    (echo -e "unsetenv TERM" && echo -e "clear") | ./mysh 2> bashtest/mysh.txt
    (echo -e "unsetenv TERM" && echo -e "clear") | tcsh 2> bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\n\n\e[1;36m-------------------------[BUILTIN SETENV]-------------------------\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 (setenv) :"; sleep 0.05
    (echo -e "setenv bonjour jesuisuntest" && echo -e "env") | ./mysh > bashtest/mysh.txt
    grep "bonjour=jesuisuntest" bashtest/mysh.txt > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/mysh.txt

    echo -e "\n\n\e[1;36m-------------------------[TABS AND SPACES]-------------------------\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 (ls space) :"; sleep 0.05
    echo -e "ls " | ./mysh > bashtest/mysh.txt
    echo -e "ls " | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°2 (ls spaces) :"; sleep 0.05
    echo -e "ls     " | ./mysh > bashtest/mysh.txt
    echo -e "ls     " | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°3 (ls spaces -l) :"; sleep 0.05
    echo -e "ls   -l" | ./mysh > bashtest/mysh.txt
    echo -e "ls   -l" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°4 (ls tab) :"; sleep 0.05
    echo -e "ls\t" | ./mysh > bashtest/mysh.txt
    echo -e "ls\t" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°5 (ls tabs) :"; sleep 0.05
    echo -e "ls\t\t\t\t\t" | ./mysh > bashtest/mysh.txt
    echo -e "ls\t\t\t\t\t" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°6 (ls tabs -l) :"; sleep 0.05
    echo -e "ls\t\t\t\t\t-l" | ./mysh > bashtest/mysh.txt
    echo -e "ls\t\t\t\t\t-l" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°7 (ls tab space) :"; sleep 0.05
    echo -e "ls\t " | ./mysh > bashtest/mysh.txt
    echo -e "ls\t " | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°8 (ls tab space) :"; sleep 0.05
    echo -e "ls  \t \t     \t    \t \t\t" | ./mysh > bashtest/mysh.txt
    echo -e "ls  \t \t     \t    \t \t\t" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°9 (ls tab space -l) :"; sleep 0.05
    echo -e "ls\t -l" | ./mysh > bashtest/mysh.txt
    echo -e "ls\t -l" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°10 (ls tabs spaces -l) :"; sleep 0.05
    echo -e "ls  \t\t \t -l" | ./mysh > bashtest/mysh.txt
    echo -e "ls  \t\t \t -l" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°11 (space) :"; sleep 0.05
    echo -e " " | ./mysh > bashtest/mysh.txt
    echo -e " " | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°12 (tab) :"; sleep 0.05
    echo -e "\t" | ./mysh > bashtest/mysh.txt
    echo -e "\t" | tcsh > bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\n\n\e[1;36m-------------------------[ROBUSTNESS]-------------------------\n\e[0m"; sleep 0.05

    echo -e "\e[1;37mTest n°1 (random command) :"; sleep 0.05
    echo -e "hgfrertyh" | ./mysh 2> bashtest/mysh.txt
    echo -e "hgfrertyh" | tcsh 2> bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°2 (cd random file) :"; sleep 0.05
    echo -e "cd hgfrertyh" | ./mysh 2> bashtest/mysh.txt
    echo -e "cd hgfrertyh" | tcsh 2> bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°3 (cd executable) :"; sleep 0.05
    echo -e "cd ./mysh" | ./mysh 2> bashtest/mysh.txt
    echo -e "cd ./mysh" | tcsh 2> bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°4 (cd too many arg) :"; sleep 0.05
    echo -e "cd abc efg" | ./mysh 2> bashtest/mysh.txt
    echo -e "cd abc efg" | tcsh 2> bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°5 (alphanumerique exit) :"; sleep 0.05
    echo -e "exit abc" | ./mysh 2> bashtest/mysh.txt
    echo -e "exit abc" | tcsh 2> bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°6 (./) :"; sleep 0.05
    echo -e "./" | ./mysh 2> bashtest/mysh.txt
    echo -e "./" | tcsh 2> bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt

    echo -e "\e[1;37mTest n°7 (setenv too many arg) :"; sleep 0.05
    echo -e "setenv a b c" | ./mysh 2> bashtest/mysh.txt
    echo -e "setenv a b c" | tcsh 2> bashtest/tcsh.txt
    sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
        ((i++))
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm bashtest/tcsh.txt
    rm bashtest/mysh.txt
    if [ $i -eq 41 ]; then
        echo -e "\e[1;37m------ ALL TEST PASSED ------\n\e[0m"
    else
        echo -e "\e[1;37m------ $i / 41 test passed ------\n\e[0m"
    fi
}

test
make fclean