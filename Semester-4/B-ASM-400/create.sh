#!/bin/bash

mkdir -p bashtest/main bashtest/output
cat << 'EOF' > bashtest/main/strlen_main.c
#include <stdio.h>
#include <string.h>
extern size_t strlen(const char *);
int main(void)
{
    printf("%zu\n", strlen("test123"));
    printf("%zu\n", strlen("cazbjicabcacbhicabcabcuoa"));
    printf("error handling: %zu\n", strlen(NULL));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strchr_main.c
#include <stdio.h>
#include <string.h>
extern char *strchr(const char *, int);
int main(void)
{
    char test[] = "test123";
    printf("%s\n", strchr(test, 's'));
    printf("error handling: %s, ", strchr(test, 'a'));
    printf("%s\n", strchr(NULL, 'a'));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strrchr_main.c
#include <stdio.h>
#include <string.h>
extern char *strrchr(const char *, int);
int main(void)
{
    char test[] = "test123";
    printf("%s\n", strrchr(test, 't'));
    printf("error handling: %s, ", strrchr(test, 'a'));
    printf("%s\n", strrchr(NULL, 'a'));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/memset_main.c
#include <stdio.h>
#include <string.h>
extern void *memset(void *, int, size_t);
int main(void)
{
    char test[] = "test12345";
    char test2[] = "ABCDEFGHIJK";
    printf("Before memset: %s\n", test);
    memset(test, 'a', sizeof(test) - 1);
    printf("After memset: %s\n", test);
    printf("Before memset: %s\n", test2);
    memset(test2, '0', sizeof(test2) - 1);
    printf("After memset: %s\n", test2);
    printf("error handling: %s\n", memset(NULL, '0', 0));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/memcpy_main.c
#include <stdio.h>
#include <string.h>
extern void *memcpy(void *, const void *, size_t);
int main(void)
{
    char src[] = "source data";
    char dest[50] = "initial";
    memcpy(dest, src, sizeof(src));
    printf("%s\n", dest);
    printf("error handling: %s, %s\n", memcpy(NULL, src, sizeof(src)), memcpy(dest, NULL, 0));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strcmp_main.c
#include <stdio.h>
#include <string.h>
extern int strcmp(const char *, const char *);
int main(void) {
    printf("%d\n", strcmp("Hello", "Hellp"));
    printf("%d\n", strcmp("Hello", "Hello"));
    printf("%d\n", strcmp("Hello", "Helln"));
    printf("error handling: %d, ", strcmp("Hello", NULL));
    printf("%d, ", strcmp(NULL, "Hello"));
    printf("%d\n", strcmp(NULL, NULL));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/memmove_main.c
#include <stdio.h>
#include <string.h>
extern void *memmove(void *, const void *, size_t);
int main(void)
{
    char test[] = "1234567890";
    memmove(test + 3, test, 5);
    printf("%s\n", test);
    printf("error handling: %s, %s\n", memmove(NULL, test, 5), memmove(test, NULL, 5));
    return 0;
}
EOF
echo -e "7\n25\nerror handling: 0" > bashtest/output/strlen_output.txt
echo -e "st123\nerror handling: (null), (null)" > bashtest/output/strchr_output.txt
echo -e "t123\nerror handling: (null), (null)" > bashtest/output/strrchr_output.txt
cat << 'EOF' > bashtest/output/memset_output.txt
Before memset: test12345
After memset: aaaaaaaaa
Before memset: ABCDEFGHIJK
After memset: 00000000000
error handling: (null)
EOF
echo -e "source data\nerror handling: (null), source data" > bashtest/output/memcpy_output.txt
echo -e "-1\n0\n1\nerror handling: 0, 0, 0" > bashtest/output/strcmp_output.txt
echo -e "1231234590\nerror handling: (null), (null)" > bashtest/output/memmove_output.txt
