#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#define M_ADD 0
#define M_SUBSTRACT 1
#define M_CHANGE 2

char buf[80];
char empty[2];
char input[20];

void less(char * name)
{
    int initrow = 23;
    int fd0;
    if( (fd0 = open(name,O_RDONLY)) < 0){
        printf(1, "cannot open file %s\n",name);
        exit();
    }
    int n;
    int len =0;
    memset(buf,0,sizeof(buf));
    for(int i=0;i<initrow;i++){
        n = read(fd0,buf,sizeof(buf));
        printf(1,buf,sizeof(buf));
        len += n;
        memset(buf,0,sizeof(buf));
        if(n <= 0){
            printf(1,"End of file\n");
            exit();
        }
    }
    memset(input,0,sizeof(input));
    read(1,input,sizeof(input));
    if(strcmp(input,"\n") == 0){
        read(fd0,buf,sizeof(buf));
        printf(1,buf,sizeof(buf));
        if(n <= 0){
            printf(1,"End of file\n");
            exit();
        }
    }else if(strcmp(input,"q") == 0){
        printf(1,"Quit\n");
        exit();
    }
    close(fd0);

}

int main(int argc, char *argv[]){
    if(argc <= 1){
        printf(1, "Need more argument\n");
        exit();
    }

    if(strcmp("--version",argv[1]) == 0){
        printf(1,"\n");
        printf(1,"Less Version Wibu 1.0\n");
        printf(1,"\n");
    }else if(strcmp("--help",argv[1]) == 0){
        printf(1,"\n");
        printf(1,"Pakai less [filename] untuk membaca file\n");
        printf(1,"\n");
        printf(1,"Pakai less --version untuk melihat versi\n");
    }else{
        less(argv[1]);
    }
    exit();
}