#!/bin/bash

BOLD="\e[1m"
RED="\e[31m"
GREEN="\e[32m"
RESET="\e[0m"

exercises=("strlen" "strchr" "strrchr" "memset" "memcpy" "strcmp" "memmove" "strncmp" "strcasecmp" "strstr" "strpbrk" "strcspn" "ffs" "index" "rindex" "strfry" "memfrob" "syscall")
echo -e "${BOLD}Building libasm.so${RESET}"
make re 1> /dev/null
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: 'make re' failed.${RESET}"
    exit 1
fi
echo -e "${GREEN}'make re' success.${RESET}"
TMP_OUTPUT="bashtest/tmp_output.txt"
mkdir -p bashtest
for ex in "${exercises[@]}"; do
    echo "--------------------------------------------------------------------------------------------"
    echo -e "${BOLD}Testing $ex${RESET}"
    if [[ ! -f "src/${ex}.asm" && ! -f "${ex}.asm" ]]; then
        echo -e "${RED}src/${ex}.asm not found.${RESET}"
        continue
    fi
    gcc -fno-builtin bashtest/main/"${ex}"_main.c -o a.out 2> /dev/null
    if [ $? -ne 0 ]; then
        echo -e "${RED}Compilation of bashtest/main/${ex}_main.c failed.${RESET}"
        continue
    fi
    LD_PRELOAD=./libasm.so ./a.out > "$TMP_OUTPUT"
    EXPECTED="bashtest/output/${ex}_output.txt"
    if [ ! -f "$EXPECTED" ]; then
        echo -e "${RED}Expected file $EXPECTED not found.{RESET}"
        rm -f a.out
        continue
    fi
    echo "--------------------------------------------------------------------------------------------"
    echo -e "${BOLD}Output:                                                         Expected: ${RESET}"
    sdiff "$TMP_OUTPUT" "$EXPECTED"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}$ex: OK${RESET}"
    else
        echo -e "${RED}$ex: KO${RESET}"
    fi
    rm -f a.out
done
rm -f "$TMP_OUTPUT"
