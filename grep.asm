
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  11:	e9 a3 00 00 00       	jmp    b9 <grep+0xb9>
    m += n;
  16:	8b 45 ec             	mov    -0x14(%ebp),%eax
  19:	01 45 f4             	add    %eax,-0xc(%ebp)
    p = buf;
  1c:	c7 45 f0 40 0e 00 00 	movl   $0xe40,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  23:	eb 44                	jmp    69 <grep+0x69>
      *q = 0;
  25:	8b 45 e8             	mov    -0x18(%ebp),%eax
  28:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  2b:	83 ec 08             	sub    $0x8,%esp
  2e:	ff 75 f0             	pushl  -0x10(%ebp)
  31:	ff 75 08             	pushl  0x8(%ebp)
  34:	e8 97 01 00 00       	call   1d0 <match>
  39:	83 c4 10             	add    $0x10,%esp
  3c:	85 c0                	test   %eax,%eax
  3e:	74 20                	je     60 <grep+0x60>
        *q = '\n';
  40:	8b 45 e8             	mov    -0x18(%ebp),%eax
  43:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  46:	8b 45 e8             	mov    -0x18(%ebp),%eax
  49:	83 c0 01             	add    $0x1,%eax
  4c:	2b 45 f0             	sub    -0x10(%ebp),%eax
  4f:	83 ec 04             	sub    $0x4,%esp
  52:	50                   	push   %eax
  53:	ff 75 f0             	pushl  -0x10(%ebp)
  56:	6a 01                	push   $0x1
  58:	e8 76 05 00 00       	call   5d3 <write>
  5d:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
  60:	8b 45 e8             	mov    -0x18(%ebp),%eax
  63:	83 c0 01             	add    $0x1,%eax
  66:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  69:	83 ec 08             	sub    $0x8,%esp
  6c:	6a 0a                	push   $0xa
  6e:	ff 75 f0             	pushl  -0x10(%ebp)
  71:	e8 a8 03 00 00       	call   41e <strchr>
  76:	83 c4 10             	add    $0x10,%esp
  79:	89 45 e8             	mov    %eax,-0x18(%ebp)
  7c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  80:	75 a3                	jne    25 <grep+0x25>
    }
    if(p == buf)
  82:	81 7d f0 40 0e 00 00 	cmpl   $0xe40,-0x10(%ebp)
  89:	75 07                	jne    92 <grep+0x92>
      m = 0;
  8b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  92:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  96:	7e 21                	jle    b9 <grep+0xb9>
      m -= p - buf;
  98:	8b 45 f0             	mov    -0x10(%ebp),%eax
  9b:	2d 40 0e 00 00       	sub    $0xe40,%eax
  a0:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  a3:	83 ec 04             	sub    $0x4,%esp
  a6:	ff 75 f4             	pushl  -0xc(%ebp)
  a9:	ff 75 f0             	pushl  -0x10(%ebp)
  ac:	68 40 0e 00 00       	push   $0xe40
  b1:	e8 b4 04 00 00       	call   56a <memmove>
  b6:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  bc:	ba 00 04 00 00       	mov    $0x400,%edx
  c1:	29 c2                	sub    %eax,%edx
  c3:	89 d0                	mov    %edx,%eax
  c5:	89 c2                	mov    %eax,%edx
  c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  ca:	05 40 0e 00 00       	add    $0xe40,%eax
  cf:	83 ec 04             	sub    $0x4,%esp
  d2:	52                   	push   %edx
  d3:	50                   	push   %eax
  d4:	ff 75 0c             	pushl  0xc(%ebp)
  d7:	e8 ef 04 00 00       	call   5cb <read>
  dc:	83 c4 10             	add    $0x10,%esp
  df:	89 45 ec             	mov    %eax,-0x14(%ebp)
  e2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  e6:	0f 8f 2a ff ff ff    	jg     16 <grep+0x16>
    }
  }
}
  ec:	90                   	nop
  ed:	90                   	nop
  ee:	c9                   	leave  
  ef:	c3                   	ret    

000000f0 <main>:

