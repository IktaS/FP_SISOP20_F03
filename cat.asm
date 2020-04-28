
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   a:	eb 15                	jmp    21 <cat+0x21>
    write(1, buf, n);
   c:	83 ec 04             	sub    $0x4,%esp
   f:	ff 75 f4             	pushl  -0xc(%ebp)
  12:	68 a0 0b 00 00       	push   $0xba0
  17:	6a 01                	push   $0x1
  19:	e8 94 03 00 00       	call   3b2 <write>
  1e:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf, sizeof(buf))) > 0)
  21:	83 ec 04             	sub    $0x4,%esp
  24:	68 00 02 00 00       	push   $0x200
  29:	68 a0 0b 00 00       	push   $0xba0
  2e:	ff 75 08             	pushl  0x8(%ebp)
  31:	e8 74 03 00 00       	call   3aa <read>
  36:	83 c4 10             	add    $0x10,%esp
  39:	89 45 f4             	mov    %eax,-0xc(%ebp)
  3c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  40:	7f ca                	jg     c <cat+0xc>
  if(n < 0){
  42:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  46:	79 17                	jns    5f <cat+0x5f>
    printf(1, "cat: read error\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 d5 08 00 00       	push   $0x8d5
  50:	6a 01                	push   $0x1
  52:	e8 b7 04 00 00       	call   50e <printf>
  57:	83 c4 10             	add    $0x10,%esp
    exit();
  5a:	e8 33 03 00 00       	call   392 <exit>
  }
}
  5f:	90                   	nop
  60:	c9                   	leave  
  61:	c3                   	ret    

00000062 <main>:

int
main(int argc, char *argv[])
{
  62:	f3 0f 1e fb          	endbr32 
  66:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  6a:	83 e4 f0             	and    $0xfffffff0,%esp
  6d:	ff 71 fc             	pushl  -0x4(%ecx)
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	51                   	push   %ecx
  75:	83 ec 10             	sub    $0x10,%esp
  78:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  7a:	83 3b 01             	cmpl   $0x1,(%ebx)
  7d:	7f 12                	jg     91 <main+0x2f>
    cat(0);
  7f:	83 ec 0c             	sub    $0xc,%esp
  82:	6a 00                	push   $0x0
  84:	e8 77 ff ff ff       	call   0 <cat>
  89:	83 c4 10             	add    $0x10,%esp
    exit();
  8c:	e8 01 03 00 00       	call   392 <exit>
  }

  for(i = 1; i < argc; i++){
  91:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  98:	eb 71                	jmp    10b <main+0xa9>
    if((fd = open(argv[i], 0)) < 0){
  9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  9d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  a4:	8b 43 04             	mov    0x4(%ebx),%eax
  a7:	01 d0                	add    %edx,%eax
  a9:	8b 00                	mov    (%eax),%eax
  ab:	83 ec 08             	sub    $0x8,%esp
  ae:	6a 00                	push   $0x0
  b0:	50                   	push   %eax
  b1:	e8 1c 03 00 00       	call   3d2 <open>
  b6:	83 c4 10             	add    $0x10,%esp
  b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  c0:	79 29                	jns    eb <main+0x89>
      printf(1, "cat: cannot open %s\n", argv[i]);
  c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  cc:	8b 43 04             	mov    0x4(%ebx),%eax
  cf:	01 d0                	add    %edx,%eax
  d1:	8b 00                	mov    (%eax),%eax
  d3:	83 ec 04             	sub    $0x4,%esp
  d6:	50                   	push   %eax
  d7:	68 e6 08 00 00       	push   $0x8e6
  dc:	6a 01                	push   $0x1
  de:	e8 2b 04 00 00       	call   50e <printf>
  e3:	83 c4 10             	add    $0x10,%esp
      exit();
  e6:	e8 a7 02 00 00       	call   392 <exit>
    }
    cat(fd);
  eb:	83 ec 0c             	sub    $0xc,%esp
  ee:	ff 75 f0             	pushl  -0x10(%ebp)
  f1:	e8 0a ff ff ff       	call   0 <cat>
  f6:	83 c4 10             	add    $0x10,%esp
    close(fd);
  f9:	83 ec 0c             	sub    $0xc,%esp
  fc:	ff 75 f0             	pushl  -0x10(%ebp)
  ff:	e8 b6 02 00 00       	call   3ba <close>
 104:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
 107:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 10b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 10e:	3b 03                	cmp    (%ebx),%eax
 110:	7c 88                	jl     9a <main+0x38>
  }
  exit();
 112:	e8 7b 02 00 00       	call   392 <exit>

