#include <stdio.h>

extern int open(char* arg2,int arg3);
extern int close(int arg1);

int main(int argc, char **argv) {
    if(argc != 2){
        printf("Usage: %s one argument\n", argv[0]);
		return 1;
    }
    
    int fd =open(argv[1],0);
    printf( "The corresponding file descriptor is: %d \n", fd);
    if(close(fd)<0){
        printf("CLOSING FAILED\n");
    }
    else
    {
        printf("CLOSING DONE\n");
    }
    
    return 0;
}
    