int
main(int argc, char *argv[])
{
  f0:	f3 0f 1e fb          	endbr32 
  f4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f8:	83 e4 f0             	and    $0xfffffff0,%esp
  fb:	ff 71 fc             	pushl  -0x4(%ecx)
  fe:	55                   	push   %ebp
  ff:	89 e5                	mov    %esp,%ebp
 101:	53                   	push   %ebx
 102:	51                   	push   %ecx
 103:	83 ec 10             	sub    $0x10,%esp
 106:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 108:	83 3b 01             	cmpl   $0x1,(%ebx)
 10b:	7f 17                	jg     124 <main+0x34>
    printf(2, "usage: grep pattern [file ...]\n");
 10d:	83 ec 08             	sub    $0x8,%esp
 110:	68 f8 0a 00 00       	push   $0xaf8
 115:	6a 02                	push   $0x2
 117:	e8 13 06 00 00       	call   72f <printf>
 11c:	83 c4 10             	add    $0x10,%esp
    exit();
 11f:	e8 8f 04 00 00       	call   5b3 <exit>
  }
  pattern = argv[1];
 124:	8b 43 04             	mov    0x4(%ebx),%eax
 127:	8b 40 04             	mov    0x4(%eax),%eax
 12a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  if(argc <= 2){
 12d:	83 3b 02             	cmpl   $0x2,(%ebx)
 130:	7f 15                	jg     147 <main+0x57>
    grep(pattern, 0);
 132:	83 ec 08             	sub    $0x8,%esp
 135:	6a 00                	push   $0x0
 137:	ff 75 f0             	pushl  -0x10(%ebp)
 13a:	e8 c1 fe ff ff       	call   0 <grep>
 13f:	83 c4 10             	add    $0x10,%esp
    exit();
 142:	e8 6c 04 00 00       	call   5b3 <exit>
  }

  for(i = 2; i < argc; i++){
 147:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
 14e:	eb 74                	jmp    1c4 <main+0xd4>
    if((fd = open(argv[i], 0)) < 0){
 150:	8b 45 f4             	mov    -0xc(%ebp),%eax
 153:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 15a:	8b 43 04             	mov    0x4(%ebx),%eax
 15d:	01 d0                	add    %edx,%eax
 15f:	8b 00                	mov    (%eax),%eax
 161:	83 ec 08             	sub    $0x8,%esp
 164:	6a 00                	push   $0x0
 166:	50                   	push   %eax
 167:	e8 87 04 00 00       	call   5f3 <open>
 16c:	83 c4 10             	add    $0x10,%esp
 16f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 172:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 176:	79 29                	jns    1a1 <main+0xb1>
      printf(1, "grep: cannot open %s\n", argv[i]);
 178:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 182:	8b 43 04             	mov    0x4(%ebx),%eax
 185:	01 d0                	add    %edx,%eax
 187:	8b 00                	mov    (%eax),%eax
 189:	83 ec 04             	sub    $0x4,%esp
 18c:	50                   	push   %eax
 18d:	68 18 0b 00 00       	push   $0xb18
 192:	6a 01                	push   $0x1
 194:	e8 96 05 00 00       	call   72f <printf>
 199:	83 c4 10             	add    $0x10,%esp
      exit();
 19c:	e8 12 04 00 00       	call   5b3 <exit>
    }
    grep(pattern, fd);
 1a1:	83 ec 08             	sub    $0x8,%esp
 1a4:	ff 75 ec             	pushl  -0x14(%ebp)
 1a7:	ff 75 f0             	pushl  -0x10(%ebp)
 1aa:	e8 51 fe ff ff       	call   0 <grep>
 1af:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1b2:	83 ec 0c             	sub    $0xc,%esp
 1b5:	ff 75 ec             	pushl  -0x14(%ebp)
 1b8:	e8 1e 04 00 00       	call   5db <close>
 1bd:	83 c4 10             	add    $0x10,%esp
  for(i = 2; i < argc; i++){
 1c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c7:	3b 03                	cmp    (%ebx),%eax
 1c9:	7c 85                	jl     150 <main+0x60>
  }
  exit();
 1cb:	e8 e3 03 00 00       	call   5b3 <exit>

000001d0 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1d0:	f3 0f 1e fb          	endbr32 
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
 1dd:	0f b6 00             	movzbl (%eax),%eax
 1e0:	3c 5e                	cmp    $0x5e,%al
 1e2:	75 17                	jne    1fb <match+0x2b>
    return matchhere(re+1, text);
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	83 c0 01             	add    $0x1,%eax
 1ea:	83 ec 08             	sub    $0x8,%esp
 1ed:	ff 75 0c             	pushl  0xc(%ebp)
 1f0:	50                   	push   %eax
 1f1:	e8 38 00 00 00       	call   22e <matchhere>
 1f6:	83 c4 10             	add    $0x10,%esp
 1f9:	eb 31                	jmp    22c <match+0x5c>
  do{  // must look at empty string
    if(matchhere(re, text))
 1fb:	83 ec 08             	sub    $0x8,%esp
 1fe:	ff 75 0c             	pushl  0xc(%ebp)
 201:	ff 75 08             	pushl  0x8(%ebp)
 204:	e8 25 00 00 00       	call   22e <matchhere>
 209:	83 c4 10             	add    $0x10,%esp
 20c:	85 c0                	test   %eax,%eax
 20e:	74 07                	je     217 <match+0x47>
      return 1;
 210:	b8 01 00 00 00       	mov    $0x1,%eax
 215:	eb 15                	jmp    22c <match+0x5c>
  }while(*text++ != '\0');
 217:	8b 45 0c             	mov    0xc(%ebp),%eax
 21a:	8d 50 01             	lea    0x1(%eax),%edx
 21d:	89 55 0c             	mov    %edx,0xc(%ebp)
 220:	0f b6 00             	movzbl (%eax),%eax
 223:	84 c0                	test   %al,%al
 225:	75 d4                	jne    1fb <match+0x2b>
  return 0;
 227:	b8 00 00 00 00       	mov    $0x0,%eax
}
 22c:	c9                   	leave  
 22d:	c3                   	ret    

0000022e <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 22e:	f3 0f 1e fb          	endbr32 
 232:	55                   	push   %ebp
 233:	89 e5                	mov    %esp,%ebp
 235:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
 238:	8b 45 08             	mov    0x8(%ebp),%eax
 23b:	0f b6 00             	movzbl (%eax),%eax
 23e:	84 c0                	test   %al,%al
 240:	75 0a                	jne    24c <matchhere+0x1e>
    return 1;
 242:	b8 01 00 00 00       	mov    $0x1,%eax
 247:	e9 99 00 00 00       	jmp    2e5 <matchhere+0xb7>
  if(re[1] == '*')
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
 24f:	83 c0 01             	add    $0x1,%eax
 252:	0f b6 00             	movzbl (%eax),%eax
 255:	3c 2a                	cmp    $0x2a,%al
 257:	75 21                	jne    27a <matchhere+0x4c>
    return matchstar(re[0], re+2, text);
 259:	8b 45 08             	mov    0x8(%ebp),%eax
 25c:	8d 50 02             	lea    0x2(%eax),%edx
 25f:	8b 45 08             	mov    0x8(%ebp),%eax
 262:	0f b6 00             	movzbl (%eax),%eax
 265:	0f be c0             	movsbl %al,%eax
 268:	83 ec 04             	sub    $0x4,%esp
 26b:	ff 75 0c             	pushl  0xc(%ebp)
 26e:	52                   	push   %edx
 26f:	50                   	push   %eax
 270:	e8 72 00 00 00       	call   2e7 <matchstar>
 275:	83 c4 10             	add    $0x10,%esp
 278:	eb 6b                	jmp    2e5 <matchhere+0xb7>
  if(re[0] == '$' && re[1] == '\0')
 27a:	8b 45 08             	mov    0x8(%ebp),%eax
 27d:	0f b6 00             	movzbl (%eax),%eax
 280:	3c 24                	cmp    $0x24,%al
 282:	75 1d                	jne    2a1 <matchhere+0x73>
 284:	8b 45 08             	mov    0x8(%ebp),%eax
 287:	83 c0 01             	add    $0x1,%eax
 28a:	0f b6 00             	movzbl (%eax),%eax
 28d:	84 c0                	test   %al,%al
 28f:	75 10                	jne    2a1 <matchhere+0x73>
    return *text == '\0';
 291:	8b 45 0c             	mov    0xc(%ebp),%eax
 294:	0f b6 00             	movzbl (%eax),%eax
 297:	84 c0                	test   %al,%al
 299:	0f 94 c0             	sete   %al
 29c:	0f b6 c0             	movzbl %al,%eax
 29f:	eb 44                	jmp    2e5 <matchhere+0xb7>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 2a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a4:	0f b6 00             	movzbl (%eax),%eax
 2a7:	84 c0                	test   %al,%al
 2a9:	74 35                	je     2e0 <matchhere+0xb2>
 2ab:	8b 45 08             	mov    0x8(%ebp),%eax
 2ae:	0f b6 00             	movzbl (%eax),%eax
 2b1:	3c 2e                	cmp    $0x2e,%al
 2b3:	74 10                	je     2c5 <matchhere+0x97>
 2b5:	8b 45 08             	mov    0x8(%ebp),%eax
 2b8:	0f b6 10             	movzbl (%eax),%edx
 2bb:	8b 45 0c             	mov    0xc(%ebp),%eax
 2be:	0f b6 00             	movzbl (%eax),%eax
 2c1:	38 c2                	cmp    %al,%dl
 2c3:	75 1b                	jne    2e0 <matchhere+0xb2>
    return matchhere(re+1, text+1);
 2c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c8:	8d 50 01             	lea    0x1(%eax),%edx
 2cb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ce:	83 c0 01             	add    $0x1,%eax
 2d1:	83 ec 08             	sub    $0x8,%esp
 2d4:	52                   	push   %edx
 2d5:	50                   	push   %eax
 2d6:	e8 53 ff ff ff       	call   22e <matchhere>
 2db:	83 c4 10             	add    $0x10,%esp
 2de:	eb 05                	jmp    2e5 <matchhere+0xb7>
  return 0;
 2e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2e5:	c9                   	leave  
 2e6:	c3                   	ret    