00000117 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 117:	55                   	push   %ebp
 118:	89 e5                	mov    %esp,%ebp
 11a:	57                   	push   %edi
 11b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 11c:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11f:	8b 55 10             	mov    0x10(%ebp),%edx
 122:	8b 45 0c             	mov    0xc(%ebp),%eax
 125:	89 cb                	mov    %ecx,%ebx
 127:	89 df                	mov    %ebx,%edi
 129:	89 d1                	mov    %edx,%ecx
 12b:	fc                   	cld    
 12c:	f3 aa                	rep stos %al,%es:(%edi)
 12e:	89 ca                	mov    %ecx,%edx
 130:	89 fb                	mov    %edi,%ebx
 132:	89 5d 08             	mov    %ebx,0x8(%ebp)
 135:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 138:	90                   	nop
 139:	5b                   	pop    %ebx
 13a:	5f                   	pop    %edi
 13b:	5d                   	pop    %ebp
 13c:	c3                   	ret    

0000013d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 13d:	f3 0f 1e fb          	endbr32 
 141:	55                   	push   %ebp
 142:	89 e5                	mov    %esp,%ebp
 144:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 147:	8b 45 08             	mov    0x8(%ebp),%eax
 14a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 14d:	90                   	nop
 14e:	8b 55 0c             	mov    0xc(%ebp),%edx
 151:	8d 42 01             	lea    0x1(%edx),%eax
 154:	89 45 0c             	mov    %eax,0xc(%ebp)
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	8d 48 01             	lea    0x1(%eax),%ecx
 15d:	89 4d 08             	mov    %ecx,0x8(%ebp)
 160:	0f b6 12             	movzbl (%edx),%edx
 163:	88 10                	mov    %dl,(%eax)
 165:	0f b6 00             	movzbl (%eax),%eax
 168:	84 c0                	test   %al,%al
 16a:	75 e2                	jne    14e <strcpy+0x11>
    ;
  return os;
 16c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 16f:	c9                   	leave  
 170:	c3                   	ret    

00000171 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 171:	f3 0f 1e fb          	endbr32 
 175:	55                   	push   %ebp
 176:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 178:	eb 08                	jmp    182 <strcmp+0x11>
    p++, q++;
 17a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 182:	8b 45 08             	mov    0x8(%ebp),%eax
 185:	0f b6 00             	movzbl (%eax),%eax
 188:	84 c0                	test   %al,%al
 18a:	74 10                	je     19c <strcmp+0x2b>
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	0f b6 10             	movzbl (%eax),%edx
 192:	8b 45 0c             	mov    0xc(%ebp),%eax
 195:	0f b6 00             	movzbl (%eax),%eax
 198:	38 c2                	cmp    %al,%dl
 19a:	74 de                	je     17a <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	0f b6 00             	movzbl (%eax),%eax
 1a2:	0f b6 d0             	movzbl %al,%edx
 1a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a8:	0f b6 00             	movzbl (%eax),%eax
 1ab:	0f b6 c0             	movzbl %al,%eax
 1ae:	29 c2                	sub    %eax,%edx
 1b0:	89 d0                	mov    %edx,%eax
}
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    

000001b4 <strlen>:

