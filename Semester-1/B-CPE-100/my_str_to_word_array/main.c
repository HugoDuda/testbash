/*
** EPITECH PROJECT, 2023
** main.c
** File description:
** main
*/

#include "my.h"

int main(int ac, char **av)
{
    char **BUFFER = my_str_to_word_array(av[2], av[1][0]);

    for (int i = 0; BUFFER[i] != NULL; i++)
        printf("%s\n", BUFFER[i]);
    for (int i = 0; BUFFER[i] != NULL; i++)
        free(BUFFER[i]);
    free(BUFFER);
    return 0;
}
