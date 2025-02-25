#!/bin/bash

mkdir -p bashtest/main bashtest/output
cat << 'EOF' > bashtest/main/strlen_main.c
#include <stdio.h>
#include <string.h>
extern size_t strlen(const char *);
int main(void)
{
    printf("Test 1: Normal string\n");
    printf("-> %zu\n", strlen("test123"));
    printf("Test 2: Empty string\n");
    printf("-> %zu\n", strlen(""));
    printf("Test 3: Null pointer\n");
    printf("-> %zu\n", strlen(NULL));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strchr_main.c
#include <stdio.h>
#include <string.h>
extern char *strchr(const char *, int);
int main(void)
{
    printf("Test 1: Normal search (character found)\n");
    printf("-> %s\n", strchr("Hello World", 'W'));
    printf("Test 2: Character not found\n");
    printf("-> %s\n", strchr("Hello World", 'z'));
    printf("Test 3: Search for null terminator\n");
    printf("-> %s\n", strchr("Hello World", '\0'));
    printf("Test 4: Empty string\n");
    printf("-> %s\n", strchr("", 'a'));
    printf("Test 5: Null pointer\n");
    printf("-> %s\n", strchr(NULL, 'a'));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strrchr_main.c
#include <stdio.h>
#include <string.h>
extern char *strrchr(const char *, int);
int main(void)
{
    printf("Test 1: Normal search (last occurrence)\n");
    printf("-> %s\n", strrchr("Hello World", 'l'));
    printf("Test 2: Character not found\n");
    printf("-> %s\n", strrchr("Hello World", 'z'));
    printf("Test 3: Search for null terminator\n");
    printf("-> %s\n", strrchr("Hello World", '\0'));
    printf("Test 4: Empty string\n");
    printf("-> %s\n", strrchr("", 'a'));
    printf("Test 5: Null pointer\n");
    printf("-> %s\n", strrchr(NULL, 'a'));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/memset_main.c
#include <stdio.h>
#include <string.h>
extern void *memset(void *s, int c, size_t n);
int main(void)
{
    printf("Test 1: Partial fill (first 5 bytes)\n");
    char buffer1[20] = "Hello World";
    printf("Before: %s\n", buffer1);
    printf("-> %s\n", (char *)memset(buffer1, 'X', 5));
    printf("Test 2: Zero length fill (no change)\n");
    char buffer2[20] = "Hello World";
    printf("Before: %s\n", buffer2);
    printf("-> %s\n", (char *)memset(buffer2, 'Y', 0));
    printf("Test 3: Full buffer fill (with manual null termination)\n");
    char buffer3[20] = "Hello World";
    printf("Before: %s\n", buffer3);
    memset(buffer3, 'Z', 12);
    buffer3[12] = '\0';
    printf("-> %s\n", buffer3);
    printf("Test 4: Null pointer input\n");
    printf("-> %p\n", memset(NULL, 'A', 5));
    return 0;
}

EOF
cat << 'EOF' > bashtest/main/memcpy_main.c
#include <stdio.h>
#include <string.h>
extern void *memcpy(void *dest, const void *src, size_t n);
int main(void)
{
    printf("Test 1: Normal copy\n");
    char src[] = "Hello World";
    char dest[20] = {0};
    printf("Before: %s\n", dest);
    printf("-> %s\n", (char *)memcpy(dest, src, strlen(src) + 1));
    printf("Test 2: Zero length copy (no change)\n");
    char buffer[20] = "Hello World";
    printf("Before: %s\n", buffer);
    printf("-> %s\n", (char *)memcpy(buffer, "ABCDE", 0));
    printf("Test 3: Binary data copy\n");
    int srcArr[5] = {1, 2, 3, 4, 5};
    int destArr[5] = {0};
    memcpy(destArr, srcArr, 5 * sizeof(int));
    printf("-> ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", destArr[i]);
    }
    printf("Test 4: Error handling - NULL destination\n");
    printf("-> %p\n", memcpy(NULL, src, 5));
    printf("Test 5: Error handling - NULL source\n");
    printf("-> %p\n", memcpy(dest, NULL, 5));
    printf("Test 6: Error handling - both destination and source NULL\n");
    printf("-> %p\n", memcpy(NULL, NULL, 5));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strcmp_main.c
#include <stdio.h>
#include <string.h>
extern int strcmp(const char *s1, const char *s2);
int main(void)
{
    printf("Test 1: Identical strings\n");
    printf("-> %d\n", strcmp("Hello", "Hello"));
    printf("Test 2: s1 < s2 (lexicographically)\n");
    printf("-> %d\n", strcmp("Apple", "Banana"));
    printf("Test 3: s1 > s2 (lexicographically)\n");
    printf("-> %d\n", strcmp("Banana", "Apple"));
    printf("Test 4: Empty string vs non-empty\n");
    printf("-> %d\n", strcmp("", "Hello"));
    printf("Test 5: Non-empty vs empty string\n");
    printf("-> %d\n", strcmp("Hello", ""));
    printf("Test 6: Both strings empty\n");
    printf("-> %d\n", strcmp("", ""));
    printf("Test 7: Error handling - NULL first argument\n");
    printf("-> %d\n", strcmp(NULL, "Hello"));
    printf("Test 8: Error handling - NULL second argument\n");
    printf("-> %d\n", strcmp("Hello", NULL));
    printf("Test 9: Error handling - both arguments NULL\n");
    printf("-> %d\n", strcmp(NULL, NULL));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/memmove_main.c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
extern void *memmove(void *, const void *, size_t);
void test_non_overlap()
{
    printf("Test 1: Non-overlapping copy\n");
    char src[] = "Hello World";
    char dest[20] = {0};
    void *res = memmove(dest, src, strlen(src) + 1);
    printf("-> %s\n", dest);
}
void test_overlap_forward()
{
    printf("Test 2: Overlap with destination after source\n");
    char buffer[20] = "abcdefghij";
    void *res = memmove(buffer + 3, buffer, 5);
    printf("-> %s\n", buffer);
}
void test_overlap_backward()
{
    printf("Test 3: Overlap with destination before source\n");
    char buffer[20] = "abcdefghij";
    void *res = memmove(buffer, buffer + 3, 5);
    printf("-> %s\n", buffer);
}
void test_zero_size()
{
    printf("Test 4: Zero size copy (no change)\n");
    char buffer[20] = "TestZero";
    char expected[] = "TestZero";
    void *res = memmove(buffer, buffer + 2, 0);
    printf("-> %s\n", buffer);
}
void test_same_pointer()
{
    printf("Test 5: Self-copy (same pointer)\n");
    char buffer[20] = "SamePointer";
    void *res = memmove(buffer, buffer, strlen(buffer) + 1);
    printf("-> %s\n", buffer);
}
void test_error_null_dest()
{
    printf("Test 6: Error handling - NULL destination\n");
    char src[] = "Hello World";
    void *res = memmove(NULL, src, 5);
    printf("-> %s\n", res);
}
void test_error_null_src()
{
    printf("Test 7: Error handling - NULL source\n");
    char dest[20] = "Hello World";
    void *res = memmove(dest, NULL, 5);
    printf("-> %s\n", res);
}
void test_error_both_null()
{
    printf("Test 8: Error handling - both destination and source are NULL\n");
    void *res = memmove(NULL, NULL, 5);
    printf("-> %s\n", res);
}
void test_binary_data()
{
    printf("Test 9: Binary data copy with overlap\n");
    unsigned char data[12] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
    void *res = memmove(data + 2, data, 6);
    int passed = (data[0] == 0 && data[1] == 1 &&
                  data[2] == 0 && data[3] == 1 && data[4] == 2 &&
                  data[5] == 3 && data[6] == 4 && data[7] == 5 &&
                  data[8] == 8 && data[9] == 9 &&
                  data[10] == 10 && data[11] == 11);
    if (res != NULL && passed)
        printf("-> data is correct\n");
    else {
        printf("-> data = ");
        for (int i = 0; i < 12; i++)
            printf("%d ", data[i]);
        printf("\n");
    }
}
int main(void)
{
    test_non_overlap();
    test_overlap_forward();
    test_overlap_backward();
    test_zero_size();
    test_same_pointer();
    test_error_null_dest();
    test_error_null_src();
    test_error_both_null();
    test_binary_data();
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strncmp_main.c
#include <stdio.h>
#include <string.h>
extern int strncmp(const char *s1, const char *s2, size_t n);
int main(void)
{
    printf("Test 1: Identical strings, full comparison\n");
    printf("-> %d\n", strncmp("Hello", "Hello", 5));
    printf("Test 2: Different strings, full comparison\n");
    printf("-> %d\n", strncmp("Apple", "Banana", 6));
    printf("Test 3: Partial comparison, equal prefix\n");
    printf("-> %d\n", strncmp("Hello World", "HelloThere", 5));
    printf("Test 4: Partial comparison, non equal beyond prefix\n");
    printf("-> %d\n", strncmp("Hello World", "HelloThere", 7));
    printf("Test 5: n = 0 (should be equal)\n");
    printf("-> %d\n", strncmp("Hello", "World", 0));
    printf("Test 6: Empty string vs non-empty\n");
    printf("-> %d\n", strncmp("", "Hello", 5));
    printf("Test 7: Non-empty vs empty string\n");
    printf("-> %d\n", strncmp("Hello", "", 5));
    printf("Test 8: Both empty strings\n");
    printf("-> %d\n", strncmp("", "", 5));
    printf("Test 9: Error handling - NULL first argument\n");
    printf("-> %d\n", strncmp(NULL, "Hello", 5));
    printf("Test 10: Error handling - NULL second argument\n");
    printf("-> %d\n", strncmp("Hello", NULL, 5));
    printf("Test 11: Error handling - both arguments NULL\n");
    printf("-> %d\n", strncmp(NULL, NULL, 5));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strcasecmp_main.c
#include <stdio.h>
#include <string.h>
extern int strcasecmp(const char *s1, const char *s2);
int main(void)
{
    printf("Test 1: Identical strings (same case)\n");
    printf("-> %d\n", strcasecmp("Hello", "Hello"));
    printf("Test 2: Identical strings (different case)\n");
    printf("-> %d\n", strcasecmp("Hello", "hello"));
    printf("Test 3: Different strings (lexicographically)\n");
    printf("-> %d\n", strcasecmp("Apple", "banana"));
    printf("Test 4: Different strings (reverse order)\n");
    printf("-> %d\n", strcasecmp("zeta", "Alpha"));
    printf("Test 5: Empty string vs non-empty string\n");
    printf("-> %d\n", strcasecmp("", "Hello"));
    printf("Test 6: Non-empty string vs empty string\n");
    printf("-> %d\n", strcasecmp("Hello", ""));
    printf("Test 7: Both strings empty\n");
    printf("-> %d\n", strcasecmp("", ""));
    printf("Test 8: Error handling - NULL first argument\n");
    printf("-> %d\n", strcasecmp(NULL, "Hello"));
    printf("Test 9: Error handling - NULL second argument\n");
    printf("-> %d\n", strcasecmp("Hello", NULL));
    printf("Test 10: Error handling - both arguments NULL\n");
    printf("-> %d\n", strcasecmp(NULL, NULL));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strstr_main.c
#include <stdio.h>
#include <string.h>
extern char *strstr(const char *haystack, const char *needle);
int main(void)
{
    const char *haystack;
    const char *needle;
    char *result;
    printf("Test 1: Substring present\n");
    haystack = "Hello World";
    needle = "World";
    result = strstr(haystack, needle);
    printf("-> %s\n", result ? result : "NULL");
    printf("Test 2: Substring not present\n");
    haystack = "Hello World";
    needle = "test";
    result = strstr(haystack, needle);
    printf("-> %s\n", result ? result : "NULL");
    printf("Test 3: Empty needle\n");
    haystack = "Hello World";
    needle = "";
    result = strstr(haystack, needle);
    printf("-> %s\n", result ? result : "NULL");
    printf("Test 4: Empty haystack, non-empty needle\n");
    haystack = "";
    needle = "Hello";
    result = strstr(haystack, needle);
    printf("-> %s\n", result ? result : "NULL");
    printf("Test 5: Both haystack and needle empty\n");
    haystack = "";
    needle = "";
    result = strstr(haystack, needle);
    printf("-> %s\n", result ? result : "NULL");
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strpbrk_main.c
#include <stdio.h>
#include <string.h>
extern char *strpbrk(const char *haystack, const char *accept);

int main(void)
{
    const char *haystack;
    const char *accept;
    char *result;

    printf("Test 1: Found character\n");
    haystack = "Hello World";
    accept = "XYWZ";
    result = strpbrk(haystack, accept);
    printf("-> %s\n", result ? result : "NULL");
    printf("Test 2: No matching character\n");
    haystack = "Hello World";
    accept = "xyz";
    result = strpbrk(haystack, accept);
    printf("-> %s\n", result ? result : "NULL");
    printf("Test 3: Empty accept string\n");
    haystack = "Hello World";
    accept = "";
    result = strpbrk(haystack, accept);
    printf("-> %s\n", result ? result : "NULL");
    printf("Test 4: Empty haystack, non-empty accept\n");
    haystack = "";
    accept = "abc";
    result = strpbrk(haystack, accept);
    printf("-> %s\n", result ? result : "NULL");
    printf("Test 5: Both haystack and accept empty\n");
    haystack = "";
    accept = "";
    result = strpbrk(haystack, accept);
    printf("-> %s\n", result ? result : "NULL");
    printf("Test 6: NULL haystack\n");
    haystack = NULL;
    accept = "abc";
    result = strpbrk(haystack, accept);
    printf("-> %s\n", result ? result : "NULL");
    printf("Test 7: NULL accept\n");
    haystack = "Hello World";
    accept = NULL;
    result = strpbrk(haystack, accept);
    printf("-> %s\n", result ? result : "NULL");
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strcspn_main.c
#include <stdio.h>
#include <string.h>
extern size_t strcspn(const char *s, const char *reject);
int main(void)
{
    const char *s;
    const char *reject;
    size_t result;
    printf("Test 1: No reject characters present\n");
    s = "abcdef";
    reject = "xyz";
    result = strcspn(s, reject);
    printf("-> %zu\n", result);
    printf("Test 2: Reject character present in the middle\n");
    s = "Hello World";
    reject = ", ";
    result = strcspn(s, reject);
    printf("-> %zu\n", result);
    printf("Test 3: Reject character is the first character\n");
    s = "Hello World";
    reject = "H";
    result = strcspn(s, reject);
    printf("-> %zu\n", result);
    printf("Test 4: s is empty\n");
    s = "";
    reject = "abc";
    result = strcspn(s, reject);
    printf("-> %zu\n", result);
    printf("Test 5: reject is empty\n");
    s = "Hello World";
    reject = "";
    result = strcspn(s, reject);
    printf("-> %zu\n", result);
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/ffs_main.c
#include <stdio.h>
#include <strings.h>
extern int ffs(int i);
int main(void) {
    printf("Test 1: ffs(0)\n");
    printf("-> %d\n", ffs(0));
    printf("Test 2: ffs(1)\n");
    printf("-> %d\n", ffs(1));
    printf("Test 3: ffs(2)\n");
    printf("-> %d\n", ffs(2));
    printf("Test 4: ffs(4)\n");
    printf("-> %d\n", ffs(4));
    printf("Test 5: ffs(18)\n");
    printf("-> %d\n", ffs(18));
    printf("Test 6: ffs(-1)\n");
    printf("-> %d\n", ffs(-1));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/index_main.c
#include <stdio.h>
#include <strings.h>
extern char *index(const char *, int);
int main(void)
{
    printf("Test 1: Normal search (character found)\n");
    printf("-> %s\n", index("Hello World", 'W'));
    printf("Test 2: Character not found\n");
    printf("-> %s\n", index("Hello World", 'z'));
    printf("Test 3: Search for null terminator\n");
    printf("-> %s\n", index("Hello World", '\0'));
    printf("Test 4: Empty string\n");
    printf("-> %s\n", index("", 'a'));
    printf("Test 5: Null pointer\n");
    printf("-> %s\n", index(NULL, 'a'));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/rindex_main.c
#include <stdio.h>
#include <strings.h>
extern char *rindex(const char *, int);
int main(void)
{
    printf("Test 1: Normal search (last occurrence)\n");
    printf("-> %s\n", rindex("Hello World", 'l'));
    printf("Test 2: Character not found\n");
    printf("-> %s\n", rindex("Hello World", 'z'));
    printf("Test 3: Search for null terminator\n");
    printf("-> %s\n", rindex("Hello World", '\0'));
    printf("Test 4: Empty string\n");
    printf("-> %s\n", rindex("", 'a'));
    printf("Test 5: Null pointer\n");
    printf("-> %s\n", rindex(NULL, 'a'));
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/strfry_main.c
#include <stdio.h>
#include <string.h>
extern char *strfry(char *);
int main(void)
{
    char *test = strdup("bonjourzceczczcsqczcscc");
    char *random = strfry(test);

    printf("%s\n", random);
    if (!strcmp(test, random))
        printf("-> String is ramdomized\n");
    else
        printf("-> String not randomized\n");
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/memfrob_main.c
#include <stdio.h>
#include <string.h>
extern void *memfrob(void *s, size_t n);
int main(void)
{
    char str[] = "Hello World";
    printf("Test 1: Original string\n");
    printf("-> %s\n", str);
    memfrob(str, strlen(str));
    printf("Test 2: After memfrob (obfuscated)\n-> Random value\n");
    memfrob(str, strlen(str));
    printf("Test 3: After memfrob again (restored)\n");
    printf("-> %s\n", str);
    return 0;
}
EOF
cat << 'EOF' > bashtest/main/syscall_main.c
#include <stdio.h>
#include <string.h>
extern long syscall(long number, long arg0, long arg1, long arg2, long arg3, long arg4, long arg5);
int main(void)
{
    const char *msg = "Hello World\n";
    printf("Test: Write syscall\n");
    printf("return value: %ld\n", syscall(1, 1, (long)msg, strlen(msg), 0, 0, 0));
    return 0;
}
EOF
echo -e "Test 1: Normal string
-> 7
Test 2: Empty string
-> 0
Test 3: Null pointer
-> 0" > bashtest/output/strlen_output.txt
echo -e "Test 1: Normal search (character found)
-> World
Test 2: Character not found
-> (null)
Test 3: Search for null terminator
-> 
Test 4: Empty string
-> (null)
Test 5: Null pointer
-> (null)" > bashtest/output/strchr_output.txt
echo -e "Test 1: Normal search (last occurrence)
-> ld
Test 2: Character not found
-> (null)
Test 3: Search for null terminator
-> 
Test 4: Empty string
-> (null)
Test 5: Null pointer
-> (null)" > bashtest/output/strrchr_output.txt
cat << 'EOF' > bashtest/output/memset_output.txt
Test 1: Partial fill (first 5 bytes)
Before: Hello World
-> XXXXX World
Test 2: Zero length fill (no change)
Before: Hello World
-> Hello World
Test 3: Full buffer fill (with manual null termination)
Before: Hello World
-> ZZZZZZZZZZZZ
Test 4: Null pointer input
-> (nil)
EOF
echo -e "Test 1: Normal copy
Before: 
-> Hello World
Test 2: Zero length copy (no change)
Before: Hello World
-> Hello World
Test 3: Binary data copy
-> 1 2 3 4 5 Test 4: Error handling - NULL destination
-> (nil)
Test 5: Error handling - NULL source
-> (nil)
Test 6: Error handling - both destination and source NULL
-> (nil)" > bashtest/output/memcpy_output.txt
echo -e "Test 1: Identical strings
-> 0
Test 2: s1 < s2 (lexicographically)
-> -1
Test 3: s1 > s2 (lexicographically)
-> 1
Test 4: Empty string vs non-empty
-> -72
Test 5: Non-empty vs empty string
-> 72
Test 6: Both strings empty
-> 0
Test 7: Error handling - NULL first argument
-> 0
Test 8: Error handling - NULL second argument
-> 0
Test 9: Error handling - both arguments NULL
-> 0" > bashtest/output/strcmp_output.txt
echo -e "Test 1: Non-overlapping copy
-> Hello World
Test 2: Overlap with destination after source
-> abcabcdeij
Test 3: Overlap with destination before source
-> defghfghij
Test 4: Zero size copy (no change)
-> TestZero
Test 5: Self-copy (same pointer)
-> SamePointer
Test 6: Error handling - NULL destination
-> (null)
Test 7: Error handling - NULL source
-> (null)
Test 8: Error handling - both destination and source are NULL
-> (null)
Test 9: Binary data copy with overlap
-> data is correct" > bashtest/output/memmove_output.txt
echo -e "Test 1: Identical strings, full comparison
-> 0
Test 2: Different strings, full comparison
-> -1
Test 3: Partial comparison, equal prefix
-> 0
Test 4: Partial comparison, non equal beyond prefix
-> -52
Test 5: n = 0 (should be equal)
-> 0
Test 6: Empty string vs non-empty
-> -72
Test 7: Non-empty vs empty string
-> 72
Test 8: Both empty strings
-> 0
Test 9: Error handling - NULL first argument
-> 0
Test 10: Error handling - NULL second argument
-> 0
Test 11: Error handling - both arguments NULL
-> 0" > bashtest/output/strncmp_output.txt
echo -e "Test 1: Identical strings (same case)
-> 0
Test 2: Identical strings (different case)
-> 0
Test 3: Different strings (lexicographically)
-> -1
Test 4: Different strings (reverse order)
-> 25
Test 5: Empty string vs non-empty string
-> -72
Test 6: Non-empty string vs empty string
-> 72
Test 7: Both strings empty
-> 0
Test 8: Error handling - NULL first argument
-> 0
Test 9: Error handling - NULL second argument
-> 0
Test 10: Error handling - both arguments NULL
-> 0" > bashtest/output/strcasecmp_output.txt
echo -e "Test 1: Substring present
-> World
Test 2: Substring not present
-> NULL
Test 3: Empty needle
-> Hello World
Test 4: Empty haystack, non-empty needle
-> NULL
Test 5: Both haystack and needle empty
-> " > bashtest/output/strstr_output.txt
echo -e "Test 1: Found character
-> World
Test 2: No matching character
-> NULL
Test 3: Empty accept string
-> NULL
Test 4: Empty haystack, non-empty accept
-> NULL
Test 5: Both haystack and accept empty
-> NULL
Test 6: NULL haystack
-> NULL
Test 7: NULL accept
-> NULL" > bashtest/output/strpbrk_output.txt
echo -e "Test 1: No reject characters present
-> 6
Test 2: Reject character present in the middle
-> 5
Test 3: Reject character is the first character
-> 0
Test 4: s is empty
-> 0
Test 5: reject is empty
-> 11" > bashtest/output/strcspn_output.txt
echo -e "Test 1: ffs(0)
-> 0
Test 2: ffs(1)
-> 1
Test 3: ffs(2)
-> 2
Test 4: ffs(4)
-> 3
Test 5: ffs(18)
-> 2
Test 6: ffs(-1)
-> 1" > bashtest/output/ffs_output.txt
echo -e "Test 1: Normal search (character found)
-> World
Test 2: Character not found
-> (null)
Test 3: Search for null terminator
-> 
Test 4: Empty string
-> (null)
Test 5: Null pointer
-> (null)" > bashtest/output/index_output.txt
echo -e "Test 1: Normal search (last occurrence)
-> ld
Test 2: Character not found
-> (null)
Test 3: Search for null terminator
-> 
Test 4: Empty string
-> (null)
Test 5: Null pointer
-> (null)" > bashtest/output/rindex_output.txt
echo -e "-> String is ramdomized" > bashtest/output/strfry_output.txt
echo -e "Test 1: Original string
-> Hello World
Test 2: After memfrob (obfuscated)
-> Random value
Test 3: After memfrob again (restored)
-> Hello World" > bashtest/output/memfrob_output.txt
echo -e "Test: Write syscall
Hello World
return value: 12" > bashtest/output/syscall_output.txt
