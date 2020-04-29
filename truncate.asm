
_truncate:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fcntl.h"
#define M_ADD 0
#define M_SUBSTRACT 1
#define M_CHANGE 2

int main(int argc, char *argv[]){
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  13:	83 ec 30             	sub    $0x30,%esp
  16:	89 cb                	mov    %ecx,%ebx
    int size, mode;
    struct stat st;
    if(argc <= 3){
  18:	83 3b 03             	cmpl   $0x3,(%ebx)
  1b:	7f 17                	jg     34 <main+0x34>
        printf(1, "Need more than 2 argument\n");
  1d:	83 ec 08             	sub    $0x8,%esp
  20:	68 ba 09 00 00       	push   $0x9ba
  25:	6a 01                	push   $0x1
  27:	e8 c7 05 00 00       	call   5f3 <printf>
  2c:	83 c4 10             	add    $0x10,%esp
        exit();
  2f:	e8 43 04 00 00       	call   477 <exit>
    }

    if(strcmp("-s",argv[1]) == 0){
  34:	8b 43 04             	mov    0x4(%ebx),%eax
  37:	83 c0 04             	add    $0x4,%eax
  3a:	8b 00                	mov    (%eax),%eax
  3c:	83 ec 08             	sub    $0x8,%esp
  3f:	50                   	push   %eax
  40:	68 d5 09 00 00       	push   $0x9d5
  45:	e8 0c 02 00 00       	call   256 <strcmp>
  4a:	83 c4 10             	add    $0x10,%esp
  4d:	85 c0                	test   %eax,%eax
  4f:	0f 85 a2 01 00 00    	jne    1f7 <main+0x1f7>
        char * charsize = argv[2];
  55:	8b 43 04             	mov    0x4(%ebx),%eax
  58:	8b 40 08             	mov    0x8(%eax),%eax
  5b:	89 45 ec             	mov    %eax,-0x14(%ebp)
        char * temp;
        int multiplier = 1;
  5e:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
        if((temp = strchr(argv[2],'+')) != NULL){
  65:	8b 43 04             	mov    0x4(%ebx),%eax
  68:	83 c0 08             	add    $0x8,%eax
  6b:	8b 00                	mov    (%eax),%eax
  6d:	83 ec 08             	sub    $0x8,%esp
  70:	6a 2b                	push   $0x2b
  72:	50                   	push   %eax
  73:	e8 6a 02 00 00       	call   2e2 <strchr>
  78:	83 c4 10             	add    $0x10,%esp
  7b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  7e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  82:	74 0d                	je     91 <main+0x91>
            charsize = charsize + 1;
  84:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
            mode = M_ADD;
  88:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8f:	eb 33                	jmp    c4 <main+0xc4>
        }else if( (temp = strchr(argv[2],'-')) != NULL){
  91:	8b 43 04             	mov    0x4(%ebx),%eax
  94:	83 c0 08             	add    $0x8,%eax
  97:	8b 00                	mov    (%eax),%eax
  99:	83 ec 08             	sub    $0x8,%esp
  9c:	6a 2d                	push   $0x2d
  9e:	50                   	push   %eax
  9f:	e8 3e 02 00 00       	call   2e2 <strchr>
  a4:	83 c4 10             	add    $0x10,%esp
  a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  aa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  ae:	74 0d                	je     bd <main+0xbd>
            charsize = charsize + 1;
  b0:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
            mode = M_SUBSTRACT;
  b4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  bb:	eb 07                	jmp    c4 <main+0xc4>
        }else{
            mode = M_CHANGE;
  bd:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
        }
        if((temp = strchr(charsize,'K')) != NULL){
  c4:	83 ec 08             	sub    $0x8,%esp
  c7:	6a 4b                	push   $0x4b
  c9:	ff 75 ec             	pushl  -0x14(%ebp)
  cc:	e8 11 02 00 00       	call   2e2 <strchr>
  d1:	83 c4 10             	add    $0x10,%esp
  d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  db:	74 0c                	je     e9 <main+0xe9>
            *temp = '\0';
  dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  e0:	c6 00 00             	movb   $0x0,(%eax)
            multiplier *= 1024;
  e3:	c1 65 e8 0a          	shll   $0xa,-0x18(%ebp)
  e7:	eb 48                	jmp    131 <main+0x131>
        }
        else if( (temp = strchr(charsize,'M')) != NULL ){
  e9:	83 ec 08             	sub    $0x8,%esp
  ec:	6a 4d                	push   $0x4d
  ee:	ff 75 ec             	pushl  -0x14(%ebp)
  f1:	e8 ec 01 00 00       	call   2e2 <strchr>
  f6:	83 c4 10             	add    $0x10,%esp
  f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  fc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 100:	74 0c                	je     10e <main+0x10e>
            *temp = '\0';
 102:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 105:	c6 00 00             	movb   $0x0,(%eax)
            multiplier *= 1024 * 1024;
 108:	c1 65 e8 14          	shll   $0x14,-0x18(%ebp)
 10c:	eb 23                	jmp    131 <main+0x131>
        }
        else if( (temp = strchr(charsize,'G')) != NULL ){
 10e:	83 ec 08             	sub    $0x8,%esp
 111:	6a 47                	push   $0x47
 113:	ff 75 ec             	pushl  -0x14(%ebp)
 116:	e8 c7 01 00 00       	call   2e2 <strchr>
 11b:	83 c4 10             	add    $0x10,%esp
 11e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 121:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 125:	74 0a                	je     131 <main+0x131>
            *temp = '\0';
 127:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 12a:	c6 00 00             	movb   $0x0,(%eax)
            multiplier *= 1024 * 1024 * 1024;
 12d:	c1 65 e8 1e          	shll   $0x1e,-0x18(%ebp)
        }

        if( stat(argv[3],&st) < 0){
 131:	8b 43 04             	mov    0x4(%ebx),%eax
 134:	83 c0 0c             	add    $0xc,%eax
 137:	8b 00                	mov    (%eax),%eax
 139:	83 ec 08             	sub    $0x8,%esp
 13c:	8d 55 d0             	lea    -0x30(%ebp),%edx
 13f:	52                   	push   %edx
 140:	50                   	push   %eax
 141:	e8 46 02 00 00       	call   38c <stat>
 146:	83 c4 10             	add    $0x10,%esp
 149:	85 c0                	test   %eax,%eax
 14b:	79 20                	jns    16d <main+0x16d>
            printf(1, "cannot open path %s",argv[3]);
 14d:	8b 43 04             	mov    0x4(%ebx),%eax
 150:	83 c0 0c             	add    $0xc,%eax
 153:	8b 00                	mov    (%eax),%eax
 155:	83 ec 04             	sub    $0x4,%esp
 158:	50                   	push   %eax
 159:	68 d8 09 00 00       	push   $0x9d8
 15e:	6a 01                	push   $0x1
 160:	e8 8e 04 00 00       	call   5f3 <printf>
 165:	83 c4 10             	add    $0x10,%esp
            exit();
 168:	e8 0a 03 00 00       	call   477 <exit>
        }
        size = st.size;
 16d:	8b 45 e0             	mov    -0x20(%ebp),%eax
 170:	89 45 f4             	mov    %eax,-0xc(%ebp)
        switch (mode)
 173:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 177:	74 4f                	je     1c8 <main+0x1c8>
 179:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 17d:	7f 63                	jg     1e2 <main+0x1e2>
 17f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 183:	74 08                	je     18d <main+0x18d>
 185:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
 189:	74 19                	je     1a4 <main+0x1a4>
 18b:	eb 55                	jmp    1e2 <main+0x1e2>
        {
            case M_ADD:
                size += (atoi(charsize) * multiplier);
 18d:	83 ec 0c             	sub    $0xc,%esp
 190:	ff 75 ec             	pushl  -0x14(%ebp)
 193:	e8 45 02 00 00       	call   3dd <atoi>
 198:	83 c4 10             	add    $0x10,%esp
 19b:	0f af 45 e8          	imul   -0x18(%ebp),%eax
 19f:	01 45 f4             	add    %eax,-0xc(%ebp)
                break;
 1a2:	eb 3e                	jmp    1e2 <main+0x1e2>
            
            case M_SUBSTRACT:
                size -= (atoi(charsize) * multiplier);
 1a4:	83 ec 0c             	sub    $0xc,%esp
 1a7:	ff 75 ec             	pushl  -0x14(%ebp)
 1aa:	e8 2e 02 00 00       	call   3dd <atoi>
 1af:	83 c4 10             	add    $0x10,%esp
 1b2:	0f af 45 e8          	imul   -0x18(%ebp),%eax
 1b6:	29 45 f4             	sub    %eax,-0xc(%ebp)
                if(size < 0) size = 0;
 1b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1bd:	79 22                	jns    1e1 <main+0x1e1>
 1bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
                break;
 1c6:	eb 19                	jmp    1e1 <main+0x1e1>
            
            case M_CHANGE:
                size = (atoi(charsize) * multiplier);
 1c8:	83 ec 0c             	sub    $0xc,%esp
 1cb:	ff 75 ec             	pushl  -0x14(%ebp)
 1ce:	e8 0a 02 00 00       	call   3dd <atoi>
 1d3:	83 c4 10             	add    $0x10,%esp
 1d6:	8b 55 e8             	mov    -0x18(%ebp),%edx
 1d9:	0f af c2             	imul   %edx,%eax
 1dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
                break;
 1df:	eb 01                	jmp    1e2 <main+0x1e2>
                break;
 1e1:	90                   	nop
        }

        printf(1,"size = %d\n",size);
 1e2:	83 ec 04             	sub    $0x4,%esp
 1e5:	ff 75 f4             	pushl  -0xc(%ebp)
 1e8:	68 ec 09 00 00       	push   $0x9ec
 1ed:	6a 01                	push   $0x1
 1ef:	e8 ff 03 00 00       	call   5f3 <printf>
 1f4:	83 c4 10             	add    $0x10,%esp

    }
    exit();
 1f7:	e8 7b 02 00 00       	call   477 <exit>

000001fc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1fc:	55                   	push   %ebp
 1fd:	89 e5                	mov    %esp,%ebp
 1ff:	57                   	push   %edi
 200:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 201:	8b 4d 08             	mov    0x8(%ebp),%ecx
 204:	8b 55 10             	mov    0x10(%ebp),%edx
 207:	8b 45 0c             	mov    0xc(%ebp),%eax
 20a:	89 cb                	mov    %ecx,%ebx
 20c:	89 df                	mov    %ebx,%edi
 20e:	89 d1                	mov    %edx,%ecx
 210:	fc                   	cld    
 211:	f3 aa                	rep stos %al,%es:(%edi)
 213:	89 ca                	mov    %ecx,%edx
 215:	89 fb                	mov    %edi,%ebx
 217:	89 5d 08             	mov    %ebx,0x8(%ebp)
 21a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 21d:	90                   	nop
 21e:	5b                   	pop    %ebx
 21f:	5f                   	pop    %edi
 220:	5d                   	pop    %ebp
 221:	c3                   	ret    

00000222 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 222:	f3 0f 1e fb          	endbr32 
 226:	55                   	push   %ebp
 227:	89 e5                	mov    %esp,%ebp
 229:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 22c:	8b 45 08             	mov    0x8(%ebp),%eax
 22f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 232:	90                   	nop
 233:	8b 55 0c             	mov    0xc(%ebp),%edx
 236:	8d 42 01             	lea    0x1(%edx),%eax
 239:	89 45 0c             	mov    %eax,0xc(%ebp)
 23c:	8b 45 08             	mov    0x8(%ebp),%eax
 23f:	8d 48 01             	lea    0x1(%eax),%ecx
 242:	89 4d 08             	mov    %ecx,0x8(%ebp)
 245:	0f b6 12             	movzbl (%edx),%edx
 248:	88 10                	mov    %dl,(%eax)
 24a:	0f b6 00             	movzbl (%eax),%eax
 24d:	84 c0                	test   %al,%al
 24f:	75 e2                	jne    233 <strcpy+0x11>
    ;
  return os;
 251:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 254:	c9                   	leave  
 255:	c3                   	ret    

00000256 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 256:	f3 0f 1e fb          	endbr32 
 25a:	55                   	push   %ebp
 25b:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 25d:	eb 08                	jmp    267 <strcmp+0x11>
    p++, q++;
 25f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 263:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 267:	8b 45 08             	mov    0x8(%ebp),%eax
 26a:	0f b6 00             	movzbl (%eax),%eax
 26d:	84 c0                	test   %al,%al
 26f:	74 10                	je     281 <strcmp+0x2b>
 271:	8b 45 08             	mov    0x8(%ebp),%eax
 274:	0f b6 10             	movzbl (%eax),%edx
 277:	8b 45 0c             	mov    0xc(%ebp),%eax
 27a:	0f b6 00             	movzbl (%eax),%eax
 27d:	38 c2                	cmp    %al,%dl
 27f:	74 de                	je     25f <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
 281:	8b 45 08             	mov    0x8(%ebp),%eax
 284:	0f b6 00             	movzbl (%eax),%eax
 287:	0f b6 d0             	movzbl %al,%edx
 28a:	8b 45 0c             	mov    0xc(%ebp),%eax
 28d:	0f b6 00             	movzbl (%eax),%eax
 290:	0f b6 c0             	movzbl %al,%eax
 293:	29 c2                	sub    %eax,%edx
 295:	89 d0                	mov    %edx,%eax
}
 297:	5d                   	pop    %ebp
 298:	c3                   	ret    

