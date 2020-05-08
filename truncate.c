#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#define M_ADD 0
#define M_SUBSTRACT 1
#define M_CHANGE 2

char buf[512];
char empty[2];


void truncate(char * name,int size)
{
    int nowsize = size;
    int fd0;
    if( (fd0 = open(name,O_RDONLY)) < 0){
        printf(1, "cannot open file %s\n",name);
        exit();
    }
    if(unlink(name) < 0){
        printf(1, "error unlinking %s\n",name);
        exit();
    }
    int fd1;
    if( (fd1 = open(name,O_CREATE | O_RDWR)) < 0){
        printf(1, "cannot open file %s\n",name);
        exit();
    }
    int n;
    while( (n = read(fd0,buf,sizeof(buf))) > 0 && nowsize > 0){
        if(n > nowsize){
            n = nowsize;
        }
        nowsize -= n;
        write(fd1, buf, n);
    }
    memset(empty,0,sizeof(empty));
    if(nowsize > 0){
        while(nowsize--){
            write(fd1,empty,1);
        }
    }
    close(fd0);
    close(fd1);
}

int main(int argc, char *argv[]){
    int size, mode;
    struct stat st;
    if(argc <= 1){
        printf(1, "Need more argument\n");
        exit();
    }

    if(strcmp("-s",argv[1]) == 0){
        if(argc <= 3){
            printf(1, "Need more than 3 argument, check --help\n");
            exit();
        }
        char * charsize = argv[2];
        char * temp;
        int multiplier = 1;
        if((temp = strchr(argv[2],'+')) != NULL){
            charsize = charsize + 1;
            mode = M_ADD;
        }else if( (temp = strchr(argv[2],'-')) != NULL){
            charsize = charsize + 1;
            mode = M_SUBSTRACT;
        }else{
            mode = M_CHANGE;
        }
        if((temp = strchr(charsize,'K')) != NULL){
            *temp = '\0';
            multiplier *= 1024;
        }
        else if( (temp = strchr(charsize,'M')) != NULL ){
            *temp = '\0';
            multiplier *= 1024 * 1024;
        }
        else if( (temp = strchr(charsize,'G')) != NULL ){
            *temp = '\0';
            multiplier *= 1024 * 1024 * 1024;
        }

        if( stat(argv[3],&st) < 0){
            printf(1, "cannot open path %s",argv[3]);
            exit();
        }
        size = st.size;
        switch (mode)
        {
            case M_ADD:
                size += (atoi(charsize) * multiplier);
                break;
            
            case M_SUBSTRACT:
                size -= (atoi(charsize) * multiplier);
                if(size < 0) size = 0;
                break;
            
            case M_CHANGE:
                size = (atoi(charsize) * multiplier);
                break;
        }
        //size is good, now how the fuck do I truncate
        truncate(argv[3],size);
    }else if(strcmp("--version",argv[1]) == 0){
        printf(1,"\n");
        printf(1,"Truncate Version Wibu 1.0\n");
        printf(1,"\n");
    }else if(strcmp("--help",argv[1]) == 0){
        printf(1,"\n");
        printf(1,"Pakai -s untuk menentukan size\n");
        printf(1,"bisa menggunakan tanda + atau -\n");
        printf(1,"bisa menggunakan tanda K,M dan G untuk multiplier size\n");
        printf(1,"\n");
        printf(1,"Gunakan --version untuk melihat version\n");
        printf(1,"\n");
    }else{
        printf(1,"Unkown command, gunakan --help untuk melihat command\n");
    }
    exit();
}