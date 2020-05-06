
_truncate:     file format elf32-i386


Disassembly of section .text:

00000000 <truncate>:

char buf[512];


void truncate(char * name,int size)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	83 ec 18             	sub    $0x18,%esp
    int nowsize = size;
   a:	8b 45 0c             	mov    0xc(%ebp),%eax
   d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    printf(1, "nowsize = %d\n",nowsize);
  10:	83 ec 04             	sub    $0x4,%esp
  13:	ff 75 f4             	pushl  -0xc(%ebp)
  16:	68 f4 0a 00 00       	push   $0xaf4
  1b:	6a 01                	push   $0x1
  1d:	e8 0b 07 00 00       	call   72d <printf>
  22:	83 c4 10             	add    $0x10,%esp
    int fd0;
    if( (fd0 = open(name,O_RDONLY)) < 0){
  25:	83 ec 08             	sub    $0x8,%esp
  28:	6a 00                	push   $0x0
  2a:	ff 75 08             	pushl  0x8(%ebp)
  2d:	e8 bf 05 00 00       	call   5f1 <open>
  32:	83 c4 10             	add    $0x10,%esp
  35:	89 45 ec             	mov    %eax,-0x14(%ebp)
  38:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  3c:	79 1a                	jns    58 <truncate+0x58>
        printf(1, "cannot open file %s\n",name);
  3e:	83 ec 04             	sub    $0x4,%esp
  41:	ff 75 08             	pushl  0x8(%ebp)
  44:	68 02 0b 00 00       	push   $0xb02
  49:	6a 01                	push   $0x1
  4b:	e8 dd 06 00 00       	call   72d <printf>
  50:	83 c4 10             	add    $0x10,%esp
        exit();
  53:	e8 59 05 00 00       	call   5b1 <exit>
    }
    if(unlink(name) < 0){
  58:	83 ec 0c             	sub    $0xc,%esp
  5b:	ff 75 08             	pushl  0x8(%ebp)
  5e:	e8 9e 05 00 00       	call   601 <unlink>
  63:	83 c4 10             	add    $0x10,%esp
  66:	85 c0                	test   %eax,%eax
  68:	79 1a                	jns    84 <truncate+0x84>
        printf(1, "error unlinking %s\n",name);
  6a:	83 ec 04             	sub    $0x4,%esp
  6d:	ff 75 08             	pushl  0x8(%ebp)
  70:	68 17 0b 00 00       	push   $0xb17
  75:	6a 01                	push   $0x1
  77:	e8 b1 06 00 00       	call   72d <printf>
  7c:	83 c4 10             	add    $0x10,%esp
        exit();
  7f:	e8 2d 05 00 00       	call   5b1 <exit>
    }
    int fd1;
    if( (fd1 = open(name,O_CREATE | O_RDWR)) < 0){
  84:	83 ec 08             	sub    $0x8,%esp
  87:	68 02 02 00 00       	push   $0x202
  8c:	ff 75 08             	pushl  0x8(%ebp)
  8f:	e8 5d 05 00 00       	call   5f1 <open>
  94:	83 c4 10             	add    $0x10,%esp
  97:	89 45 e8             	mov    %eax,-0x18(%ebp)
  9a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  9e:	79 44                	jns    e4 <truncate+0xe4>
        printf(1, "cannot open file %s\n",name);
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	ff 75 08             	pushl  0x8(%ebp)
  a6:	68 02 0b 00 00       	push   $0xb02
  ab:	6a 01                	push   $0x1
  ad:	e8 7b 06 00 00       	call   72d <printf>
  b2:	83 c4 10             	add    $0x10,%esp
        exit();
  b5:	e8 f7 04 00 00       	call   5b1 <exit>
    }
    int n;
    while( (n = read(fd0,buf,sizeof(buf))) > 0 && nowsize > 0){
        if(n > nowsize){
  ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  bd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  c0:	7e 06                	jle    c8 <truncate+0xc8>
            n = nowsize;
  c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
        }
        nowsize -= n;
  c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  cb:	29 45 f4             	sub    %eax,-0xc(%ebp)
        write(fd1, buf, n);
  ce:	83 ec 04             	sub    $0x4,%esp
  d1:	ff 75 f0             	pushl  -0x10(%ebp)
  d4:	68 20 0e 00 00       	push   $0xe20
  d9:	ff 75 e8             	pushl  -0x18(%ebp)
  dc:	e8 f0 04 00 00       	call   5d1 <write>
  e1:	83 c4 10             	add    $0x10,%esp
    while( (n = read(fd0,buf,sizeof(buf))) > 0 && nowsize > 0){
  e4:	83 ec 04             	sub    $0x4,%esp
  e7:	68 00 02 00 00       	push   $0x200
  ec:	68 20 0e 00 00       	push   $0xe20
  f1:	ff 75 ec             	pushl  -0x14(%ebp)
  f4:	e8 d0 04 00 00       	call   5c9 <read>
  f9:	83 c4 10             	add    $0x10,%esp
  fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 103:	7e 06                	jle    10b <truncate+0x10b>
 105:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 109:	7f af                	jg     ba <truncate+0xba>
    }
    if(nowsize > 0){
 10b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 10f:	7e 24                	jle    135 <truncate+0x135>
        while(nowsize--){
 111:	eb 15                	jmp    128 <truncate+0x128>
            write(fd1,"\0",1);
 113:	83 ec 04             	sub    $0x4,%esp
 116:	6a 01                	push   $0x1
 118:	68 2b 0b 00 00       	push   $0xb2b
 11d:	ff 75 e8             	pushl  -0x18(%ebp)
 120:	e8 ac 04 00 00       	call   5d1 <write>
 125:	83 c4 10             	add    $0x10,%esp
        while(nowsize--){
 128:	8b 45 f4             	mov    -0xc(%ebp),%eax
 12b:	8d 50 ff             	lea    -0x1(%eax),%edx
 12e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 131:	85 c0                	test   %eax,%eax
 133:	75 de                	jne    113 <truncate+0x113>
        }
    }

}
 135:	90                   	nop
 136:	c9                   	leave  
 137:	c3                   	ret    

00000138 <main>:

int main(int argc, char *argv[]){
 138:	f3 0f 1e fb          	endbr32 
 13c:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 140:	83 e4 f0             	and    $0xfffffff0,%esp
 143:	ff 71 fc             	pushl  -0x4(%ecx)
 146:	55                   	push   %ebp
 147:	89 e5                	mov    %esp,%ebp
 149:	53                   	push   %ebx
 14a:	51                   	push   %ecx
 14b:	83 ec 30             	sub    $0x30,%esp
 14e:	89 cb                	mov    %ecx,%ebx
    int size, mode;
    struct stat st;
    if(argc <= 3){
 150:	83 3b 03             	cmpl   $0x3,(%ebx)
 153:	7f 17                	jg     16c <main+0x34>
        printf(1, "Need more than 2 argument\n");
 155:	83 ec 08             	sub    $0x8,%esp
 158:	68 2d 0b 00 00       	push   $0xb2d
 15d:	6a 01                	push   $0x1
 15f:	e8 c9 05 00 00       	call   72d <printf>
 164:	83 c4 10             	add    $0x10,%esp
        exit();
 167:	e8 45 04 00 00       	call   5b1 <exit>
    }

    if(strcmp("-s",argv[1]) == 0){
 16c:	8b 43 04             	mov    0x4(%ebx),%eax
 16f:	83 c0 04             	add    $0x4,%eax
 172:	8b 00                	mov    (%eax),%eax
 174:	83 ec 08             	sub    $0x8,%esp
 177:	50                   	push   %eax
 178:	68 48 0b 00 00       	push   $0xb48
 17d:	e8 0e 02 00 00       	call   390 <strcmp>
 182:	83 c4 10             	add    $0x10,%esp
 185:	85 c0                	test   %eax,%eax
 187:	0f 85 a4 01 00 00    	jne    331 <main+0x1f9>
        char * charsize = argv[2];
 18d:	8b 43 04             	mov    0x4(%ebx),%eax
 190:	8b 40 08             	mov    0x8(%eax),%eax
 193:	89 45 ec             	mov    %eax,-0x14(%ebp)
        char * temp;
        int multiplier = 1;
 196:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
        if((temp = strchr(argv[2],'+')) != NULL){
 19d:	8b 43 04             	mov    0x4(%ebx),%eax
 1a0:	83 c0 08             	add    $0x8,%eax
 1a3:	8b 00                	mov    (%eax),%eax
 1a5:	83 ec 08             	sub    $0x8,%esp
 1a8:	6a 2b                	push   $0x2b
 1aa:	50                   	push   %eax
 1ab:	e8 6c 02 00 00       	call   41c <strchr>
 1b0:	83 c4 10             	add    $0x10,%esp
 1b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 1b6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 1ba:	74 0d                	je     1c9 <main+0x91>
            charsize = charsize + 1;
 1bc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
            mode = M_ADD;
 1c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 1c7:	eb 33                	jmp    1fc <main+0xc4>
        }else if( (temp = strchr(argv[2],'-')) != NULL){
 1c9:	8b 43 04             	mov    0x4(%ebx),%eax
 1cc:	83 c0 08             	add    $0x8,%eax
 1cf:	8b 00                	mov    (%eax),%eax
 1d1:	83 ec 08             	sub    $0x8,%esp
 1d4:	6a 2d                	push   $0x2d
 1d6:	50                   	push   %eax
 1d7:	e8 40 02 00 00       	call   41c <strchr>
 1dc:	83 c4 10             	add    $0x10,%esp
 1df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 1e2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 1e6:	74 0d                	je     1f5 <main+0xbd>
            charsize = charsize + 1;
 1e8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
            mode = M_SUBSTRACT;
 1ec:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 1f3:	eb 07                	jmp    1fc <main+0xc4>
        }else{
            mode = M_CHANGE;
 1f5:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
        }
        if((temp = strchr(charsize,'K')) != NULL){
 1fc:	83 ec 08             	sub    $0x8,%esp
 1ff:	6a 4b                	push   $0x4b
 201:	ff 75 ec             	pushl  -0x14(%ebp)
 204:	e8 13 02 00 00       	call   41c <strchr>
 209:	83 c4 10             	add    $0x10,%esp
 20c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 20f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 213:	74 0c                	je     221 <main+0xe9>
            *temp = '\0';
 215:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 218:	c6 00 00             	movb   $0x0,(%eax)
            multiplier *= 1024;
 21b:	c1 65 e8 0a          	shll   $0xa,-0x18(%ebp)
 21f:	eb 48                	jmp    269 <main+0x131>
        }
        else if( (temp = strchr(charsize,'M')) != NULL ){
 221:	83 ec 08             	sub    $0x8,%esp
 224:	6a 4d                	push   $0x4d
 226:	ff 75 ec             	pushl  -0x14(%ebp)
 229:	e8 ee 01 00 00       	call   41c <strchr>
 22e:	83 c4 10             	add    $0x10,%esp
 231:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 234:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 238:	74 0c                	je     246 <main+0x10e>
            *temp = '\0';
 23a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 23d:	c6 00 00             	movb   $0x0,(%eax)
            multiplier *= 1024 * 1024;
 240:	c1 65 e8 14          	shll   $0x14,-0x18(%ebp)
 244:	eb 23                	jmp    269 <main+0x131>
        }
        else if( (temp = strchr(charsize,'G')) != NULL ){
 246:	83 ec 08             	sub    $0x8,%esp
 249:	6a 47                	push   $0x47
 24b:	ff 75 ec             	pushl  -0x14(%ebp)
 24e:	e8 c9 01 00 00       	call   41c <strchr>
 253:	83 c4 10             	add    $0x10,%esp
 256:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 259:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 25d:	74 0a                	je     269 <main+0x131>
            *temp = '\0';
 25f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 262:	c6 00 00             	movb   $0x0,(%eax)
            multiplier *= 1024 * 1024 * 1024;
 265:	c1 65 e8 1e          	shll   $0x1e,-0x18(%ebp)
        }

        if( stat(argv[3],&st) < 0){
 269:	8b 43 04             	mov    0x4(%ebx),%eax
 26c:	83 c0 0c             	add    $0xc,%eax
 26f:	8b 00                	mov    (%eax),%eax
 271:	83 ec 08             	sub    $0x8,%esp
 274:	8d 55 d0             	lea    -0x30(%ebp),%edx
 277:	52                   	push   %edx
 278:	50                   	push   %eax
 279:	e8 48 02 00 00       	call   4c6 <stat>
 27e:	83 c4 10             	add    $0x10,%esp
 281:	85 c0                	test   %eax,%eax
 283:	79 20                	jns    2a5 <main+0x16d>
            printf(1, "cannot open path %s",argv[3]);
 285:	8b 43 04             	mov    0x4(%ebx),%eax
 288:	83 c0 0c             	add    $0xc,%eax
 28b:	8b 00                	mov    (%eax),%eax
 28d:	83 ec 04             	sub    $0x4,%esp
 290:	50                   	push   %eax
 291:	68 4b 0b 00 00       	push   $0xb4b
 296:	6a 01                	push   $0x1
 298:	e8 90 04 00 00       	call   72d <printf>
 29d:	83 c4 10             	add    $0x10,%esp
            exit();
 2a0:	e8 0c 03 00 00       	call   5b1 <exit>
        }
        size = st.size;
 2a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
 2a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        switch (mode)
 2ab:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 2af:	74 4f                	je     300 <main+0x1c8>
 2b1:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 2b5:	7f 63                	jg     31a <main+0x1e2>
 2b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2bb:	74 08                	je     2c5 <main+0x18d>
 2bd:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
 2c1:	74 19                	je     2dc <main+0x1a4>
 2c3:	eb 55                	jmp    31a <main+0x1e2>
        {
            case M_ADD:
                size += (atoi(charsize) * multiplier);
 2c5:	83 ec 0c             	sub    $0xc,%esp
 2c8:	ff 75 ec             	pushl  -0x14(%ebp)
 2cb:	e8 47 02 00 00       	call   517 <atoi>
 2d0:	83 c4 10             	add    $0x10,%esp
 2d3:	0f af 45 e8          	imul   -0x18(%ebp),%eax
 2d7:	01 45 f4             	add    %eax,-0xc(%ebp)
                break;
 2da:	eb 3e                	jmp    31a <main+0x1e2>
            
            case M_SUBSTRACT:
                size -= (atoi(charsize) * multiplier);
 2dc:	83 ec 0c             	sub    $0xc,%esp
 2df:	ff 75 ec             	pushl  -0x14(%ebp)
 2e2:	e8 30 02 00 00       	call   517 <atoi>
 2e7:	83 c4 10             	add    $0x10,%esp
 2ea:	0f af 45 e8          	imul   -0x18(%ebp),%eax
 2ee:	29 45 f4             	sub    %eax,-0xc(%ebp)
                if(size < 0) size = 0;
 2f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2f5:	79 22                	jns    319 <main+0x1e1>
 2f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
                break;
 2fe:	eb 19                	jmp    319 <main+0x1e1>
            
            case M_CHANGE:
                size = (atoi(charsize) * multiplier);
 300:	83 ec 0c             	sub    $0xc,%esp
 303:	ff 75 ec             	pushl  -0x14(%ebp)
 306:	e8 0c 02 00 00       	call   517 <atoi>
 30b:	83 c4 10             	add    $0x10,%esp
 30e:	8b 55 e8             	mov    -0x18(%ebp),%edx
 311:	0f af c2             	imul   %edx,%eax
 314:	89 45 f4             	mov    %eax,-0xc(%ebp)
                break;
 317:	eb 01                	jmp    31a <main+0x1e2>
                break;
 319:	90                   	nop
        }
        //size is good, now how the fuck do I truncate
        truncate(argv[3],size);
 31a:	8b 43 04             	mov    0x4(%ebx),%eax
 31d:	83 c0 0c             	add    $0xc,%eax
 320:	8b 00                	mov    (%eax),%eax
 322:	83 ec 08             	sub    $0x8,%esp
 325:	ff 75 f4             	pushl  -0xc(%ebp)
 328:	50                   	push   %eax
 329:	e8 d2 fc ff ff       	call   0 <truncate>
 32e:	83 c4 10             	add    $0x10,%esp
    }
    exit();
 331:	e8 7b 02 00 00       	call   5b1 <exit>

00000336 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 336:	55                   	push   %ebp
 337:	89 e5                	mov    %esp,%ebp
 339:	57                   	push   %edi
 33a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 33b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 33e:	8b 55 10             	mov    0x10(%ebp),%edx
 341:	8b 45 0c             	mov    0xc(%ebp),%eax
 344:	89 cb                	mov    %ecx,%ebx
 346:	89 df                	mov    %ebx,%edi
 348:	89 d1                	mov    %edx,%ecx
 34a:	fc                   	cld    
 34b:	f3 aa                	rep stos %al,%es:(%edi)
 34d:	89 ca                	mov    %ecx,%edx
 34f:	89 fb                	mov    %edi,%ebx
 351:	89 5d 08             	mov    %ebx,0x8(%ebp)
 354:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 357:	90                   	nop
 358:	5b                   	pop    %ebx
 359:	5f                   	pop    %edi
 35a:	5d                   	pop    %ebp
 35b:	c3                   	ret    

0000035c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 35c:	f3 0f 1e fb          	endbr32 
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 366:	8b 45 08             	mov    0x8(%ebp),%eax
 369:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 36c:	90                   	nop
 36d:	8b 55 0c             	mov    0xc(%ebp),%edx
 370:	8d 42 01             	lea    0x1(%edx),%eax
 373:	89 45 0c             	mov    %eax,0xc(%ebp)
 376:	8b 45 08             	mov    0x8(%ebp),%eax
 379:	8d 48 01             	lea    0x1(%eax),%ecx
 37c:	89 4d 08             	mov    %ecx,0x8(%ebp)
 37f:	0f b6 12             	movzbl (%edx),%edx
 382:	88 10                	mov    %dl,(%eax)
 384:	0f b6 00             	movzbl (%eax),%eax
 387:	84 c0                	test   %al,%al
 389:	75 e2                	jne    36d <strcpy+0x11>
    ;
  return os;
 38b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 38e:	c9                   	leave  
 38f:	c3                   	ret    

00000390 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 390:	f3 0f 1e fb          	endbr32 
 394:	55                   	push   %ebp
 395:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 397:	eb 08                	jmp    3a1 <strcmp+0x11>
    p++, q++;
 399:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 39d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 3a1:	8b 45 08             	mov    0x8(%ebp),%eax
 3a4:	0f b6 00             	movzbl (%eax),%eax
 3a7:	84 c0                	test   %al,%al
 3a9:	74 10                	je     3bb <strcmp+0x2b>
 3ab:	8b 45 08             	mov    0x8(%ebp),%eax
 3ae:	0f b6 10             	movzbl (%eax),%edx
 3b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b4:	0f b6 00             	movzbl (%eax),%eax
 3b7:	38 c2                	cmp    %al,%dl
 3b9:	74 de                	je     399 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
 3bb:	8b 45 08             	mov    0x8(%ebp),%eax
 3be:	0f b6 00             	movzbl (%eax),%eax
 3c1:	0f b6 d0             	movzbl %al,%edx
 3c4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c7:	0f b6 00             	movzbl (%eax),%eax
 3ca:	0f b6 c0             	movzbl %al,%eax
 3cd:	29 c2                	sub    %eax,%edx
 3cf:	89 d0                	mov    %edx,%eax
}
 3d1:	5d                   	pop    %ebp
 3d2:	c3                   	ret    

000003d3 <strlen>:

uint
strlen(char *s)
{
 3d3:	f3 0f 1e fb          	endbr32 
 3d7:	55                   	push   %ebp
 3d8:	89 e5                	mov    %esp,%ebp
 3da:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3e4:	eb 04                	jmp    3ea <strlen+0x17>
 3e6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3ed:	8b 45 08             	mov    0x8(%ebp),%eax
 3f0:	01 d0                	add    %edx,%eax
 3f2:	0f b6 00             	movzbl (%eax),%eax
 3f5:	84 c0                	test   %al,%al
 3f7:	75 ed                	jne    3e6 <strlen+0x13>
    ;
  return n;
 3f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3fc:	c9                   	leave  
 3fd:	c3                   	ret    

000003fe <memset>:

void*
memset(void *dst, int c, uint n)
{
 3fe:	f3 0f 1e fb          	endbr32 
 402:	55                   	push   %ebp
 403:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 405:	8b 45 10             	mov    0x10(%ebp),%eax
 408:	50                   	push   %eax
 409:	ff 75 0c             	pushl  0xc(%ebp)
 40c:	ff 75 08             	pushl  0x8(%ebp)
 40f:	e8 22 ff ff ff       	call   336 <stosb>
 414:	83 c4 0c             	add    $0xc,%esp
  return dst;
 417:	8b 45 08             	mov    0x8(%ebp),%eax
}
 41a:	c9                   	leave  
 41b:	c3                   	ret    

0000041c <strchr>:

char*
strchr(const char *s, char c)
{
 41c:	f3 0f 1e fb          	endbr32 
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	83 ec 04             	sub    $0x4,%esp
 426:	8b 45 0c             	mov    0xc(%ebp),%eax
 429:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 42c:	eb 14                	jmp    442 <strchr+0x26>
    if(*s == c)
 42e:	8b 45 08             	mov    0x8(%ebp),%eax
 431:	0f b6 00             	movzbl (%eax),%eax
 434:	38 45 fc             	cmp    %al,-0x4(%ebp)
 437:	75 05                	jne    43e <strchr+0x22>
      return (char*)s;
 439:	8b 45 08             	mov    0x8(%ebp),%eax
 43c:	eb 13                	jmp    451 <strchr+0x35>
  for(; *s; s++)
 43e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 442:	8b 45 08             	mov    0x8(%ebp),%eax
 445:	0f b6 00             	movzbl (%eax),%eax
 448:	84 c0                	test   %al,%al
 44a:	75 e2                	jne    42e <strchr+0x12>
  return 0;
 44c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 451:	c9                   	leave  
 452:	c3                   	ret    

00000453 <gets>:

char*
gets(char *buf, int max)
{
 453:	f3 0f 1e fb          	endbr32 
 457:	55                   	push   %ebp
 458:	89 e5                	mov    %esp,%ebp
 45a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 45d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 464:	eb 42                	jmp    4a8 <gets+0x55>
    cc = read(0, &c, 1);
 466:	83 ec 04             	sub    $0x4,%esp
 469:	6a 01                	push   $0x1
 46b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 46e:	50                   	push   %eax
 46f:	6a 00                	push   $0x0
 471:	e8 53 01 00 00       	call   5c9 <read>
 476:	83 c4 10             	add    $0x10,%esp
 479:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 47c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 480:	7e 33                	jle    4b5 <gets+0x62>
      break;
    buf[i++] = c;
 482:	8b 45 f4             	mov    -0xc(%ebp),%eax
 485:	8d 50 01             	lea    0x1(%eax),%edx
 488:	89 55 f4             	mov    %edx,-0xc(%ebp)
 48b:	89 c2                	mov    %eax,%edx
 48d:	8b 45 08             	mov    0x8(%ebp),%eax
 490:	01 c2                	add    %eax,%edx
 492:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 496:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 498:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 49c:	3c 0a                	cmp    $0xa,%al
 49e:	74 16                	je     4b6 <gets+0x63>
 4a0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4a4:	3c 0d                	cmp    $0xd,%al
 4a6:	74 0e                	je     4b6 <gets+0x63>
  for(i=0; i+1 < max; ){
 4a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ab:	83 c0 01             	add    $0x1,%eax
 4ae:	39 45 0c             	cmp    %eax,0xc(%ebp)
 4b1:	7f b3                	jg     466 <gets+0x13>
 4b3:	eb 01                	jmp    4b6 <gets+0x63>
      break;
 4b5:	90                   	nop
      break;
  }
  buf[i] = '\0';
 4b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4b9:	8b 45 08             	mov    0x8(%ebp),%eax
 4bc:	01 d0                	add    %edx,%eax
 4be:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4c1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4c4:	c9                   	leave  
 4c5:	c3                   	ret    

000004c6 <stat>:

int
stat(char *n, struct stat *st)
{
 4c6:	f3 0f 1e fb          	endbr32 
 4ca:	55                   	push   %ebp
 4cb:	89 e5                	mov    %esp,%ebp
 4cd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4d0:	83 ec 08             	sub    $0x8,%esp
 4d3:	6a 00                	push   $0x0
 4d5:	ff 75 08             	pushl  0x8(%ebp)
 4d8:	e8 14 01 00 00       	call   5f1 <open>
 4dd:	83 c4 10             	add    $0x10,%esp
 4e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e7:	79 07                	jns    4f0 <stat+0x2a>
    return -1;
 4e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4ee:	eb 25                	jmp    515 <stat+0x4f>
  r = fstat(fd, st);
 4f0:	83 ec 08             	sub    $0x8,%esp
 4f3:	ff 75 0c             	pushl  0xc(%ebp)
 4f6:	ff 75 f4             	pushl  -0xc(%ebp)
 4f9:	e8 0b 01 00 00       	call   609 <fstat>
 4fe:	83 c4 10             	add    $0x10,%esp
 501:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 504:	83 ec 0c             	sub    $0xc,%esp
 507:	ff 75 f4             	pushl  -0xc(%ebp)
 50a:	e8 ca 00 00 00       	call   5d9 <close>
 50f:	83 c4 10             	add    $0x10,%esp
  return r;
 512:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 515:	c9                   	leave  
 516:	c3                   	ret    

00000517 <atoi>:

int
atoi(const char *s)
{
 517:	f3 0f 1e fb          	endbr32 
 51b:	55                   	push   %ebp
 51c:	89 e5                	mov    %esp,%ebp
 51e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 521:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 528:	eb 25                	jmp    54f <atoi+0x38>
    n = n*10 + *s++ - '0';
 52a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 52d:	89 d0                	mov    %edx,%eax
 52f:	c1 e0 02             	shl    $0x2,%eax
 532:	01 d0                	add    %edx,%eax
 534:	01 c0                	add    %eax,%eax
 536:	89 c1                	mov    %eax,%ecx
 538:	8b 45 08             	mov    0x8(%ebp),%eax
 53b:	8d 50 01             	lea    0x1(%eax),%edx
 53e:	89 55 08             	mov    %edx,0x8(%ebp)
 541:	0f b6 00             	movzbl (%eax),%eax
 544:	0f be c0             	movsbl %al,%eax
 547:	01 c8                	add    %ecx,%eax
 549:	83 e8 30             	sub    $0x30,%eax
 54c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 54f:	8b 45 08             	mov    0x8(%ebp),%eax
 552:	0f b6 00             	movzbl (%eax),%eax
 555:	3c 2f                	cmp    $0x2f,%al
 557:	7e 0a                	jle    563 <atoi+0x4c>
 559:	8b 45 08             	mov    0x8(%ebp),%eax
 55c:	0f b6 00             	movzbl (%eax),%eax
 55f:	3c 39                	cmp    $0x39,%al
 561:	7e c7                	jle    52a <atoi+0x13>
  return n;
 563:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 566:	c9                   	leave  
 567:	c3                   	ret    

00000568 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 568:	f3 0f 1e fb          	endbr32 
 56c:	55                   	push   %ebp
 56d:	89 e5                	mov    %esp,%ebp
 56f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 572:	8b 45 08             	mov    0x8(%ebp),%eax
 575:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 578:	8b 45 0c             	mov    0xc(%ebp),%eax
 57b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 57e:	eb 17                	jmp    597 <memmove+0x2f>
    *dst++ = *src++;
 580:	8b 55 f8             	mov    -0x8(%ebp),%edx
 583:	8d 42 01             	lea    0x1(%edx),%eax
 586:	89 45 f8             	mov    %eax,-0x8(%ebp)
 589:	8b 45 fc             	mov    -0x4(%ebp),%eax
 58c:	8d 48 01             	lea    0x1(%eax),%ecx
 58f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 592:	0f b6 12             	movzbl (%edx),%edx
 595:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 597:	8b 45 10             	mov    0x10(%ebp),%eax
 59a:	8d 50 ff             	lea    -0x1(%eax),%edx
 59d:	89 55 10             	mov    %edx,0x10(%ebp)
 5a0:	85 c0                	test   %eax,%eax
 5a2:	7f dc                	jg     580 <memmove+0x18>
  return vdst;
 5a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5a7:	c9                   	leave  
 5a8:	c3                   	ret    

000005a9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5a9:	b8 01 00 00 00       	mov    $0x1,%eax
 5ae:	cd 40                	int    $0x40
 5b0:	c3                   	ret    

000005b1 <exit>:
SYSCALL(exit)
 5b1:	b8 02 00 00 00       	mov    $0x2,%eax
 5b6:	cd 40                	int    $0x40
 5b8:	c3                   	ret    

000005b9 <wait>:
SYSCALL(wait)
 5b9:	b8 03 00 00 00       	mov    $0x3,%eax
 5be:	cd 40                	int    $0x40
 5c0:	c3                   	ret    

000005c1 <pipe>:
SYSCALL(pipe)
 5c1:	b8 04 00 00 00       	mov    $0x4,%eax
 5c6:	cd 40                	int    $0x40
 5c8:	c3                   	ret    

000005c9 <read>:
SYSCALL(read)
 5c9:	b8 05 00 00 00       	mov    $0x5,%eax
 5ce:	cd 40                	int    $0x40
 5d0:	c3                   	ret    

000005d1 <write>:
SYSCALL(write)
 5d1:	b8 10 00 00 00       	mov    $0x10,%eax
 5d6:	cd 40                	int    $0x40
 5d8:	c3                   	ret    

000005d9 <close>:
SYSCALL(close)
 5d9:	b8 15 00 00 00       	mov    $0x15,%eax
 5de:	cd 40                	int    $0x40
 5e0:	c3                   	ret    

000005e1 <kill>:
SYSCALL(kill)
 5e1:	b8 06 00 00 00       	mov    $0x6,%eax
 5e6:	cd 40                	int    $0x40
 5e8:	c3                   	ret    

000005e9 <exec>:
SYSCALL(exec)
 5e9:	b8 07 00 00 00       	mov    $0x7,%eax
 5ee:	cd 40                	int    $0x40
 5f0:	c3                   	ret    

000005f1 <open>:
SYSCALL(open)
 5f1:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f6:	cd 40                	int    $0x40
 5f8:	c3                   	ret    

000005f9 <mknod>:
SYSCALL(mknod)
 5f9:	b8 11 00 00 00       	mov    $0x11,%eax
 5fe:	cd 40                	int    $0x40
 600:	c3                   	ret    

00000601 <unlink>:
SYSCALL(unlink)
 601:	b8 12 00 00 00       	mov    $0x12,%eax
 606:	cd 40                	int    $0x40
 608:	c3                   	ret    

00000609 <fstat>:
SYSCALL(fstat)
 609:	b8 08 00 00 00       	mov    $0x8,%eax
 60e:	cd 40                	int    $0x40
 610:	c3                   	ret    

00000611 <link>:
SYSCALL(link)
 611:	b8 13 00 00 00       	mov    $0x13,%eax
 616:	cd 40                	int    $0x40
 618:	c3                   	ret    

00000619 <mkdir>:
SYSCALL(mkdir)
 619:	b8 14 00 00 00       	mov    $0x14,%eax
 61e:	cd 40                	int    $0x40
 620:	c3                   	ret    

00000621 <chdir>:
SYSCALL(chdir)
 621:	b8 09 00 00 00       	mov    $0x9,%eax
 626:	cd 40                	int    $0x40
 628:	c3                   	ret    

00000629 <dup>:
SYSCALL(dup)
 629:	b8 0a 00 00 00       	mov    $0xa,%eax
 62e:	cd 40                	int    $0x40
 630:	c3                   	ret    

00000631 <getpid>:
SYSCALL(getpid)
 631:	b8 0b 00 00 00       	mov    $0xb,%eax
 636:	cd 40                	int    $0x40
 638:	c3                   	ret    

00000639 <sbrk>:
SYSCALL(sbrk)
 639:	b8 0c 00 00 00       	mov    $0xc,%eax
 63e:	cd 40                	int    $0x40
 640:	c3                   	ret    

00000641 <sleep>:
SYSCALL(sleep)
 641:	b8 0d 00 00 00       	mov    $0xd,%eax
 646:	cd 40                	int    $0x40
 648:	c3                   	ret    

00000649 <uptime>:
SYSCALL(uptime)
 649:	b8 0e 00 00 00       	mov    $0xe,%eax
 64e:	cd 40                	int    $0x40
 650:	c3                   	ret    

00000651 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 651:	f3 0f 1e fb          	endbr32 
 655:	55                   	push   %ebp
 656:	89 e5                	mov    %esp,%ebp
 658:	83 ec 18             	sub    $0x18,%esp
 65b:	8b 45 0c             	mov    0xc(%ebp),%eax
 65e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 661:	83 ec 04             	sub    $0x4,%esp
 664:	6a 01                	push   $0x1
 666:	8d 45 f4             	lea    -0xc(%ebp),%eax
 669:	50                   	push   %eax
 66a:	ff 75 08             	pushl  0x8(%ebp)
 66d:	e8 5f ff ff ff       	call   5d1 <write>
 672:	83 c4 10             	add    $0x10,%esp
}
 675:	90                   	nop
 676:	c9                   	leave  
 677:	c3                   	ret    

00000678 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 678:	f3 0f 1e fb          	endbr32 
 67c:	55                   	push   %ebp
 67d:	89 e5                	mov    %esp,%ebp
 67f:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 682:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 689:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 68d:	74 17                	je     6a6 <printint+0x2e>
 68f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 693:	79 11                	jns    6a6 <printint+0x2e>
    neg = 1;
 695:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 69c:	8b 45 0c             	mov    0xc(%ebp),%eax
 69f:	f7 d8                	neg    %eax
 6a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6a4:	eb 06                	jmp    6ac <printint+0x34>
  } else {
    x = xx;
 6a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 6a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6b9:	ba 00 00 00 00       	mov    $0x0,%edx
 6be:	f7 f1                	div    %ecx
 6c0:	89 d1                	mov    %edx,%ecx
 6c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c5:	8d 50 01             	lea    0x1(%eax),%edx
 6c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6cb:	0f b6 91 d0 0d 00 00 	movzbl 0xdd0(%ecx),%edx
 6d2:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 6d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6dc:	ba 00 00 00 00       	mov    $0x0,%edx
 6e1:	f7 f1                	div    %ecx
 6e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6ea:	75 c7                	jne    6b3 <printint+0x3b>
  if(neg)
 6ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6f0:	74 2d                	je     71f <printint+0xa7>
    buf[i++] = '-';
 6f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f5:	8d 50 01             	lea    0x1(%eax),%edx
 6f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6fb:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 700:	eb 1d                	jmp    71f <printint+0xa7>
    putc(fd, buf[i]);
 702:	8d 55 dc             	lea    -0x24(%ebp),%edx
 705:	8b 45 f4             	mov    -0xc(%ebp),%eax
 708:	01 d0                	add    %edx,%eax
 70a:	0f b6 00             	movzbl (%eax),%eax
 70d:	0f be c0             	movsbl %al,%eax
 710:	83 ec 08             	sub    $0x8,%esp
 713:	50                   	push   %eax
 714:	ff 75 08             	pushl  0x8(%ebp)
 717:	e8 35 ff ff ff       	call   651 <putc>
 71c:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 71f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 723:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 727:	79 d9                	jns    702 <printint+0x8a>
}
 729:	90                   	nop
 72a:	90                   	nop
 72b:	c9                   	leave  
 72c:	c3                   	ret    

0000072d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 72d:	f3 0f 1e fb          	endbr32 
 731:	55                   	push   %ebp
 732:	89 e5                	mov    %esp,%ebp
 734:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 737:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 73e:	8d 45 0c             	lea    0xc(%ebp),%eax
 741:	83 c0 04             	add    $0x4,%eax
 744:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 747:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 74e:	e9 59 01 00 00       	jmp    8ac <printf+0x17f>
    c = fmt[i] & 0xff;
 753:	8b 55 0c             	mov    0xc(%ebp),%edx
 756:	8b 45 f0             	mov    -0x10(%ebp),%eax
 759:	01 d0                	add    %edx,%eax
 75b:	0f b6 00             	movzbl (%eax),%eax
 75e:	0f be c0             	movsbl %al,%eax
 761:	25 ff 00 00 00       	and    $0xff,%eax
 766:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 769:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 76d:	75 2c                	jne    79b <printf+0x6e>
      if(c == '%'){
 76f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 773:	75 0c                	jne    781 <printf+0x54>
        state = '%';
 775:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 77c:	e9 27 01 00 00       	jmp    8a8 <printf+0x17b>
      } else {
        putc(fd, c);
 781:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 784:	0f be c0             	movsbl %al,%eax
 787:	83 ec 08             	sub    $0x8,%esp
 78a:	50                   	push   %eax
 78b:	ff 75 08             	pushl  0x8(%ebp)
 78e:	e8 be fe ff ff       	call   651 <putc>
 793:	83 c4 10             	add    $0x10,%esp
 796:	e9 0d 01 00 00       	jmp    8a8 <printf+0x17b>
      }
    } else if(state == '%'){
 79b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 79f:	0f 85 03 01 00 00    	jne    8a8 <printf+0x17b>
      if(c == 'd'){
 7a5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7a9:	75 1e                	jne    7c9 <printf+0x9c>
        printint(fd, *ap, 10, 1);
 7ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7ae:	8b 00                	mov    (%eax),%eax
 7b0:	6a 01                	push   $0x1
 7b2:	6a 0a                	push   $0xa
 7b4:	50                   	push   %eax
 7b5:	ff 75 08             	pushl  0x8(%ebp)
 7b8:	e8 bb fe ff ff       	call   678 <printint>
 7bd:	83 c4 10             	add    $0x10,%esp
        ap++;
 7c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7c4:	e9 d8 00 00 00       	jmp    8a1 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 7c9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7cd:	74 06                	je     7d5 <printf+0xa8>
 7cf:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 7d3:	75 1e                	jne    7f3 <printf+0xc6>
        printint(fd, *ap, 16, 0);
 7d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7d8:	8b 00                	mov    (%eax),%eax
 7da:	6a 00                	push   $0x0
 7dc:	6a 10                	push   $0x10
 7de:	50                   	push   %eax
 7df:	ff 75 08             	pushl  0x8(%ebp)
 7e2:	e8 91 fe ff ff       	call   678 <printint>
 7e7:	83 c4 10             	add    $0x10,%esp
        ap++;
 7ea:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7ee:	e9 ae 00 00 00       	jmp    8a1 <printf+0x174>
      } else if(c == 's'){
 7f3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7f7:	75 43                	jne    83c <printf+0x10f>
        s = (char*)*ap;
 7f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7fc:	8b 00                	mov    (%eax),%eax
 7fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 801:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 805:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 809:	75 25                	jne    830 <printf+0x103>
          s = "(null)";
 80b:	c7 45 f4 5f 0b 00 00 	movl   $0xb5f,-0xc(%ebp)
        while(*s != 0){
 812:	eb 1c                	jmp    830 <printf+0x103>
          putc(fd, *s);
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	0f b6 00             	movzbl (%eax),%eax
 81a:	0f be c0             	movsbl %al,%eax
 81d:	83 ec 08             	sub    $0x8,%esp
 820:	50                   	push   %eax
 821:	ff 75 08             	pushl  0x8(%ebp)
 824:	e8 28 fe ff ff       	call   651 <putc>
 829:	83 c4 10             	add    $0x10,%esp
          s++;
 82c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 830:	8b 45 f4             	mov    -0xc(%ebp),%eax
 833:	0f b6 00             	movzbl (%eax),%eax
 836:	84 c0                	test   %al,%al
 838:	75 da                	jne    814 <printf+0xe7>
 83a:	eb 65                	jmp    8a1 <printf+0x174>
        }
      } else if(c == 'c'){
 83c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 840:	75 1d                	jne    85f <printf+0x132>
        putc(fd, *ap);
 842:	8b 45 e8             	mov    -0x18(%ebp),%eax
 845:	8b 00                	mov    (%eax),%eax
 847:	0f be c0             	movsbl %al,%eax
 84a:	83 ec 08             	sub    $0x8,%esp
 84d:	50                   	push   %eax
 84e:	ff 75 08             	pushl  0x8(%ebp)
 851:	e8 fb fd ff ff       	call   651 <putc>
 856:	83 c4 10             	add    $0x10,%esp
        ap++;
 859:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 85d:	eb 42                	jmp    8a1 <printf+0x174>
      } else if(c == '%'){
 85f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 863:	75 17                	jne    87c <printf+0x14f>
        putc(fd, c);
 865:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 868:	0f be c0             	movsbl %al,%eax
 86b:	83 ec 08             	sub    $0x8,%esp
 86e:	50                   	push   %eax
 86f:	ff 75 08             	pushl  0x8(%ebp)
 872:	e8 da fd ff ff       	call   651 <putc>
 877:	83 c4 10             	add    $0x10,%esp
 87a:	eb 25                	jmp    8a1 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 87c:	83 ec 08             	sub    $0x8,%esp
 87f:	6a 25                	push   $0x25
 881:	ff 75 08             	pushl  0x8(%ebp)
 884:	e8 c8 fd ff ff       	call   651 <putc>
 889:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 88c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 88f:	0f be c0             	movsbl %al,%eax
 892:	83 ec 08             	sub    $0x8,%esp
 895:	50                   	push   %eax
 896:	ff 75 08             	pushl  0x8(%ebp)
 899:	e8 b3 fd ff ff       	call   651 <putc>
 89e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 8a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 8a8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 8ac:	8b 55 0c             	mov    0xc(%ebp),%edx
 8af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b2:	01 d0                	add    %edx,%eax
 8b4:	0f b6 00             	movzbl (%eax),%eax
 8b7:	84 c0                	test   %al,%al
 8b9:	0f 85 94 fe ff ff    	jne    753 <printf+0x26>
    }
  }
}
 8bf:	90                   	nop
 8c0:	90                   	nop
 8c1:	c9                   	leave  
 8c2:	c3                   	ret    

000008c3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c3:	f3 0f 1e fb          	endbr32 
 8c7:	55                   	push   %ebp
 8c8:	89 e5                	mov    %esp,%ebp
 8ca:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8cd:	8b 45 08             	mov    0x8(%ebp),%eax
 8d0:	83 e8 08             	sub    $0x8,%eax
 8d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d6:	a1 08 0e 00 00       	mov    0xe08,%eax
 8db:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8de:	eb 24                	jmp    904 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e3:	8b 00                	mov    (%eax),%eax
 8e5:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 8e8:	72 12                	jb     8fc <free+0x39>
 8ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ed:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8f0:	77 24                	ja     916 <free+0x53>
 8f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f5:	8b 00                	mov    (%eax),%eax
 8f7:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 8fa:	72 1a                	jb     916 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ff:	8b 00                	mov    (%eax),%eax
 901:	89 45 fc             	mov    %eax,-0x4(%ebp)
 904:	8b 45 f8             	mov    -0x8(%ebp),%eax
 907:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 90a:	76 d4                	jbe    8e0 <free+0x1d>
 90c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90f:	8b 00                	mov    (%eax),%eax
 911:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 914:	73 ca                	jae    8e0 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 916:	8b 45 f8             	mov    -0x8(%ebp),%eax
 919:	8b 40 04             	mov    0x4(%eax),%eax
 91c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 923:	8b 45 f8             	mov    -0x8(%ebp),%eax
 926:	01 c2                	add    %eax,%edx
 928:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92b:	8b 00                	mov    (%eax),%eax
 92d:	39 c2                	cmp    %eax,%edx
 92f:	75 24                	jne    955 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 931:	8b 45 f8             	mov    -0x8(%ebp),%eax
 934:	8b 50 04             	mov    0x4(%eax),%edx
 937:	8b 45 fc             	mov    -0x4(%ebp),%eax
 93a:	8b 00                	mov    (%eax),%eax
 93c:	8b 40 04             	mov    0x4(%eax),%eax
 93f:	01 c2                	add    %eax,%edx
 941:	8b 45 f8             	mov    -0x8(%ebp),%eax
 944:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 947:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94a:	8b 00                	mov    (%eax),%eax
 94c:	8b 10                	mov    (%eax),%edx
 94e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 951:	89 10                	mov    %edx,(%eax)
 953:	eb 0a                	jmp    95f <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 955:	8b 45 fc             	mov    -0x4(%ebp),%eax
 958:	8b 10                	mov    (%eax),%edx
 95a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95d:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 95f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 962:	8b 40 04             	mov    0x4(%eax),%eax
 965:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 96c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 96f:	01 d0                	add    %edx,%eax
 971:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 974:	75 20                	jne    996 <free+0xd3>
    p->s.size += bp->s.size;
 976:	8b 45 fc             	mov    -0x4(%ebp),%eax
 979:	8b 50 04             	mov    0x4(%eax),%edx
 97c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 97f:	8b 40 04             	mov    0x4(%eax),%eax
 982:	01 c2                	add    %eax,%edx
 984:	8b 45 fc             	mov    -0x4(%ebp),%eax
 987:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 98a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 98d:	8b 10                	mov    (%eax),%edx
 98f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 992:	89 10                	mov    %edx,(%eax)
 994:	eb 08                	jmp    99e <free+0xdb>
  } else
    p->s.ptr = bp;
 996:	8b 45 fc             	mov    -0x4(%ebp),%eax
 999:	8b 55 f8             	mov    -0x8(%ebp),%edx
 99c:	89 10                	mov    %edx,(%eax)
  freep = p;
 99e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a1:	a3 08 0e 00 00       	mov    %eax,0xe08
}
 9a6:	90                   	nop
 9a7:	c9                   	leave  
 9a8:	c3                   	ret    

