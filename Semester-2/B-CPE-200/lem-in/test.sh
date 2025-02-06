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
    
    echo -e "\n\e[1;36m------------------------[VALID FILE]------------------------\n\e[0m"; sleep 0.05

        file=("bashtest/valid1" "bashtest/valid2" "bashtest/valid4")
        descriptions=("Valid file 1" "Valid file 2" "Valid file 3")

        for ((index=0; index<${#file[@]}; index++)); do
            echo -e "\e[1;37mTest n°$t (${descriptions[index]}) :"; sleep 0.05
            ./amazed < ${file[index]} > /dev/null
            if [ $? -eq 0 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            ((t++))
        done
    
    echo -e "\n\e[1;36m------------------------[ERROR HANDLING WITH PARSING]------------------------\n\e[0m"; sleep 0.05
    
        file=("bashtest/nostart" "bashtest/noend" "bashtest/multiplestart" "bashtest/multipleend" "bashtest/notunnels" "bashtest/Invalidend" "bashtest/Invalidstart" "bashtest/Invalidstart2" "bashtest/Invalidstart3")
        descriptions=("No start" "No end" "Multiple start" "Multiple end" "No tunnels" "Invalid end" "Invalid start 1" "Invalid start 2" "Invalid start 3")

        for ((index=0; index<${#file[@]}; index++)); do
            echo -e "\e[1;37mTest n°$t (${descriptions[index]}) :"; sleep 0.05
            ./amazed < ${file[index]} > /dev/null
            if [ $? -eq 84 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            ((t++))
        done
}
test
make -s fclean