000002e7 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 2e7:	f3 0f 1e fb          	endbr32 
 2eb:	55                   	push   %ebp
 2ec:	89 e5                	mov    %esp,%ebp
 2ee:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 2f1:	83 ec 08             	sub    $0x8,%esp
 2f4:	ff 75 10             	pushl  0x10(%ebp)
 2f7:	ff 75 0c             	pushl  0xc(%ebp)
 2fa:	e8 2f ff ff ff       	call   22e <matchhere>
 2ff:	83 c4 10             	add    $0x10,%esp
 302:	85 c0                	test   %eax,%eax
 304:	74 07                	je     30d <matchstar+0x26>
      return 1;
 306:	b8 01 00 00 00       	mov    $0x1,%eax
 30b:	eb 29                	jmp    336 <matchstar+0x4f>
  }while(*text!='\0' && (*text++==c || c=='.'));
 30d:	8b 45 10             	mov    0x10(%ebp),%eax
 310:	0f b6 00             	movzbl (%eax),%eax
 313:	84 c0                	test   %al,%al
 315:	74 1a                	je     331 <matchstar+0x4a>
 317:	8b 45 10             	mov    0x10(%ebp),%eax
 31a:	8d 50 01             	lea    0x1(%eax),%edx
 31d:	89 55 10             	mov    %edx,0x10(%ebp)
 320:	0f b6 00             	movzbl (%eax),%eax
 323:	0f be c0             	movsbl %al,%eax
 326:	39 45 08             	cmp    %eax,0x8(%ebp)
 329:	74 c6                	je     2f1 <matchstar+0xa>
 32b:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 32f:	74 c0                	je     2f1 <matchstar+0xa>
  return 0;
 331:	b8 00 00 00 00       	mov    $0x0,%eax
}
 336:	c9                   	leave  
 337:	c3                   	ret    

00000338 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 338:	55                   	push   %ebp
 339:	89 e5                	mov    %esp,%ebp
 33b:	57                   	push   %edi
 33c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 33d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 340:	8b 55 10             	mov    0x10(%ebp),%edx
 343:	8b 45 0c             	mov    0xc(%ebp),%eax
 346:	89 cb                	mov    %ecx,%ebx
 348:	89 df                	mov    %ebx,%edi
 34a:	89 d1                	mov    %edx,%ecx
 34c:	fc                   	cld    
 34d:	f3 aa                	rep stos %al,%es:(%edi)
 34f:	89 ca                	mov    %ecx,%edx
 351:	89 fb                	mov    %edi,%ebx
 353:	89 5d 08             	mov    %ebx,0x8(%ebp)
 356:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 359:	90                   	nop
 35a:	5b                   	pop    %ebx
 35b:	5f                   	pop    %edi
 35c:	5d                   	pop    %ebp
 35d:	c3                   	ret    

0000035e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 35e:	f3 0f 1e fb          	endbr32 
 362:	55                   	push   %ebp
 363:	89 e5                	mov    %esp,%ebp
 365:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 36e:	90                   	nop
 36f:	8b 55 0c             	mov    0xc(%ebp),%edx
 372:	8d 42 01             	lea    0x1(%edx),%eax
 375:	89 45 0c             	mov    %eax,0xc(%ebp)
 378:	8b 45 08             	mov    0x8(%ebp),%eax
 37b:	8d 48 01             	lea    0x1(%eax),%ecx
 37e:	89 4d 08             	mov    %ecx,0x8(%ebp)
 381:	0f b6 12             	movzbl (%edx),%edx
 384:	88 10                	mov    %dl,(%eax)
 386:	0f b6 00             	movzbl (%eax),%eax
 389:	84 c0                	test   %al,%al
 38b:	75 e2                	jne    36f <strcpy+0x11>
    ;
  return os;
 38d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 390:	c9                   	leave  
 391:	c3                   	ret    

