
_truncate:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[]){
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  13:	83 ec 20             	sub    $0x20,%esp
  16:	89 cb                	mov    %ecx,%ebx
    int fd,size;
    struct stat st;
    if(argc <= 3){
  18:	83 3b 03             	cmpl   $0x3,(%ebx)
  1b:	7f 17                	jg     34 <main+0x34>
        printf(1, "Need more than 2 argument\n");
  1d:	83 ec 08             	sub    $0x8,%esp
  20:	68 8c 09 00 00       	push   $0x98c
  25:	6a 01                	push   $0x1
  27:	e8 97 05 00 00       	call   5c3 <printf>
  2c:	83 c4 10             	add    $0x10,%esp
        exit();
  2f:	e8 13 04 00 00       	call   447 <exit>
    }

    if(strcmp("-s",argv[1]) == 0){
  34:	8b 43 04             	mov    0x4(%ebx),%eax
  37:	83 c0 04             	add    $0x4,%eax
  3a:	8b 00                	mov    (%eax),%eax
  3c:	83 ec 08             	sub    $0x8,%esp
  3f:	50                   	push   %eax
  40:	68 a7 09 00 00       	push   $0x9a7
  45:	e8 dc 01 00 00       	call   226 <strcmp>
  4a:	83 c4 10             	add    $0x10,%esp
  4d:	85 c0                	test   %eax,%eax
  4f:	0f 85 72 01 00 00    	jne    1c7 <main+0x1c7>
        char * temp;
        if((temp = strchr(argv[2],'K')) != NULL){
  55:	8b 43 04             	mov    0x4(%ebx),%eax
  58:	83 c0 08             	add    $0x8,%eax
  5b:	8b 00                	mov    (%eax),%eax
  5d:	83 ec 08             	sub    $0x8,%esp
  60:	6a 4b                	push   $0x4b
  62:	50                   	push   %eax
  63:	e8 4a 02 00 00       	call   2b2 <strchr>
  68:	83 c4 10             	add    $0x10,%esp
  6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  6e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  72:	74 28                	je     9c <main+0x9c>
            *temp = '\0';
  74:	8b 45 f0             	mov    -0x10(%ebp),%eax
  77:	c6 00 00             	movb   $0x0,(%eax)
            size = atoi(argv[2]) * 1000;
  7a:	8b 43 04             	mov    0x4(%ebx),%eax
  7d:	83 c0 08             	add    $0x8,%eax
  80:	8b 00                	mov    (%eax),%eax
  82:	83 ec 0c             	sub    $0xc,%esp
  85:	50                   	push   %eax
  86:	e8 22 03 00 00       	call   3ad <atoi>
  8b:	83 c4 10             	add    $0x10,%esp
  8e:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
  94:	89 45 f4             	mov    %eax,-0xc(%ebp)
  97:	e9 9f 00 00 00       	jmp    13b <main+0x13b>
        }
        else if( (temp = strchr(argv[2],'M')) != NULL ){
  9c:	8b 43 04             	mov    0x4(%ebx),%eax
  9f:	83 c0 08             	add    $0x8,%eax
  a2:	8b 00                	mov    (%eax),%eax
  a4:	83 ec 08             	sub    $0x8,%esp
  a7:	6a 4d                	push   $0x4d
  a9:	50                   	push   %eax
  aa:	e8 03 02 00 00       	call   2b2 <strchr>
  af:	83 c4 10             	add    $0x10,%esp
  b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  b9:	74 25                	je     e0 <main+0xe0>
            *temp = '\0';
  bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  be:	c6 00 00             	movb   $0x0,(%eax)
            size = atoi(argv[2]) * 1000000;
  c1:	8b 43 04             	mov    0x4(%ebx),%eax
  c4:	83 c0 08             	add    $0x8,%eax
  c7:	8b 00                	mov    (%eax),%eax
  c9:	83 ec 0c             	sub    $0xc,%esp
  cc:	50                   	push   %eax
  cd:	e8 db 02 00 00       	call   3ad <atoi>
  d2:	83 c4 10             	add    $0x10,%esp
  d5:	69 c0 40 42 0f 00    	imul   $0xf4240,%eax,%eax
  db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  de:	eb 5b                	jmp    13b <main+0x13b>
        }
        else if( (temp = strchr(argv[2],'G')) != NULL ){
  e0:	8b 43 04             	mov    0x4(%ebx),%eax
  e3:	83 c0 08             	add    $0x8,%eax
  e6:	8b 00                	mov    (%eax),%eax
  e8:	83 ec 08             	sub    $0x8,%esp
  eb:	6a 47                	push   $0x47
  ed:	50                   	push   %eax
  ee:	e8 bf 01 00 00       	call   2b2 <strchr>
  f3:	83 c4 10             	add    $0x10,%esp
  f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  fd:	74 25                	je     124 <main+0x124>
            *temp = '\0';
  ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 102:	c6 00 00             	movb   $0x0,(%eax)
            size = atoi(argv[2]) * 1000000000;
 105:	8b 43 04             	mov    0x4(%ebx),%eax
 108:	83 c0 08             	add    $0x8,%eax
 10b:	8b 00                	mov    (%eax),%eax
 10d:	83 ec 0c             	sub    $0xc,%esp
 110:	50                   	push   %eax
 111:	e8 97 02 00 00       	call   3ad <atoi>
 116:	83 c4 10             	add    $0x10,%esp
 119:	69 c0 00 ca 9a 3b    	imul   $0x3b9aca00,%eax,%eax
 11f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 122:	eb 17                	jmp    13b <main+0x13b>
        }else{
            size = atoi(argv[2]);
 124:	8b 43 04             	mov    0x4(%ebx),%eax
 127:	83 c0 08             	add    $0x8,%eax
 12a:	8b 00                	mov    (%eax),%eax
 12c:	83 ec 0c             	sub    $0xc,%esp
 12f:	50                   	push   %eax
 130:	e8 78 02 00 00       	call   3ad <atoi>
 135:	83 c4 10             	add    $0x10,%esp
 138:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }

        if((fd = open(argv[3],O_CREATE|O_RDWR)) < 0){
 13b:	8b 43 04             	mov    0x4(%ebx),%eax
 13e:	83 c0 0c             	add    $0xc,%eax
 141:	8b 00                	mov    (%eax),%eax
 143:	83 ec 08             	sub    $0x8,%esp
 146:	68 02 02 00 00       	push   $0x202
 14b:	50                   	push   %eax
 14c:	e8 36 03 00 00       	call   487 <open>
 151:	83 c4 10             	add    $0x10,%esp
 154:	89 45 ec             	mov    %eax,-0x14(%ebp)
 157:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 15b:	79 20                	jns    17d <main+0x17d>
            printf(1,"truncate: cannot open file %s",argv[3]);
 15d:	8b 43 04             	mov    0x4(%ebx),%eax
 160:	83 c0 0c             	add    $0xc,%eax
 163:	8b 00                	mov    (%eax),%eax
 165:	83 ec 04             	sub    $0x4,%esp
 168:	50                   	push   %eax
 169:	68 aa 09 00 00       	push   $0x9aa
 16e:	6a 01                	push   $0x1
 170:	e8 4e 04 00 00       	call   5c3 <printf>
 175:	83 c4 10             	add    $0x10,%esp
            exit();
 178:	e8 ca 02 00 00       	call   447 <exit>
        }

        if(fstat(fd,&st) < 0){
 17d:	83 ec 08             	sub    $0x8,%esp
 180:	8d 45 d8             	lea    -0x28(%ebp),%eax
 183:	50                   	push   %eax
 184:	ff 75 ec             	pushl  -0x14(%ebp)
 187:	e8 13 03 00 00       	call   49f <fstat>
 18c:	83 c4 10             	add    $0x10,%esp
 18f:	85 c0                	test   %eax,%eax
 191:	79 20                	jns    1b3 <main+0x1b3>
            printf(1,"truncate: failed reading stat file %s",argv[3]);
 193:	8b 43 04             	mov    0x4(%ebx),%eax
 196:	83 c0 0c             	add    $0xc,%eax
 199:	8b 00                	mov    (%eax),%eax
 19b:	83 ec 04             	sub    $0x4,%esp
 19e:	50                   	push   %eax
 19f:	68 c8 09 00 00       	push   $0x9c8
 1a4:	6a 01                	push   $0x1
 1a6:	e8 18 04 00 00       	call   5c3 <printf>
 1ab:	83 c4 10             	add    $0x10,%esp
            exit();
 1ae:	e8 94 02 00 00       	call   447 <exit>
        }
        st.size = size;
 1b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b6:	89 45 e8             	mov    %eax,-0x18(%ebp)
        close(fd);
 1b9:	83 ec 0c             	sub    $0xc,%esp
 1bc:	ff 75 ec             	pushl  -0x14(%ebp)
 1bf:	e8 ab 02 00 00       	call   46f <close>
 1c4:	83 c4 10             	add    $0x10,%esp
    }
    exit();
 1c7:	e8 7b 02 00 00       	call   447 <exit>

000001cc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1cc:	55                   	push   %ebp
 1cd:	89 e5                	mov    %esp,%ebp
 1cf:	57                   	push   %edi
 1d0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1d1:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1d4:	8b 55 10             	mov    0x10(%ebp),%edx
 1d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1da:	89 cb                	mov    %ecx,%ebx
 1dc:	89 df                	mov    %ebx,%edi
 1de:	89 d1                	mov    %edx,%ecx
 1e0:	fc                   	cld    
 1e1:	f3 aa                	rep stos %al,%es:(%edi)
 1e3:	89 ca                	mov    %ecx,%edx
 1e5:	89 fb                	mov    %edi,%ebx
 1e7:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1ea:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1ed:	90                   	nop
 1ee:	5b                   	pop    %ebx
 1ef:	5f                   	pop    %edi
 1f0:	5d                   	pop    %ebp
 1f1:	c3                   	ret    

000001f2 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1f2:	f3 0f 1e fb          	endbr32 
 1f6:	55                   	push   %ebp
 1f7:	89 e5                	mov    %esp,%ebp
 1f9:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 202:	90                   	nop
 203:	8b 55 0c             	mov    0xc(%ebp),%edx
 206:	8d 42 01             	lea    0x1(%edx),%eax
 209:	89 45 0c             	mov    %eax,0xc(%ebp)
 20c:	8b 45 08             	mov    0x8(%ebp),%eax
 20f:	8d 48 01             	lea    0x1(%eax),%ecx
 212:	89 4d 08             	mov    %ecx,0x8(%ebp)
 215:	0f b6 12             	movzbl (%edx),%edx
 218:	88 10                	mov    %dl,(%eax)
 21a:	0f b6 00             	movzbl (%eax),%eax
 21d:	84 c0                	test   %al,%al
 21f:	75 e2                	jne    203 <strcpy+0x11>
    ;
  return os;
 221:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 224:	c9                   	leave  
 225:	c3                   	ret    

00000226 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 226:	f3 0f 1e fb          	endbr32 
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 22d:	eb 08                	jmp    237 <strcmp+0x11>
    p++, q++;
 22f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 233:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	0f b6 00             	movzbl (%eax),%eax
 23d:	84 c0                	test   %al,%al
 23f:	74 10                	je     251 <strcmp+0x2b>
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	0f b6 10             	movzbl (%eax),%edx
 247:	8b 45 0c             	mov    0xc(%ebp),%eax
 24a:	0f b6 00             	movzbl (%eax),%eax
 24d:	38 c2                	cmp    %al,%dl
 24f:	74 de                	je     22f <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
 251:	8b 45 08             	mov    0x8(%ebp),%eax
 254:	0f b6 00             	movzbl (%eax),%eax
 257:	0f b6 d0             	movzbl %al,%edx
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	0f b6 00             	movzbl (%eax),%eax
 260:	0f b6 c0             	movzbl %al,%eax
 263:	29 c2                	sub    %eax,%edx
 265:	89 d0                	mov    %edx,%eax
}
 267:	5d                   	pop    %ebp
 268:	c3                   	ret    