000009a9 <morecore>:

static Header*
morecore(uint nu)
{
 9a9:	f3 0f 1e fb          	endbr32 
 9ad:	55                   	push   %ebp
 9ae:	89 e5                	mov    %esp,%ebp
 9b0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9b3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9ba:	77 07                	ja     9c3 <morecore+0x1a>
    nu = 4096;
 9bc:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 9c3:	8b 45 08             	mov    0x8(%ebp),%eax
 9c6:	c1 e0 03             	shl    $0x3,%eax
 9c9:	83 ec 0c             	sub    $0xc,%esp
 9cc:	50                   	push   %eax
 9cd:	e8 67 fc ff ff       	call   639 <sbrk>
 9d2:	83 c4 10             	add    $0x10,%esp
 9d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 9d8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 9dc:	75 07                	jne    9e5 <morecore+0x3c>
    return 0;
 9de:	b8 00 00 00 00       	mov    $0x0,%eax
 9e3:	eb 26                	jmp    a0b <morecore+0x62>
  hp = (Header*)p;
 9e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 9eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ee:	8b 55 08             	mov    0x8(%ebp),%edx
 9f1:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9f7:	83 c0 08             	add    $0x8,%eax
 9fa:	83 ec 0c             	sub    $0xc,%esp
 9fd:	50                   	push   %eax
 9fe:	e8 c0 fe ff ff       	call   8c3 <free>
 a03:	83 c4 10             	add    $0x10,%esp
  return freep;
 a06:	a1 08 0e 00 00       	mov    0xe08,%eax
}
 a0b:	c9                   	leave  
 a0c:	c3                   	ret    