00000299 <strlen>:

uint
strlen(char *s)
{
 299:	f3 0f 1e fb          	endbr32 
 29d:	55                   	push   %ebp
 29e:	89 e5                	mov    %esp,%ebp
 2a0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 2a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2aa:	eb 04                	jmp    2b0 <strlen+0x17>
 2ac:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	01 d0                	add    %edx,%eax
 2b8:	0f b6 00             	movzbl (%eax),%eax
 2bb:	84 c0                	test   %al,%al
 2bd:	75 ed                	jne    2ac <strlen+0x13>
    ;
  return n;
 2bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2c2:	c9                   	leave  
 2c3:	c3                   	ret    

000002c4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2c4:	f3 0f 1e fb          	endbr32 
 2c8:	55                   	push   %ebp
 2c9:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 2cb:	8b 45 10             	mov    0x10(%ebp),%eax
 2ce:	50                   	push   %eax
 2cf:	ff 75 0c             	pushl  0xc(%ebp)
 2d2:	ff 75 08             	pushl  0x8(%ebp)
 2d5:	e8 22 ff ff ff       	call   1fc <stosb>
 2da:	83 c4 0c             	add    $0xc,%esp
  return dst;
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2e0:	c9                   	leave  
 2e1:	c3                   	ret    

000002e2 <strchr>:

char*
strchr(const char *s, char c)
{
 2e2:	f3 0f 1e fb          	endbr32 
 2e6:	55                   	push   %ebp
 2e7:	89 e5                	mov    %esp,%ebp
 2e9:	83 ec 04             	sub    $0x4,%esp
 2ec:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ef:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2f2:	eb 14                	jmp    308 <strchr+0x26>
    if(*s == c)
 2f4:	8b 45 08             	mov    0x8(%ebp),%eax
 2f7:	0f b6 00             	movzbl (%eax),%eax
 2fa:	38 45 fc             	cmp    %al,-0x4(%ebp)
 2fd:	75 05                	jne    304 <strchr+0x22>
      return (char*)s;
 2ff:	8b 45 08             	mov    0x8(%ebp),%eax
 302:	eb 13                	jmp    317 <strchr+0x35>
  for(; *s; s++)
 304:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 308:	8b 45 08             	mov    0x8(%ebp),%eax
 30b:	0f b6 00             	movzbl (%eax),%eax
 30e:	84 c0                	test   %al,%al
 310:	75 e2                	jne    2f4 <strchr+0x12>
  return 0;
 312:	b8 00 00 00 00       	mov    $0x0,%eax
}
 317:	c9                   	leave  
 318:	c3                   	ret    

00000319 <gets>:

char*
gets(char *buf, int max)
{
 319:	f3 0f 1e fb          	endbr32 
 31d:	55                   	push   %ebp
 31e:	89 e5                	mov    %esp,%ebp
 320:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 323:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 32a:	eb 42                	jmp    36e <gets+0x55>
    cc = read(0, &c, 1);
 32c:	83 ec 04             	sub    $0x4,%esp
 32f:	6a 01                	push   $0x1
 331:	8d 45 ef             	lea    -0x11(%ebp),%eax
 334:	50                   	push   %eax
 335:	6a 00                	push   $0x0
 337:	e8 53 01 00 00       	call   48f <read>
 33c:	83 c4 10             	add    $0x10,%esp
 33f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 342:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 346:	7e 33                	jle    37b <gets+0x62>
      break;
    buf[i++] = c;
 348:	8b 45 f4             	mov    -0xc(%ebp),%eax
 34b:	8d 50 01             	lea    0x1(%eax),%edx
 34e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 351:	89 c2                	mov    %eax,%edx
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	01 c2                	add    %eax,%edx
 358:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 35c:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 35e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 362:	3c 0a                	cmp    $0xa,%al
 364:	74 16                	je     37c <gets+0x63>
 366:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 36a:	3c 0d                	cmp    $0xd,%al
 36c:	74 0e                	je     37c <gets+0x63>
  for(i=0; i+1 < max; ){
 36e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 371:	83 c0 01             	add    $0x1,%eax
 374:	39 45 0c             	cmp    %eax,0xc(%ebp)
 377:	7f b3                	jg     32c <gets+0x13>
 379:	eb 01                	jmp    37c <gets+0x63>
      break;
 37b:	90                   	nop
      break;
  }
  buf[i] = '\0';
 37c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 37f:	8b 45 08             	mov    0x8(%ebp),%eax
 382:	01 d0                	add    %edx,%eax
 384:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 387:	8b 45 08             	mov    0x8(%ebp),%eax
}
 38a:	c9                   	leave  
 38b:	c3                   	ret    

0000038c <stat>:

int
stat(char *n, struct stat *st)
{
 38c:	f3 0f 1e fb          	endbr32 
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 396:	83 ec 08             	sub    $0x8,%esp
 399:	6a 00                	push   $0x0
 39b:	ff 75 08             	pushl  0x8(%ebp)
 39e:	e8 14 01 00 00       	call   4b7 <open>
 3a3:	83 c4 10             	add    $0x10,%esp
 3a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 3a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3ad:	79 07                	jns    3b6 <stat+0x2a>
    return -1;
 3af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3b4:	eb 25                	jmp    3db <stat+0x4f>
  r = fstat(fd, st);
 3b6:	83 ec 08             	sub    $0x8,%esp
 3b9:	ff 75 0c             	pushl  0xc(%ebp)
 3bc:	ff 75 f4             	pushl  -0xc(%ebp)
 3bf:	e8 0b 01 00 00       	call   4cf <fstat>
 3c4:	83 c4 10             	add    $0x10,%esp
 3c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 3ca:	83 ec 0c             	sub    $0xc,%esp
 3cd:	ff 75 f4             	pushl  -0xc(%ebp)
 3d0:	e8 ca 00 00 00       	call   49f <close>
 3d5:	83 c4 10             	add    $0x10,%esp
  return r;
 3d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 3db:	c9                   	leave  
 3dc:	c3                   	ret    

000003dd <atoi>:

int
atoi(const char *s)
{
 3dd:	f3 0f 1e fb          	endbr32 
 3e1:	55                   	push   %ebp
 3e2:	89 e5                	mov    %esp,%ebp
 3e4:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 3e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3ee:	eb 25                	jmp    415 <atoi+0x38>
    n = n*10 + *s++ - '0';
 3f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3f3:	89 d0                	mov    %edx,%eax
 3f5:	c1 e0 02             	shl    $0x2,%eax
 3f8:	01 d0                	add    %edx,%eax
 3fa:	01 c0                	add    %eax,%eax
 3fc:	89 c1                	mov    %eax,%ecx
 3fe:	8b 45 08             	mov    0x8(%ebp),%eax
 401:	8d 50 01             	lea    0x1(%eax),%edx
 404:	89 55 08             	mov    %edx,0x8(%ebp)
 407:	0f b6 00             	movzbl (%eax),%eax
 40a:	0f be c0             	movsbl %al,%eax
 40d:	01 c8                	add    %ecx,%eax
 40f:	83 e8 30             	sub    $0x30,%eax
 412:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 415:	8b 45 08             	mov    0x8(%ebp),%eax
 418:	0f b6 00             	movzbl (%eax),%eax
 41b:	3c 2f                	cmp    $0x2f,%al
 41d:	7e 0a                	jle    429 <atoi+0x4c>
 41f:	8b 45 08             	mov    0x8(%ebp),%eax
 422:	0f b6 00             	movzbl (%eax),%eax
 425:	3c 39                	cmp    $0x39,%al
 427:	7e c7                	jle    3f0 <atoi+0x13>
  return n;
 429:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 42c:	c9                   	leave  
 42d:	c3                   	ret    

0000042e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 42e:	f3 0f 1e fb          	endbr32 
 432:	55                   	push   %ebp
 433:	89 e5                	mov    %esp,%ebp
 435:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 438:	8b 45 08             	mov    0x8(%ebp),%eax
 43b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 43e:	8b 45 0c             	mov    0xc(%ebp),%eax
 441:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 444:	eb 17                	jmp    45d <memmove+0x2f>
    *dst++ = *src++;
 446:	8b 55 f8             	mov    -0x8(%ebp),%edx
 449:	8d 42 01             	lea    0x1(%edx),%eax
 44c:	89 45 f8             	mov    %eax,-0x8(%ebp)
 44f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 452:	8d 48 01             	lea    0x1(%eax),%ecx
 455:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 458:	0f b6 12             	movzbl (%edx),%edx
 45b:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 45d:	8b 45 10             	mov    0x10(%ebp),%eax
 460:	8d 50 ff             	lea    -0x1(%eax),%edx
 463:	89 55 10             	mov    %edx,0x10(%ebp)
 466:	85 c0                	test   %eax,%eax
 468:	7f dc                	jg     446 <memmove+0x18>
  return vdst;
 46a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 46d:	c9                   	leave  
 46e:	c3                   	ret    

0000046f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 46f:	b8 01 00 00 00       	mov    $0x1,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret    

00000477 <exit>:
SYSCALL(exit)
 477:	b8 02 00 00 00       	mov    $0x2,%eax
 47c:	cd 40                	int    $0x40
 47e:	c3                   	ret    

0000047f <wait>:
SYSCALL(wait)
 47f:	b8 03 00 00 00       	mov    $0x3,%eax
 484:	cd 40                	int    $0x40
 486:	c3                   	ret    

00000487 <pipe>:
SYSCALL(pipe)
 487:	b8 04 00 00 00       	mov    $0x4,%eax
 48c:	cd 40                	int    $0x40
 48e:	c3                   	ret    

0000048f <read>:
SYSCALL(read)
 48f:	b8 05 00 00 00       	mov    $0x5,%eax
 494:	cd 40                	int    $0x40
 496:	c3                   	ret    

00000497 <write>:
SYSCALL(write)
 497:	b8 10 00 00 00       	mov    $0x10,%eax
 49c:	cd 40                	int    $0x40
 49e:	c3                   	ret    

0000049f <close>:
SYSCALL(close)
 49f:	b8 15 00 00 00       	mov    $0x15,%eax
 4a4:	cd 40                	int    $0x40
 4a6:	c3                   	ret    

000004a7 <kill>:
SYSCALL(kill)
 4a7:	b8 06 00 00 00       	mov    $0x6,%eax
 4ac:	cd 40                	int    $0x40
 4ae:	c3                   	ret    

000004af <exec>:
SYSCALL(exec)
 4af:	b8 07 00 00 00       	mov    $0x7,%eax
 4b4:	cd 40                	int    $0x40
 4b6:	c3                   	ret    

000004b7 <open>:
SYSCALL(open)
 4b7:	b8 0f 00 00 00       	mov    $0xf,%eax
 4bc:	cd 40                	int    $0x40
 4be:	c3                   	ret    

000004bf <mknod>:
SYSCALL(mknod)
 4bf:	b8 11 00 00 00       	mov    $0x11,%eax
 4c4:	cd 40                	int    $0x40
 4c6:	c3                   	ret    

000004c7 <unlink>:
SYSCALL(unlink)
 4c7:	b8 12 00 00 00       	mov    $0x12,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret    

000004cf <fstat>:
SYSCALL(fstat)
 4cf:	b8 08 00 00 00       	mov    $0x8,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret    

000004d7 <link>:
SYSCALL(link)
 4d7:	b8 13 00 00 00       	mov    $0x13,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret    

000004df <mkdir>:
SYSCALL(mkdir)
 4df:	b8 14 00 00 00       	mov    $0x14,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret    

000004e7 <chdir>:
SYSCALL(chdir)
 4e7:	b8 09 00 00 00       	mov    $0x9,%eax
 4ec:	cd 40                	int    $0x40
 4ee:	c3                   	ret    

000004ef <dup>:
SYSCALL(dup)
 4ef:	b8 0a 00 00 00       	mov    $0xa,%eax
 4f4:	cd 40                	int    $0x40
 4f6:	c3                   	ret    

000004f7 <getpid>:
SYSCALL(getpid)
 4f7:	b8 0b 00 00 00       	mov    $0xb,%eax
 4fc:	cd 40                	int    $0x40
 4fe:	c3                   	ret    

000004ff <sbrk>:
SYSCALL(sbrk)
 4ff:	b8 0c 00 00 00       	mov    $0xc,%eax
 504:	cd 40                	int    $0x40
 506:	c3                   	ret    

00000507 <sleep>:
SYSCALL(sleep)
 507:	b8 0d 00 00 00       	mov    $0xd,%eax
 50c:	cd 40                	int    $0x40
 50e:	c3                   	ret    

0000050f <uptime>:
SYSCALL(uptime)
 50f:	b8 0e 00 00 00       	mov    $0xe,%eax
 514:	cd 40                	int    $0x40
 516:	c3                   	ret    

00000517 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 517:	f3 0f 1e fb          	endbr32 
 51b:	55                   	push   %ebp
 51c:	89 e5                	mov    %esp,%ebp
 51e:	83 ec 18             	sub    $0x18,%esp
 521:	8b 45 0c             	mov    0xc(%ebp),%eax
 524:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 527:	83 ec 04             	sub    $0x4,%esp
 52a:	6a 01                	push   $0x1
 52c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 52f:	50                   	push   %eax
 530:	ff 75 08             	pushl  0x8(%ebp)
 533:	e8 5f ff ff ff       	call   497 <write>
 538:	83 c4 10             	add    $0x10,%esp
}
 53b:	90                   	nop
 53c:	c9                   	leave  
 53d:	c3                   	ret    

0000053e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 53e:	f3 0f 1e fb          	endbr32 
 542:	55                   	push   %ebp
 543:	89 e5                	mov    %esp,%ebp
 545:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 548:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 54f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 553:	74 17                	je     56c <printint+0x2e>
 555:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 559:	79 11                	jns    56c <printint+0x2e>
    neg = 1;
 55b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 562:	8b 45 0c             	mov    0xc(%ebp),%eax
 565:	f7 d8                	neg    %eax
 567:	89 45 ec             	mov    %eax,-0x14(%ebp)
 56a:	eb 06                	jmp    572 <printint+0x34>
  } else {
    x = xx;
 56c:	8b 45 0c             	mov    0xc(%ebp),%eax
 56f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 572:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 579:	8b 4d 10             	mov    0x10(%ebp),%ecx
 57c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 57f:	ba 00 00 00 00       	mov    $0x0,%edx
 584:	f7 f1                	div    %ecx
 586:	89 d1                	mov    %edx,%ecx
 588:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58b:	8d 50 01             	lea    0x1(%eax),%edx
 58e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 591:	0f b6 91 48 0c 00 00 	movzbl 0xc48(%ecx),%edx
 598:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 59c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 59f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5a2:	ba 00 00 00 00       	mov    $0x0,%edx
 5a7:	f7 f1                	div    %ecx
 5a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5ac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5b0:	75 c7                	jne    579 <printint+0x3b>
  if(neg)
 5b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5b6:	74 2d                	je     5e5 <printint+0xa7>
    buf[i++] = '-';
 5b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5bb:	8d 50 01             	lea    0x1(%eax),%edx
 5be:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5c1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5c6:	eb 1d                	jmp    5e5 <printint+0xa7>
    putc(fd, buf[i]);
 5c8:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ce:	01 d0                	add    %edx,%eax
 5d0:	0f b6 00             	movzbl (%eax),%eax
 5d3:	0f be c0             	movsbl %al,%eax
 5d6:	83 ec 08             	sub    $0x8,%esp
 5d9:	50                   	push   %eax
 5da:	ff 75 08             	pushl  0x8(%ebp)
 5dd:	e8 35 ff ff ff       	call   517 <putc>
 5e2:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5e5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ed:	79 d9                	jns    5c8 <printint+0x8a>
}
 5ef:	90                   	nop
 5f0:	90                   	nop
 5f1:	c9                   	leave  
 5f2:	c3                   	ret    

000005f3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5f3:	f3 0f 1e fb          	endbr32 
 5f7:	55                   	push   %ebp
 5f8:	89 e5                	mov    %esp,%ebp
 5fa:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5fd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 604:	8d 45 0c             	lea    0xc(%ebp),%eax
 607:	83 c0 04             	add    $0x4,%eax
 60a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 60d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 614:	e9 59 01 00 00       	jmp    772 <printf+0x17f>
    c = fmt[i] & 0xff;
 619:	8b 55 0c             	mov    0xc(%ebp),%edx
 61c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61f:	01 d0                	add    %edx,%eax
 621:	0f b6 00             	movzbl (%eax),%eax
 624:	0f be c0             	movsbl %al,%eax
 627:	25 ff 00 00 00       	and    $0xff,%eax
 62c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 62f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 633:	75 2c                	jne    661 <printf+0x6e>
      if(c == '%'){
 635:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 639:	75 0c                	jne    647 <printf+0x54>
        state = '%';
 63b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 642:	e9 27 01 00 00       	jmp    76e <printf+0x17b>
      } else {
        putc(fd, c);
 647:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64a:	0f be c0             	movsbl %al,%eax
 64d:	83 ec 08             	sub    $0x8,%esp
 650:	50                   	push   %eax
 651:	ff 75 08             	pushl  0x8(%ebp)
 654:	e8 be fe ff ff       	call   517 <putc>
 659:	83 c4 10             	add    $0x10,%esp
 65c:	e9 0d 01 00 00       	jmp    76e <printf+0x17b>
      }
    } else if(state == '%'){
 661:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 665:	0f 85 03 01 00 00    	jne    76e <printf+0x17b>
      if(c == 'd'){
 66b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 66f:	75 1e                	jne    68f <printf+0x9c>
        printint(fd, *ap, 10, 1);
 671:	8b 45 e8             	mov    -0x18(%ebp),%eax
 674:	8b 00                	mov    (%eax),%eax
 676:	6a 01                	push   $0x1
 678:	6a 0a                	push   $0xa
 67a:	50                   	push   %eax
 67b:	ff 75 08             	pushl  0x8(%ebp)
 67e:	e8 bb fe ff ff       	call   53e <printint>
 683:	83 c4 10             	add    $0x10,%esp
        ap++;
 686:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68a:	e9 d8 00 00 00       	jmp    767 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 68f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 693:	74 06                	je     69b <printf+0xa8>
 695:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 699:	75 1e                	jne    6b9 <printf+0xc6>
        printint(fd, *ap, 16, 0);
 69b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 69e:	8b 00                	mov    (%eax),%eax
 6a0:	6a 00                	push   $0x0
 6a2:	6a 10                	push   $0x10
 6a4:	50                   	push   %eax
 6a5:	ff 75 08             	pushl  0x8(%ebp)
 6a8:	e8 91 fe ff ff       	call   53e <printint>
 6ad:	83 c4 10             	add    $0x10,%esp
        ap++;
 6b0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6b4:	e9 ae 00 00 00       	jmp    767 <printf+0x174>
      } else if(c == 's'){
 6b9:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6bd:	75 43                	jne    702 <printf+0x10f>
        s = (char*)*ap;
 6bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6c2:	8b 00                	mov    (%eax),%eax
 6c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6cf:	75 25                	jne    6f6 <printf+0x103>
          s = "(null)";
 6d1:	c7 45 f4 f7 09 00 00 	movl   $0x9f7,-0xc(%ebp)
        while(*s != 0){
 6d8:	eb 1c                	jmp    6f6 <printf+0x103>
          putc(fd, *s);
 6da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6dd:	0f b6 00             	movzbl (%eax),%eax
 6e0:	0f be c0             	movsbl %al,%eax
 6e3:	83 ec 08             	sub    $0x8,%esp
 6e6:	50                   	push   %eax
 6e7:	ff 75 08             	pushl  0x8(%ebp)
 6ea:	e8 28 fe ff ff       	call   517 <putc>
 6ef:	83 c4 10             	add    $0x10,%esp
          s++;
 6f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f9:	0f b6 00             	movzbl (%eax),%eax
 6fc:	84 c0                	test   %al,%al
 6fe:	75 da                	jne    6da <printf+0xe7>
 700:	eb 65                	jmp    767 <printf+0x174>
        }
      } else if(c == 'c'){
 702:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 706:	75 1d                	jne    725 <printf+0x132>
        putc(fd, *ap);
 708:	8b 45 e8             	mov    -0x18(%ebp),%eax
 70b:	8b 00                	mov    (%eax),%eax
 70d:	0f be c0             	movsbl %al,%eax
 710:	83 ec 08             	sub    $0x8,%esp
 713:	50                   	push   %eax
 714:	ff 75 08             	pushl  0x8(%ebp)
 717:	e8 fb fd ff ff       	call   517 <putc>
 71c:	83 c4 10             	add    $0x10,%esp
        ap++;
 71f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 723:	eb 42                	jmp    767 <printf+0x174>
      } else if(c == '%'){
 725:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 729:	75 17                	jne    742 <printf+0x14f>
        putc(fd, c);
 72b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 72e:	0f be c0             	movsbl %al,%eax
 731:	83 ec 08             	sub    $0x8,%esp
 734:	50                   	push   %eax
 735:	ff 75 08             	pushl  0x8(%ebp)
 738:	e8 da fd ff ff       	call   517 <putc>
 73d:	83 c4 10             	add    $0x10,%esp
 740:	eb 25                	jmp    767 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 742:	83 ec 08             	sub    $0x8,%esp
 745:	6a 25                	push   $0x25
 747:	ff 75 08             	pushl  0x8(%ebp)
 74a:	e8 c8 fd ff ff       	call   517 <putc>
 74f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 752:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 755:	0f be c0             	movsbl %al,%eax
 758:	83 ec 08             	sub    $0x8,%esp
 75b:	50                   	push   %eax
 75c:	ff 75 08             	pushl  0x8(%ebp)
 75f:	e8 b3 fd ff ff       	call   517 <putc>
 764:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 767:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 76e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 772:	8b 55 0c             	mov    0xc(%ebp),%edx
 775:	8b 45 f0             	mov    -0x10(%ebp),%eax
 778:	01 d0                	add    %edx,%eax
 77a:	0f b6 00             	movzbl (%eax),%eax
 77d:	84 c0                	test   %al,%al
 77f:	0f 85 94 fe ff ff    	jne    619 <printf+0x26>
    }
  }
}
 785:	90                   	nop
 786:	90                   	nop
 787:	c9                   	leave  
 788:	c3                   	ret    