00000269 <strlen>:

uint
strlen(char *s)
{
 269:	f3 0f 1e fb          	endbr32 
 26d:	55                   	push   %ebp
 26e:	89 e5                	mov    %esp,%ebp
 270:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 273:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 27a:	eb 04                	jmp    280 <strlen+0x17>
 27c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 280:	8b 55 fc             	mov    -0x4(%ebp),%edx
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	01 d0                	add    %edx,%eax
 288:	0f b6 00             	movzbl (%eax),%eax
 28b:	84 c0                	test   %al,%al
 28d:	75 ed                	jne    27c <strlen+0x13>
    ;
  return n;
 28f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 292:	c9                   	leave  
 293:	c3                   	ret    

00000294 <memset>:

void*
memset(void *dst, int c, uint n)
{
 294:	f3 0f 1e fb          	endbr32 
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 29b:	8b 45 10             	mov    0x10(%ebp),%eax
 29e:	50                   	push   %eax
 29f:	ff 75 0c             	pushl  0xc(%ebp)
 2a2:	ff 75 08             	pushl  0x8(%ebp)
 2a5:	e8 22 ff ff ff       	call   1cc <stosb>
 2aa:	83 c4 0c             	add    $0xc,%esp
  return dst;
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b0:	c9                   	leave  
 2b1:	c3                   	ret    

000002b2 <strchr>:

char*
strchr(const char *s, char c)
{
 2b2:	f3 0f 1e fb          	endbr32 
 2b6:	55                   	push   %ebp
 2b7:	89 e5                	mov    %esp,%ebp
 2b9:	83 ec 04             	sub    $0x4,%esp
 2bc:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bf:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2c2:	eb 14                	jmp    2d8 <strchr+0x26>
    if(*s == c)
 2c4:	8b 45 08             	mov    0x8(%ebp),%eax
 2c7:	0f b6 00             	movzbl (%eax),%eax
 2ca:	38 45 fc             	cmp    %al,-0x4(%ebp)
 2cd:	75 05                	jne    2d4 <strchr+0x22>
      return (char*)s;
 2cf:	8b 45 08             	mov    0x8(%ebp),%eax
 2d2:	eb 13                	jmp    2e7 <strchr+0x35>
  for(; *s; s++)
 2d4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2d8:	8b 45 08             	mov    0x8(%ebp),%eax
 2db:	0f b6 00             	movzbl (%eax),%eax
 2de:	84 c0                	test   %al,%al
 2e0:	75 e2                	jne    2c4 <strchr+0x12>
  return 0;
 2e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2e7:	c9                   	leave  
 2e8:	c3                   	ret    

000002e9 <gets>:

char*
gets(char *buf, int max)
{
 2e9:	f3 0f 1e fb          	endbr32 
 2ed:	55                   	push   %ebp
 2ee:	89 e5                	mov    %esp,%ebp
 2f0:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2fa:	eb 42                	jmp    33e <gets+0x55>
    cc = read(0, &c, 1);
 2fc:	83 ec 04             	sub    $0x4,%esp
 2ff:	6a 01                	push   $0x1
 301:	8d 45 ef             	lea    -0x11(%ebp),%eax
 304:	50                   	push   %eax
 305:	6a 00                	push   $0x0
 307:	e8 53 01 00 00       	call   45f <read>
 30c:	83 c4 10             	add    $0x10,%esp
 30f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 312:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 316:	7e 33                	jle    34b <gets+0x62>
      break;
    buf[i++] = c;
 318:	8b 45 f4             	mov    -0xc(%ebp),%eax
 31b:	8d 50 01             	lea    0x1(%eax),%edx
 31e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 321:	89 c2                	mov    %eax,%edx
 323:	8b 45 08             	mov    0x8(%ebp),%eax
 326:	01 c2                	add    %eax,%edx
 328:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 32c:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 32e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 332:	3c 0a                	cmp    $0xa,%al
 334:	74 16                	je     34c <gets+0x63>
 336:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 33a:	3c 0d                	cmp    $0xd,%al
 33c:	74 0e                	je     34c <gets+0x63>
  for(i=0; i+1 < max; ){
 33e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 341:	83 c0 01             	add    $0x1,%eax
 344:	39 45 0c             	cmp    %eax,0xc(%ebp)
 347:	7f b3                	jg     2fc <gets+0x13>
 349:	eb 01                	jmp    34c <gets+0x63>
      break;
 34b:	90                   	nop
      break;
  }
  buf[i] = '\0';
 34c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 34f:	8b 45 08             	mov    0x8(%ebp),%eax
 352:	01 d0                	add    %edx,%eax
 354:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 357:	8b 45 08             	mov    0x8(%ebp),%eax
}
 35a:	c9                   	leave  
 35b:	c3                   	ret    

0000035c <stat>:

int
stat(char *n, struct stat *st)
{
 35c:	f3 0f 1e fb          	endbr32 
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 366:	83 ec 08             	sub    $0x8,%esp
 369:	6a 00                	push   $0x0
 36b:	ff 75 08             	pushl  0x8(%ebp)
 36e:	e8 14 01 00 00       	call   487 <open>
 373:	83 c4 10             	add    $0x10,%esp
 376:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 379:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 37d:	79 07                	jns    386 <stat+0x2a>
    return -1;
 37f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 384:	eb 25                	jmp    3ab <stat+0x4f>
  r = fstat(fd, st);
 386:	83 ec 08             	sub    $0x8,%esp
 389:	ff 75 0c             	pushl  0xc(%ebp)
 38c:	ff 75 f4             	pushl  -0xc(%ebp)
 38f:	e8 0b 01 00 00       	call   49f <fstat>
 394:	83 c4 10             	add    $0x10,%esp
 397:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 39a:	83 ec 0c             	sub    $0xc,%esp
 39d:	ff 75 f4             	pushl  -0xc(%ebp)
 3a0:	e8 ca 00 00 00       	call   46f <close>
 3a5:	83 c4 10             	add    $0x10,%esp
  return r;
 3a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 3ab:	c9                   	leave  
 3ac:	c3                   	ret    

000003ad <atoi>:

int
atoi(const char *s)
{
 3ad:	f3 0f 1e fb          	endbr32 
 3b1:	55                   	push   %ebp
 3b2:	89 e5                	mov    %esp,%ebp
 3b4:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 3b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3be:	eb 25                	jmp    3e5 <atoi+0x38>
    n = n*10 + *s++ - '0';
 3c0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3c3:	89 d0                	mov    %edx,%eax
 3c5:	c1 e0 02             	shl    $0x2,%eax
 3c8:	01 d0                	add    %edx,%eax
 3ca:	01 c0                	add    %eax,%eax
 3cc:	89 c1                	mov    %eax,%ecx
 3ce:	8b 45 08             	mov    0x8(%ebp),%eax
 3d1:	8d 50 01             	lea    0x1(%eax),%edx
 3d4:	89 55 08             	mov    %edx,0x8(%ebp)
 3d7:	0f b6 00             	movzbl (%eax),%eax
 3da:	0f be c0             	movsbl %al,%eax
 3dd:	01 c8                	add    %ecx,%eax
 3df:	83 e8 30             	sub    $0x30,%eax
 3e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3e5:	8b 45 08             	mov    0x8(%ebp),%eax
 3e8:	0f b6 00             	movzbl (%eax),%eax
 3eb:	3c 2f                	cmp    $0x2f,%al
 3ed:	7e 0a                	jle    3f9 <atoi+0x4c>
 3ef:	8b 45 08             	mov    0x8(%ebp),%eax
 3f2:	0f b6 00             	movzbl (%eax),%eax
 3f5:	3c 39                	cmp    $0x39,%al
 3f7:	7e c7                	jle    3c0 <atoi+0x13>
  return n;
 3f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3fc:	c9                   	leave  
 3fd:	c3                   	ret    

000003fe <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3fe:	f3 0f 1e fb          	endbr32 
 402:	55                   	push   %ebp
 403:	89 e5                	mov    %esp,%ebp
 405:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 408:	8b 45 08             	mov    0x8(%ebp),%eax
 40b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 40e:	8b 45 0c             	mov    0xc(%ebp),%eax
 411:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 414:	eb 17                	jmp    42d <memmove+0x2f>
    *dst++ = *src++;
 416:	8b 55 f8             	mov    -0x8(%ebp),%edx
 419:	8d 42 01             	lea    0x1(%edx),%eax
 41c:	89 45 f8             	mov    %eax,-0x8(%ebp)
 41f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 422:	8d 48 01             	lea    0x1(%eax),%ecx
 425:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 428:	0f b6 12             	movzbl (%edx),%edx
 42b:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 42d:	8b 45 10             	mov    0x10(%ebp),%eax
 430:	8d 50 ff             	lea    -0x1(%eax),%edx
 433:	89 55 10             	mov    %edx,0x10(%ebp)
 436:	85 c0                	test   %eax,%eax
 438:	7f dc                	jg     416 <memmove+0x18>
  return vdst;
 43a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 43d:	c9                   	leave  
 43e:	c3                   	ret    

0000043f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 43f:	b8 01 00 00 00       	mov    $0x1,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret    

00000447 <exit>:
SYSCALL(exit)
 447:	b8 02 00 00 00       	mov    $0x2,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret    

0000044f <wait>:
SYSCALL(wait)
 44f:	b8 03 00 00 00       	mov    $0x3,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret    

00000457 <pipe>:
SYSCALL(pipe)
 457:	b8 04 00 00 00       	mov    $0x4,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret    

0000045f <read>:
SYSCALL(read)
 45f:	b8 05 00 00 00       	mov    $0x5,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret    

00000467 <write>:
SYSCALL(write)
 467:	b8 10 00 00 00       	mov    $0x10,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret    

0000046f <close>:
SYSCALL(close)
 46f:	b8 15 00 00 00       	mov    $0x15,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret    

00000477 <kill>:
SYSCALL(kill)
 477:	b8 06 00 00 00       	mov    $0x6,%eax
 47c:	cd 40                	int    $0x40
 47e:	c3                   	ret    

0000047f <exec>:
SYSCALL(exec)
 47f:	b8 07 00 00 00       	mov    $0x7,%eax
 484:	cd 40                	int    $0x40
 486:	c3                   	ret    

00000487 <open>:
SYSCALL(open)
 487:	b8 0f 00 00 00       	mov    $0xf,%eax
 48c:	cd 40                	int    $0x40
 48e:	c3                   	ret    

0000048f <mknod>:
SYSCALL(mknod)
 48f:	b8 11 00 00 00       	mov    $0x11,%eax
 494:	cd 40                	int    $0x40
 496:	c3                   	ret    

00000497 <unlink>:
SYSCALL(unlink)
 497:	b8 12 00 00 00       	mov    $0x12,%eax
 49c:	cd 40                	int    $0x40
 49e:	c3                   	ret    

0000049f <fstat>:
SYSCALL(fstat)
 49f:	b8 08 00 00 00       	mov    $0x8,%eax
 4a4:	cd 40                	int    $0x40
 4a6:	c3                   	ret    

000004a7 <link>:
SYSCALL(link)
 4a7:	b8 13 00 00 00       	mov    $0x13,%eax
 4ac:	cd 40                	int    $0x40
 4ae:	c3                   	ret    

000004af <mkdir>:
SYSCALL(mkdir)
 4af:	b8 14 00 00 00       	mov    $0x14,%eax
 4b4:	cd 40                	int    $0x40
 4b6:	c3                   	ret    

000004b7 <chdir>:
SYSCALL(chdir)
 4b7:	b8 09 00 00 00       	mov    $0x9,%eax
 4bc:	cd 40                	int    $0x40
 4be:	c3                   	ret    

000004bf <dup>:
SYSCALL(dup)
 4bf:	b8 0a 00 00 00       	mov    $0xa,%eax
 4c4:	cd 40                	int    $0x40
 4c6:	c3                   	ret    

000004c7 <getpid>:
SYSCALL(getpid)
 4c7:	b8 0b 00 00 00       	mov    $0xb,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret    

000004cf <sbrk>:
SYSCALL(sbrk)
 4cf:	b8 0c 00 00 00       	mov    $0xc,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret    

000004d7 <sleep>:
SYSCALL(sleep)
 4d7:	b8 0d 00 00 00       	mov    $0xd,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret    

000004df <uptime>:
SYSCALL(uptime)
 4df:	b8 0e 00 00 00       	mov    $0xe,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret    

000004e7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4e7:	f3 0f 1e fb          	endbr32 
 4eb:	55                   	push   %ebp
 4ec:	89 e5                	mov    %esp,%ebp
 4ee:	83 ec 18             	sub    $0x18,%esp
 4f1:	8b 45 0c             	mov    0xc(%ebp),%eax
 4f4:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4f7:	83 ec 04             	sub    $0x4,%esp
 4fa:	6a 01                	push   $0x1
 4fc:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4ff:	50                   	push   %eax
 500:	ff 75 08             	pushl  0x8(%ebp)
 503:	e8 5f ff ff ff       	call   467 <write>
 508:	83 c4 10             	add    $0x10,%esp
}
 50b:	90                   	nop
 50c:	c9                   	leave  
 50d:	c3                   	ret    

0000050e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 50e:	f3 0f 1e fb          	endbr32 
 512:	55                   	push   %ebp
 513:	89 e5                	mov    %esp,%ebp
 515:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 518:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 51f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 523:	74 17                	je     53c <printint+0x2e>
 525:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 529:	79 11                	jns    53c <printint+0x2e>
    neg = 1;
 52b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 532:	8b 45 0c             	mov    0xc(%ebp),%eax
 535:	f7 d8                	neg    %eax
 537:	89 45 ec             	mov    %eax,-0x14(%ebp)
 53a:	eb 06                	jmp    542 <printint+0x34>
  } else {
    x = xx;
 53c:	8b 45 0c             	mov    0xc(%ebp),%eax
 53f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 542:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 549:	8b 4d 10             	mov    0x10(%ebp),%ecx
 54c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 54f:	ba 00 00 00 00       	mov    $0x0,%edx
 554:	f7 f1                	div    %ecx
 556:	89 d1                	mov    %edx,%ecx
 558:	8b 45 f4             	mov    -0xc(%ebp),%eax
 55b:	8d 50 01             	lea    0x1(%eax),%edx
 55e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 561:	0f b6 91 40 0c 00 00 	movzbl 0xc40(%ecx),%edx
 568:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 56c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 56f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 572:	ba 00 00 00 00       	mov    $0x0,%edx
 577:	f7 f1                	div    %ecx
 579:	89 45 ec             	mov    %eax,-0x14(%ebp)
 57c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 580:	75 c7                	jne    549 <printint+0x3b>
  if(neg)
 582:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 586:	74 2d                	je     5b5 <printint+0xa7>
    buf[i++] = '-';
 588:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58b:	8d 50 01             	lea    0x1(%eax),%edx
 58e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 591:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 596:	eb 1d                	jmp    5b5 <printint+0xa7>
    putc(fd, buf[i]);
 598:	8d 55 dc             	lea    -0x24(%ebp),%edx
 59b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59e:	01 d0                	add    %edx,%eax
 5a0:	0f b6 00             	movzbl (%eax),%eax
 5a3:	0f be c0             	movsbl %al,%eax
 5a6:	83 ec 08             	sub    $0x8,%esp
 5a9:	50                   	push   %eax
 5aa:	ff 75 08             	pushl  0x8(%ebp)
 5ad:	e8 35 ff ff ff       	call   4e7 <putc>
 5b2:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5b5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5bd:	79 d9                	jns    598 <printint+0x8a>
}
 5bf:	90                   	nop
 5c0:	90                   	nop
 5c1:	c9                   	leave  
 5c2:	c3                   	ret    

000005c3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5c3:	f3 0f 1e fb          	endbr32 
 5c7:	55                   	push   %ebp
 5c8:	89 e5                	mov    %esp,%ebp
 5ca:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5cd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5d4:	8d 45 0c             	lea    0xc(%ebp),%eax
 5d7:	83 c0 04             	add    $0x4,%eax
 5da:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5e4:	e9 59 01 00 00       	jmp    742 <printf+0x17f>
    c = fmt[i] & 0xff;
 5e9:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ef:	01 d0                	add    %edx,%eax
 5f1:	0f b6 00             	movzbl (%eax),%eax
 5f4:	0f be c0             	movsbl %al,%eax
 5f7:	25 ff 00 00 00       	and    $0xff,%eax
 5fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 603:	75 2c                	jne    631 <printf+0x6e>
      if(c == '%'){
 605:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 609:	75 0c                	jne    617 <printf+0x54>
        state = '%';
 60b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 612:	e9 27 01 00 00       	jmp    73e <printf+0x17b>
      } else {
        putc(fd, c);
 617:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 61a:	0f be c0             	movsbl %al,%eax
 61d:	83 ec 08             	sub    $0x8,%esp
 620:	50                   	push   %eax
 621:	ff 75 08             	pushl  0x8(%ebp)
 624:	e8 be fe ff ff       	call   4e7 <putc>
 629:	83 c4 10             	add    $0x10,%esp
 62c:	e9 0d 01 00 00       	jmp    73e <printf+0x17b>
      }
    } else if(state == '%'){
 631:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 635:	0f 85 03 01 00 00    	jne    73e <printf+0x17b>
      if(c == 'd'){
 63b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 63f:	75 1e                	jne    65f <printf+0x9c>
        printint(fd, *ap, 10, 1);
 641:	8b 45 e8             	mov    -0x18(%ebp),%eax
 644:	8b 00                	mov    (%eax),%eax
 646:	6a 01                	push   $0x1
 648:	6a 0a                	push   $0xa
 64a:	50                   	push   %eax
 64b:	ff 75 08             	pushl  0x8(%ebp)
 64e:	e8 bb fe ff ff       	call   50e <printint>
 653:	83 c4 10             	add    $0x10,%esp
        ap++;
 656:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 65a:	e9 d8 00 00 00       	jmp    737 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 65f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 663:	74 06                	je     66b <printf+0xa8>
 665:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 669:	75 1e                	jne    689 <printf+0xc6>
        printint(fd, *ap, 16, 0);
 66b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 66e:	8b 00                	mov    (%eax),%eax
 670:	6a 00                	push   $0x0
 672:	6a 10                	push   $0x10
 674:	50                   	push   %eax
 675:	ff 75 08             	pushl  0x8(%ebp)
 678:	e8 91 fe ff ff       	call   50e <printint>
 67d:	83 c4 10             	add    $0x10,%esp
        ap++;
 680:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 684:	e9 ae 00 00 00       	jmp    737 <printf+0x174>
      } else if(c == 's'){
 689:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 68d:	75 43                	jne    6d2 <printf+0x10f>
        s = (char*)*ap;
 68f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 692:	8b 00                	mov    (%eax),%eax
 694:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 697:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 69b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 69f:	75 25                	jne    6c6 <printf+0x103>
          s = "(null)";
 6a1:	c7 45 f4 ee 09 00 00 	movl   $0x9ee,-0xc(%ebp)
        while(*s != 0){
 6a8:	eb 1c                	jmp    6c6 <printf+0x103>
          putc(fd, *s);
 6aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ad:	0f b6 00             	movzbl (%eax),%eax
 6b0:	0f be c0             	movsbl %al,%eax
 6b3:	83 ec 08             	sub    $0x8,%esp
 6b6:	50                   	push   %eax
 6b7:	ff 75 08             	pushl  0x8(%ebp)
 6ba:	e8 28 fe ff ff       	call   4e7 <putc>
 6bf:	83 c4 10             	add    $0x10,%esp
          s++;
 6c2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c9:	0f b6 00             	movzbl (%eax),%eax
 6cc:	84 c0                	test   %al,%al
 6ce:	75 da                	jne    6aa <printf+0xe7>
 6d0:	eb 65                	jmp    737 <printf+0x174>
        }
      } else if(c == 'c'){
 6d2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6d6:	75 1d                	jne    6f5 <printf+0x132>
        putc(fd, *ap);
 6d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6db:	8b 00                	mov    (%eax),%eax
 6dd:	0f be c0             	movsbl %al,%eax
 6e0:	83 ec 08             	sub    $0x8,%esp
 6e3:	50                   	push   %eax
 6e4:	ff 75 08             	pushl  0x8(%ebp)
 6e7:	e8 fb fd ff ff       	call   4e7 <putc>
 6ec:	83 c4 10             	add    $0x10,%esp
        ap++;
 6ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6f3:	eb 42                	jmp    737 <printf+0x174>
      } else if(c == '%'){
 6f5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6f9:	75 17                	jne    712 <printf+0x14f>
        putc(fd, c);
 6fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6fe:	0f be c0             	movsbl %al,%eax
 701:	83 ec 08             	sub    $0x8,%esp
 704:	50                   	push   %eax
 705:	ff 75 08             	pushl  0x8(%ebp)
 708:	e8 da fd ff ff       	call   4e7 <putc>
 70d:	83 c4 10             	add    $0x10,%esp
 710:	eb 25                	jmp    737 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 712:	83 ec 08             	sub    $0x8,%esp
 715:	6a 25                	push   $0x25
 717:	ff 75 08             	pushl  0x8(%ebp)
 71a:	e8 c8 fd ff ff       	call   4e7 <putc>
 71f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 722:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 725:	0f be c0             	movsbl %al,%eax
 728:	83 ec 08             	sub    $0x8,%esp
 72b:	50                   	push   %eax
 72c:	ff 75 08             	pushl  0x8(%ebp)
 72f:	e8 b3 fd ff ff       	call   4e7 <putc>
 734:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 737:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 73e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 742:	8b 55 0c             	mov    0xc(%ebp),%edx
 745:	8b 45 f0             	mov    -0x10(%ebp),%eax
 748:	01 d0                	add    %edx,%eax
 74a:	0f b6 00             	movzbl (%eax),%eax
 74d:	84 c0                	test   %al,%al
 74f:	0f 85 94 fe ff ff    	jne    5e9 <printf+0x26>
    }
  }
}
 755:	90                   	nop
 756:	90                   	nop
 757:	c9                   	leave  
 758:	c3                   	ret    

00000759 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 759:	f3 0f 1e fb          	endbr32 
 75d:	55                   	push   %ebp
 75e:	89 e5                	mov    %esp,%ebp
 760:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 763:	8b 45 08             	mov    0x8(%ebp),%eax
 766:	83 e8 08             	sub    $0x8,%eax
 769:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76c:	a1 5c 0c 00 00       	mov    0xc5c,%eax
 771:	89 45 fc             	mov    %eax,-0x4(%ebp)
 774:	eb 24                	jmp    79a <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 776:	8b 45 fc             	mov    -0x4(%ebp),%eax
 779:	8b 00                	mov    (%eax),%eax
 77b:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 77e:	72 12                	jb     792 <free+0x39>
 780:	8b 45 f8             	mov    -0x8(%ebp),%eax
 783:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 786:	77 24                	ja     7ac <free+0x53>
 788:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78b:	8b 00                	mov    (%eax),%eax
 78d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 790:	72 1a                	jb     7ac <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 792:	8b 45 fc             	mov    -0x4(%ebp),%eax
 795:	8b 00                	mov    (%eax),%eax
 797:	89 45 fc             	mov    %eax,-0x4(%ebp)
 79a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7a0:	76 d4                	jbe    776 <free+0x1d>
 7a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a5:	8b 00                	mov    (%eax),%eax
 7a7:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7aa:	73 ca                	jae    776 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7af:	8b 40 04             	mov    0x4(%eax),%eax
 7b2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bc:	01 c2                	add    %eax,%edx
 7be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c1:	8b 00                	mov    (%eax),%eax
 7c3:	39 c2                	cmp    %eax,%edx
 7c5:	75 24                	jne    7eb <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 7c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ca:	8b 50 04             	mov    0x4(%eax),%edx
 7cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d0:	8b 00                	mov    (%eax),%eax
 7d2:	8b 40 04             	mov    0x4(%eax),%eax
 7d5:	01 c2                	add    %eax,%edx
 7d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7da:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e0:	8b 00                	mov    (%eax),%eax
 7e2:	8b 10                	mov    (%eax),%edx
 7e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e7:	89 10                	mov    %edx,(%eax)
 7e9:	eb 0a                	jmp    7f5 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 7eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ee:	8b 10                	mov    (%eax),%edx
 7f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f8:	8b 40 04             	mov    0x4(%eax),%eax
 7fb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 802:	8b 45 fc             	mov    -0x4(%ebp),%eax
 805:	01 d0                	add    %edx,%eax
 807:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 80a:	75 20                	jne    82c <free+0xd3>
    p->s.size += bp->s.size;
 80c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80f:	8b 50 04             	mov    0x4(%eax),%edx
 812:	8b 45 f8             	mov    -0x8(%ebp),%eax
 815:	8b 40 04             	mov    0x4(%eax),%eax
 818:	01 c2                	add    %eax,%edx
 81a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 820:	8b 45 f8             	mov    -0x8(%ebp),%eax
 823:	8b 10                	mov    (%eax),%edx
 825:	8b 45 fc             	mov    -0x4(%ebp),%eax
 828:	89 10                	mov    %edx,(%eax)
 82a:	eb 08                	jmp    834 <free+0xdb>
  } else
    p->s.ptr = bp;
 82c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 832:	89 10                	mov    %edx,(%eax)
  freep = p;
 834:	8b 45 fc             	mov    -0x4(%ebp),%eax
 837:	a3 5c 0c 00 00       	mov    %eax,0xc5c
}
 83c:	90                   	nop
 83d:	c9                   	leave  
 83e:	c3                   	ret    