00000a0d <malloc>:

void*
malloc(uint nbytes)
{
 a0d:	f3 0f 1e fb          	endbr32 
 a11:	55                   	push   %ebp
 a12:	89 e5                	mov    %esp,%ebp
 a14:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a17:	8b 45 08             	mov    0x8(%ebp),%eax
 a1a:	83 c0 07             	add    $0x7,%eax
 a1d:	c1 e8 03             	shr    $0x3,%eax
 a20:	83 c0 01             	add    $0x1,%eax
 a23:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a26:	a1 08 0e 00 00       	mov    0xe08,%eax
 a2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a2e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a32:	75 23                	jne    a57 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 a34:	c7 45 f0 00 0e 00 00 	movl   $0xe00,-0x10(%ebp)
 a3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a3e:	a3 08 0e 00 00       	mov    %eax,0xe08
 a43:	a1 08 0e 00 00       	mov    0xe08,%eax
 a48:	a3 00 0e 00 00       	mov    %eax,0xe00
    base.s.size = 0;
 a4d:	c7 05 04 0e 00 00 00 	movl   $0x0,0xe04
 a54:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a57:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a5a:	8b 00                	mov    (%eax),%eax
 a5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a62:	8b 40 04             	mov    0x4(%eax),%eax
 a65:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 a68:	77 4d                	ja     ab7 <malloc+0xaa>
      if(p->s.size == nunits)
 a6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6d:	8b 40 04             	mov    0x4(%eax),%eax
 a70:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 a73:	75 0c                	jne    a81 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a78:	8b 10                	mov    (%eax),%edx
 a7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a7d:	89 10                	mov    %edx,(%eax)
 a7f:	eb 26                	jmp    aa7 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a84:	8b 40 04             	mov    0x4(%eax),%eax
 a87:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a8a:	89 c2                	mov    %eax,%edx
 a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a95:	8b 40 04             	mov    0x4(%eax),%eax
 a98:	c1 e0 03             	shl    $0x3,%eax
 a9b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 aa4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 aa7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aaa:	a3 08 0e 00 00       	mov    %eax,0xe08
      return (void*)(p + 1);
 aaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab2:	83 c0 08             	add    $0x8,%eax
 ab5:	eb 3b                	jmp    af2 <malloc+0xe5>
    }
    if(p == freep)
 ab7:	a1 08 0e 00 00       	mov    0xe08,%eax
 abc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 abf:	75 1e                	jne    adf <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 ac1:	83 ec 0c             	sub    $0xc,%esp
 ac4:	ff 75 ec             	pushl  -0x14(%ebp)
 ac7:	e8 dd fe ff ff       	call   9a9 <morecore>
 acc:	83 c4 10             	add    $0x10,%esp
 acf:	89 45 f4             	mov    %eax,-0xc(%ebp)
 ad2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ad6:	75 07                	jne    adf <malloc+0xd2>
        return 0;
 ad8:	b8 00 00 00 00       	mov    $0x0,%eax
 add:	eb 13                	jmp    af2 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 adf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae8:	8b 00                	mov    (%eax),%eax
 aea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 aed:	e9 6d ff ff ff       	jmp    a5f <malloc+0x52>
  }
}
 af2:	c9                   	leave  
 af3:	c3                   	ret    