00000392 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 392:	f3 0f 1e fb          	endbr32 
 396:	55                   	push   %ebp
 397:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 399:	eb 08                	jmp    3a3 <strcmp+0x11>
    p++, q++;
 39b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 39f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 3a3:	8b 45 08             	mov    0x8(%ebp),%eax
 3a6:	0f b6 00             	movzbl (%eax),%eax
 3a9:	84 c0                	test   %al,%al
 3ab:	74 10                	je     3bd <strcmp+0x2b>
 3ad:	8b 45 08             	mov    0x8(%ebp),%eax
 3b0:	0f b6 10             	movzbl (%eax),%edx
 3b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b6:	0f b6 00             	movzbl (%eax),%eax
 3b9:	38 c2                	cmp    %al,%dl
 3bb:	74 de                	je     39b <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
 3bd:	8b 45 08             	mov    0x8(%ebp),%eax
 3c0:	0f b6 00             	movzbl (%eax),%eax
 3c3:	0f b6 d0             	movzbl %al,%edx
 3c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c9:	0f b6 00             	movzbl (%eax),%eax
 3cc:	0f b6 c0             	movzbl %al,%eax
 3cf:	29 c2                	sub    %eax,%edx
 3d1:	89 d0                	mov    %edx,%eax
}
 3d3:	5d                   	pop    %ebp
 3d4:	c3                   	ret    

000003d5 <strlen>:

