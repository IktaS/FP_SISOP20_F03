#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#define M_ADD 0
#define M_SUBSTRACT 1
#define M_CHANGE 2

char buf[512];


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
    if(nowsize > 0){
        while(nowsize--){
            write(fd1,"\0",1);
        }
    }

}

int main(int argc, char *argv[]){
    int size, mode;
    struct stat st;
    if(argc <= 3){
        printf(1, "Need more than 2 argument\n");
        exit();
    }

    if(strcmp("-s",argv[1]) == 0){
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
    }
    exit();
}