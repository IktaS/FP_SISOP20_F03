#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[]){
    int fd,size;
    struct stat st;
    if(argc <= 3){
        printf(1, "Need more than 2 argument\n");
        exit();
    }

    if(strcmp("-s",argv[1]) == 0){
        char * temp;
        if((temp = strchr(argv[2],'K')) != NULL){
            *temp = '\0';
            size = atoi(argv[2]) * 1000;
        }
        else if( (temp = strchr(argv[2],'M')) != NULL ){
            *temp = '\0';
            size = atoi(argv[2]) * 1000000;
        }
        else if( (temp = strchr(argv[2],'G')) != NULL ){
            *temp = '\0';
            size = atoi(argv[2]) * 1000000000;
        }else{
            size = atoi(argv[2]);
        }

        if((fd = open(argv[3],O_CREATE|O_RDWR)) < 0){
            printf(1,"truncate: cannot open file %s",argv[3]);
            exit();
        }

        if(fstat(fd,&st) < 0){
            printf(1,"truncate: failed reading stat file %s",argv[3]);
            exit();
        }
        //how the fuck do I change the file size
        close(fd);
    }
    exit();
}