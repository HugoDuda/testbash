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


    echo -e "\n\n\e[1;36m------------------------[VALGRIND CHECKING]------------------------\n\e[0m"; sleep 0.05

    commands=("" "randomcmd" "ls" "pwd" "cd" "env" "setenv test" "unsetenv PATH")
    output_files=("nothing" "randomcmd" "ls" "pwd" "cd" "env" "setenv" "unsetenv")

        for ((index=0; index<${#commands[@]}; index++)); do
            echo -e "\e[1;37mTest n°$t (${commands[index]}) :";
            echo -e "${commands[index]}" | valgrind --leak-check=full --show-leak-kinds=all ./mysh > "bashtest/valgrind_output/${output_files[index]}.txt" 2>&1
            if grep -q "ERROR SUMMARY: 0 errors" "bashtest/valgrind_output/${output_files[index]}.txt"; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE (Check output in valgrind_output)\n\e[0m"
            fi
        ((t++))
        done

        echo -e "\e[1;37mTest n°$t (setenv & unsetenv & env each) :";
        (echo -e "env" && echo -e "setenv test bonjourjesuisuntest" && echo -e "env" && echo -e "unsetenv test" && echo -e "env") | valgrind --leak-check=full --show-leak-kinds=all ./mysh > bashtest/valgrind_output/setenvandunsetenv.txt 2>&1
        if grep -q "ERROR SUMMARY: 0 errors" bashtest/valgrind_output/setenvandunsetenv.txt; then
            echo -e "\e[1;32mSUCESS\n\e[0m"
            ((i++))
        else
            echo -e "\e[1;31mFAILURE (Check output in valgrind_output)\n\e[0m"
        fi
        ((t++))

    echo -e "\n\n\e[1;36m-------------------------[BASE TEST]-------------------------\n\e[0m"; sleep 0.05

    commands2=("" "ls" "./bashtest/executable" "azertyuioptestabc")
    descriptions=("empty" "simple exec" "run simple command" "wrong simple command")

        for ((index=0; index<${#commands2[@]}; index++)); do
            echo -e "\e[1;37mTest n°$t (${descriptions[index]}) :"; sleep 0.05
            echo -e "${commands2[index]}" | ./mysh > bashtest/mysh.txt 2>&1
            echo -e "${commands2[index]}" | tcsh > bashtest/tcsh.txt 2>&1
            sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
            if [ $? -eq 0 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            rm bashtest/tcsh.txt
            rm bashtest/mysh.txt
            ((t++))
        done

    echo -e "\n\n\e[1;36m-------------------------[PATH HANDLING]-------------------------\n\e[0m"; sleep 0.05

            echo -e "\e[1;37mTest n°$t (unsetenv PATH handling) :"; sleep 0.05
            echo -e 'unsetenv PATH\nls\npwd' | ./mysh > bashtest/mysh.txt 2>&1
            sdiff -s bashtest/mysh.txt bashtest/cmdnotfound.txt
            if [ $? -eq 0 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            rm bashtest/mysh.txt
            ((t++))

            echo -e "\e[1;37mTest n°$t (Change PATH for /bin/) :"; sleep 0.05
            echo -e 'setenv PATH /bin/\nls\npwd' | ./mysh > bashtest/mysh.txt 2>&1
            echo -e 'setenv PATH /bin/\nls\npwd' | tcsh > bashtest/tcsh.txt 2>&1
            sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
            if [ $? -eq 0 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            rm bashtest/tcsh.txt
            rm bashtest/mysh.txt
            ((t++))

            echo -e "\e[1;37mTest n°$t (Change PATH for random folder) :"; sleep 0.05
            echo -e 'setenv PATH /randomfolder/\nls\npwd' | ./mysh > bashtest/mysh.txt 2>&1
            sdiff -s bashtest/mysh.txt bashtest/cmdnotfound.txt
            if [ $? -eq 0 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            rm bashtest/mysh.txt
            ((t++))

            echo -e "\e[1;37mTest n°$t (Exec command path) :"; sleep 0.05
            echo -e '/bin/ls' | ./mysh > bashtest/mysh.txt 2>&1
            echo -e '/bin/ls' | tcsh > bashtest/tcsh.txt 2>&1
            sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
            if [ $? -eq 0 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            rm bashtest/tcsh.txt
            rm bashtest/mysh.txt
            ((t++))

    echo -e "\n\n\e[1;36m-------------------------[BUILTIN ENV]-------------------------\n\e[0m"; sleep 0.05

        echo -e "\e[1;37mTest n°$t (env) :"; sleep 0.05
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
        ((t++))

    echo -e "\n\n\e[1;36m-------------------------[BUILTIN UNSETENV]-------------------------\n\e[0m"; sleep 0.05

        echo -e "\e[1;37mTest n°$t (unsetenv) :"; sleep 0.05
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
            else
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            fi
        else
            echo -e "\e[1;31mFAILURE\n\e[0m"
        fi
        rm bashtest/mysh.txt
        ((t++))

    echo -e "\n\n\e[1;36m-------------------------[BUILTIN SETENV]-------------------------\n\e[0m"; sleep 0.05

        echo -e "\e[1;37mTest n°$t (setenv) :"; sleep 0.05
        (echo -e "setenv bonjour jesuisuntest" && echo -e "env") | ./mysh > bashtest/mysh.txt
        grep "bonjour=jesuisuntest" bashtest/mysh.txt > /dev/null
        if [ $? -eq 0 ]; then
            echo -e "\e[1;32mSUCESS\n\e[0m"
            ((i++))
        else
            echo -e "\e[1;31mFAILURE\n\e[0m"
        fi
        rm bashtest/mysh.txt
        ((t++))

        echo -e "\e[1;37mTest n°$t (unsetenv with special value n°1) :"; sleep 0.05
        (echo -e "unsetenv") | ./mysh 2> bashtest/mysh.txt
        (echo -e "unsetenv") | tcsh 2> bashtest/tcsh.txt
        sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
        if [ $? -eq 0 ]; then
            echo -e "\e[1;32mSUCESS\n\e[0m"
            ((i++))
        else
            echo -e "\e[1;31mFAILURE\n\e[0m"
        fi
        rm bashtest/mysh.txt
        rm bashtest/tcsh.txt
        ((t++))

        echo -e "\e[1;37mTest n°$t (setenv with special value n°1) :"; sleep 0.05
        (echo -e "setenv 1bonjour jesuisuntest") | ./mysh 2> bashtest/mysh.txt
        (echo -e "setenv 1bonjour jesuisuntest") | tcsh 2> bashtest/tcsh.txt
        sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
        if [ $? -eq 0 ]; then
            echo -e "\e[1;32mSUCESS\n\e[0m"
            ((i++))
        else
            echo -e "\e[1;31mFAILURE\n\e[0m"
        fi
        rm bashtest/mysh.txt
        rm bashtest/tcsh.txt
        ((t++))

        echo -e "\e[1;37mTest n°$t (setenv with special value n°2) :"; sleep 0.05
        (echo -e "setenv bon/jour jesuisuntest") | ./mysh 2> bashtest/mysh.txt
        (echo -e "setenv bon/jour jesuisuntest") | tcsh 2> bashtest/tcsh.txt
        sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
        if [ $? -eq 0 ]; then
            echo -e "\e[1;32mSUCESS\n\e[0m"
            ((i++))
        else
            echo -e "\e[1;31mFAILURE\n\e[0m"
        fi
        rm bashtest/mysh.txt
        rm bashtest/tcsh.txt
        ((t++))

        echo -e "\e[1;37mTest n°$t (setenv with special value n°3) :"; sleep 0.05
        (echo -e "setenv b=onjour jesuisuntest") | ./mysh 2> bashtest/mysh.txt
        (echo -e "setenv b=onjour jesuisuntest") | tcsh 2> bashtest/tcsh.txt
        sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
        if [ $? -eq 0 ]; then
            echo -e "\e[1;32mSUCESS\n\e[0m"
            ((i++))
        else
            echo -e "\e[1;31mFAILURE\n\e[0m"
        fi
        rm bashtest/mysh.txt
        rm bashtest/tcsh.txt
        ((t++))

        echo -e "\e[1;37mTest n°$t (setenv with special value n°4) :"; sleep 0.05
        echo -e "setenv" | ./mysh | grep -v "^_" | sort > bashtest/mysh.txt
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
        ((t++))

        echo -e "\e[1;37mTest n°$t (setenv with special value n°5) :"; sleep 0.05
        (echo -e "setenv a b c") | ./mysh 2> bashtest/mysh.txt
        (echo -e "setenv a b c") | tcsh 2> bashtest/tcsh.txt
        sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
        if [ $? -eq 0 ]; then
            echo -e "\e[1;32mSUCESS\n\e[0m"
            ((i++))
        else
            echo -e "\e[1;31mFAILURE\n\e[0m"
        fi
        rm bashtest/mysh.txt
        rm bashtest/tcsh.txt
        ((t++))

    echo -e "\n\n\e[1;36m-------------------------[BUILTIN CD]-------------------------\n\e[0m"; sleep 0.05

        commands3=("cd" "cd bashtest" "cd .." "cd /")
        descriptions2=("cd" "cd folder" "cd .." "cd /")

        for ((index=0; index<${#commands3[@]}; index++)); do
            echo -e "\e[1;37mTest n°$t (${descriptions2[index]}) :"; sleep 0.05
            (echo -e "${commands3[index]}" && echo -e "pwd") | ./mysh > bashtest/mysh.txt
            (echo -e "${commands3[index]}" && echo -e "pwd") | tcsh > bashtest/tcsh.txt
            sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
            if [ $? -eq 0 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            ((t++))
        rm bashtest/tcsh.txt
        rm bashtest/mysh.txt
        done

        commands6=("cd ffecvdzevvsd" "cd ./mysh" "cd abc def")
        descriptions6=("cd invalid folder" "cd executable" "cd too many argument")

        for ((index=0; index<${#commands6[@]}; index++)); do
            echo -e "\e[1;37mTest n°$t (${descriptions6[index]}) :"; sleep 0.05
            (echo -e "${commands6[index]}") | ./mysh 2> bashtest/mysh.txt
            (echo -e "${commands6[index]}") | tcsh 2> bashtest/tcsh.txt
            sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
            if [ $? -eq 0 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            ((t++))
        rm bashtest/tcsh.txt
        rm bashtest/mysh.txt
        done

        echo -e "\e[1;37mTest n°$t (cd -) :"; sleep 0.05
        (echo -e "pwd" && echo -e "cd .." && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd" && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd /" && echo -e "pwd" && echo -e "cd -" && echo "pwd" && echo -e "cd /bin/" && echo -e "pwd") | ./mysh > bashtest/mysh.txt
        (echo -e "pwd" && echo -e "cd .." && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd" && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd -" && echo -e "pwd" && echo -e "cd /" && echo -e "pwd" && echo -e "cd -" && echo "pwd" && echo -e "cd /bin/" && echo -e "pwd") | tcsh > bashtest/tcsh.txt
        sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
        if [ $? -eq 0 ]; then
            echo -e "\e[1;32mSUCESS\n\e[0m"
            ((i++))
        else
            echo -e "\e[1;31mFAILURE\n\e[0m"
        fi
        rm bashtest/tcsh.txt
        rm bashtest/mysh.txt
        ((t++))

    echo -e "\n\n\e[1;36m-------------------------[TABS AND SPACES]-------------------------\n\e[0m"; sleep 0.05

        commands5=("ls " "ls     " "ls   -a" "ls\t" "ls\t\t\t\t\t" "ls\t\t\t\t\t-a" "ls\t -a" "ls  \t\t \t -a" " " "\t")
        descriptions4=("ls space" "ls spaces" "ls spaces -a" "ls tab" "ls tabs" "ls tabs -a" "ls tab space" "ls tabs spaces -a" "space" "tab")

        for ((index=0; index<${#commands5[@]}; index++)); do
            echo -e "\e[1;37mTest n°$t (${descriptions4[index]}) :"; sleep 0.05
            echo -e "${commands5[index]}" | ./mysh > bashtest/mysh.txt
            echo -e "${commands5[index]}" | tcsh > bashtest/tcsh.txt
            sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
            if [ $? -eq 0 ]; then
                echo -e "\e[1;32mSUCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            rm bashtest/tcsh.txt
            rm bashtest/mysh.txt
            ((t++))
        done

    echo -e "\n\n\e[1;36m-------------------------[ERROR HANDLING]-------------------------\n\e[0m"; sleep 0.05

        echo -e "\e[1;37mTest n°$t (Bin not compatible) :"; sleep 0.05
        (echo -e "bashtest/wa") | ./mysh 2> bashtest/mysh.txt
        sdiff -s bashtest/mysh.txt bashtest/wa.txt
        if [ $? -eq 0 ]; then
            echo -e "\e[1;32mSUCESS\n\e[0m"
            ((i++))
        else
            echo -e "\e[1;31mFAILURE\n\e[0m"
        fi
        rm bashtest/mysh.txt
        ((t++))

        commands6=("bashtest/segv" "bashtest/valgrind_output")
        descriptions5=("SegFault with core dump" "exec a directory")

        for ((index=0; index<${#commands6[@]}; index++)); do
            echo -e "\e[1;37mTest n°$t (${descriptions5[index]}) :"; sleep 0.05
            echo -e "${commands6[index]}" | ./mysh 2> bashtest/mysh.txt
            echo -e "${commands6[index]}" | tcsh 2> bashtest/tcsh.txt
            sdiff -s bashtest/mysh.txt bashtest/tcsh.txt
            if [ $? -eq 0 ]; then
                echo -e "\e[1;32mSUCCESS\n\e[0m"
                ((i++))
            else
                echo -e "\e[1;31mFAILURE\n\e[0m"
            fi
            rm bashtest/tcsh.txt
            rm bashtest/mysh.txt
            ((t++))
        done

    ((t--))
    echo -e "\n\e[1;37m--------------------------- RESULTS --------------------------\e[0m"
    echo -e "\e[1;37m|                                                            |\e[0m"
    if [ $i -eq $t ]; then
        echo -e "\e[1;37m|                      ALL TESTS PASSED                      |\e[0m"
    else
        echo -e "\e[1;37m                       $i / $t test passed\e[0m"
    fi
    echo -e "\e[1;37m|                                                            |\e[0m"
    echo -e "\e[1;37m--------------------------------------------------------------\e[0m"
    echo -e "\n\e[1;31m----------------------------------------------------------------\e[0m";
    echo -e "\n\e[1;31m!!!!!!!!!! DON'T FORGET TO USE ISATTY FUNCTION !!!!!!!!!!!\e[0m";
    echo -e "\n\e[1;31m----------------------------------------------------------------\e\n[0m";
}

test
make fclean