uint
strlen(char *s)
{
 3d5:	f3 0f 1e fb          	endbr32 
 3d9:	55                   	push   %ebp
 3da:	89 e5                	mov    %esp,%ebp
 3dc:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3e6:	eb 04                	jmp    3ec <strlen+0x17>
 3e8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3ec:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3ef:	8b 45 08             	mov    0x8(%ebp),%eax
 3f2:	01 d0                	add    %edx,%eax
 3f4:	0f b6 00             	movzbl (%eax),%eax
 3f7:	84 c0                	test   %al,%al
 3f9:	75 ed                	jne    3e8 <strlen+0x13>
    ;
  return n;
 3fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3fe:	c9                   	leave  
 3ff:	c3                   	ret    

00000400 <memset>:

void*
memset(void *dst, int c, uint n)
{
 400:	f3 0f 1e fb          	endbr32 
 404:	55                   	push   %ebp
 405:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 407:	8b 45 10             	mov    0x10(%ebp),%eax
 40a:	50                   	push   %eax
 40b:	ff 75 0c             	pushl  0xc(%ebp)
 40e:	ff 75 08             	pushl  0x8(%ebp)
 411:	e8 22 ff ff ff       	call   338 <stosb>
 416:	83 c4 0c             	add    $0xc,%esp
  return dst;
 419:	8b 45 08             	mov    0x8(%ebp),%eax
}
 41c:	c9                   	leave  
 41d:	c3                   	ret    

0000041e <strchr>:

char*
strchr(const char *s, char c)
{
 41e:	f3 0f 1e fb          	endbr32 
 422:	55                   	push   %ebp
 423:	89 e5                	mov    %esp,%ebp
 425:	83 ec 04             	sub    $0x4,%esp
 428:	8b 45 0c             	mov    0xc(%ebp),%eax
 42b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 42e:	eb 14                	jmp    444 <strchr+0x26>
    if(*s == c)
 430:	8b 45 08             	mov    0x8(%ebp),%eax
 433:	0f b6 00             	movzbl (%eax),%eax
 436:	38 45 fc             	cmp    %al,-0x4(%ebp)
 439:	75 05                	jne    440 <strchr+0x22>
      return (char*)s;
 43b:	8b 45 08             	mov    0x8(%ebp),%eax
 43e:	eb 13                	jmp    453 <strchr+0x35>
  for(; *s; s++)
 440:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 444:	8b 45 08             	mov    0x8(%ebp),%eax
 447:	0f b6 00             	movzbl (%eax),%eax
 44a:	84 c0                	test   %al,%al
 44c:	75 e2                	jne    430 <strchr+0x12>
  return 0;
 44e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 453:	c9                   	leave  
 454:	c3                   	ret    

00000455 <gets>:

char*
gets(char *buf, int max)
{
 455:	f3 0f 1e fb          	endbr32 
 459:	55                   	push   %ebp
 45a:	89 e5                	mov    %esp,%ebp
 45c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 45f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 466:	eb 42                	jmp    4aa <gets+0x55>
    cc = read(0, &c, 1);
 468:	83 ec 04             	sub    $0x4,%esp
 46b:	6a 01                	push   $0x1
 46d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 470:	50                   	push   %eax
 471:	6a 00                	push   $0x0
 473:	e8 53 01 00 00       	call   5cb <read>
 478:	83 c4 10             	add    $0x10,%esp
 47b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 47e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 482:	7e 33                	jle    4b7 <gets+0x62>
      break;
    buf[i++] = c;
 484:	8b 45 f4             	mov    -0xc(%ebp),%eax
 487:	8d 50 01             	lea    0x1(%eax),%edx
 48a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 48d:	89 c2                	mov    %eax,%edx
 48f:	8b 45 08             	mov    0x8(%ebp),%eax
 492:	01 c2                	add    %eax,%edx
 494:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 498:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 49a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 49e:	3c 0a                	cmp    $0xa,%al
 4a0:	74 16                	je     4b8 <gets+0x63>
 4a2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4a6:	3c 0d                	cmp    $0xd,%al
 4a8:	74 0e                	je     4b8 <gets+0x63>
  for(i=0; i+1 < max; ){
 4aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ad:	83 c0 01             	add    $0x1,%eax
 4b0:	39 45 0c             	cmp    %eax,0xc(%ebp)
 4b3:	7f b3                	jg     468 <gets+0x13>
 4b5:	eb 01                	jmp    4b8 <gets+0x63>
      break;
 4b7:	90                   	nop
      break;
  }
  buf[i] = '\0';
 4b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4bb:	8b 45 08             	mov    0x8(%ebp),%eax
 4be:	01 d0                	add    %edx,%eax
 4c0:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4c6:	c9                   	leave  
 4c7:	c3                   	ret    

000004c8 <stat>:

int
stat(char *n, struct stat *st)
{
 4c8:	f3 0f 1e fb          	endbr32 
 4cc:	55                   	push   %ebp
 4cd:	89 e5                	mov    %esp,%ebp
 4cf:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4d2:	83 ec 08             	sub    $0x8,%esp
 4d5:	6a 00                	push   $0x0
 4d7:	ff 75 08             	pushl  0x8(%ebp)
 4da:	e8 14 01 00 00       	call   5f3 <open>
 4df:	83 c4 10             	add    $0x10,%esp
 4e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e9:	79 07                	jns    4f2 <stat+0x2a>
    return -1;
 4eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4f0:	eb 25                	jmp    517 <stat+0x4f>
  r = fstat(fd, st);
 4f2:	83 ec 08             	sub    $0x8,%esp
 4f5:	ff 75 0c             	pushl  0xc(%ebp)
 4f8:	ff 75 f4             	pushl  -0xc(%ebp)
 4fb:	e8 0b 01 00 00       	call   60b <fstat>
 500:	83 c4 10             	add    $0x10,%esp
 503:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 506:	83 ec 0c             	sub    $0xc,%esp
 509:	ff 75 f4             	pushl  -0xc(%ebp)
 50c:	e8 ca 00 00 00       	call   5db <close>
 511:	83 c4 10             	add    $0x10,%esp
  return r;
 514:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 517:	c9                   	leave  
 518:	c3                   	ret    

00000519 <atoi>:

int
atoi(const char *s)
{
 519:	f3 0f 1e fb          	endbr32 
 51d:	55                   	push   %ebp
 51e:	89 e5                	mov    %esp,%ebp
 520:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 523:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 52a:	eb 25                	jmp    551 <atoi+0x38>
    n = n*10 + *s++ - '0';
 52c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 52f:	89 d0                	mov    %edx,%eax
 531:	c1 e0 02             	shl    $0x2,%eax
 534:	01 d0                	add    %edx,%eax
 536:	01 c0                	add    %eax,%eax
 538:	89 c1                	mov    %eax,%ecx
 53a:	8b 45 08             	mov    0x8(%ebp),%eax
 53d:	8d 50 01             	lea    0x1(%eax),%edx
 540:	89 55 08             	mov    %edx,0x8(%ebp)
 543:	0f b6 00             	movzbl (%eax),%eax
 546:	0f be c0             	movsbl %al,%eax
 549:	01 c8                	add    %ecx,%eax
 54b:	83 e8 30             	sub    $0x30,%eax
 54e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 551:	8b 45 08             	mov    0x8(%ebp),%eax
 554:	0f b6 00             	movzbl (%eax),%eax
 557:	3c 2f                	cmp    $0x2f,%al
 559:	7e 0a                	jle    565 <atoi+0x4c>
 55b:	8b 45 08             	mov    0x8(%ebp),%eax
 55e:	0f b6 00             	movzbl (%eax),%eax
 561:	3c 39                	cmp    $0x39,%al
 563:	7e c7                	jle    52c <atoi+0x13>
  return n;
 565:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 568:	c9                   	leave  
 569:	c3                   	ret    

0000056a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 56a:	f3 0f 1e fb          	endbr32 
 56e:	55                   	push   %ebp
 56f:	89 e5                	mov    %esp,%ebp
 571:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 574:	8b 45 08             	mov    0x8(%ebp),%eax
 577:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 57a:	8b 45 0c             	mov    0xc(%ebp),%eax
 57d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 580:	eb 17                	jmp    599 <memmove+0x2f>
    *dst++ = *src++;
 582:	8b 55 f8             	mov    -0x8(%ebp),%edx
 585:	8d 42 01             	lea    0x1(%edx),%eax
 588:	89 45 f8             	mov    %eax,-0x8(%ebp)
 58b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 58e:	8d 48 01             	lea    0x1(%eax),%ecx
 591:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 594:	0f b6 12             	movzbl (%edx),%edx
 597:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 599:	8b 45 10             	mov    0x10(%ebp),%eax
 59c:	8d 50 ff             	lea    -0x1(%eax),%edx
 59f:	89 55 10             	mov    %edx,0x10(%ebp)
 5a2:	85 c0                	test   %eax,%eax
 5a4:	7f dc                	jg     582 <memmove+0x18>
  return vdst;
 5a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5a9:	c9                   	leave  
 5aa:	c3                   	ret    

000005ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5ab:	b8 01 00 00 00       	mov    $0x1,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <exit>:
SYSCALL(exit)
 5b3:	b8 02 00 00 00       	mov    $0x2,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <wait>:
SYSCALL(wait)
 5bb:	b8 03 00 00 00       	mov    $0x3,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <pipe>:
SYSCALL(pipe)
 5c3:	b8 04 00 00 00       	mov    $0x4,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <read>:
SYSCALL(read)
 5cb:	b8 05 00 00 00       	mov    $0x5,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <write>:
SYSCALL(write)
 5d3:	b8 10 00 00 00       	mov    $0x10,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <close>:
SYSCALL(close)
 5db:	b8 15 00 00 00       	mov    $0x15,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <kill>:
SYSCALL(kill)
 5e3:	b8 06 00 00 00       	mov    $0x6,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <exec>:
SYSCALL(exec)
 5eb:	b8 07 00 00 00       	mov    $0x7,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <open>:
SYSCALL(open)
 5f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <mknod>:
SYSCALL(mknod)
 5fb:	b8 11 00 00 00       	mov    $0x11,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <unlink>:
SYSCALL(unlink)
 603:	b8 12 00 00 00       	mov    $0x12,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <fstat>:
SYSCALL(fstat)
 60b:	b8 08 00 00 00       	mov    $0x8,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <link>:
SYSCALL(link)
 613:	b8 13 00 00 00       	mov    $0x13,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <mkdir>:
SYSCALL(mkdir)
 61b:	b8 14 00 00 00       	mov    $0x14,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <chdir>:
SYSCALL(chdir)
 623:	b8 09 00 00 00       	mov    $0x9,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <dup>:
SYSCALL(dup)
 62b:	b8 0a 00 00 00       	mov    $0xa,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <getpid>:
SYSCALL(getpid)
 633:	b8 0b 00 00 00       	mov    $0xb,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <sbrk>:
SYSCALL(sbrk)
 63b:	b8 0c 00 00 00       	mov    $0xc,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <sleep>:
SYSCALL(sleep)
 643:	b8 0d 00 00 00       	mov    $0xd,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <uptime>:
SYSCALL(uptime)
 64b:	b8 0e 00 00 00       	mov    $0xe,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 653:	f3 0f 1e fb          	endbr32 
 657:	55                   	push   %ebp
 658:	89 e5                	mov    %esp,%ebp
 65a:	83 ec 18             	sub    $0x18,%esp
 65d:	8b 45 0c             	mov    0xc(%ebp),%eax
 660:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 663:	83 ec 04             	sub    $0x4,%esp
 666:	6a 01                	push   $0x1
 668:	8d 45 f4             	lea    -0xc(%ebp),%eax
 66b:	50                   	push   %eax
 66c:	ff 75 08             	pushl  0x8(%ebp)
 66f:	e8 5f ff ff ff       	call   5d3 <write>
 674:	83 c4 10             	add    $0x10,%esp
}
 677:	90                   	nop
 678:	c9                   	leave  
 679:	c3                   	ret    

0000067a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 67a:	f3 0f 1e fb          	endbr32 
 67e:	55                   	push   %ebp
 67f:	89 e5                	mov    %esp,%ebp
 681:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 684:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 68b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 68f:	74 17                	je     6a8 <printint+0x2e>
 691:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 695:	79 11                	jns    6a8 <printint+0x2e>
    neg = 1;
 697:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 69e:	8b 45 0c             	mov    0xc(%ebp),%eax
 6a1:	f7 d8                	neg    %eax
 6a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6a6:	eb 06                	jmp    6ae <printint+0x34>
  } else {
    x = xx;
 6a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 6ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6bb:	ba 00 00 00 00       	mov    $0x0,%edx
 6c0:	f7 f1                	div    %ecx
 6c2:	89 d1                	mov    %edx,%ecx
 6c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c7:	8d 50 01             	lea    0x1(%eax),%edx
 6ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6cd:	0f b6 91 00 0e 00 00 	movzbl 0xe00(%ecx),%edx
 6d4:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 6d8:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6db:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6de:	ba 00 00 00 00       	mov    $0x0,%edx
 6e3:	f7 f1                	div    %ecx
 6e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6ec:	75 c7                	jne    6b5 <printint+0x3b>
  if(neg)
 6ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6f2:	74 2d                	je     721 <printint+0xa7>
    buf[i++] = '-';
 6f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f7:	8d 50 01             	lea    0x1(%eax),%edx
 6fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6fd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 702:	eb 1d                	jmp    721 <printint+0xa7>
    putc(fd, buf[i]);
 704:	8d 55 dc             	lea    -0x24(%ebp),%edx
 707:	8b 45 f4             	mov    -0xc(%ebp),%eax
 70a:	01 d0                	add    %edx,%eax
 70c:	0f b6 00             	movzbl (%eax),%eax
 70f:	0f be c0             	movsbl %al,%eax
 712:	83 ec 08             	sub    $0x8,%esp
 715:	50                   	push   %eax
 716:	ff 75 08             	pushl  0x8(%ebp)
 719:	e8 35 ff ff ff       	call   653 <putc>
 71e:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 721:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 725:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 729:	79 d9                	jns    704 <printint+0x8a>
}
 72b:	90                   	nop
 72c:	90                   	nop
 72d:	c9                   	leave  
 72e:	c3                   	ret    

0000072f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 72f:	f3 0f 1e fb          	endbr32 
 733:	55                   	push   %ebp
 734:	89 e5                	mov    %esp,%ebp
 736:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 739:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 740:	8d 45 0c             	lea    0xc(%ebp),%eax
 743:	83 c0 04             	add    $0x4,%eax
 746:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 749:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 750:	e9 59 01 00 00       	jmp    8ae <printf+0x17f>
    c = fmt[i] & 0xff;
 755:	8b 55 0c             	mov    0xc(%ebp),%edx
 758:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75b:	01 d0                	add    %edx,%eax
 75d:	0f b6 00             	movzbl (%eax),%eax
 760:	0f be c0             	movsbl %al,%eax
 763:	25 ff 00 00 00       	and    $0xff,%eax
 768:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 76b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 76f:	75 2c                	jne    79d <printf+0x6e>
      if(c == '%'){
 771:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 775:	75 0c                	jne    783 <printf+0x54>
        state = '%';
 777:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 77e:	e9 27 01 00 00       	jmp    8aa <printf+0x17b>
      } else {
        putc(fd, c);
 783:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 786:	0f be c0             	movsbl %al,%eax
 789:	83 ec 08             	sub    $0x8,%esp
 78c:	50                   	push   %eax
 78d:	ff 75 08             	pushl  0x8(%ebp)
 790:	e8 be fe ff ff       	call   653 <putc>
 795:	83 c4 10             	add    $0x10,%esp
 798:	e9 0d 01 00 00       	jmp    8aa <printf+0x17b>
      }
    } else if(state == '%'){
 79d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7a1:	0f 85 03 01 00 00    	jne    8aa <printf+0x17b>
      if(c == 'd'){
 7a7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7ab:	75 1e                	jne    7cb <printf+0x9c>
        printint(fd, *ap, 10, 1);
 7ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7b0:	8b 00                	mov    (%eax),%eax
 7b2:	6a 01                	push   $0x1
 7b4:	6a 0a                	push   $0xa
 7b6:	50                   	push   %eax
 7b7:	ff 75 08             	pushl  0x8(%ebp)
 7ba:	e8 bb fe ff ff       	call   67a <printint>
 7bf:	83 c4 10             	add    $0x10,%esp
        ap++;
 7c2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7c6:	e9 d8 00 00 00       	jmp    8a3 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 7cb:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7cf:	74 06                	je     7d7 <printf+0xa8>
 7d1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 7d5:	75 1e                	jne    7f5 <printf+0xc6>
        printint(fd, *ap, 16, 0);
 7d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7da:	8b 00                	mov    (%eax),%eax
 7dc:	6a 00                	push   $0x0
 7de:	6a 10                	push   $0x10
 7e0:	50                   	push   %eax
 7e1:	ff 75 08             	pushl  0x8(%ebp)
 7e4:	e8 91 fe ff ff       	call   67a <printint>
 7e9:	83 c4 10             	add    $0x10,%esp
        ap++;
 7ec:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7f0:	e9 ae 00 00 00       	jmp    8a3 <printf+0x174>
      } else if(c == 's'){
 7f5:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7f9:	75 43                	jne    83e <printf+0x10f>
        s = (char*)*ap;
 7fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7fe:	8b 00                	mov    (%eax),%eax
 800:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 803:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 807:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 80b:	75 25                	jne    832 <printf+0x103>
          s = "(null)";
 80d:	c7 45 f4 2e 0b 00 00 	movl   $0xb2e,-0xc(%ebp)
        while(*s != 0){
 814:	eb 1c                	jmp    832 <printf+0x103>
          putc(fd, *s);
 816:	8b 45 f4             	mov    -0xc(%ebp),%eax
 819:	0f b6 00             	movzbl (%eax),%eax
 81c:	0f be c0             	movsbl %al,%eax
 81f:	83 ec 08             	sub    $0x8,%esp
 822:	50                   	push   %eax
 823:	ff 75 08             	pushl  0x8(%ebp)
 826:	e8 28 fe ff ff       	call   653 <putc>
 82b:	83 c4 10             	add    $0x10,%esp
          s++;
 82e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 832:	8b 45 f4             	mov    -0xc(%ebp),%eax
 835:	0f b6 00             	movzbl (%eax),%eax
 838:	84 c0                	test   %al,%al
 83a:	75 da                	jne    816 <printf+0xe7>
 83c:	eb 65                	jmp    8a3 <printf+0x174>
        }
      } else if(c == 'c'){
 83e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 842:	75 1d                	jne    861 <printf+0x132>
        putc(fd, *ap);
 844:	8b 45 e8             	mov    -0x18(%ebp),%eax
 847:	8b 00                	mov    (%eax),%eax
 849:	0f be c0             	movsbl %al,%eax
 84c:	83 ec 08             	sub    $0x8,%esp
 84f:	50                   	push   %eax
 850:	ff 75 08             	pushl  0x8(%ebp)
 853:	e8 fb fd ff ff       	call   653 <putc>
 858:	83 c4 10             	add    $0x10,%esp
        ap++;
 85b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 85f:	eb 42                	jmp    8a3 <printf+0x174>
      } else if(c == '%'){
 861:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 865:	75 17                	jne    87e <printf+0x14f>
        putc(fd, c);
 867:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 86a:	0f be c0             	movsbl %al,%eax
 86d:	83 ec 08             	sub    $0x8,%esp
 870:	50                   	push   %eax
 871:	ff 75 08             	pushl  0x8(%ebp)
 874:	e8 da fd ff ff       	call   653 <putc>
 879:	83 c4 10             	add    $0x10,%esp
 87c:	eb 25                	jmp    8a3 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 87e:	83 ec 08             	sub    $0x8,%esp
 881:	6a 25                	push   $0x25
 883:	ff 75 08             	pushl  0x8(%ebp)
 886:	e8 c8 fd ff ff       	call   653 <putc>
 88b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 88e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 891:	0f be c0             	movsbl %al,%eax
 894:	83 ec 08             	sub    $0x8,%esp
 897:	50                   	push   %eax
 898:	ff 75 08             	pushl  0x8(%ebp)
 89b:	e8 b3 fd ff ff       	call   653 <putc>
 8a0:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 8a3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 8aa:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 8ae:	8b 55 0c             	mov    0xc(%ebp),%edx
 8b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b4:	01 d0                	add    %edx,%eax
 8b6:	0f b6 00             	movzbl (%eax),%eax
 8b9:	84 c0                	test   %al,%al
 8bb:	0f 85 94 fe ff ff    	jne    755 <printf+0x26>
    }
  }
}
 8c1:	90                   	nop
 8c2:	90                   	nop
 8c3:	c9                   	leave  
 8c4:	c3                   	ret    

000008c5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c5:	f3 0f 1e fb          	endbr32 
 8c9:	55                   	push   %ebp
 8ca:	89 e5                	mov    %esp,%ebp
 8cc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8cf:	8b 45 08             	mov    0x8(%ebp),%eax
 8d2:	83 e8 08             	sub    $0x8,%eax
 8d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d8:	a1 28 0e 00 00       	mov    0xe28,%eax
 8dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8e0:	eb 24                	jmp    906 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e5:	8b 00                	mov    (%eax),%eax
 8e7:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 8ea:	72 12                	jb     8fe <free+0x39>
 8ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ef:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8f2:	77 24                	ja     918 <free+0x53>
 8f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f7:	8b 00                	mov    (%eax),%eax
 8f9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 8fc:	72 1a                	jb     918 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 901:	8b 00                	mov    (%eax),%eax
 903:	89 45 fc             	mov    %eax,-0x4(%ebp)
 906:	8b 45 f8             	mov    -0x8(%ebp),%eax
 909:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 90c:	76 d4                	jbe    8e2 <free+0x1d>
 90e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 911:	8b 00                	mov    (%eax),%eax
 913:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 916:	73 ca                	jae    8e2 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 918:	8b 45 f8             	mov    -0x8(%ebp),%eax
 91b:	8b 40 04             	mov    0x4(%eax),%eax
 91e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 925:	8b 45 f8             	mov    -0x8(%ebp),%eax
 928:	01 c2                	add    %eax,%edx
 92a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92d:	8b 00                	mov    (%eax),%eax
 92f:	39 c2                	cmp    %eax,%edx
 931:	75 24                	jne    957 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 933:	8b 45 f8             	mov    -0x8(%ebp),%eax
 936:	8b 50 04             	mov    0x4(%eax),%edx
 939:	8b 45 fc             	mov    -0x4(%ebp),%eax
 93c:	8b 00                	mov    (%eax),%eax
 93e:	8b 40 04             	mov    0x4(%eax),%eax
 941:	01 c2                	add    %eax,%edx
 943:	8b 45 f8             	mov    -0x8(%ebp),%eax
 946:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 949:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94c:	8b 00                	mov    (%eax),%eax
 94e:	8b 10                	mov    (%eax),%edx
 950:	8b 45 f8             	mov    -0x8(%ebp),%eax
 953:	89 10                	mov    %edx,(%eax)
 955:	eb 0a                	jmp    961 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 957:	8b 45 fc             	mov    -0x4(%ebp),%eax
 95a:	8b 10                	mov    (%eax),%edx
 95c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 961:	8b 45 fc             	mov    -0x4(%ebp),%eax
 964:	8b 40 04             	mov    0x4(%eax),%eax
 967:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 96e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 971:	01 d0                	add    %edx,%eax
 973:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 976:	75 20                	jne    998 <free+0xd3>
    p->s.size += bp->s.size;
 978:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97b:	8b 50 04             	mov    0x4(%eax),%edx
 97e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 981:	8b 40 04             	mov    0x4(%eax),%eax
 984:	01 c2                	add    %eax,%edx
 986:	8b 45 fc             	mov    -0x4(%ebp),%eax
 989:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 98c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 98f:	8b 10                	mov    (%eax),%edx
 991:	8b 45 fc             	mov    -0x4(%ebp),%eax
 994:	89 10                	mov    %edx,(%eax)
 996:	eb 08                	jmp    9a0 <free+0xdb>
  } else
    p->s.ptr = bp;
 998:	8b 45 fc             	mov    -0x4(%ebp),%eax
 99b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 99e:	89 10                	mov    %edx,(%eax)
  freep = p;
 9a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a3:	a3 28 0e 00 00       	mov    %eax,0xe28
}
 9a8:	90                   	nop
 9a9:	c9                   	leave  
 9aa:	c3                   	ret    