0000083f <morecore>:

static Header*
morecore(uint nu)
{
 83f:	f3 0f 1e fb          	endbr32 
 843:	55                   	push   %ebp
 844:	89 e5                	mov    %esp,%ebp
 846:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 849:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 850:	77 07                	ja     859 <morecore+0x1a>
    nu = 4096;
 852:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 859:	8b 45 08             	mov    0x8(%ebp),%eax
 85c:	c1 e0 03             	shl    $0x3,%eax
 85f:	83 ec 0c             	sub    $0xc,%esp
 862:	50                   	push   %eax
 863:	e8 67 fc ff ff       	call   4cf <sbrk>
 868:	83 c4 10             	add    $0x10,%esp
 86b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 86e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 872:	75 07                	jne    87b <morecore+0x3c>
    return 0;
 874:	b8 00 00 00 00       	mov    $0x0,%eax
 879:	eb 26                	jmp    8a1 <morecore+0x62>
  hp = (Header*)p;
 87b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 881:	8b 45 f0             	mov    -0x10(%ebp),%eax
 884:	8b 55 08             	mov    0x8(%ebp),%edx
 887:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 88a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88d:	83 c0 08             	add    $0x8,%eax
 890:	83 ec 0c             	sub    $0xc,%esp
 893:	50                   	push   %eax
 894:	e8 c0 fe ff ff       	call   759 <free>
 899:	83 c4 10             	add    $0x10,%esp
  return freep;
 89c:	a1 5c 0c 00 00       	mov    0xc5c,%eax
}
 8a1:	c9                   	leave  
 8a2:	c3                   	ret    

