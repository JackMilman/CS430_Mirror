#include <stdlib.h>
#include <stdio.h>

int main() {
    char *p = (char *) malloc(sizeof(char) * 300);
    *p = 13;
    char *q = p; 
    // free(p);

    printf("%ld\n", (long int *) p);
    printf("%ld\n", (long int *) q);
}