uint
strlen(char *s)
{
 1b4:	f3 0f 1e fb          	endbr32 
 1b8:	55                   	push   %ebp
 1b9:	89 e5                	mov    %esp,%ebp
 1bb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c5:	eb 04                	jmp    1cb <strlen+0x17>
 1c7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ce:	8b 45 08             	mov    0x8(%ebp),%eax
 1d1:	01 d0                	add    %edx,%eax
 1d3:	0f b6 00             	movzbl (%eax),%eax
 1d6:	84 c0                	test   %al,%al
 1d8:	75 ed                	jne    1c7 <strlen+0x13>
    ;
  return n;
 1da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1dd:	c9                   	leave  
 1de:	c3                   	ret    

000001df <memset>:

void*
memset(void *dst, int c, uint n)
{
 1df:	f3 0f 1e fb          	endbr32 
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1e6:	8b 45 10             	mov    0x10(%ebp),%eax
 1e9:	50                   	push   %eax
 1ea:	ff 75 0c             	pushl  0xc(%ebp)
 1ed:	ff 75 08             	pushl  0x8(%ebp)
 1f0:	e8 22 ff ff ff       	call   117 <stosb>
 1f5:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1fb:	c9                   	leave  
 1fc:	c3                   	ret    

000001fd <strchr>:

char*
strchr(const char *s, char c)
{
 1fd:	f3 0f 1e fb          	endbr32 
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 04             	sub    $0x4,%esp
 207:	8b 45 0c             	mov    0xc(%ebp),%eax
 20a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 20d:	eb 14                	jmp    223 <strchr+0x26>
    if(*s == c)
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	0f b6 00             	movzbl (%eax),%eax
 215:	38 45 fc             	cmp    %al,-0x4(%ebp)
 218:	75 05                	jne    21f <strchr+0x22>
      return (char*)s;
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	eb 13                	jmp    232 <strchr+0x35>
  for(; *s; s++)
 21f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 00             	movzbl (%eax),%eax
 229:	84 c0                	test   %al,%al
 22b:	75 e2                	jne    20f <strchr+0x12>
  return 0;
 22d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 232:	c9                   	leave  
 233:	c3                   	ret    

00000234 <gets>:

char*
gets(char *buf, int max)
{
 234:	f3 0f 1e fb          	endbr32 
 238:	55                   	push   %ebp
 239:	89 e5                	mov    %esp,%ebp
 23b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 245:	eb 42                	jmp    289 <gets+0x55>
    cc = read(0, &c, 1);
 247:	83 ec 04             	sub    $0x4,%esp
 24a:	6a 01                	push   $0x1
 24c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 24f:	50                   	push   %eax
 250:	6a 00                	push   $0x0
 252:	e8 53 01 00 00       	call   3aa <read>
 257:	83 c4 10             	add    $0x10,%esp
 25a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 25d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 261:	7e 33                	jle    296 <gets+0x62>
      break;
    buf[i++] = c;
 263:	8b 45 f4             	mov    -0xc(%ebp),%eax
 266:	8d 50 01             	lea    0x1(%eax),%edx
 269:	89 55 f4             	mov    %edx,-0xc(%ebp)
 26c:	89 c2                	mov    %eax,%edx
 26e:	8b 45 08             	mov    0x8(%ebp),%eax
 271:	01 c2                	add    %eax,%edx
 273:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 277:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 279:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 27d:	3c 0a                	cmp    $0xa,%al
 27f:	74 16                	je     297 <gets+0x63>
 281:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 285:	3c 0d                	cmp    $0xd,%al
 287:	74 0e                	je     297 <gets+0x63>
  for(i=0; i+1 < max; ){
 289:	8b 45 f4             	mov    -0xc(%ebp),%eax
 28c:	83 c0 01             	add    $0x1,%eax
 28f:	39 45 0c             	cmp    %eax,0xc(%ebp)
 292:	7f b3                	jg     247 <gets+0x13>
 294:	eb 01                	jmp    297 <gets+0x63>
      break;
 296:	90                   	nop
      break;
  }
  buf[i] = '\0';
 297:	8b 55 f4             	mov    -0xc(%ebp),%edx
 29a:	8b 45 08             	mov    0x8(%ebp),%eax
 29d:	01 d0                	add    %edx,%eax
 29f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a5:	c9                   	leave  
 2a6:	c3                   	ret    

000002a7 <stat>:

int
stat(char *n, struct stat *st)
{
 2a7:	f3 0f 1e fb          	endbr32 
 2ab:	55                   	push   %ebp
 2ac:	89 e5                	mov    %esp,%ebp
 2ae:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b1:	83 ec 08             	sub    $0x8,%esp
 2b4:	6a 00                	push   $0x0
 2b6:	ff 75 08             	pushl  0x8(%ebp)
 2b9:	e8 14 01 00 00       	call   3d2 <open>
 2be:	83 c4 10             	add    $0x10,%esp
 2c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2c8:	79 07                	jns    2d1 <stat+0x2a>
    return -1;
 2ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2cf:	eb 25                	jmp    2f6 <stat+0x4f>
  r = fstat(fd, st);
 2d1:	83 ec 08             	sub    $0x8,%esp
 2d4:	ff 75 0c             	pushl  0xc(%ebp)
 2d7:	ff 75 f4             	pushl  -0xc(%ebp)
 2da:	e8 0b 01 00 00       	call   3ea <fstat>
 2df:	83 c4 10             	add    $0x10,%esp
 2e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2e5:	83 ec 0c             	sub    $0xc,%esp
 2e8:	ff 75 f4             	pushl  -0xc(%ebp)
 2eb:	e8 ca 00 00 00       	call   3ba <close>
 2f0:	83 c4 10             	add    $0x10,%esp
  return r;
 2f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2f6:	c9                   	leave  
 2f7:	c3                   	ret    

000002f8 <atoi>:

int
atoi(const char *s)
{
 2f8:	f3 0f 1e fb          	endbr32 
 2fc:	55                   	push   %ebp
 2fd:	89 e5                	mov    %esp,%ebp
 2ff:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 302:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 309:	eb 25                	jmp    330 <atoi+0x38>
    n = n*10 + *s++ - '0';
 30b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 30e:	89 d0                	mov    %edx,%eax
 310:	c1 e0 02             	shl    $0x2,%eax
 313:	01 d0                	add    %edx,%eax
 315:	01 c0                	add    %eax,%eax
 317:	89 c1                	mov    %eax,%ecx
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	8d 50 01             	lea    0x1(%eax),%edx
 31f:	89 55 08             	mov    %edx,0x8(%ebp)
 322:	0f b6 00             	movzbl (%eax),%eax
 325:	0f be c0             	movsbl %al,%eax
 328:	01 c8                	add    %ecx,%eax
 32a:	83 e8 30             	sub    $0x30,%eax
 32d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 330:	8b 45 08             	mov    0x8(%ebp),%eax
 333:	0f b6 00             	movzbl (%eax),%eax
 336:	3c 2f                	cmp    $0x2f,%al
 338:	7e 0a                	jle    344 <atoi+0x4c>
 33a:	8b 45 08             	mov    0x8(%ebp),%eax
 33d:	0f b6 00             	movzbl (%eax),%eax
 340:	3c 39                	cmp    $0x39,%al
 342:	7e c7                	jle    30b <atoi+0x13>
  return n;
 344:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 347:	c9                   	leave  
 348:	c3                   	ret    

00000349 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 349:	f3 0f 1e fb          	endbr32 
 34d:	55                   	push   %ebp
 34e:	89 e5                	mov    %esp,%ebp
 350:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 359:	8b 45 0c             	mov    0xc(%ebp),%eax
 35c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 35f:	eb 17                	jmp    378 <memmove+0x2f>
    *dst++ = *src++;
 361:	8b 55 f8             	mov    -0x8(%ebp),%edx
 364:	8d 42 01             	lea    0x1(%edx),%eax
 367:	89 45 f8             	mov    %eax,-0x8(%ebp)
 36a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 36d:	8d 48 01             	lea    0x1(%eax),%ecx
 370:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 373:	0f b6 12             	movzbl (%edx),%edx
 376:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 378:	8b 45 10             	mov    0x10(%ebp),%eax
 37b:	8d 50 ff             	lea    -0x1(%eax),%edx
 37e:	89 55 10             	mov    %edx,0x10(%ebp)
 381:	85 c0                	test   %eax,%eax
 383:	7f dc                	jg     361 <memmove+0x18>
  return vdst;
 385:	8b 45 08             	mov    0x8(%ebp),%eax
}
 388:	c9                   	leave  
 389:	c3                   	ret    

0000038a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38a:	b8 01 00 00 00       	mov    $0x1,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <exit>:
SYSCALL(exit)
 392:	b8 02 00 00 00       	mov    $0x2,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <wait>:
SYSCALL(wait)
 39a:	b8 03 00 00 00       	mov    $0x3,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <pipe>:
SYSCALL(pipe)
 3a2:	b8 04 00 00 00       	mov    $0x4,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <read>:
SYSCALL(read)
 3aa:	b8 05 00 00 00       	mov    $0x5,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <write>:
SYSCALL(write)
 3b2:	b8 10 00 00 00       	mov    $0x10,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <close>:
SYSCALL(close)
 3ba:	b8 15 00 00 00       	mov    $0x15,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <kill>:
SYSCALL(kill)
 3c2:	b8 06 00 00 00       	mov    $0x6,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <exec>:
SYSCALL(exec)
 3ca:	b8 07 00 00 00       	mov    $0x7,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <open>:
SYSCALL(open)
 3d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <mknod>:
SYSCALL(mknod)
 3da:	b8 11 00 00 00       	mov    $0x11,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <unlink>:
SYSCALL(unlink)
 3e2:	b8 12 00 00 00       	mov    $0x12,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <fstat>:
SYSCALL(fstat)
 3ea:	b8 08 00 00 00       	mov    $0x8,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <link>:
SYSCALL(link)
 3f2:	b8 13 00 00 00       	mov    $0x13,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mkdir>:
SYSCALL(mkdir)
 3fa:	b8 14 00 00 00       	mov    $0x14,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <chdir>:
SYSCALL(chdir)
 402:	b8 09 00 00 00       	mov    $0x9,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <dup>:
SYSCALL(dup)
 40a:	b8 0a 00 00 00       	mov    $0xa,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <getpid>:
SYSCALL(getpid)
 412:	b8 0b 00 00 00       	mov    $0xb,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <sbrk>:
SYSCALL(sbrk)
 41a:	b8 0c 00 00 00       	mov    $0xc,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <sleep>:
SYSCALL(sleep)
 422:	b8 0d 00 00 00       	mov    $0xd,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <uptime>:
SYSCALL(uptime)
 42a:	b8 0e 00 00 00       	mov    $0xe,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 432:	f3 0f 1e fb          	endbr32 
 436:	55                   	push   %ebp
 437:	89 e5                	mov    %esp,%ebp
 439:	83 ec 18             	sub    $0x18,%esp
 43c:	8b 45 0c             	mov    0xc(%ebp),%eax
 43f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 442:	83 ec 04             	sub    $0x4,%esp
 445:	6a 01                	push   $0x1
 447:	8d 45 f4             	lea    -0xc(%ebp),%eax
 44a:	50                   	push   %eax
 44b:	ff 75 08             	pushl  0x8(%ebp)
 44e:	e8 5f ff ff ff       	call   3b2 <write>
 453:	83 c4 10             	add    $0x10,%esp
}
 456:	90                   	nop
 457:	c9                   	leave  
 458:	c3                   	ret    

00000459 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 459:	f3 0f 1e fb          	endbr32 
 45d:	55                   	push   %ebp
 45e:	89 e5                	mov    %esp,%ebp
 460:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 463:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 46a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 46e:	74 17                	je     487 <printint+0x2e>
 470:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 474:	79 11                	jns    487 <printint+0x2e>
    neg = 1;
 476:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 47d:	8b 45 0c             	mov    0xc(%ebp),%eax
 480:	f7 d8                	neg    %eax
 482:	89 45 ec             	mov    %eax,-0x14(%ebp)
 485:	eb 06                	jmp    48d <printint+0x34>
  } else {
    x = xx;
 487:	8b 45 0c             	mov    0xc(%ebp),%eax
 48a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 48d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 494:	8b 4d 10             	mov    0x10(%ebp),%ecx
 497:	8b 45 ec             	mov    -0x14(%ebp),%eax
 49a:	ba 00 00 00 00       	mov    $0x0,%edx
 49f:	f7 f1                	div    %ecx
 4a1:	89 d1                	mov    %edx,%ecx
 4a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a6:	8d 50 01             	lea    0x1(%eax),%edx
 4a9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4ac:	0f b6 91 6c 0b 00 00 	movzbl 0xb6c(%ecx),%edx
 4b3:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 4b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4bd:	ba 00 00 00 00       	mov    $0x0,%edx
 4c2:	f7 f1                	div    %ecx
 4c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4cb:	75 c7                	jne    494 <printint+0x3b>
  if(neg)
 4cd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4d1:	74 2d                	je     500 <printint+0xa7>
    buf[i++] = '-';
 4d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4d6:	8d 50 01             	lea    0x1(%eax),%edx
 4d9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4dc:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4e1:	eb 1d                	jmp    500 <printint+0xa7>
    putc(fd, buf[i]);
 4e3:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4e9:	01 d0                	add    %edx,%eax
 4eb:	0f b6 00             	movzbl (%eax),%eax
 4ee:	0f be c0             	movsbl %al,%eax
 4f1:	83 ec 08             	sub    $0x8,%esp
 4f4:	50                   	push   %eax
 4f5:	ff 75 08             	pushl  0x8(%ebp)
 4f8:	e8 35 ff ff ff       	call   432 <putc>
 4fd:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 500:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 504:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 508:	79 d9                	jns    4e3 <printint+0x8a>
}
 50a:	90                   	nop
 50b:	90                   	nop
 50c:	c9                   	leave  
 50d:	c3                   	ret    

0000050e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 50e:	f3 0f 1e fb          	endbr32 
 512:	55                   	push   %ebp
 513:	89 e5                	mov    %esp,%ebp
 515:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 518:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 51f:	8d 45 0c             	lea    0xc(%ebp),%eax
 522:	83 c0 04             	add    $0x4,%eax
 525:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 528:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 52f:	e9 59 01 00 00       	jmp    68d <printf+0x17f>
    c = fmt[i] & 0xff;
 534:	8b 55 0c             	mov    0xc(%ebp),%edx
 537:	8b 45 f0             	mov    -0x10(%ebp),%eax
 53a:	01 d0                	add    %edx,%eax
 53c:	0f b6 00             	movzbl (%eax),%eax
 53f:	0f be c0             	movsbl %al,%eax
 542:	25 ff 00 00 00       	and    $0xff,%eax
 547:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 54a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 54e:	75 2c                	jne    57c <printf+0x6e>
      if(c == '%'){
 550:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 554:	75 0c                	jne    562 <printf+0x54>
        state = '%';
 556:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 55d:	e9 27 01 00 00       	jmp    689 <printf+0x17b>
      } else {
        putc(fd, c);
 562:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 565:	0f be c0             	movsbl %al,%eax
 568:	83 ec 08             	sub    $0x8,%esp
 56b:	50                   	push   %eax
 56c:	ff 75 08             	pushl  0x8(%ebp)
 56f:	e8 be fe ff ff       	call   432 <putc>
 574:	83 c4 10             	add    $0x10,%esp
 577:	e9 0d 01 00 00       	jmp    689 <printf+0x17b>
      }
    } else if(state == '%'){
 57c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 580:	0f 85 03 01 00 00    	jne    689 <printf+0x17b>
      if(c == 'd'){
 586:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 58a:	75 1e                	jne    5aa <printf+0x9c>
        printint(fd, *ap, 10, 1);
 58c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 58f:	8b 00                	mov    (%eax),%eax
 591:	6a 01                	push   $0x1
 593:	6a 0a                	push   $0xa
 595:	50                   	push   %eax
 596:	ff 75 08             	pushl  0x8(%ebp)
 599:	e8 bb fe ff ff       	call   459 <printint>
 59e:	83 c4 10             	add    $0x10,%esp
        ap++;
 5a1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5a5:	e9 d8 00 00 00       	jmp    682 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 5aa:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5ae:	74 06                	je     5b6 <printf+0xa8>
 5b0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5b4:	75 1e                	jne    5d4 <printf+0xc6>
        printint(fd, *ap, 16, 0);
 5b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b9:	8b 00                	mov    (%eax),%eax
 5bb:	6a 00                	push   $0x0
 5bd:	6a 10                	push   $0x10
 5bf:	50                   	push   %eax
 5c0:	ff 75 08             	pushl  0x8(%ebp)
 5c3:	e8 91 fe ff ff       	call   459 <printint>
 5c8:	83 c4 10             	add    $0x10,%esp
        ap++;
 5cb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5cf:	e9 ae 00 00 00       	jmp    682 <printf+0x174>
      } else if(c == 's'){
 5d4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5d8:	75 43                	jne    61d <printf+0x10f>
        s = (char*)*ap;
 5da:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5dd:	8b 00                	mov    (%eax),%eax
 5df:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ea:	75 25                	jne    611 <printf+0x103>
          s = "(null)";
 5ec:	c7 45 f4 fb 08 00 00 	movl   $0x8fb,-0xc(%ebp)
        while(*s != 0){
 5f3:	eb 1c                	jmp    611 <printf+0x103>
          putc(fd, *s);
 5f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f8:	0f b6 00             	movzbl (%eax),%eax
 5fb:	0f be c0             	movsbl %al,%eax
 5fe:	83 ec 08             	sub    $0x8,%esp
 601:	50                   	push   %eax
 602:	ff 75 08             	pushl  0x8(%ebp)
 605:	e8 28 fe ff ff       	call   432 <putc>
 60a:	83 c4 10             	add    $0x10,%esp
          s++;
 60d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 611:	8b 45 f4             	mov    -0xc(%ebp),%eax
 614:	0f b6 00             	movzbl (%eax),%eax
 617:	84 c0                	test   %al,%al
 619:	75 da                	jne    5f5 <printf+0xe7>
 61b:	eb 65                	jmp    682 <printf+0x174>
        }
      } else if(c == 'c'){
 61d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 621:	75 1d                	jne    640 <printf+0x132>
        putc(fd, *ap);
 623:	8b 45 e8             	mov    -0x18(%ebp),%eax
 626:	8b 00                	mov    (%eax),%eax
 628:	0f be c0             	movsbl %al,%eax
 62b:	83 ec 08             	sub    $0x8,%esp
 62e:	50                   	push   %eax
 62f:	ff 75 08             	pushl  0x8(%ebp)
 632:	e8 fb fd ff ff       	call   432 <putc>
 637:	83 c4 10             	add    $0x10,%esp
        ap++;
 63a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 63e:	eb 42                	jmp    682 <printf+0x174>
      } else if(c == '%'){
 640:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 644:	75 17                	jne    65d <printf+0x14f>
        putc(fd, c);
 646:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 649:	0f be c0             	movsbl %al,%eax
 64c:	83 ec 08             	sub    $0x8,%esp
 64f:	50                   	push   %eax
 650:	ff 75 08             	pushl  0x8(%ebp)
 653:	e8 da fd ff ff       	call   432 <putc>
 658:	83 c4 10             	add    $0x10,%esp
 65b:	eb 25                	jmp    682 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 65d:	83 ec 08             	sub    $0x8,%esp
 660:	6a 25                	push   $0x25
 662:	ff 75 08             	pushl  0x8(%ebp)
 665:	e8 c8 fd ff ff       	call   432 <putc>
 66a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 66d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 670:	0f be c0             	movsbl %al,%eax
 673:	83 ec 08             	sub    $0x8,%esp
 676:	50                   	push   %eax
 677:	ff 75 08             	pushl  0x8(%ebp)
 67a:	e8 b3 fd ff ff       	call   432 <putc>
 67f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 682:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 689:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 68d:	8b 55 0c             	mov    0xc(%ebp),%edx
 690:	8b 45 f0             	mov    -0x10(%ebp),%eax
 693:	01 d0                	add    %edx,%eax
 695:	0f b6 00             	movzbl (%eax),%eax
 698:	84 c0                	test   %al,%al
 69a:	0f 85 94 fe ff ff    	jne    534 <printf+0x26>
    }
  }
}
 6a0:	90                   	nop
 6a1:	90                   	nop
 6a2:	c9                   	leave  
 6a3:	c3                   	ret    

000006a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a4:	f3 0f 1e fb          	endbr32 
 6a8:	55                   	push   %ebp
 6a9:	89 e5                	mov    %esp,%ebp
 6ab:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6ae:	8b 45 08             	mov    0x8(%ebp),%eax
 6b1:	83 e8 08             	sub    $0x8,%eax
 6b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b7:	a1 88 0b 00 00       	mov    0xb88,%eax
 6bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6bf:	eb 24                	jmp    6e5 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c4:	8b 00                	mov    (%eax),%eax
 6c6:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 6c9:	72 12                	jb     6dd <free+0x39>
 6cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ce:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6d1:	77 24                	ja     6f7 <free+0x53>
 6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d6:	8b 00                	mov    (%eax),%eax
 6d8:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6db:	72 1a                	jb     6f7 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e0:	8b 00                	mov    (%eax),%eax
 6e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6eb:	76 d4                	jbe    6c1 <free+0x1d>
 6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f0:	8b 00                	mov    (%eax),%eax
 6f2:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6f5:	73 ca                	jae    6c1 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fa:	8b 40 04             	mov    0x4(%eax),%eax
 6fd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 704:	8b 45 f8             	mov    -0x8(%ebp),%eax
 707:	01 c2                	add    %eax,%edx
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	8b 00                	mov    (%eax),%eax
 70e:	39 c2                	cmp    %eax,%edx
 710:	75 24                	jne    736 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 712:	8b 45 f8             	mov    -0x8(%ebp),%eax
 715:	8b 50 04             	mov    0x4(%eax),%edx
 718:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71b:	8b 00                	mov    (%eax),%eax
 71d:	8b 40 04             	mov    0x4(%eax),%eax
 720:	01 c2                	add    %eax,%edx
 722:	8b 45 f8             	mov    -0x8(%ebp),%eax
 725:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 728:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72b:	8b 00                	mov    (%eax),%eax
 72d:	8b 10                	mov    (%eax),%edx
 72f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 732:	89 10                	mov    %edx,(%eax)
 734:	eb 0a                	jmp    740 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 736:	8b 45 fc             	mov    -0x4(%ebp),%eax
 739:	8b 10                	mov    (%eax),%edx
 73b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 740:	8b 45 fc             	mov    -0x4(%ebp),%eax
 743:	8b 40 04             	mov    0x4(%eax),%eax
 746:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 750:	01 d0                	add    %edx,%eax
 752:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 755:	75 20                	jne    777 <free+0xd3>
    p->s.size += bp->s.size;
 757:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75a:	8b 50 04             	mov    0x4(%eax),%edx
 75d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 760:	8b 40 04             	mov    0x4(%eax),%eax
 763:	01 c2                	add    %eax,%edx
 765:	8b 45 fc             	mov    -0x4(%ebp),%eax
 768:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 76b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76e:	8b 10                	mov    (%eax),%edx
 770:	8b 45 fc             	mov    -0x4(%ebp),%eax
 773:	89 10                	mov    %edx,(%eax)
 775:	eb 08                	jmp    77f <free+0xdb>
  } else
    p->s.ptr = bp;
 777:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 77d:	89 10                	mov    %edx,(%eax)
  freep = p;
 77f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 782:	a3 88 0b 00 00       	mov    %eax,0xb88
}
 787:	90                   	nop
 788:	c9                   	leave  
 789:	c3                   	ret    