000009ab <morecore>:

static Header*
morecore(uint nu)
{
 9ab:	f3 0f 1e fb          	endbr32 
 9af:	55                   	push   %ebp
 9b0:	89 e5                	mov    %esp,%ebp
 9b2:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9b5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9bc:	77 07                	ja     9c5 <morecore+0x1a>
    nu = 4096;
 9be:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 9c5:	8b 45 08             	mov    0x8(%ebp),%eax
 9c8:	c1 e0 03             	shl    $0x3,%eax
 9cb:	83 ec 0c             	sub    $0xc,%esp
 9ce:	50                   	push   %eax
 9cf:	e8 67 fc ff ff       	call   63b <sbrk>
 9d4:	83 c4 10             	add    $0x10,%esp
 9d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 9da:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 9de:	75 07                	jne    9e7 <morecore+0x3c>
    return 0;
 9e0:	b8 00 00 00 00       	mov    $0x0,%eax
 9e5:	eb 26                	jmp    a0d <morecore+0x62>
  hp = (Header*)p;
 9e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 9ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9f0:	8b 55 08             	mov    0x8(%ebp),%edx
 9f3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9f9:	83 c0 08             	add    $0x8,%eax
 9fc:	83 ec 0c             	sub    $0xc,%esp
 9ff:	50                   	push   %eax
 a00:	e8 c0 fe ff ff       	call   8c5 <free>
 a05:	83 c4 10             	add    $0x10,%esp
  return freep;
 a08:	a1 28 0e 00 00       	mov    0xe28,%eax
}
 a0d:	c9                   	leave  
 a0e:	c3                   	ret    

