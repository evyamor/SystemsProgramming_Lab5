#include <stdio.h>

extern int atou_s(char* arg2);

int main(int argc, char **argv) {
    if(argc != 2){
        printf("Usage: %s one argument\n", argv[0]);
		return 1;
    }
    int val =atou_s(argv[1]);
    printf( "The corresponding int is: %d \n", val);
    return 0;
}
    