0000078a <morecore>:

static Header*
morecore(uint nu)
{
 78a:	f3 0f 1e fb          	endbr32 
 78e:	55                   	push   %ebp
 78f:	89 e5                	mov    %esp,%ebp
 791:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 794:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 79b:	77 07                	ja     7a4 <morecore+0x1a>
    nu = 4096;
 79d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7a4:	8b 45 08             	mov    0x8(%ebp),%eax
 7a7:	c1 e0 03             	shl    $0x3,%eax
 7aa:	83 ec 0c             	sub    $0xc,%esp
 7ad:	50                   	push   %eax
 7ae:	e8 67 fc ff ff       	call   41a <sbrk>
 7b3:	83 c4 10             	add    $0x10,%esp
 7b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7b9:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7bd:	75 07                	jne    7c6 <morecore+0x3c>
    return 0;
 7bf:	b8 00 00 00 00       	mov    $0x0,%eax
 7c4:	eb 26                	jmp    7ec <morecore+0x62>
  hp = (Header*)p;
 7c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cf:	8b 55 08             	mov    0x8(%ebp),%edx
 7d2:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d8:	83 c0 08             	add    $0x8,%eax
 7db:	83 ec 0c             	sub    $0xc,%esp
 7de:	50                   	push   %eax
 7df:	e8 c0 fe ff ff       	call   6a4 <free>
 7e4:	83 c4 10             	add    $0x10,%esp
  return freep;
 7e7:	a1 88 0b 00 00       	mov    0xb88,%eax
}
 7ec:	c9                   	leave  
 7ed:	c3                   	ret    