00000789 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 789:	f3 0f 1e fb          	endbr32 
 78d:	55                   	push   %ebp
 78e:	89 e5                	mov    %esp,%ebp
 790:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 793:	8b 45 08             	mov    0x8(%ebp),%eax
 796:	83 e8 08             	sub    $0x8,%eax
 799:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79c:	a1 64 0c 00 00       	mov    0xc64,%eax
 7a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7a4:	eb 24                	jmp    7ca <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a9:	8b 00                	mov    (%eax),%eax
 7ab:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 7ae:	72 12                	jb     7c2 <free+0x39>
 7b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7b6:	77 24                	ja     7dc <free+0x53>
 7b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bb:	8b 00                	mov    (%eax),%eax
 7bd:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7c0:	72 1a                	jb     7dc <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c5:	8b 00                	mov    (%eax),%eax
 7c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7cd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7d0:	76 d4                	jbe    7a6 <free+0x1d>
 7d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d5:	8b 00                	mov    (%eax),%eax
 7d7:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7da:	73 ca                	jae    7a6 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7df:	8b 40 04             	mov    0x4(%eax),%eax
 7e2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ec:	01 c2                	add    %eax,%edx
 7ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f1:	8b 00                	mov    (%eax),%eax
 7f3:	39 c2                	cmp    %eax,%edx
 7f5:	75 24                	jne    81b <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 7f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7fa:	8b 50 04             	mov    0x4(%eax),%edx
 7fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 800:	8b 00                	mov    (%eax),%eax
 802:	8b 40 04             	mov    0x4(%eax),%eax
 805:	01 c2                	add    %eax,%edx
 807:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 80d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 810:	8b 00                	mov    (%eax),%eax
 812:	8b 10                	mov    (%eax),%edx
 814:	8b 45 f8             	mov    -0x8(%ebp),%eax
 817:	89 10                	mov    %edx,(%eax)
 819:	eb 0a                	jmp    825 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 81b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81e:	8b 10                	mov    (%eax),%edx
 820:	8b 45 f8             	mov    -0x8(%ebp),%eax
 823:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 825:	8b 45 fc             	mov    -0x4(%ebp),%eax
 828:	8b 40 04             	mov    0x4(%eax),%eax
 82b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 832:	8b 45 fc             	mov    -0x4(%ebp),%eax
 835:	01 d0                	add    %edx,%eax
 837:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 83a:	75 20                	jne    85c <free+0xd3>
    p->s.size += bp->s.size;
 83c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83f:	8b 50 04             	mov    0x4(%eax),%edx
 842:	8b 45 f8             	mov    -0x8(%ebp),%eax
 845:	8b 40 04             	mov    0x4(%eax),%eax
 848:	01 c2                	add    %eax,%edx
 84a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 850:	8b 45 f8             	mov    -0x8(%ebp),%eax
 853:	8b 10                	mov    (%eax),%edx
 855:	8b 45 fc             	mov    -0x4(%ebp),%eax
 858:	89 10                	mov    %edx,(%eax)
 85a:	eb 08                	jmp    864 <free+0xdb>
  } else
    p->s.ptr = bp;
 85c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 862:	89 10                	mov    %edx,(%eax)
  freep = p;
 864:	8b 45 fc             	mov    -0x4(%ebp),%eax
 867:	a3 64 0c 00 00       	mov    %eax,0xc64
}
 86c:	90                   	nop
 86d:	c9                   	leave  
 86e:	c3                   	ret    

