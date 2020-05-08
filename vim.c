#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#define M_ADD 0
#define M_SUBSTRACT 1
#define M_CHANGE 2

char buf[512];
char empty[2];

void overwrite(char * name,char * message)
{
    int fd0;
    if( (fd0 = open(name,O_RDWR)) < 0){
        printf(1, "cannot open file %s\n",name);
        exit();
    }
    int n;
    int len =0;
    memset(buf,0,sizeof(buf));
    while((n = read(fd0,buf,sizeof(buf))) > 0){
        len += n;
        memset(buf,0,sizeof(buf));
    }
    int fd1;

    if( (fd1 = open(name,O_CREATE | O_RDWR)) < 0){
        printf(1, "cannot open file %s\n",name);
        exit();
    }

    write(fd1,message,strlen(message));

    memset(empty,0,sizeof(empty));
    if(len > strlen(message)){
        int left = len - strlen(message);
        while(left--){
            write(fd1,empty,1);
        }
    }
    close(fd0);
    close(fd1);
}

int main(int argc, char *argv[]){
    if(argc <= 1){
        printf(1, "Need more argument\n");
        exit();
    }

    if(strcmp("--version",argv[1]) == 0){
        printf(1,"\n");
        printf(1,"Vim Version Wibu 1.0\n");
        printf(1,"\n");
    }else if(strcmp("--help",argv[1]) == 0){
        printf(1,"\n");
        printf(1,"Pakai vim [filename] [message] untuk menulis message ke dalam file\n");
        printf(1,"\n");
        printf(1,"Pakai vim --version untuk melihat versi\n");
    }else{
        if(argc <= 2){
            printf(1, "Need more than 1 argument, check --help\n");
            exit();
        }
        overwrite(argv[1],argv[2]);
    }
    exit();
}