00000a0f <malloc>:

void*
malloc(uint nbytes)
{
 a0f:	f3 0f 1e fb          	endbr32 
 a13:	55                   	push   %ebp
 a14:	89 e5                	mov    %esp,%ebp
 a16:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a19:	8b 45 08             	mov    0x8(%ebp),%eax
 a1c:	83 c0 07             	add    $0x7,%eax
 a1f:	c1 e8 03             	shr    $0x3,%eax
 a22:	83 c0 01             	add    $0x1,%eax
 a25:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a28:	a1 28 0e 00 00       	mov    0xe28,%eax
 a2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a30:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a34:	75 23                	jne    a59 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 a36:	c7 45 f0 20 0e 00 00 	movl   $0xe20,-0x10(%ebp)
 a3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a40:	a3 28 0e 00 00       	mov    %eax,0xe28
 a45:	a1 28 0e 00 00       	mov    0xe28,%eax
 a4a:	a3 20 0e 00 00       	mov    %eax,0xe20
    base.s.size = 0;
 a4f:	c7 05 24 0e 00 00 00 	movl   $0x0,0xe24
 a56:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a59:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a5c:	8b 00                	mov    (%eax),%eax
 a5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a64:	8b 40 04             	mov    0x4(%eax),%eax
 a67:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 a6a:	77 4d                	ja     ab9 <malloc+0xaa>
      if(p->s.size == nunits)
 a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6f:	8b 40 04             	mov    0x4(%eax),%eax
 a72:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 a75:	75 0c                	jne    a83 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a7a:	8b 10                	mov    (%eax),%edx
 a7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a7f:	89 10                	mov    %edx,(%eax)
 a81:	eb 26                	jmp    aa9 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 a83:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a86:	8b 40 04             	mov    0x4(%eax),%eax
 a89:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a8c:	89 c2                	mov    %eax,%edx
 a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a91:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a97:	8b 40 04             	mov    0x4(%eax),%eax
 a9a:	c1 e0 03             	shl    $0x3,%eax
 a9d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa3:	8b 55 ec             	mov    -0x14(%ebp),%edx
 aa6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 aa9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aac:	a3 28 0e 00 00       	mov    %eax,0xe28
      return (void*)(p + 1);
 ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab4:	83 c0 08             	add    $0x8,%eax
 ab7:	eb 3b                	jmp    af4 <malloc+0xe5>
    }
    if(p == freep)
 ab9:	a1 28 0e 00 00       	mov    0xe28,%eax
 abe:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 ac1:	75 1e                	jne    ae1 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 ac3:	83 ec 0c             	sub    $0xc,%esp
 ac6:	ff 75 ec             	pushl  -0x14(%ebp)
 ac9:	e8 dd fe ff ff       	call   9ab <morecore>
 ace:	83 c4 10             	add    $0x10,%esp
 ad1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 ad4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ad8:	75 07                	jne    ae1 <malloc+0xd2>
        return 0;
 ada:	b8 00 00 00 00       	mov    $0x0,%eax
 adf:	eb 13                	jmp    af4 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 ae7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aea:	8b 00                	mov    (%eax),%eax
 aec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 aef:	e9 6d ff ff ff       	jmp    a61 <malloc+0x52>
  }
}
 af4:	c9                   	leave  
 af5:	c3                   	ret    