0000086f <morecore>:

static Header*
morecore(uint nu)
{
 86f:	f3 0f 1e fb          	endbr32 
 873:	55                   	push   %ebp
 874:	89 e5                	mov    %esp,%ebp
 876:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 879:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 880:	77 07                	ja     889 <morecore+0x1a>
    nu = 4096;
 882:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 889:	8b 45 08             	mov    0x8(%ebp),%eax
 88c:	c1 e0 03             	shl    $0x3,%eax
 88f:	83 ec 0c             	sub    $0xc,%esp
 892:	50                   	push   %eax
 893:	e8 67 fc ff ff       	call   4ff <sbrk>
 898:	83 c4 10             	add    $0x10,%esp
 89b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 89e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8a2:	75 07                	jne    8ab <morecore+0x3c>
    return 0;
 8a4:	b8 00 00 00 00       	mov    $0x0,%eax
 8a9:	eb 26                	jmp    8d1 <morecore+0x62>
  hp = (Header*)p;
 8ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b4:	8b 55 08             	mov    0x8(%ebp),%edx
 8b7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8bd:	83 c0 08             	add    $0x8,%eax
 8c0:	83 ec 0c             	sub    $0xc,%esp
 8c3:	50                   	push   %eax
 8c4:	e8 c0 fe ff ff       	call   789 <free>
 8c9:	83 c4 10             	add    $0x10,%esp
  return freep;
 8cc:	a1 64 0c 00 00       	mov    0xc64,%eax
}
 8d1:	c9                   	leave  
 8d2:	c3                   	ret    