000007ee <malloc>:

void*
malloc(uint nbytes)
{
 7ee:	f3 0f 1e fb          	endbr32 
 7f2:	55                   	push   %ebp
 7f3:	89 e5                	mov    %esp,%ebp
 7f5:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f8:	8b 45 08             	mov    0x8(%ebp),%eax
 7fb:	83 c0 07             	add    $0x7,%eax
 7fe:	c1 e8 03             	shr    $0x3,%eax
 801:	83 c0 01             	add    $0x1,%eax
 804:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 807:	a1 88 0b 00 00       	mov    0xb88,%eax
 80c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 80f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 813:	75 23                	jne    838 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 815:	c7 45 f0 80 0b 00 00 	movl   $0xb80,-0x10(%ebp)
 81c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81f:	a3 88 0b 00 00       	mov    %eax,0xb88
 824:	a1 88 0b 00 00       	mov    0xb88,%eax
 829:	a3 80 0b 00 00       	mov    %eax,0xb80
    base.s.size = 0;
 82e:	c7 05 84 0b 00 00 00 	movl   $0x0,0xb84
 835:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 838:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83b:	8b 00                	mov    (%eax),%eax
 83d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 840:	8b 45 f4             	mov    -0xc(%ebp),%eax
 843:	8b 40 04             	mov    0x4(%eax),%eax
 846:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 849:	77 4d                	ja     898 <malloc+0xaa>
      if(p->s.size == nunits)
 84b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84e:	8b 40 04             	mov    0x4(%eax),%eax
 851:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 854:	75 0c                	jne    862 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 856:	8b 45 f4             	mov    -0xc(%ebp),%eax
 859:	8b 10                	mov    (%eax),%edx
 85b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85e:	89 10                	mov    %edx,(%eax)
 860:	eb 26                	jmp    888 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 862:	8b 45 f4             	mov    -0xc(%ebp),%eax
 865:	8b 40 04             	mov    0x4(%eax),%eax
 868:	2b 45 ec             	sub    -0x14(%ebp),%eax
 86b:	89 c2                	mov    %eax,%edx
 86d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 870:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 873:	8b 45 f4             	mov    -0xc(%ebp),%eax
 876:	8b 40 04             	mov    0x4(%eax),%eax
 879:	c1 e0 03             	shl    $0x3,%eax
 87c:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 87f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 882:	8b 55 ec             	mov    -0x14(%ebp),%edx
 885:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 888:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88b:	a3 88 0b 00 00       	mov    %eax,0xb88
      return (void*)(p + 1);
 890:	8b 45 f4             	mov    -0xc(%ebp),%eax
 893:	83 c0 08             	add    $0x8,%eax
 896:	eb 3b                	jmp    8d3 <malloc+0xe5>
    }
    if(p == freep)
 898:	a1 88 0b 00 00       	mov    0xb88,%eax
 89d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8a0:	75 1e                	jne    8c0 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 8a2:	83 ec 0c             	sub    $0xc,%esp
 8a5:	ff 75 ec             	pushl  -0x14(%ebp)
 8a8:	e8 dd fe ff ff       	call   78a <morecore>
 8ad:	83 c4 10             	add    $0x10,%esp
 8b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8b7:	75 07                	jne    8c0 <malloc+0xd2>
        return 0;
 8b9:	b8 00 00 00 00       	mov    $0x0,%eax
 8be:	eb 13                	jmp    8d3 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c9:	8b 00                	mov    (%eax),%eax
 8cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8ce:	e9 6d ff ff ff       	jmp    840 <malloc+0x52>
  }
}
 8d3:	c9                   	leave  
 8d4:	c3                   	ret    
