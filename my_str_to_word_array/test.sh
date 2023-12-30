#!/bin/bash

function test () {
    echo -e "\n\n\n\e[1;36m------------------------[BASIC TEST]------------------------\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mTest n°1 (2 words) :" ; sleep 0.05
    ./a.out " " "Bonjour toi" > log.txt
    sdiff -s log.txt bashtest_folder/test2.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm log.txt

    echo -e "\e[1;37mTest n°2 (5 words) :" ; sleep 0.05
    ./a.out '.' "Bonjour.toi.comment.tu.vas" > log.txt
    sdiff -s log.txt bashtest_folder/test3.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm log.txt

    echo -e "\e[1;37mTest n°3 (10 words) :" ; sleep 0.05
    ./a.out ',' "Bonjour,toi,comment,tu,vas,moi,ça,va,super,bien" > log.txt
    sdiff -s log.txt bashtest_folder/test4.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm log.txt

    echo -e "\n\n\n\e[1;36m------------------------[MULTIPLE SEPARATOR]------------------------\n\e[0m"; sleep 0.1
        
    echo -e "\e[1;37mTest n°1 (2 separators each) :" ; sleep 0.05
    ./a.out '.' "Bonjour..toi..comment..tu..vas" > log.txt
    sdiff -s log.txt bashtest_folder/test3.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm log.txt

    echo -e "\e[1;37mTest n°2 (5 separators each) :" ; sleep 0.05
    ./a.out '.' "Bonjour.....toi.....comment.....tu.....vas" > log.txt
    sdiff -s log.txt bashtest_folder/test3.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm log.txt

    echo -e "\e[1;37mTest n°3 (10 separators each) :" ; sleep 0.05
    ./a.out ' ' "Bonjour          toi          comment          tu          vas" > log.txt
    sdiff -s log.txt bashtest_folder/test3.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm log.txt

    echo -e "\n\n\n\e[1;36m------------------------[SEPARATOR BEGINING AND END]------------------------\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mTest n°1 (Begining separator) :" ; sleep 0.05
    ./a.out ' ' " Bonjour toi comment tu vas" > log.txt
    sdiff -s log.txt bashtest_folder/test3.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm log.txt

    echo -e "\e[1;37mTest n°2 (End separator) :" ; sleep 0.05
    ./a.out ' ' "Bonjour toi comment tu vas " > log.txt
    sdiff -s log.txt bashtest_folder/test3.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi

    echo -e "\e[1;37mTest n°3 (Multiple begining separators) :" ; sleep 0.05
    ./a.out ' ' "     Bonjour toi comment tu vas" > log.txt
    sdiff -s log.txt bashtest_folder/test3.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm log.txt

    echo -e "\e[1;37mTest n°4 (Multiple end separators) :" ; sleep 0.05
    ./a.out ' ' "Bonjour toi comment tu vas     " > log.txt
    sdiff -s log.txt bashtest_folder/test3.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm log.txt

    echo -e "\n\n\n\e[1;36m------------------------[FINAL TEST]------------------------\n\e[0m"; sleep 0.1

    echo -e "\e[1;37mTest n°1 (Multiple begining, end and each separators with 10 word) :" ; sleep 0.05
    ./a.out '/' "/////Bonjour///toi//comment//////tu/////vas/moi/////ça//////va////////super//bien/////////" > log.txt
    sdiff -s log.txt bashtest_folder/test4.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mSUCESS\n\e[0m"
    else
        echo -e "\e[1;31mFAILURE\n\e[0m"
    fi
    rm log.txt
}

gcc *.c
test
rm a.out