000008d3 <malloc>:

void*
malloc(uint nbytes)
{
 8d3:	f3 0f 1e fb          	endbr32 
 8d7:	55                   	push   %ebp
 8d8:	89 e5                	mov    %esp,%ebp
 8da:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8dd:	8b 45 08             	mov    0x8(%ebp),%eax
 8e0:	83 c0 07             	add    $0x7,%eax
 8e3:	c1 e8 03             	shr    $0x3,%eax
 8e6:	83 c0 01             	add    $0x1,%eax
 8e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8ec:	a1 64 0c 00 00       	mov    0xc64,%eax
 8f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8f8:	75 23                	jne    91d <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 8fa:	c7 45 f0 5c 0c 00 00 	movl   $0xc5c,-0x10(%ebp)
 901:	8b 45 f0             	mov    -0x10(%ebp),%eax
 904:	a3 64 0c 00 00       	mov    %eax,0xc64
 909:	a1 64 0c 00 00       	mov    0xc64,%eax
 90e:	a3 5c 0c 00 00       	mov    %eax,0xc5c
    base.s.size = 0;
 913:	c7 05 60 0c 00 00 00 	movl   $0x0,0xc60
 91a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 91d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 920:	8b 00                	mov    (%eax),%eax
 922:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 925:	8b 45 f4             	mov    -0xc(%ebp),%eax
 928:	8b 40 04             	mov    0x4(%eax),%eax
 92b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 92e:	77 4d                	ja     97d <malloc+0xaa>
      if(p->s.size == nunits)
 930:	8b 45 f4             	mov    -0xc(%ebp),%eax
 933:	8b 40 04             	mov    0x4(%eax),%eax
 936:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 939:	75 0c                	jne    947 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 93b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93e:	8b 10                	mov    (%eax),%edx
 940:	8b 45 f0             	mov    -0x10(%ebp),%eax
 943:	89 10                	mov    %edx,(%eax)
 945:	eb 26                	jmp    96d <malloc+0x9a>
      else {
        p->s.size -= nunits;
 947:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94a:	8b 40 04             	mov    0x4(%eax),%eax
 94d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 950:	89 c2                	mov    %eax,%edx
 952:	8b 45 f4             	mov    -0xc(%ebp),%eax
 955:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 958:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95b:	8b 40 04             	mov    0x4(%eax),%eax
 95e:	c1 e0 03             	shl    $0x3,%eax
 961:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 964:	8b 45 f4             	mov    -0xc(%ebp),%eax
 967:	8b 55 ec             	mov    -0x14(%ebp),%edx
 96a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 96d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 970:	a3 64 0c 00 00       	mov    %eax,0xc64
      return (void*)(p + 1);
 975:	8b 45 f4             	mov    -0xc(%ebp),%eax
 978:	83 c0 08             	add    $0x8,%eax
 97b:	eb 3b                	jmp    9b8 <malloc+0xe5>
    }
    if(p == freep)
 97d:	a1 64 0c 00 00       	mov    0xc64,%eax
 982:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 985:	75 1e                	jne    9a5 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 987:	83 ec 0c             	sub    $0xc,%esp
 98a:	ff 75 ec             	pushl  -0x14(%ebp)
 98d:	e8 dd fe ff ff       	call   86f <morecore>
 992:	83 c4 10             	add    $0x10,%esp
 995:	89 45 f4             	mov    %eax,-0xc(%ebp)
 998:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 99c:	75 07                	jne    9a5 <malloc+0xd2>
        return 0;
 99e:	b8 00 00 00 00       	mov    $0x0,%eax
 9a3:	eb 13                	jmp    9b8 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ae:	8b 00                	mov    (%eax),%eax
 9b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9b3:	e9 6d ff ff ff       	jmp    925 <malloc+0x52>
  }
}
 9b8:	c9                   	leave  
 9b9:	c3                   	ret    