000008a3 <malloc>:

void*
malloc(uint nbytes)
{
 8a3:	f3 0f 1e fb          	endbr32 
 8a7:	55                   	push   %ebp
 8a8:	89 e5                	mov    %esp,%ebp
 8aa:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ad:	8b 45 08             	mov    0x8(%ebp),%eax
 8b0:	83 c0 07             	add    $0x7,%eax
 8b3:	c1 e8 03             	shr    $0x3,%eax
 8b6:	83 c0 01             	add    $0x1,%eax
 8b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8bc:	a1 5c 0c 00 00       	mov    0xc5c,%eax
 8c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8c8:	75 23                	jne    8ed <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 8ca:	c7 45 f0 54 0c 00 00 	movl   $0xc54,-0x10(%ebp)
 8d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d4:	a3 5c 0c 00 00       	mov    %eax,0xc5c
 8d9:	a1 5c 0c 00 00       	mov    0xc5c,%eax
 8de:	a3 54 0c 00 00       	mov    %eax,0xc54
    base.s.size = 0;
 8e3:	c7 05 58 0c 00 00 00 	movl   $0x0,0xc58
 8ea:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f0:	8b 00                	mov    (%eax),%eax
 8f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f8:	8b 40 04             	mov    0x4(%eax),%eax
 8fb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 8fe:	77 4d                	ja     94d <malloc+0xaa>
      if(p->s.size == nunits)
 900:	8b 45 f4             	mov    -0xc(%ebp),%eax
 903:	8b 40 04             	mov    0x4(%eax),%eax
 906:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 909:	75 0c                	jne    917 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 90b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90e:	8b 10                	mov    (%eax),%edx
 910:	8b 45 f0             	mov    -0x10(%ebp),%eax
 913:	89 10                	mov    %edx,(%eax)
 915:	eb 26                	jmp    93d <malloc+0x9a>
      else {
        p->s.size -= nunits;
 917:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91a:	8b 40 04             	mov    0x4(%eax),%eax
 91d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 920:	89 c2                	mov    %eax,%edx
 922:	8b 45 f4             	mov    -0xc(%ebp),%eax
 925:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 928:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92b:	8b 40 04             	mov    0x4(%eax),%eax
 92e:	c1 e0 03             	shl    $0x3,%eax
 931:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 934:	8b 45 f4             	mov    -0xc(%ebp),%eax
 937:	8b 55 ec             	mov    -0x14(%ebp),%edx
 93a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 93d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 940:	a3 5c 0c 00 00       	mov    %eax,0xc5c
      return (void*)(p + 1);
 945:	8b 45 f4             	mov    -0xc(%ebp),%eax
 948:	83 c0 08             	add    $0x8,%eax
 94b:	eb 3b                	jmp    988 <malloc+0xe5>
    }
    if(p == freep)
 94d:	a1 5c 0c 00 00       	mov    0xc5c,%eax
 952:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 955:	75 1e                	jne    975 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 957:	83 ec 0c             	sub    $0xc,%esp
 95a:	ff 75 ec             	pushl  -0x14(%ebp)
 95d:	e8 dd fe ff ff       	call   83f <morecore>
 962:	83 c4 10             	add    $0x10,%esp
 965:	89 45 f4             	mov    %eax,-0xc(%ebp)
 968:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 96c:	75 07                	jne    975 <malloc+0xd2>
        return 0;
 96e:	b8 00 00 00 00       	mov    $0x0,%eax
 973:	eb 13                	jmp    988 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 975:	8b 45 f4             	mov    -0xc(%ebp),%eax
 978:	89 45 f0             	mov    %eax,-0x10(%ebp)
 97b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97e:	8b 00                	mov    (%eax),%eax
 980:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 983:	e9 6d ff ff ff       	jmp    8f5 <malloc+0x52>
  }
}
 988:	c9                   	leave  
 989:	c3                   	ret    
