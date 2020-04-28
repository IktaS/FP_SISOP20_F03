
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <opentest>:

// simple file system tests

void
opentest(void)
{
       0:	f3 0f 1e fb          	endbr32 
       4:	55                   	push   %ebp
       5:	89 e5                	mov    %esp,%ebp
       7:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
       a:	a1 38 5f 00 00       	mov    0x5f38,%eax
       f:	83 ec 08             	sub    $0x8,%esp
      12:	68 02 42 00 00       	push   $0x4202
      17:	50                   	push   %eax
      18:	e8 07 3e 00 00       	call   3e24 <printf>
      1d:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
      20:	83 ec 08             	sub    $0x8,%esp
      23:	6a 00                	push   $0x0
      25:	68 ec 41 00 00       	push   $0x41ec
      2a:	e8 b9 3c 00 00       	call   3ce8 <open>
      2f:	83 c4 10             	add    $0x10,%esp
      32:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
      35:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      39:	79 1b                	jns    56 <opentest+0x56>
    printf(stdout, "open echo failed!\n");
      3b:	a1 38 5f 00 00       	mov    0x5f38,%eax
      40:	83 ec 08             	sub    $0x8,%esp
      43:	68 0d 42 00 00       	push   $0x420d
      48:	50                   	push   %eax
      49:	e8 d6 3d 00 00       	call   3e24 <printf>
      4e:	83 c4 10             	add    $0x10,%esp
    exit();
      51:	e8 52 3c 00 00       	call   3ca8 <exit>
  }
  close(fd);
      56:	83 ec 0c             	sub    $0xc,%esp
      59:	ff 75 f4             	pushl  -0xc(%ebp)
      5c:	e8 6f 3c 00 00       	call   3cd0 <close>
      61:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
      64:	83 ec 08             	sub    $0x8,%esp
      67:	6a 00                	push   $0x0
      69:	68 20 42 00 00       	push   $0x4220
      6e:	e8 75 3c 00 00       	call   3ce8 <open>
      73:	83 c4 10             	add    $0x10,%esp
      76:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
      79:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      7d:	78 1b                	js     9a <opentest+0x9a>
    printf(stdout, "open doesnotexist succeeded!\n");
      7f:	a1 38 5f 00 00       	mov    0x5f38,%eax
      84:	83 ec 08             	sub    $0x8,%esp
      87:	68 2d 42 00 00       	push   $0x422d
      8c:	50                   	push   %eax
      8d:	e8 92 3d 00 00       	call   3e24 <printf>
      92:	83 c4 10             	add    $0x10,%esp
    exit();
      95:	e8 0e 3c 00 00       	call   3ca8 <exit>
  }
  printf(stdout, "open test ok\n");
      9a:	a1 38 5f 00 00       	mov    0x5f38,%eax
      9f:	83 ec 08             	sub    $0x8,%esp
      a2:	68 4b 42 00 00       	push   $0x424b
      a7:	50                   	push   %eax
      a8:	e8 77 3d 00 00       	call   3e24 <printf>
      ad:	83 c4 10             	add    $0x10,%esp
}
      b0:	90                   	nop
      b1:	c9                   	leave  
      b2:	c3                   	ret    

000000b3 <writetest>:

void
writetest(void)
{
      b3:	f3 0f 1e fb          	endbr32 
      b7:	55                   	push   %ebp
      b8:	89 e5                	mov    %esp,%ebp
      ba:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
      bd:	a1 38 5f 00 00       	mov    0x5f38,%eax
      c2:	83 ec 08             	sub    $0x8,%esp
      c5:	68 59 42 00 00       	push   $0x4259
      ca:	50                   	push   %eax
      cb:	e8 54 3d 00 00       	call   3e24 <printf>
      d0:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
      d3:	83 ec 08             	sub    $0x8,%esp
      d6:	68 02 02 00 00       	push   $0x202
      db:	68 6a 42 00 00       	push   $0x426a
      e0:	e8 03 3c 00 00       	call   3ce8 <open>
      e5:	83 c4 10             	add    $0x10,%esp
      e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
      eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      ef:	78 22                	js     113 <writetest+0x60>
    printf(stdout, "creat small succeeded; ok\n");
      f1:	a1 38 5f 00 00       	mov    0x5f38,%eax
      f6:	83 ec 08             	sub    $0x8,%esp
      f9:	68 70 42 00 00       	push   $0x4270
      fe:	50                   	push   %eax
      ff:	e8 20 3d 00 00       	call   3e24 <printf>
     104:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     107:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     10e:	e9 8f 00 00 00       	jmp    1a2 <writetest+0xef>
    printf(stdout, "error: creat small failed!\n");
     113:	a1 38 5f 00 00       	mov    0x5f38,%eax
     118:	83 ec 08             	sub    $0x8,%esp
     11b:	68 8b 42 00 00       	push   $0x428b
     120:	50                   	push   %eax
     121:	e8 fe 3c 00 00       	call   3e24 <printf>
     126:	83 c4 10             	add    $0x10,%esp
    exit();
     129:	e8 7a 3b 00 00       	call   3ca8 <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     12e:	83 ec 04             	sub    $0x4,%esp
     131:	6a 0a                	push   $0xa
     133:	68 a7 42 00 00       	push   $0x42a7
     138:	ff 75 f0             	pushl  -0x10(%ebp)
     13b:	e8 88 3b 00 00       	call   3cc8 <write>
     140:	83 c4 10             	add    $0x10,%esp
     143:	83 f8 0a             	cmp    $0xa,%eax
     146:	74 1e                	je     166 <writetest+0xb3>
      printf(stdout, "error: write aa %d new file failed\n", i);
     148:	a1 38 5f 00 00       	mov    0x5f38,%eax
     14d:	83 ec 04             	sub    $0x4,%esp
     150:	ff 75 f4             	pushl  -0xc(%ebp)
     153:	68 b4 42 00 00       	push   $0x42b4
     158:	50                   	push   %eax
     159:	e8 c6 3c 00 00       	call   3e24 <printf>
     15e:	83 c4 10             	add    $0x10,%esp
      exit();
     161:	e8 42 3b 00 00       	call   3ca8 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     166:	83 ec 04             	sub    $0x4,%esp
     169:	6a 0a                	push   $0xa
     16b:	68 d8 42 00 00       	push   $0x42d8
     170:	ff 75 f0             	pushl  -0x10(%ebp)
     173:	e8 50 3b 00 00       	call   3cc8 <write>
     178:	83 c4 10             	add    $0x10,%esp
     17b:	83 f8 0a             	cmp    $0xa,%eax
     17e:	74 1e                	je     19e <writetest+0xeb>
      printf(stdout, "error: write bb %d new file failed\n", i);
     180:	a1 38 5f 00 00       	mov    0x5f38,%eax
     185:	83 ec 04             	sub    $0x4,%esp
     188:	ff 75 f4             	pushl  -0xc(%ebp)
     18b:	68 e4 42 00 00       	push   $0x42e4
     190:	50                   	push   %eax
     191:	e8 8e 3c 00 00       	call   3e24 <printf>
     196:	83 c4 10             	add    $0x10,%esp
      exit();
     199:	e8 0a 3b 00 00       	call   3ca8 <exit>
  for(i = 0; i < 100; i++){
     19e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1a2:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     1a6:	7e 86                	jle    12e <writetest+0x7b>
    }
  }
  printf(stdout, "writes ok\n");
     1a8:	a1 38 5f 00 00       	mov    0x5f38,%eax
     1ad:	83 ec 08             	sub    $0x8,%esp
     1b0:	68 08 43 00 00       	push   $0x4308
     1b5:	50                   	push   %eax
     1b6:	e8 69 3c 00 00       	call   3e24 <printf>
     1bb:	83 c4 10             	add    $0x10,%esp
  close(fd);
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	ff 75 f0             	pushl  -0x10(%ebp)
     1c4:	e8 07 3b 00 00       	call   3cd0 <close>
     1c9:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     1cc:	83 ec 08             	sub    $0x8,%esp
     1cf:	6a 00                	push   $0x0
     1d1:	68 6a 42 00 00       	push   $0x426a
     1d6:	e8 0d 3b 00 00       	call   3ce8 <open>
     1db:	83 c4 10             	add    $0x10,%esp
     1de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     1e1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1e5:	78 3c                	js     223 <writetest+0x170>
    printf(stdout, "open small succeeded ok\n");
     1e7:	a1 38 5f 00 00       	mov    0x5f38,%eax
     1ec:	83 ec 08             	sub    $0x8,%esp
     1ef:	68 13 43 00 00       	push   $0x4313
     1f4:	50                   	push   %eax
     1f5:	e8 2a 3c 00 00       	call   3e24 <printf>
     1fa:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     1fd:	83 ec 04             	sub    $0x4,%esp
     200:	68 d0 07 00 00       	push   $0x7d0
     205:	68 20 87 00 00       	push   $0x8720
     20a:	ff 75 f0             	pushl  -0x10(%ebp)
     20d:	e8 ae 3a 00 00       	call   3cc0 <read>
     212:	83 c4 10             	add    $0x10,%esp
     215:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     218:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     21f:	75 57                	jne    278 <writetest+0x1c5>
     221:	eb 1b                	jmp    23e <writetest+0x18b>
    printf(stdout, "error: open small failed!\n");
     223:	a1 38 5f 00 00       	mov    0x5f38,%eax
     228:	83 ec 08             	sub    $0x8,%esp
     22b:	68 2c 43 00 00       	push   $0x432c
     230:	50                   	push   %eax
     231:	e8 ee 3b 00 00       	call   3e24 <printf>
     236:	83 c4 10             	add    $0x10,%esp
    exit();
     239:	e8 6a 3a 00 00       	call   3ca8 <exit>
    printf(stdout, "read succeeded ok\n");
     23e:	a1 38 5f 00 00       	mov    0x5f38,%eax
     243:	83 ec 08             	sub    $0x8,%esp
     246:	68 47 43 00 00       	push   $0x4347
     24b:	50                   	push   %eax
     24c:	e8 d3 3b 00 00       	call   3e24 <printf>
     251:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     254:	83 ec 0c             	sub    $0xc,%esp
     257:	ff 75 f0             	pushl  -0x10(%ebp)
     25a:	e8 71 3a 00 00       	call   3cd0 <close>
     25f:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
     262:	83 ec 0c             	sub    $0xc,%esp
     265:	68 6a 42 00 00       	push   $0x426a
     26a:	e8 89 3a 00 00       	call   3cf8 <unlink>
     26f:	83 c4 10             	add    $0x10,%esp
     272:	85 c0                	test   %eax,%eax
     274:	79 38                	jns    2ae <writetest+0x1fb>
     276:	eb 1b                	jmp    293 <writetest+0x1e0>
    printf(stdout, "read failed\n");
     278:	a1 38 5f 00 00       	mov    0x5f38,%eax
     27d:	83 ec 08             	sub    $0x8,%esp
     280:	68 5a 43 00 00       	push   $0x435a
     285:	50                   	push   %eax
     286:	e8 99 3b 00 00       	call   3e24 <printf>
     28b:	83 c4 10             	add    $0x10,%esp
    exit();
     28e:	e8 15 3a 00 00       	call   3ca8 <exit>
    printf(stdout, "unlink small failed\n");
     293:	a1 38 5f 00 00       	mov    0x5f38,%eax
     298:	83 ec 08             	sub    $0x8,%esp
     29b:	68 67 43 00 00       	push   $0x4367
     2a0:	50                   	push   %eax
     2a1:	e8 7e 3b 00 00       	call   3e24 <printf>
     2a6:	83 c4 10             	add    $0x10,%esp
    exit();
     2a9:	e8 fa 39 00 00       	call   3ca8 <exit>
  }
  printf(stdout, "small file test ok\n");
     2ae:	a1 38 5f 00 00       	mov    0x5f38,%eax
     2b3:	83 ec 08             	sub    $0x8,%esp
     2b6:	68 7c 43 00 00       	push   $0x437c
     2bb:	50                   	push   %eax
     2bc:	e8 63 3b 00 00       	call   3e24 <printf>
     2c1:	83 c4 10             	add    $0x10,%esp
}
     2c4:	90                   	nop
     2c5:	c9                   	leave  
     2c6:	c3                   	ret    

000002c7 <writetest1>:

void
writetest1(void)
{
     2c7:	f3 0f 1e fb          	endbr32 
     2cb:	55                   	push   %ebp
     2cc:	89 e5                	mov    %esp,%ebp
     2ce:	83 ec 18             	sub    $0x18,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     2d1:	a1 38 5f 00 00       	mov    0x5f38,%eax
     2d6:	83 ec 08             	sub    $0x8,%esp
     2d9:	68 90 43 00 00       	push   $0x4390
     2de:	50                   	push   %eax
     2df:	e8 40 3b 00 00       	call   3e24 <printf>
     2e4:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
     2e7:	83 ec 08             	sub    $0x8,%esp
     2ea:	68 02 02 00 00       	push   $0x202
     2ef:	68 a0 43 00 00       	push   $0x43a0
     2f4:	e8 ef 39 00 00       	call   3ce8 <open>
     2f9:	83 c4 10             	add    $0x10,%esp
     2fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     2ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     303:	79 1b                	jns    320 <writetest1+0x59>
    printf(stdout, "error: creat big failed!\n");
     305:	a1 38 5f 00 00       	mov    0x5f38,%eax
     30a:	83 ec 08             	sub    $0x8,%esp
     30d:	68 a4 43 00 00       	push   $0x43a4
     312:	50                   	push   %eax
     313:	e8 0c 3b 00 00       	call   3e24 <printf>
     318:	83 c4 10             	add    $0x10,%esp
    exit();
     31b:	e8 88 39 00 00       	call   3ca8 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     320:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     327:	eb 4b                	jmp    374 <writetest1+0xad>
    ((int*)buf)[0] = i;
     329:	ba 20 87 00 00       	mov    $0x8720,%edx
     32e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     331:	89 02                	mov    %eax,(%edx)
    if(write(fd, buf, 512) != 512){
     333:	83 ec 04             	sub    $0x4,%esp
     336:	68 00 02 00 00       	push   $0x200
     33b:	68 20 87 00 00       	push   $0x8720
     340:	ff 75 ec             	pushl  -0x14(%ebp)
     343:	e8 80 39 00 00       	call   3cc8 <write>
     348:	83 c4 10             	add    $0x10,%esp
     34b:	3d 00 02 00 00       	cmp    $0x200,%eax
     350:	74 1e                	je     370 <writetest1+0xa9>
      printf(stdout, "error: write big file failed\n", i);
     352:	a1 38 5f 00 00       	mov    0x5f38,%eax
     357:	83 ec 04             	sub    $0x4,%esp
     35a:	ff 75 f4             	pushl  -0xc(%ebp)
     35d:	68 be 43 00 00       	push   $0x43be
     362:	50                   	push   %eax
     363:	e8 bc 3a 00 00       	call   3e24 <printf>
     368:	83 c4 10             	add    $0x10,%esp
      exit();
     36b:	e8 38 39 00 00       	call   3ca8 <exit>
  for(i = 0; i < MAXFILE; i++){
     370:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     374:	8b 45 f4             	mov    -0xc(%ebp),%eax
     377:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     37c:	76 ab                	jbe    329 <writetest1+0x62>
    }
  }

  close(fd);
     37e:	83 ec 0c             	sub    $0xc,%esp
     381:	ff 75 ec             	pushl  -0x14(%ebp)
     384:	e8 47 39 00 00       	call   3cd0 <close>
     389:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
     38c:	83 ec 08             	sub    $0x8,%esp
     38f:	6a 00                	push   $0x0
     391:	68 a0 43 00 00       	push   $0x43a0
     396:	e8 4d 39 00 00       	call   3ce8 <open>
     39b:	83 c4 10             	add    $0x10,%esp
     39e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     3a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     3a5:	79 1b                	jns    3c2 <writetest1+0xfb>
    printf(stdout, "error: open big failed!\n");
     3a7:	a1 38 5f 00 00       	mov    0x5f38,%eax
     3ac:	83 ec 08             	sub    $0x8,%esp
     3af:	68 dc 43 00 00       	push   $0x43dc
     3b4:	50                   	push   %eax
     3b5:	e8 6a 3a 00 00       	call   3e24 <printf>
     3ba:	83 c4 10             	add    $0x10,%esp
    exit();
     3bd:	e8 e6 38 00 00       	call   3ca8 <exit>
  }

  n = 0;
     3c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     3c9:	83 ec 04             	sub    $0x4,%esp
     3cc:	68 00 02 00 00       	push   $0x200
     3d1:	68 20 87 00 00       	push   $0x8720
     3d6:	ff 75 ec             	pushl  -0x14(%ebp)
     3d9:	e8 e2 38 00 00       	call   3cc0 <read>
     3de:	83 c4 10             	add    $0x10,%esp
     3e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     3e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3e8:	75 27                	jne    411 <writetest1+0x14a>
      if(n == MAXFILE - 1){
     3ea:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     3f1:	75 7d                	jne    470 <writetest1+0x1a9>
        printf(stdout, "read only %d blocks from big", n);
     3f3:	a1 38 5f 00 00       	mov    0x5f38,%eax
     3f8:	83 ec 04             	sub    $0x4,%esp
     3fb:	ff 75 f0             	pushl  -0x10(%ebp)
     3fe:	68 f5 43 00 00       	push   $0x43f5
     403:	50                   	push   %eax
     404:	e8 1b 3a 00 00       	call   3e24 <printf>
     409:	83 c4 10             	add    $0x10,%esp
        exit();
     40c:	e8 97 38 00 00       	call   3ca8 <exit>
      }
      break;
    } else if(i != 512){
     411:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     418:	74 1e                	je     438 <writetest1+0x171>
      printf(stdout, "read failed %d\n", i);
     41a:	a1 38 5f 00 00       	mov    0x5f38,%eax
     41f:	83 ec 04             	sub    $0x4,%esp
     422:	ff 75 f4             	pushl  -0xc(%ebp)
     425:	68 12 44 00 00       	push   $0x4412
     42a:	50                   	push   %eax
     42b:	e8 f4 39 00 00       	call   3e24 <printf>
     430:	83 c4 10             	add    $0x10,%esp
      exit();
     433:	e8 70 38 00 00       	call   3ca8 <exit>
    }
    if(((int*)buf)[0] != n){
     438:	b8 20 87 00 00       	mov    $0x8720,%eax
     43d:	8b 00                	mov    (%eax),%eax
     43f:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     442:	74 23                	je     467 <writetest1+0x1a0>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     444:	b8 20 87 00 00       	mov    $0x8720,%eax
      printf(stdout, "read content of block %d is %d\n",
     449:	8b 10                	mov    (%eax),%edx
     44b:	a1 38 5f 00 00       	mov    0x5f38,%eax
     450:	52                   	push   %edx
     451:	ff 75 f0             	pushl  -0x10(%ebp)
     454:	68 24 44 00 00       	push   $0x4424
     459:	50                   	push   %eax
     45a:	e8 c5 39 00 00       	call   3e24 <printf>
     45f:	83 c4 10             	add    $0x10,%esp
      exit();
     462:	e8 41 38 00 00       	call   3ca8 <exit>
    }
    n++;
     467:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    i = read(fd, buf, 512);
     46b:	e9 59 ff ff ff       	jmp    3c9 <writetest1+0x102>
      break;
     470:	90                   	nop
  }
  close(fd);
     471:	83 ec 0c             	sub    $0xc,%esp
     474:	ff 75 ec             	pushl  -0x14(%ebp)
     477:	e8 54 38 00 00       	call   3cd0 <close>
     47c:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
     47f:	83 ec 0c             	sub    $0xc,%esp
     482:	68 a0 43 00 00       	push   $0x43a0
     487:	e8 6c 38 00 00       	call   3cf8 <unlink>
     48c:	83 c4 10             	add    $0x10,%esp
     48f:	85 c0                	test   %eax,%eax
     491:	79 1b                	jns    4ae <writetest1+0x1e7>
    printf(stdout, "unlink big failed\n");
     493:	a1 38 5f 00 00       	mov    0x5f38,%eax
     498:	83 ec 08             	sub    $0x8,%esp
     49b:	68 44 44 00 00       	push   $0x4444
     4a0:	50                   	push   %eax
     4a1:	e8 7e 39 00 00       	call   3e24 <printf>
     4a6:	83 c4 10             	add    $0x10,%esp
    exit();
     4a9:	e8 fa 37 00 00       	call   3ca8 <exit>
  }
  printf(stdout, "big files ok\n");
     4ae:	a1 38 5f 00 00       	mov    0x5f38,%eax
     4b3:	83 ec 08             	sub    $0x8,%esp
     4b6:	68 57 44 00 00       	push   $0x4457
     4bb:	50                   	push   %eax
     4bc:	e8 63 39 00 00       	call   3e24 <printf>
     4c1:	83 c4 10             	add    $0x10,%esp
}
     4c4:	90                   	nop
     4c5:	c9                   	leave  
     4c6:	c3                   	ret    

000004c7 <createtest>:

void
createtest(void)
{
     4c7:	f3 0f 1e fb          	endbr32 
     4cb:	55                   	push   %ebp
     4cc:	89 e5                	mov    %esp,%ebp
     4ce:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     4d1:	a1 38 5f 00 00       	mov    0x5f38,%eax
     4d6:	83 ec 08             	sub    $0x8,%esp
     4d9:	68 68 44 00 00       	push   $0x4468
     4de:	50                   	push   %eax
     4df:	e8 40 39 00 00       	call   3e24 <printf>
     4e4:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
     4e7:	c6 05 20 a7 00 00 61 	movb   $0x61,0xa720
  name[2] = '\0';
     4ee:	c6 05 22 a7 00 00 00 	movb   $0x0,0xa722
  for(i = 0; i < 52; i++){
     4f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4fc:	eb 35                	jmp    533 <createtest+0x6c>
    name[1] = '0' + i;
     4fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     501:	83 c0 30             	add    $0x30,%eax
     504:	a2 21 a7 00 00       	mov    %al,0xa721
    fd = open(name, O_CREATE|O_RDWR);
     509:	83 ec 08             	sub    $0x8,%esp
     50c:	68 02 02 00 00       	push   $0x202
     511:	68 20 a7 00 00       	push   $0xa720
     516:	e8 cd 37 00 00       	call   3ce8 <open>
     51b:	83 c4 10             	add    $0x10,%esp
     51e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     521:	83 ec 0c             	sub    $0xc,%esp
     524:	ff 75 f0             	pushl  -0x10(%ebp)
     527:	e8 a4 37 00 00       	call   3cd0 <close>
     52c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
     52f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     533:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     537:	7e c5                	jle    4fe <createtest+0x37>
  }
  name[0] = 'a';
     539:	c6 05 20 a7 00 00 61 	movb   $0x61,0xa720
  name[2] = '\0';
     540:	c6 05 22 a7 00 00 00 	movb   $0x0,0xa722
  for(i = 0; i < 52; i++){
     547:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     54e:	eb 1f                	jmp    56f <createtest+0xa8>
    name[1] = '0' + i;
     550:	8b 45 f4             	mov    -0xc(%ebp),%eax
     553:	83 c0 30             	add    $0x30,%eax
     556:	a2 21 a7 00 00       	mov    %al,0xa721
    unlink(name);
     55b:	83 ec 0c             	sub    $0xc,%esp
     55e:	68 20 a7 00 00       	push   $0xa720
     563:	e8 90 37 00 00       	call   3cf8 <unlink>
     568:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
     56b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     56f:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     573:	7e db                	jle    550 <createtest+0x89>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     575:	a1 38 5f 00 00       	mov    0x5f38,%eax
     57a:	83 ec 08             	sub    $0x8,%esp
     57d:	68 90 44 00 00       	push   $0x4490
     582:	50                   	push   %eax
     583:	e8 9c 38 00 00       	call   3e24 <printf>
     588:	83 c4 10             	add    $0x10,%esp
}
     58b:	90                   	nop
     58c:	c9                   	leave  
     58d:	c3                   	ret    

0000058e <dirtest>:

void dirtest(void)
{
     58e:	f3 0f 1e fb          	endbr32 
     592:	55                   	push   %ebp
     593:	89 e5                	mov    %esp,%ebp
     595:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
     598:	a1 38 5f 00 00       	mov    0x5f38,%eax
     59d:	83 ec 08             	sub    $0x8,%esp
     5a0:	68 b6 44 00 00       	push   $0x44b6
     5a5:	50                   	push   %eax
     5a6:	e8 79 38 00 00       	call   3e24 <printf>
     5ab:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
     5ae:	83 ec 0c             	sub    $0xc,%esp
     5b1:	68 c2 44 00 00       	push   $0x44c2
     5b6:	e8 55 37 00 00       	call   3d10 <mkdir>
     5bb:	83 c4 10             	add    $0x10,%esp
     5be:	85 c0                	test   %eax,%eax
     5c0:	79 1b                	jns    5dd <dirtest+0x4f>
    printf(stdout, "mkdir failed\n");
     5c2:	a1 38 5f 00 00       	mov    0x5f38,%eax
     5c7:	83 ec 08             	sub    $0x8,%esp
     5ca:	68 c7 44 00 00       	push   $0x44c7
     5cf:	50                   	push   %eax
     5d0:	e8 4f 38 00 00       	call   3e24 <printf>
     5d5:	83 c4 10             	add    $0x10,%esp
    exit();
     5d8:	e8 cb 36 00 00       	call   3ca8 <exit>
  }

  if(chdir("dir0") < 0){
     5dd:	83 ec 0c             	sub    $0xc,%esp
     5e0:	68 c2 44 00 00       	push   $0x44c2
     5e5:	e8 2e 37 00 00       	call   3d18 <chdir>
     5ea:	83 c4 10             	add    $0x10,%esp
     5ed:	85 c0                	test   %eax,%eax
     5ef:	79 1b                	jns    60c <dirtest+0x7e>
    printf(stdout, "chdir dir0 failed\n");
     5f1:	a1 38 5f 00 00       	mov    0x5f38,%eax
     5f6:	83 ec 08             	sub    $0x8,%esp
     5f9:	68 d5 44 00 00       	push   $0x44d5
     5fe:	50                   	push   %eax
     5ff:	e8 20 38 00 00       	call   3e24 <printf>
     604:	83 c4 10             	add    $0x10,%esp
    exit();
     607:	e8 9c 36 00 00       	call   3ca8 <exit>
  }

  if(chdir("..") < 0){
     60c:	83 ec 0c             	sub    $0xc,%esp
     60f:	68 e8 44 00 00       	push   $0x44e8
     614:	e8 ff 36 00 00       	call   3d18 <chdir>
     619:	83 c4 10             	add    $0x10,%esp
     61c:	85 c0                	test   %eax,%eax
     61e:	79 1b                	jns    63b <dirtest+0xad>
    printf(stdout, "chdir .. failed\n");
     620:	a1 38 5f 00 00       	mov    0x5f38,%eax
     625:	83 ec 08             	sub    $0x8,%esp
     628:	68 eb 44 00 00       	push   $0x44eb
     62d:	50                   	push   %eax
     62e:	e8 f1 37 00 00       	call   3e24 <printf>
     633:	83 c4 10             	add    $0x10,%esp
    exit();
     636:	e8 6d 36 00 00       	call   3ca8 <exit>
  }

  if(unlink("dir0") < 0){
     63b:	83 ec 0c             	sub    $0xc,%esp
     63e:	68 c2 44 00 00       	push   $0x44c2
     643:	e8 b0 36 00 00       	call   3cf8 <unlink>
     648:	83 c4 10             	add    $0x10,%esp
     64b:	85 c0                	test   %eax,%eax
     64d:	79 1b                	jns    66a <dirtest+0xdc>
    printf(stdout, "unlink dir0 failed\n");
     64f:	a1 38 5f 00 00       	mov    0x5f38,%eax
     654:	83 ec 08             	sub    $0x8,%esp
     657:	68 fc 44 00 00       	push   $0x44fc
     65c:	50                   	push   %eax
     65d:	e8 c2 37 00 00       	call   3e24 <printf>
     662:	83 c4 10             	add    $0x10,%esp
    exit();
     665:	e8 3e 36 00 00       	call   3ca8 <exit>
  }
  printf(stdout, "mkdir test\n");
     66a:	a1 38 5f 00 00       	mov    0x5f38,%eax
     66f:	83 ec 08             	sub    $0x8,%esp
     672:	68 b6 44 00 00       	push   $0x44b6
     677:	50                   	push   %eax
     678:	e8 a7 37 00 00       	call   3e24 <printf>
     67d:	83 c4 10             	add    $0x10,%esp
}
     680:	90                   	nop
     681:	c9                   	leave  
     682:	c3                   	ret    

00000683 <exectest>:

void
exectest(void)
{
     683:	f3 0f 1e fb          	endbr32 
     687:	55                   	push   %ebp
     688:	89 e5                	mov    %esp,%ebp
     68a:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
     68d:	a1 38 5f 00 00       	mov    0x5f38,%eax
     692:	83 ec 08             	sub    $0x8,%esp
     695:	68 10 45 00 00       	push   $0x4510
     69a:	50                   	push   %eax
     69b:	e8 84 37 00 00       	call   3e24 <printf>
     6a0:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
     6a3:	83 ec 08             	sub    $0x8,%esp
     6a6:	68 24 5f 00 00       	push   $0x5f24
     6ab:	68 ec 41 00 00       	push   $0x41ec
     6b0:	e8 2b 36 00 00       	call   3ce0 <exec>
     6b5:	83 c4 10             	add    $0x10,%esp
     6b8:	85 c0                	test   %eax,%eax
     6ba:	79 1b                	jns    6d7 <exectest+0x54>
    printf(stdout, "exec echo failed\n");
     6bc:	a1 38 5f 00 00       	mov    0x5f38,%eax
     6c1:	83 ec 08             	sub    $0x8,%esp
     6c4:	68 1b 45 00 00       	push   $0x451b
     6c9:	50                   	push   %eax
     6ca:	e8 55 37 00 00       	call   3e24 <printf>
     6cf:	83 c4 10             	add    $0x10,%esp
    exit();
     6d2:	e8 d1 35 00 00       	call   3ca8 <exit>
  }
}
     6d7:	90                   	nop
     6d8:	c9                   	leave  
     6d9:	c3                   	ret    

000006da <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     6da:	f3 0f 1e fb          	endbr32 
     6de:	55                   	push   %ebp
     6df:	89 e5                	mov    %esp,%ebp
     6e1:	83 ec 28             	sub    $0x28,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     6e4:	83 ec 0c             	sub    $0xc,%esp
     6e7:	8d 45 d8             	lea    -0x28(%ebp),%eax
     6ea:	50                   	push   %eax
     6eb:	e8 c8 35 00 00       	call   3cb8 <pipe>
     6f0:	83 c4 10             	add    $0x10,%esp
     6f3:	85 c0                	test   %eax,%eax
     6f5:	74 17                	je     70e <pipe1+0x34>
    printf(1, "pipe() failed\n");
     6f7:	83 ec 08             	sub    $0x8,%esp
     6fa:	68 2d 45 00 00       	push   $0x452d
     6ff:	6a 01                	push   $0x1
     701:	e8 1e 37 00 00       	call   3e24 <printf>
     706:	83 c4 10             	add    $0x10,%esp
    exit();
     709:	e8 9a 35 00 00       	call   3ca8 <exit>
  }
  pid = fork();
     70e:	e8 8d 35 00 00       	call   3ca0 <fork>
     713:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     716:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     71d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     721:	0f 85 89 00 00 00    	jne    7b0 <pipe1+0xd6>
    close(fds[0]);
     727:	8b 45 d8             	mov    -0x28(%ebp),%eax
     72a:	83 ec 0c             	sub    $0xc,%esp
     72d:	50                   	push   %eax
     72e:	e8 9d 35 00 00       	call   3cd0 <close>
     733:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
     736:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     73d:	eb 66                	jmp    7a5 <pipe1+0xcb>
      for(i = 0; i < 1033; i++)
     73f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     746:	eb 19                	jmp    761 <pipe1+0x87>
        buf[i] = seq++;
     748:	8b 45 f4             	mov    -0xc(%ebp),%eax
     74b:	8d 50 01             	lea    0x1(%eax),%edx
     74e:	89 55 f4             	mov    %edx,-0xc(%ebp)
     751:	89 c2                	mov    %eax,%edx
     753:	8b 45 f0             	mov    -0x10(%ebp),%eax
     756:	05 20 87 00 00       	add    $0x8720,%eax
     75b:	88 10                	mov    %dl,(%eax)
      for(i = 0; i < 1033; i++)
     75d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     761:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     768:	7e de                	jle    748 <pipe1+0x6e>
      if(write(fds[1], buf, 1033) != 1033){
     76a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     76d:	83 ec 04             	sub    $0x4,%esp
     770:	68 09 04 00 00       	push   $0x409
     775:	68 20 87 00 00       	push   $0x8720
     77a:	50                   	push   %eax
     77b:	e8 48 35 00 00       	call   3cc8 <write>
     780:	83 c4 10             	add    $0x10,%esp
     783:	3d 09 04 00 00       	cmp    $0x409,%eax
     788:	74 17                	je     7a1 <pipe1+0xc7>
        printf(1, "pipe1 oops 1\n");
     78a:	83 ec 08             	sub    $0x8,%esp
     78d:	68 3c 45 00 00       	push   $0x453c
     792:	6a 01                	push   $0x1
     794:	e8 8b 36 00 00       	call   3e24 <printf>
     799:	83 c4 10             	add    $0x10,%esp
        exit();
     79c:	e8 07 35 00 00       	call   3ca8 <exit>
    for(n = 0; n < 5; n++){
     7a1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     7a5:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     7a9:	7e 94                	jle    73f <pipe1+0x65>
      }
    }
    exit();
     7ab:	e8 f8 34 00 00       	call   3ca8 <exit>
  } else if(pid > 0){
     7b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     7b4:	0f 8e f4 00 00 00    	jle    8ae <pipe1+0x1d4>
    close(fds[1]);
     7ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
     7bd:	83 ec 0c             	sub    $0xc,%esp
     7c0:	50                   	push   %eax
     7c1:	e8 0a 35 00 00       	call   3cd0 <close>
     7c6:	83 c4 10             	add    $0x10,%esp
    total = 0;
     7c9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     7d0:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     7d7:	eb 66                	jmp    83f <pipe1+0x165>
      for(i = 0; i < n; i++){
     7d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7e0:	eb 3b                	jmp    81d <pipe1+0x143>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     7e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e5:	05 20 87 00 00       	add    $0x8720,%eax
     7ea:	0f b6 00             	movzbl (%eax),%eax
     7ed:	0f be c8             	movsbl %al,%ecx
     7f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f3:	8d 50 01             	lea    0x1(%eax),%edx
     7f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
     7f9:	31 c8                	xor    %ecx,%eax
     7fb:	0f b6 c0             	movzbl %al,%eax
     7fe:	85 c0                	test   %eax,%eax
     800:	74 17                	je     819 <pipe1+0x13f>
          printf(1, "pipe1 oops 2\n");
     802:	83 ec 08             	sub    $0x8,%esp
     805:	68 4a 45 00 00       	push   $0x454a
     80a:	6a 01                	push   $0x1
     80c:	e8 13 36 00 00       	call   3e24 <printf>
     811:	83 c4 10             	add    $0x10,%esp
     814:	e9 ac 00 00 00       	jmp    8c5 <pipe1+0x1eb>
      for(i = 0; i < n; i++){
     819:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     81d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     820:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     823:	7c bd                	jl     7e2 <pipe1+0x108>
          return;
        }
      }
      total += n;
     825:	8b 45 ec             	mov    -0x14(%ebp),%eax
     828:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     82b:	d1 65 e8             	shll   -0x18(%ebp)
      if(cc > sizeof(buf))
     82e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     831:	3d 00 20 00 00       	cmp    $0x2000,%eax
     836:	76 07                	jbe    83f <pipe1+0x165>
        cc = sizeof(buf);
     838:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     83f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     842:	83 ec 04             	sub    $0x4,%esp
     845:	ff 75 e8             	pushl  -0x18(%ebp)
     848:	68 20 87 00 00       	push   $0x8720
     84d:	50                   	push   %eax
     84e:	e8 6d 34 00 00       	call   3cc0 <read>
     853:	83 c4 10             	add    $0x10,%esp
     856:	89 45 ec             	mov    %eax,-0x14(%ebp)
     859:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     85d:	0f 8f 76 ff ff ff    	jg     7d9 <pipe1+0xff>
    }
    if(total != 5 * 1033){
     863:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     86a:	74 1a                	je     886 <pipe1+0x1ac>
      printf(1, "pipe1 oops 3 total %d\n", total);
     86c:	83 ec 04             	sub    $0x4,%esp
     86f:	ff 75 e4             	pushl  -0x1c(%ebp)
     872:	68 58 45 00 00       	push   $0x4558
     877:	6a 01                	push   $0x1
     879:	e8 a6 35 00 00       	call   3e24 <printf>
     87e:	83 c4 10             	add    $0x10,%esp
      exit();
     881:	e8 22 34 00 00       	call   3ca8 <exit>
    }
    close(fds[0]);
     886:	8b 45 d8             	mov    -0x28(%ebp),%eax
     889:	83 ec 0c             	sub    $0xc,%esp
     88c:	50                   	push   %eax
     88d:	e8 3e 34 00 00       	call   3cd0 <close>
     892:	83 c4 10             	add    $0x10,%esp
    wait();
     895:	e8 16 34 00 00       	call   3cb0 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     89a:	83 ec 08             	sub    $0x8,%esp
     89d:	68 7e 45 00 00       	push   $0x457e
     8a2:	6a 01                	push   $0x1
     8a4:	e8 7b 35 00 00       	call   3e24 <printf>
     8a9:	83 c4 10             	add    $0x10,%esp
     8ac:	eb 17                	jmp    8c5 <pipe1+0x1eb>
    printf(1, "fork() failed\n");
     8ae:	83 ec 08             	sub    $0x8,%esp
     8b1:	68 6f 45 00 00       	push   $0x456f
     8b6:	6a 01                	push   $0x1
     8b8:	e8 67 35 00 00       	call   3e24 <printf>
     8bd:	83 c4 10             	add    $0x10,%esp
    exit();
     8c0:	e8 e3 33 00 00       	call   3ca8 <exit>
}
     8c5:	c9                   	leave  
     8c6:	c3                   	ret    

000008c7 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     8c7:	f3 0f 1e fb          	endbr32 
     8cb:	55                   	push   %ebp
     8cc:	89 e5                	mov    %esp,%ebp
     8ce:	83 ec 28             	sub    $0x28,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     8d1:	83 ec 08             	sub    $0x8,%esp
     8d4:	68 88 45 00 00       	push   $0x4588
     8d9:	6a 01                	push   $0x1
     8db:	e8 44 35 00 00       	call   3e24 <printf>
     8e0:	83 c4 10             	add    $0x10,%esp
  pid1 = fork();
     8e3:	e8 b8 33 00 00       	call   3ca0 <fork>
     8e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     8eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8ef:	75 02                	jne    8f3 <preempt+0x2c>
    for(;;)
     8f1:	eb fe                	jmp    8f1 <preempt+0x2a>
      ;

  pid2 = fork();
     8f3:	e8 a8 33 00 00       	call   3ca0 <fork>
     8f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     8fb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8ff:	75 02                	jne    903 <preempt+0x3c>
    for(;;)
     901:	eb fe                	jmp    901 <preempt+0x3a>
      ;

  pipe(pfds);
     903:	83 ec 0c             	sub    $0xc,%esp
     906:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     909:	50                   	push   %eax
     90a:	e8 a9 33 00 00       	call   3cb8 <pipe>
     90f:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     912:	e8 89 33 00 00       	call   3ca0 <fork>
     917:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     91a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     91e:	75 4d                	jne    96d <preempt+0xa6>
    close(pfds[0]);
     920:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     923:	83 ec 0c             	sub    $0xc,%esp
     926:	50                   	push   %eax
     927:	e8 a4 33 00 00       	call   3cd0 <close>
     92c:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
     92f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     932:	83 ec 04             	sub    $0x4,%esp
     935:	6a 01                	push   $0x1
     937:	68 92 45 00 00       	push   $0x4592
     93c:	50                   	push   %eax
     93d:	e8 86 33 00 00       	call   3cc8 <write>
     942:	83 c4 10             	add    $0x10,%esp
     945:	83 f8 01             	cmp    $0x1,%eax
     948:	74 12                	je     95c <preempt+0x95>
      printf(1, "preempt write error");
     94a:	83 ec 08             	sub    $0x8,%esp
     94d:	68 94 45 00 00       	push   $0x4594
     952:	6a 01                	push   $0x1
     954:	e8 cb 34 00 00       	call   3e24 <printf>
     959:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     95c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     95f:	83 ec 0c             	sub    $0xc,%esp
     962:	50                   	push   %eax
     963:	e8 68 33 00 00       	call   3cd0 <close>
     968:	83 c4 10             	add    $0x10,%esp
    for(;;)
     96b:	eb fe                	jmp    96b <preempt+0xa4>
      ;
  }

  close(pfds[1]);
     96d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     970:	83 ec 0c             	sub    $0xc,%esp
     973:	50                   	push   %eax
     974:	e8 57 33 00 00       	call   3cd0 <close>
     979:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     97c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     97f:	83 ec 04             	sub    $0x4,%esp
     982:	68 00 20 00 00       	push   $0x2000
     987:	68 20 87 00 00       	push   $0x8720
     98c:	50                   	push   %eax
     98d:	e8 2e 33 00 00       	call   3cc0 <read>
     992:	83 c4 10             	add    $0x10,%esp
     995:	83 f8 01             	cmp    $0x1,%eax
     998:	74 14                	je     9ae <preempt+0xe7>
    printf(1, "preempt read error");
     99a:	83 ec 08             	sub    $0x8,%esp
     99d:	68 a8 45 00 00       	push   $0x45a8
     9a2:	6a 01                	push   $0x1
     9a4:	e8 7b 34 00 00       	call   3e24 <printf>
     9a9:	83 c4 10             	add    $0x10,%esp
     9ac:	eb 7e                	jmp    a2c <preempt+0x165>
    return;
  }
  close(pfds[0]);
     9ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9b1:	83 ec 0c             	sub    $0xc,%esp
     9b4:	50                   	push   %eax
     9b5:	e8 16 33 00 00       	call   3cd0 <close>
     9ba:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
     9bd:	83 ec 08             	sub    $0x8,%esp
     9c0:	68 bb 45 00 00       	push   $0x45bb
     9c5:	6a 01                	push   $0x1
     9c7:	e8 58 34 00 00       	call   3e24 <printf>
     9cc:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
     9cf:	83 ec 0c             	sub    $0xc,%esp
     9d2:	ff 75 f4             	pushl  -0xc(%ebp)
     9d5:	e8 fe 32 00 00       	call   3cd8 <kill>
     9da:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
     9dd:	83 ec 0c             	sub    $0xc,%esp
     9e0:	ff 75 f0             	pushl  -0x10(%ebp)
     9e3:	e8 f0 32 00 00       	call   3cd8 <kill>
     9e8:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
     9eb:	83 ec 0c             	sub    $0xc,%esp
     9ee:	ff 75 ec             	pushl  -0x14(%ebp)
     9f1:	e8 e2 32 00 00       	call   3cd8 <kill>
     9f6:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
     9f9:	83 ec 08             	sub    $0x8,%esp
     9fc:	68 c4 45 00 00       	push   $0x45c4
     a01:	6a 01                	push   $0x1
     a03:	e8 1c 34 00 00       	call   3e24 <printf>
     a08:	83 c4 10             	add    $0x10,%esp
  wait();
     a0b:	e8 a0 32 00 00       	call   3cb0 <wait>
  wait();
     a10:	e8 9b 32 00 00       	call   3cb0 <wait>
  wait();
     a15:	e8 96 32 00 00       	call   3cb0 <wait>
  printf(1, "preempt ok\n");
     a1a:	83 ec 08             	sub    $0x8,%esp
     a1d:	68 cd 45 00 00       	push   $0x45cd
     a22:	6a 01                	push   $0x1
     a24:	e8 fb 33 00 00       	call   3e24 <printf>
     a29:	83 c4 10             	add    $0x10,%esp
}
     a2c:	c9                   	leave  
     a2d:	c3                   	ret    

00000a2e <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     a2e:	f3 0f 1e fb          	endbr32 
     a32:	55                   	push   %ebp
     a33:	89 e5                	mov    %esp,%ebp
     a35:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     a38:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a3f:	eb 4f                	jmp    a90 <exitwait+0x62>
    pid = fork();
     a41:	e8 5a 32 00 00       	call   3ca0 <fork>
     a46:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     a49:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a4d:	79 14                	jns    a63 <exitwait+0x35>
      printf(1, "fork failed\n");
     a4f:	83 ec 08             	sub    $0x8,%esp
     a52:	68 d9 45 00 00       	push   $0x45d9
     a57:	6a 01                	push   $0x1
     a59:	e8 c6 33 00 00       	call   3e24 <printf>
     a5e:	83 c4 10             	add    $0x10,%esp
      return;
     a61:	eb 45                	jmp    aa8 <exitwait+0x7a>
    }
    if(pid){
     a63:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a67:	74 1e                	je     a87 <exitwait+0x59>
      if(wait() != pid){
     a69:	e8 42 32 00 00       	call   3cb0 <wait>
     a6e:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     a71:	74 19                	je     a8c <exitwait+0x5e>
        printf(1, "wait wrong pid\n");
     a73:	83 ec 08             	sub    $0x8,%esp
     a76:	68 e6 45 00 00       	push   $0x45e6
     a7b:	6a 01                	push   $0x1
     a7d:	e8 a2 33 00 00       	call   3e24 <printf>
     a82:	83 c4 10             	add    $0x10,%esp
        return;
     a85:	eb 21                	jmp    aa8 <exitwait+0x7a>
      }
    } else {
      exit();
     a87:	e8 1c 32 00 00       	call   3ca8 <exit>
  for(i = 0; i < 100; i++){
     a8c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a90:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     a94:	7e ab                	jle    a41 <exitwait+0x13>
    }
  }
  printf(1, "exitwait ok\n");
     a96:	83 ec 08             	sub    $0x8,%esp
     a99:	68 f6 45 00 00       	push   $0x45f6
     a9e:	6a 01                	push   $0x1
     aa0:	e8 7f 33 00 00       	call   3e24 <printf>
     aa5:	83 c4 10             	add    $0x10,%esp
}
     aa8:	c9                   	leave  
     aa9:	c3                   	ret    

00000aaa <mem>:

void
mem(void)
{
     aaa:	f3 0f 1e fb          	endbr32 
     aae:	55                   	push   %ebp
     aaf:	89 e5                	mov    %esp,%ebp
     ab1:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     ab4:	83 ec 08             	sub    $0x8,%esp
     ab7:	68 03 46 00 00       	push   $0x4603
     abc:	6a 01                	push   $0x1
     abe:	e8 61 33 00 00       	call   3e24 <printf>
     ac3:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
     ac6:	e8 5d 32 00 00       	call   3d28 <getpid>
     acb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
     ace:	e8 cd 31 00 00       	call   3ca0 <fork>
     ad3:	89 45 ec             	mov    %eax,-0x14(%ebp)
     ad6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ada:	0f 85 b7 00 00 00    	jne    b97 <mem+0xed>
    m1 = 0;
     ae0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     ae7:	eb 0e                	jmp    af7 <mem+0x4d>
      *(char**)m2 = m1;
     ae9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aec:	8b 55 f4             	mov    -0xc(%ebp),%edx
     aef:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     af1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     af4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     af7:	83 ec 0c             	sub    $0xc,%esp
     afa:	68 11 27 00 00       	push   $0x2711
     aff:	e8 00 36 00 00       	call   4104 <malloc>
     b04:	83 c4 10             	add    $0x10,%esp
     b07:	89 45 e8             	mov    %eax,-0x18(%ebp)
     b0a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     b0e:	75 d9                	jne    ae9 <mem+0x3f>
    }
    while(m1){
     b10:	eb 1c                	jmp    b2e <mem+0x84>
      m2 = *(char**)m1;
     b12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b15:	8b 00                	mov    (%eax),%eax
     b17:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     b1a:	83 ec 0c             	sub    $0xc,%esp
     b1d:	ff 75 f4             	pushl  -0xc(%ebp)
     b20:	e8 95 34 00 00       	call   3fba <free>
     b25:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     b28:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(m1){
     b2e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b32:	75 de                	jne    b12 <mem+0x68>
    }
    m1 = malloc(1024*20);
     b34:	83 ec 0c             	sub    $0xc,%esp
     b37:	68 00 50 00 00       	push   $0x5000
     b3c:	e8 c3 35 00 00       	call   4104 <malloc>
     b41:	83 c4 10             	add    $0x10,%esp
     b44:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     b47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b4b:	75 25                	jne    b72 <mem+0xc8>
      printf(1, "couldn't allocate mem?!!\n");
     b4d:	83 ec 08             	sub    $0x8,%esp
     b50:	68 0d 46 00 00       	push   $0x460d
     b55:	6a 01                	push   $0x1
     b57:	e8 c8 32 00 00       	call   3e24 <printf>
     b5c:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
     b5f:	83 ec 0c             	sub    $0xc,%esp
     b62:	ff 75 f0             	pushl  -0x10(%ebp)
     b65:	e8 6e 31 00 00       	call   3cd8 <kill>
     b6a:	83 c4 10             	add    $0x10,%esp
      exit();
     b6d:	e8 36 31 00 00       	call   3ca8 <exit>
    }
    free(m1);
     b72:	83 ec 0c             	sub    $0xc,%esp
     b75:	ff 75 f4             	pushl  -0xc(%ebp)
     b78:	e8 3d 34 00 00       	call   3fba <free>
     b7d:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
     b80:	83 ec 08             	sub    $0x8,%esp
     b83:	68 27 46 00 00       	push   $0x4627
     b88:	6a 01                	push   $0x1
     b8a:	e8 95 32 00 00       	call   3e24 <printf>
     b8f:	83 c4 10             	add    $0x10,%esp
    exit();
     b92:	e8 11 31 00 00       	call   3ca8 <exit>
  } else {
    wait();
     b97:	e8 14 31 00 00       	call   3cb0 <wait>
  }
}
     b9c:	90                   	nop
     b9d:	c9                   	leave  
     b9e:	c3                   	ret    

00000b9f <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     b9f:	f3 0f 1e fb          	endbr32 
     ba3:	55                   	push   %ebp
     ba4:	89 e5                	mov    %esp,%ebp
     ba6:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     ba9:	83 ec 08             	sub    $0x8,%esp
     bac:	68 2f 46 00 00       	push   $0x462f
     bb1:	6a 01                	push   $0x1
     bb3:	e8 6c 32 00 00       	call   3e24 <printf>
     bb8:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
     bbb:	83 ec 0c             	sub    $0xc,%esp
     bbe:	68 3e 46 00 00       	push   $0x463e
     bc3:	e8 30 31 00 00       	call   3cf8 <unlink>
     bc8:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
     bcb:	83 ec 08             	sub    $0x8,%esp
     bce:	68 02 02 00 00       	push   $0x202
     bd3:	68 3e 46 00 00       	push   $0x463e
     bd8:	e8 0b 31 00 00       	call   3ce8 <open>
     bdd:	83 c4 10             	add    $0x10,%esp
     be0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     be3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     be7:	79 17                	jns    c00 <sharedfd+0x61>
    printf(1, "fstests: cannot open sharedfd for writing");
     be9:	83 ec 08             	sub    $0x8,%esp
     bec:	68 48 46 00 00       	push   $0x4648
     bf1:	6a 01                	push   $0x1
     bf3:	e8 2c 32 00 00       	call   3e24 <printf>
     bf8:	83 c4 10             	add    $0x10,%esp
    return;
     bfb:	e9 84 01 00 00       	jmp    d84 <sharedfd+0x1e5>
  }
  pid = fork();
     c00:	e8 9b 30 00 00       	call   3ca0 <fork>
     c05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     c08:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c0c:	75 07                	jne    c15 <sharedfd+0x76>
     c0e:	b8 63 00 00 00       	mov    $0x63,%eax
     c13:	eb 05                	jmp    c1a <sharedfd+0x7b>
     c15:	b8 70 00 00 00       	mov    $0x70,%eax
     c1a:	83 ec 04             	sub    $0x4,%esp
     c1d:	6a 0a                	push   $0xa
     c1f:	50                   	push   %eax
     c20:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     c23:	50                   	push   %eax
     c24:	e8 cc 2e 00 00       	call   3af5 <memset>
     c29:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
     c2c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c33:	eb 31                	jmp    c66 <sharedfd+0xc7>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     c35:	83 ec 04             	sub    $0x4,%esp
     c38:	6a 0a                	push   $0xa
     c3a:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     c3d:	50                   	push   %eax
     c3e:	ff 75 e8             	pushl  -0x18(%ebp)
     c41:	e8 82 30 00 00       	call   3cc8 <write>
     c46:	83 c4 10             	add    $0x10,%esp
     c49:	83 f8 0a             	cmp    $0xa,%eax
     c4c:	74 14                	je     c62 <sharedfd+0xc3>
      printf(1, "fstests: write sharedfd failed\n");
     c4e:	83 ec 08             	sub    $0x8,%esp
     c51:	68 74 46 00 00       	push   $0x4674
     c56:	6a 01                	push   $0x1
     c58:	e8 c7 31 00 00       	call   3e24 <printf>
     c5d:	83 c4 10             	add    $0x10,%esp
      break;
     c60:	eb 0d                	jmp    c6f <sharedfd+0xd0>
  for(i = 0; i < 1000; i++){
     c62:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c66:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     c6d:	7e c6                	jle    c35 <sharedfd+0x96>
    }
  }
  if(pid == 0)
     c6f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c73:	75 05                	jne    c7a <sharedfd+0xdb>
    exit();
     c75:	e8 2e 30 00 00       	call   3ca8 <exit>
  else
    wait();
     c7a:	e8 31 30 00 00       	call   3cb0 <wait>
  close(fd);
     c7f:	83 ec 0c             	sub    $0xc,%esp
     c82:	ff 75 e8             	pushl  -0x18(%ebp)
     c85:	e8 46 30 00 00       	call   3cd0 <close>
     c8a:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
     c8d:	83 ec 08             	sub    $0x8,%esp
     c90:	6a 00                	push   $0x0
     c92:	68 3e 46 00 00       	push   $0x463e
     c97:	e8 4c 30 00 00       	call   3ce8 <open>
     c9c:	83 c4 10             	add    $0x10,%esp
     c9f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     ca2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ca6:	79 17                	jns    cbf <sharedfd+0x120>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     ca8:	83 ec 08             	sub    $0x8,%esp
     cab:	68 94 46 00 00       	push   $0x4694
     cb0:	6a 01                	push   $0x1
     cb2:	e8 6d 31 00 00       	call   3e24 <printf>
     cb7:	83 c4 10             	add    $0x10,%esp
    return;
     cba:	e9 c5 00 00 00       	jmp    d84 <sharedfd+0x1e5>
  }
  nc = np = 0;
     cbf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     cc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     ccc:	eb 3b                	jmp    d09 <sharedfd+0x16a>
    for(i = 0; i < sizeof(buf); i++){
     cce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cd5:	eb 2a                	jmp    d01 <sharedfd+0x162>
      if(buf[i] == 'c')
     cd7:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     cda:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cdd:	01 d0                	add    %edx,%eax
     cdf:	0f b6 00             	movzbl (%eax),%eax
     ce2:	3c 63                	cmp    $0x63,%al
     ce4:	75 04                	jne    cea <sharedfd+0x14b>
        nc++;
     ce6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(buf[i] == 'p')
     cea:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     ced:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf0:	01 d0                	add    %edx,%eax
     cf2:	0f b6 00             	movzbl (%eax),%eax
     cf5:	3c 70                	cmp    $0x70,%al
     cf7:	75 04                	jne    cfd <sharedfd+0x15e>
        np++;
     cf9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    for(i = 0; i < sizeof(buf); i++){
     cfd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d01:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d04:	83 f8 09             	cmp    $0x9,%eax
     d07:	76 ce                	jbe    cd7 <sharedfd+0x138>
  while((n = read(fd, buf, sizeof(buf))) > 0){
     d09:	83 ec 04             	sub    $0x4,%esp
     d0c:	6a 0a                	push   $0xa
     d0e:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     d11:	50                   	push   %eax
     d12:	ff 75 e8             	pushl  -0x18(%ebp)
     d15:	e8 a6 2f 00 00       	call   3cc0 <read>
     d1a:	83 c4 10             	add    $0x10,%esp
     d1d:	89 45 e0             	mov    %eax,-0x20(%ebp)
     d20:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     d24:	7f a8                	jg     cce <sharedfd+0x12f>
    }
  }
  close(fd);
     d26:	83 ec 0c             	sub    $0xc,%esp
     d29:	ff 75 e8             	pushl  -0x18(%ebp)
     d2c:	e8 9f 2f 00 00       	call   3cd0 <close>
     d31:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
     d34:	83 ec 0c             	sub    $0xc,%esp
     d37:	68 3e 46 00 00       	push   $0x463e
     d3c:	e8 b7 2f 00 00       	call   3cf8 <unlink>
     d41:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
     d44:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
     d4b:	75 1d                	jne    d6a <sharedfd+0x1cb>
     d4d:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
     d54:	75 14                	jne    d6a <sharedfd+0x1cb>
    printf(1, "sharedfd ok\n");
     d56:	83 ec 08             	sub    $0x8,%esp
     d59:	68 bf 46 00 00       	push   $0x46bf
     d5e:	6a 01                	push   $0x1
     d60:	e8 bf 30 00 00       	call   3e24 <printf>
     d65:	83 c4 10             	add    $0x10,%esp
     d68:	eb 1a                	jmp    d84 <sharedfd+0x1e5>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
     d6a:	ff 75 ec             	pushl  -0x14(%ebp)
     d6d:	ff 75 f0             	pushl  -0x10(%ebp)
     d70:	68 cc 46 00 00       	push   $0x46cc
     d75:	6a 01                	push   $0x1
     d77:	e8 a8 30 00 00       	call   3e24 <printf>
     d7c:	83 c4 10             	add    $0x10,%esp
    exit();
     d7f:	e8 24 2f 00 00       	call   3ca8 <exit>
  }
}
     d84:	c9                   	leave  
     d85:	c3                   	ret    

00000d86 <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
     d86:	f3 0f 1e fb          	endbr32 
     d8a:	55                   	push   %ebp
     d8b:	89 e5                	mov    %esp,%ebp
     d8d:	83 ec 28             	sub    $0x28,%esp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
     d90:	83 ec 08             	sub    $0x8,%esp
     d93:	68 e1 46 00 00       	push   $0x46e1
     d98:	6a 01                	push   $0x1
     d9a:	e8 85 30 00 00       	call   3e24 <printf>
     d9f:	83 c4 10             	add    $0x10,%esp

  unlink("f1");
     da2:	83 ec 0c             	sub    $0xc,%esp
     da5:	68 f0 46 00 00       	push   $0x46f0
     daa:	e8 49 2f 00 00       	call   3cf8 <unlink>
     daf:	83 c4 10             	add    $0x10,%esp
  unlink("f2");
     db2:	83 ec 0c             	sub    $0xc,%esp
     db5:	68 f3 46 00 00       	push   $0x46f3
     dba:	e8 39 2f 00 00       	call   3cf8 <unlink>
     dbf:	83 c4 10             	add    $0x10,%esp

  pid = fork();
     dc2:	e8 d9 2e 00 00       	call   3ca0 <fork>
     dc7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(pid < 0){
     dca:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     dce:	79 17                	jns    de7 <twofiles+0x61>
    printf(1, "fork failed\n");
     dd0:	83 ec 08             	sub    $0x8,%esp
     dd3:	68 d9 45 00 00       	push   $0x45d9
     dd8:	6a 01                	push   $0x1
     dda:	e8 45 30 00 00       	call   3e24 <printf>
     ddf:	83 c4 10             	add    $0x10,%esp
    exit();
     de2:	e8 c1 2e 00 00       	call   3ca8 <exit>
  }

  fname = pid ? "f1" : "f2";
     de7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     deb:	74 07                	je     df4 <twofiles+0x6e>
     ded:	b8 f0 46 00 00       	mov    $0x46f0,%eax
     df2:	eb 05                	jmp    df9 <twofiles+0x73>
     df4:	b8 f3 46 00 00       	mov    $0x46f3,%eax
     df9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  fd = open(fname, O_CREATE | O_RDWR);
     dfc:	83 ec 08             	sub    $0x8,%esp
     dff:	68 02 02 00 00       	push   $0x202
     e04:	ff 75 e4             	pushl  -0x1c(%ebp)
     e07:	e8 dc 2e 00 00       	call   3ce8 <open>
     e0c:	83 c4 10             	add    $0x10,%esp
     e0f:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(fd < 0){
     e12:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     e16:	79 17                	jns    e2f <twofiles+0xa9>
    printf(1, "create failed\n");
     e18:	83 ec 08             	sub    $0x8,%esp
     e1b:	68 f6 46 00 00       	push   $0x46f6
     e20:	6a 01                	push   $0x1
     e22:	e8 fd 2f 00 00       	call   3e24 <printf>
     e27:	83 c4 10             	add    $0x10,%esp
    exit();
     e2a:	e8 79 2e 00 00       	call   3ca8 <exit>
  }

  memset(buf, pid?'p':'c', 512);
     e2f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e33:	74 07                	je     e3c <twofiles+0xb6>
     e35:	b8 70 00 00 00       	mov    $0x70,%eax
     e3a:	eb 05                	jmp    e41 <twofiles+0xbb>
     e3c:	b8 63 00 00 00       	mov    $0x63,%eax
     e41:	83 ec 04             	sub    $0x4,%esp
     e44:	68 00 02 00 00       	push   $0x200
     e49:	50                   	push   %eax
     e4a:	68 20 87 00 00       	push   $0x8720
     e4f:	e8 a1 2c 00 00       	call   3af5 <memset>
     e54:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 12; i++){
     e57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e5e:	eb 42                	jmp    ea2 <twofiles+0x11c>
    if((n = write(fd, buf, 500)) != 500){
     e60:	83 ec 04             	sub    $0x4,%esp
     e63:	68 f4 01 00 00       	push   $0x1f4
     e68:	68 20 87 00 00       	push   $0x8720
     e6d:	ff 75 e0             	pushl  -0x20(%ebp)
     e70:	e8 53 2e 00 00       	call   3cc8 <write>
     e75:	83 c4 10             	add    $0x10,%esp
     e78:	89 45 dc             	mov    %eax,-0x24(%ebp)
     e7b:	81 7d dc f4 01 00 00 	cmpl   $0x1f4,-0x24(%ebp)
     e82:	74 1a                	je     e9e <twofiles+0x118>
      printf(1, "write failed %d\n", n);
     e84:	83 ec 04             	sub    $0x4,%esp
     e87:	ff 75 dc             	pushl  -0x24(%ebp)
     e8a:	68 05 47 00 00       	push   $0x4705
     e8f:	6a 01                	push   $0x1
     e91:	e8 8e 2f 00 00       	call   3e24 <printf>
     e96:	83 c4 10             	add    $0x10,%esp
      exit();
     e99:	e8 0a 2e 00 00       	call   3ca8 <exit>
  for(i = 0; i < 12; i++){
     e9e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ea2:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
     ea6:	7e b8                	jle    e60 <twofiles+0xda>
    }
  }
  close(fd);
     ea8:	83 ec 0c             	sub    $0xc,%esp
     eab:	ff 75 e0             	pushl  -0x20(%ebp)
     eae:	e8 1d 2e 00 00       	call   3cd0 <close>
     eb3:	83 c4 10             	add    $0x10,%esp
  if(pid)
     eb6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     eba:	74 11                	je     ecd <twofiles+0x147>
    wait();
     ebc:	e8 ef 2d 00 00       	call   3cb0 <wait>
  else
    exit();

  for(i = 0; i < 2; i++){
     ec1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ec8:	e9 dd 00 00 00       	jmp    faa <twofiles+0x224>
    exit();
     ecd:	e8 d6 2d 00 00       	call   3ca8 <exit>
    fd = open(i?"f1":"f2", 0);
     ed2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ed6:	74 07                	je     edf <twofiles+0x159>
     ed8:	b8 f0 46 00 00       	mov    $0x46f0,%eax
     edd:	eb 05                	jmp    ee4 <twofiles+0x15e>
     edf:	b8 f3 46 00 00       	mov    $0x46f3,%eax
     ee4:	83 ec 08             	sub    $0x8,%esp
     ee7:	6a 00                	push   $0x0
     ee9:	50                   	push   %eax
     eea:	e8 f9 2d 00 00       	call   3ce8 <open>
     eef:	83 c4 10             	add    $0x10,%esp
     ef2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    total = 0;
     ef5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     efc:	eb 56                	jmp    f54 <twofiles+0x1ce>
      for(j = 0; j < n; j++){
     efe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     f05:	eb 3f                	jmp    f46 <twofiles+0x1c0>
        if(buf[j] != (i?'p':'c')){
     f07:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f0a:	05 20 87 00 00       	add    $0x8720,%eax
     f0f:	0f b6 00             	movzbl (%eax),%eax
     f12:	0f be c0             	movsbl %al,%eax
     f15:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f19:	74 07                	je     f22 <twofiles+0x19c>
     f1b:	ba 70 00 00 00       	mov    $0x70,%edx
     f20:	eb 05                	jmp    f27 <twofiles+0x1a1>
     f22:	ba 63 00 00 00       	mov    $0x63,%edx
     f27:	39 c2                	cmp    %eax,%edx
     f29:	74 17                	je     f42 <twofiles+0x1bc>
          printf(1, "wrong char\n");
     f2b:	83 ec 08             	sub    $0x8,%esp
     f2e:	68 16 47 00 00       	push   $0x4716
     f33:	6a 01                	push   $0x1
     f35:	e8 ea 2e 00 00       	call   3e24 <printf>
     f3a:	83 c4 10             	add    $0x10,%esp
          exit();
     f3d:	e8 66 2d 00 00       	call   3ca8 <exit>
      for(j = 0; j < n; j++){
     f42:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f46:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f49:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     f4c:	7c b9                	jl     f07 <twofiles+0x181>
        }
      }
      total += n;
     f4e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f51:	01 45 ec             	add    %eax,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     f54:	83 ec 04             	sub    $0x4,%esp
     f57:	68 00 20 00 00       	push   $0x2000
     f5c:	68 20 87 00 00       	push   $0x8720
     f61:	ff 75 e0             	pushl  -0x20(%ebp)
     f64:	e8 57 2d 00 00       	call   3cc0 <read>
     f69:	83 c4 10             	add    $0x10,%esp
     f6c:	89 45 dc             	mov    %eax,-0x24(%ebp)
     f6f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     f73:	7f 89                	jg     efe <twofiles+0x178>
    }
    close(fd);
     f75:	83 ec 0c             	sub    $0xc,%esp
     f78:	ff 75 e0             	pushl  -0x20(%ebp)
     f7b:	e8 50 2d 00 00       	call   3cd0 <close>
     f80:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
     f83:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
     f8a:	74 1a                	je     fa6 <twofiles+0x220>
      printf(1, "wrong length %d\n", total);
     f8c:	83 ec 04             	sub    $0x4,%esp
     f8f:	ff 75 ec             	pushl  -0x14(%ebp)
     f92:	68 22 47 00 00       	push   $0x4722
     f97:	6a 01                	push   $0x1
     f99:	e8 86 2e 00 00       	call   3e24 <printf>
     f9e:	83 c4 10             	add    $0x10,%esp
      exit();
     fa1:	e8 02 2d 00 00       	call   3ca8 <exit>
  for(i = 0; i < 2; i++){
     fa6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     faa:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
     fae:	0f 8e 1e ff ff ff    	jle    ed2 <twofiles+0x14c>
    }
  }

  unlink("f1");
     fb4:	83 ec 0c             	sub    $0xc,%esp
     fb7:	68 f0 46 00 00       	push   $0x46f0
     fbc:	e8 37 2d 00 00       	call   3cf8 <unlink>
     fc1:	83 c4 10             	add    $0x10,%esp
  unlink("f2");
     fc4:	83 ec 0c             	sub    $0xc,%esp
     fc7:	68 f3 46 00 00       	push   $0x46f3
     fcc:	e8 27 2d 00 00       	call   3cf8 <unlink>
     fd1:	83 c4 10             	add    $0x10,%esp

  printf(1, "twofiles ok\n");
     fd4:	83 ec 08             	sub    $0x8,%esp
     fd7:	68 33 47 00 00       	push   $0x4733
     fdc:	6a 01                	push   $0x1
     fde:	e8 41 2e 00 00       	call   3e24 <printf>
     fe3:	83 c4 10             	add    $0x10,%esp
}
     fe6:	90                   	nop
     fe7:	c9                   	leave  
     fe8:	c3                   	ret    

00000fe9 <createdelete>:

// two processes create and delete different files in same directory
void
createdelete(void)
{
     fe9:	f3 0f 1e fb          	endbr32 
     fed:	55                   	push   %ebp
     fee:	89 e5                	mov    %esp,%ebp
     ff0:	83 ec 38             	sub    $0x38,%esp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
     ff3:	83 ec 08             	sub    $0x8,%esp
     ff6:	68 40 47 00 00       	push   $0x4740
     ffb:	6a 01                	push   $0x1
     ffd:	e8 22 2e 00 00       	call   3e24 <printf>
    1002:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1005:	e8 96 2c 00 00       	call   3ca0 <fork>
    100a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid < 0){
    100d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1011:	79 17                	jns    102a <createdelete+0x41>
    printf(1, "fork failed\n");
    1013:	83 ec 08             	sub    $0x8,%esp
    1016:	68 d9 45 00 00       	push   $0x45d9
    101b:	6a 01                	push   $0x1
    101d:	e8 02 2e 00 00       	call   3e24 <printf>
    1022:	83 c4 10             	add    $0x10,%esp
    exit();
    1025:	e8 7e 2c 00 00       	call   3ca8 <exit>
  }

  name[0] = pid ? 'p' : 'c';
    102a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    102e:	74 07                	je     1037 <createdelete+0x4e>
    1030:	b8 70 00 00 00       	mov    $0x70,%eax
    1035:	eb 05                	jmp    103c <createdelete+0x53>
    1037:	b8 63 00 00 00       	mov    $0x63,%eax
    103c:	88 45 cc             	mov    %al,-0x34(%ebp)
  name[2] = '\0';
    103f:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
  for(i = 0; i < N; i++){
    1043:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    104a:	e9 9b 00 00 00       	jmp    10ea <createdelete+0x101>
    name[1] = '0' + i;
    104f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1052:	83 c0 30             	add    $0x30,%eax
    1055:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, O_CREATE | O_RDWR);
    1058:	83 ec 08             	sub    $0x8,%esp
    105b:	68 02 02 00 00       	push   $0x202
    1060:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1063:	50                   	push   %eax
    1064:	e8 7f 2c 00 00       	call   3ce8 <open>
    1069:	83 c4 10             	add    $0x10,%esp
    106c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    106f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1073:	79 17                	jns    108c <createdelete+0xa3>
      printf(1, "create failed\n");
    1075:	83 ec 08             	sub    $0x8,%esp
    1078:	68 f6 46 00 00       	push   $0x46f6
    107d:	6a 01                	push   $0x1
    107f:	e8 a0 2d 00 00       	call   3e24 <printf>
    1084:	83 c4 10             	add    $0x10,%esp
      exit();
    1087:	e8 1c 2c 00 00       	call   3ca8 <exit>
    }
    close(fd);
    108c:	83 ec 0c             	sub    $0xc,%esp
    108f:	ff 75 ec             	pushl  -0x14(%ebp)
    1092:	e8 39 2c 00 00       	call   3cd0 <close>
    1097:	83 c4 10             	add    $0x10,%esp
    if(i > 0 && (i % 2 ) == 0){
    109a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    109e:	7e 46                	jle    10e6 <createdelete+0xfd>
    10a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10a3:	83 e0 01             	and    $0x1,%eax
    10a6:	85 c0                	test   %eax,%eax
    10a8:	75 3c                	jne    10e6 <createdelete+0xfd>
      name[1] = '0' + (i / 2);
    10aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ad:	89 c2                	mov    %eax,%edx
    10af:	c1 ea 1f             	shr    $0x1f,%edx
    10b2:	01 d0                	add    %edx,%eax
    10b4:	d1 f8                	sar    %eax
    10b6:	83 c0 30             	add    $0x30,%eax
    10b9:	88 45 cd             	mov    %al,-0x33(%ebp)
      if(unlink(name) < 0){
    10bc:	83 ec 0c             	sub    $0xc,%esp
    10bf:	8d 45 cc             	lea    -0x34(%ebp),%eax
    10c2:	50                   	push   %eax
    10c3:	e8 30 2c 00 00       	call   3cf8 <unlink>
    10c8:	83 c4 10             	add    $0x10,%esp
    10cb:	85 c0                	test   %eax,%eax
    10cd:	79 17                	jns    10e6 <createdelete+0xfd>
        printf(1, "unlink failed\n");
    10cf:	83 ec 08             	sub    $0x8,%esp
    10d2:	68 53 47 00 00       	push   $0x4753
    10d7:	6a 01                	push   $0x1
    10d9:	e8 46 2d 00 00       	call   3e24 <printf>
    10de:	83 c4 10             	add    $0x10,%esp
        exit();
    10e1:	e8 c2 2b 00 00       	call   3ca8 <exit>
  for(i = 0; i < N; i++){
    10e6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10ea:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    10ee:	0f 8e 5b ff ff ff    	jle    104f <createdelete+0x66>
      }
    }
  }

  if(pid==0)
    10f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10f8:	75 05                	jne    10ff <createdelete+0x116>
    exit();
    10fa:	e8 a9 2b 00 00       	call   3ca8 <exit>
  else
    wait();
    10ff:	e8 ac 2b 00 00       	call   3cb0 <wait>

  for(i = 0; i < N; i++){
    1104:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    110b:	e9 22 01 00 00       	jmp    1232 <createdelete+0x249>
    name[0] = 'p';
    1110:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    name[1] = '0' + i;
    1114:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1117:	83 c0 30             	add    $0x30,%eax
    111a:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, 0);
    111d:	83 ec 08             	sub    $0x8,%esp
    1120:	6a 00                	push   $0x0
    1122:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1125:	50                   	push   %eax
    1126:	e8 bd 2b 00 00       	call   3ce8 <open>
    112b:	83 c4 10             	add    $0x10,%esp
    112e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((i == 0 || i >= N/2) && fd < 0){
    1131:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1135:	74 06                	je     113d <createdelete+0x154>
    1137:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    113b:	7e 21                	jle    115e <createdelete+0x175>
    113d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1141:	79 1b                	jns    115e <createdelete+0x175>
      printf(1, "oops createdelete %s didn't exist\n", name);
    1143:	83 ec 04             	sub    $0x4,%esp
    1146:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1149:	50                   	push   %eax
    114a:	68 64 47 00 00       	push   $0x4764
    114f:	6a 01                	push   $0x1
    1151:	e8 ce 2c 00 00       	call   3e24 <printf>
    1156:	83 c4 10             	add    $0x10,%esp
      exit();
    1159:	e8 4a 2b 00 00       	call   3ca8 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    115e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1162:	7e 27                	jle    118b <createdelete+0x1a2>
    1164:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1168:	7f 21                	jg     118b <createdelete+0x1a2>
    116a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    116e:	78 1b                	js     118b <createdelete+0x1a2>
      printf(1, "oops createdelete %s did exist\n", name);
    1170:	83 ec 04             	sub    $0x4,%esp
    1173:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1176:	50                   	push   %eax
    1177:	68 88 47 00 00       	push   $0x4788
    117c:	6a 01                	push   $0x1
    117e:	e8 a1 2c 00 00       	call   3e24 <printf>
    1183:	83 c4 10             	add    $0x10,%esp
      exit();
    1186:	e8 1d 2b 00 00       	call   3ca8 <exit>
    }
    if(fd >= 0)
    118b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    118f:	78 0e                	js     119f <createdelete+0x1b6>
      close(fd);
    1191:	83 ec 0c             	sub    $0xc,%esp
    1194:	ff 75 ec             	pushl  -0x14(%ebp)
    1197:	e8 34 2b 00 00       	call   3cd0 <close>
    119c:	83 c4 10             	add    $0x10,%esp

    name[0] = 'c';
    119f:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    name[1] = '0' + i;
    11a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a6:	83 c0 30             	add    $0x30,%eax
    11a9:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, 0);
    11ac:	83 ec 08             	sub    $0x8,%esp
    11af:	6a 00                	push   $0x0
    11b1:	8d 45 cc             	lea    -0x34(%ebp),%eax
    11b4:	50                   	push   %eax
    11b5:	e8 2e 2b 00 00       	call   3ce8 <open>
    11ba:	83 c4 10             	add    $0x10,%esp
    11bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((i == 0 || i >= N/2) && fd < 0){
    11c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11c4:	74 06                	je     11cc <createdelete+0x1e3>
    11c6:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    11ca:	7e 21                	jle    11ed <createdelete+0x204>
    11cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11d0:	79 1b                	jns    11ed <createdelete+0x204>
      printf(1, "oops createdelete %s didn't exist\n", name);
    11d2:	83 ec 04             	sub    $0x4,%esp
    11d5:	8d 45 cc             	lea    -0x34(%ebp),%eax
    11d8:	50                   	push   %eax
    11d9:	68 64 47 00 00       	push   $0x4764
    11de:	6a 01                	push   $0x1
    11e0:	e8 3f 2c 00 00       	call   3e24 <printf>
    11e5:	83 c4 10             	add    $0x10,%esp
      exit();
    11e8:	e8 bb 2a 00 00       	call   3ca8 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    11ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11f1:	7e 27                	jle    121a <createdelete+0x231>
    11f3:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    11f7:	7f 21                	jg     121a <createdelete+0x231>
    11f9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11fd:	78 1b                	js     121a <createdelete+0x231>
      printf(1, "oops createdelete %s did exist\n", name);
    11ff:	83 ec 04             	sub    $0x4,%esp
    1202:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1205:	50                   	push   %eax
    1206:	68 88 47 00 00       	push   $0x4788
    120b:	6a 01                	push   $0x1
    120d:	e8 12 2c 00 00       	call   3e24 <printf>
    1212:	83 c4 10             	add    $0x10,%esp
      exit();
    1215:	e8 8e 2a 00 00       	call   3ca8 <exit>
    }
    if(fd >= 0)
    121a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    121e:	78 0e                	js     122e <createdelete+0x245>
      close(fd);
    1220:	83 ec 0c             	sub    $0xc,%esp
    1223:	ff 75 ec             	pushl  -0x14(%ebp)
    1226:	e8 a5 2a 00 00       	call   3cd0 <close>
    122b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < N; i++){
    122e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1232:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1236:	0f 8e d4 fe ff ff    	jle    1110 <createdelete+0x127>
  }

  for(i = 0; i < N; i++){
    123c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1243:	eb 33                	jmp    1278 <createdelete+0x28f>
    name[0] = 'p';
    1245:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    name[1] = '0' + i;
    1249:	8b 45 f4             	mov    -0xc(%ebp),%eax
    124c:	83 c0 30             	add    $0x30,%eax
    124f:	88 45 cd             	mov    %al,-0x33(%ebp)
    unlink(name);
    1252:	83 ec 0c             	sub    $0xc,%esp
    1255:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1258:	50                   	push   %eax
    1259:	e8 9a 2a 00 00       	call   3cf8 <unlink>
    125e:	83 c4 10             	add    $0x10,%esp
    name[0] = 'c';
    1261:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    unlink(name);
    1265:	83 ec 0c             	sub    $0xc,%esp
    1268:	8d 45 cc             	lea    -0x34(%ebp),%eax
    126b:	50                   	push   %eax
    126c:	e8 87 2a 00 00       	call   3cf8 <unlink>
    1271:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < N; i++){
    1274:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1278:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    127c:	7e c7                	jle    1245 <createdelete+0x25c>
  }

  printf(1, "createdelete ok\n");
    127e:	83 ec 08             	sub    $0x8,%esp
    1281:	68 a8 47 00 00       	push   $0x47a8
    1286:	6a 01                	push   $0x1
    1288:	e8 97 2b 00 00       	call   3e24 <printf>
    128d:	83 c4 10             	add    $0x10,%esp
}
    1290:	90                   	nop
    1291:	c9                   	leave  
    1292:	c3                   	ret    

00001293 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1293:	f3 0f 1e fb          	endbr32 
    1297:	55                   	push   %ebp
    1298:	89 e5                	mov    %esp,%ebp
    129a:	83 ec 18             	sub    $0x18,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    129d:	83 ec 08             	sub    $0x8,%esp
    12a0:	68 b9 47 00 00       	push   $0x47b9
    12a5:	6a 01                	push   $0x1
    12a7:	e8 78 2b 00 00       	call   3e24 <printf>
    12ac:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    12af:	83 ec 08             	sub    $0x8,%esp
    12b2:	68 02 02 00 00       	push   $0x202
    12b7:	68 ca 47 00 00       	push   $0x47ca
    12bc:	e8 27 2a 00 00       	call   3ce8 <open>
    12c1:	83 c4 10             	add    $0x10,%esp
    12c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    12c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12cb:	79 17                	jns    12e4 <unlinkread+0x51>
    printf(1, "create unlinkread failed\n");
    12cd:	83 ec 08             	sub    $0x8,%esp
    12d0:	68 d5 47 00 00       	push   $0x47d5
    12d5:	6a 01                	push   $0x1
    12d7:	e8 48 2b 00 00       	call   3e24 <printf>
    12dc:	83 c4 10             	add    $0x10,%esp
    exit();
    12df:	e8 c4 29 00 00       	call   3ca8 <exit>
  }
  write(fd, "hello", 5);
    12e4:	83 ec 04             	sub    $0x4,%esp
    12e7:	6a 05                	push   $0x5
    12e9:	68 ef 47 00 00       	push   $0x47ef
    12ee:	ff 75 f4             	pushl  -0xc(%ebp)
    12f1:	e8 d2 29 00 00       	call   3cc8 <write>
    12f6:	83 c4 10             	add    $0x10,%esp
  close(fd);
    12f9:	83 ec 0c             	sub    $0xc,%esp
    12fc:	ff 75 f4             	pushl  -0xc(%ebp)
    12ff:	e8 cc 29 00 00       	call   3cd0 <close>
    1304:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    1307:	83 ec 08             	sub    $0x8,%esp
    130a:	6a 02                	push   $0x2
    130c:	68 ca 47 00 00       	push   $0x47ca
    1311:	e8 d2 29 00 00       	call   3ce8 <open>
    1316:	83 c4 10             	add    $0x10,%esp
    1319:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    131c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1320:	79 17                	jns    1339 <unlinkread+0xa6>
    printf(1, "open unlinkread failed\n");
    1322:	83 ec 08             	sub    $0x8,%esp
    1325:	68 f5 47 00 00       	push   $0x47f5
    132a:	6a 01                	push   $0x1
    132c:	e8 f3 2a 00 00       	call   3e24 <printf>
    1331:	83 c4 10             	add    $0x10,%esp
    exit();
    1334:	e8 6f 29 00 00       	call   3ca8 <exit>
  }
  if(unlink("unlinkread") != 0){
    1339:	83 ec 0c             	sub    $0xc,%esp
    133c:	68 ca 47 00 00       	push   $0x47ca
    1341:	e8 b2 29 00 00       	call   3cf8 <unlink>
    1346:	83 c4 10             	add    $0x10,%esp
    1349:	85 c0                	test   %eax,%eax
    134b:	74 17                	je     1364 <unlinkread+0xd1>
    printf(1, "unlink unlinkread failed\n");
    134d:	83 ec 08             	sub    $0x8,%esp
    1350:	68 0d 48 00 00       	push   $0x480d
    1355:	6a 01                	push   $0x1
    1357:	e8 c8 2a 00 00       	call   3e24 <printf>
    135c:	83 c4 10             	add    $0x10,%esp
    exit();
    135f:	e8 44 29 00 00       	call   3ca8 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1364:	83 ec 08             	sub    $0x8,%esp
    1367:	68 02 02 00 00       	push   $0x202
    136c:	68 ca 47 00 00       	push   $0x47ca
    1371:	e8 72 29 00 00       	call   3ce8 <open>
    1376:	83 c4 10             	add    $0x10,%esp
    1379:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    137c:	83 ec 04             	sub    $0x4,%esp
    137f:	6a 03                	push   $0x3
    1381:	68 27 48 00 00       	push   $0x4827
    1386:	ff 75 f0             	pushl  -0x10(%ebp)
    1389:	e8 3a 29 00 00       	call   3cc8 <write>
    138e:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    1391:	83 ec 0c             	sub    $0xc,%esp
    1394:	ff 75 f0             	pushl  -0x10(%ebp)
    1397:	e8 34 29 00 00       	call   3cd0 <close>
    139c:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    139f:	83 ec 04             	sub    $0x4,%esp
    13a2:	68 00 20 00 00       	push   $0x2000
    13a7:	68 20 87 00 00       	push   $0x8720
    13ac:	ff 75 f4             	pushl  -0xc(%ebp)
    13af:	e8 0c 29 00 00       	call   3cc0 <read>
    13b4:	83 c4 10             	add    $0x10,%esp
    13b7:	83 f8 05             	cmp    $0x5,%eax
    13ba:	74 17                	je     13d3 <unlinkread+0x140>
    printf(1, "unlinkread read failed");
    13bc:	83 ec 08             	sub    $0x8,%esp
    13bf:	68 2b 48 00 00       	push   $0x482b
    13c4:	6a 01                	push   $0x1
    13c6:	e8 59 2a 00 00       	call   3e24 <printf>
    13cb:	83 c4 10             	add    $0x10,%esp
    exit();
    13ce:	e8 d5 28 00 00       	call   3ca8 <exit>
  }
  if(buf[0] != 'h'){
    13d3:	0f b6 05 20 87 00 00 	movzbl 0x8720,%eax
    13da:	3c 68                	cmp    $0x68,%al
    13dc:	74 17                	je     13f5 <unlinkread+0x162>
    printf(1, "unlinkread wrong data\n");
    13de:	83 ec 08             	sub    $0x8,%esp
    13e1:	68 42 48 00 00       	push   $0x4842
    13e6:	6a 01                	push   $0x1
    13e8:	e8 37 2a 00 00       	call   3e24 <printf>
    13ed:	83 c4 10             	add    $0x10,%esp
    exit();
    13f0:	e8 b3 28 00 00       	call   3ca8 <exit>
  }
  if(write(fd, buf, 10) != 10){
    13f5:	83 ec 04             	sub    $0x4,%esp
    13f8:	6a 0a                	push   $0xa
    13fa:	68 20 87 00 00       	push   $0x8720
    13ff:	ff 75 f4             	pushl  -0xc(%ebp)
    1402:	e8 c1 28 00 00       	call   3cc8 <write>
    1407:	83 c4 10             	add    $0x10,%esp
    140a:	83 f8 0a             	cmp    $0xa,%eax
    140d:	74 17                	je     1426 <unlinkread+0x193>
    printf(1, "unlinkread write failed\n");
    140f:	83 ec 08             	sub    $0x8,%esp
    1412:	68 59 48 00 00       	push   $0x4859
    1417:	6a 01                	push   $0x1
    1419:	e8 06 2a 00 00       	call   3e24 <printf>
    141e:	83 c4 10             	add    $0x10,%esp
    exit();
    1421:	e8 82 28 00 00       	call   3ca8 <exit>
  }
  close(fd);
    1426:	83 ec 0c             	sub    $0xc,%esp
    1429:	ff 75 f4             	pushl  -0xc(%ebp)
    142c:	e8 9f 28 00 00       	call   3cd0 <close>
    1431:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    1434:	83 ec 0c             	sub    $0xc,%esp
    1437:	68 ca 47 00 00       	push   $0x47ca
    143c:	e8 b7 28 00 00       	call   3cf8 <unlink>
    1441:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    1444:	83 ec 08             	sub    $0x8,%esp
    1447:	68 72 48 00 00       	push   $0x4872
    144c:	6a 01                	push   $0x1
    144e:	e8 d1 29 00 00       	call   3e24 <printf>
    1453:	83 c4 10             	add    $0x10,%esp
}
    1456:	90                   	nop
    1457:	c9                   	leave  
    1458:	c3                   	ret    

00001459 <linktest>:

void
linktest(void)
{
    1459:	f3 0f 1e fb          	endbr32 
    145d:	55                   	push   %ebp
    145e:	89 e5                	mov    %esp,%ebp
    1460:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "linktest\n");
    1463:	83 ec 08             	sub    $0x8,%esp
    1466:	68 81 48 00 00       	push   $0x4881
    146b:	6a 01                	push   $0x1
    146d:	e8 b2 29 00 00       	call   3e24 <printf>
    1472:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    1475:	83 ec 0c             	sub    $0xc,%esp
    1478:	68 8b 48 00 00       	push   $0x488b
    147d:	e8 76 28 00 00       	call   3cf8 <unlink>
    1482:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    1485:	83 ec 0c             	sub    $0xc,%esp
    1488:	68 8f 48 00 00       	push   $0x488f
    148d:	e8 66 28 00 00       	call   3cf8 <unlink>
    1492:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    1495:	83 ec 08             	sub    $0x8,%esp
    1498:	68 02 02 00 00       	push   $0x202
    149d:	68 8b 48 00 00       	push   $0x488b
    14a2:	e8 41 28 00 00       	call   3ce8 <open>
    14a7:	83 c4 10             	add    $0x10,%esp
    14aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    14ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14b1:	79 17                	jns    14ca <linktest+0x71>
    printf(1, "create lf1 failed\n");
    14b3:	83 ec 08             	sub    $0x8,%esp
    14b6:	68 93 48 00 00       	push   $0x4893
    14bb:	6a 01                	push   $0x1
    14bd:	e8 62 29 00 00       	call   3e24 <printf>
    14c2:	83 c4 10             	add    $0x10,%esp
    exit();
    14c5:	e8 de 27 00 00       	call   3ca8 <exit>
  }
  if(write(fd, "hello", 5) != 5){
    14ca:	83 ec 04             	sub    $0x4,%esp
    14cd:	6a 05                	push   $0x5
    14cf:	68 ef 47 00 00       	push   $0x47ef
    14d4:	ff 75 f4             	pushl  -0xc(%ebp)
    14d7:	e8 ec 27 00 00       	call   3cc8 <write>
    14dc:	83 c4 10             	add    $0x10,%esp
    14df:	83 f8 05             	cmp    $0x5,%eax
    14e2:	74 17                	je     14fb <linktest+0xa2>
    printf(1, "write lf1 failed\n");
    14e4:	83 ec 08             	sub    $0x8,%esp
    14e7:	68 a6 48 00 00       	push   $0x48a6
    14ec:	6a 01                	push   $0x1
    14ee:	e8 31 29 00 00       	call   3e24 <printf>
    14f3:	83 c4 10             	add    $0x10,%esp
    exit();
    14f6:	e8 ad 27 00 00       	call   3ca8 <exit>
  }
  close(fd);
    14fb:	83 ec 0c             	sub    $0xc,%esp
    14fe:	ff 75 f4             	pushl  -0xc(%ebp)
    1501:	e8 ca 27 00 00       	call   3cd0 <close>
    1506:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    1509:	83 ec 08             	sub    $0x8,%esp
    150c:	68 8f 48 00 00       	push   $0x488f
    1511:	68 8b 48 00 00       	push   $0x488b
    1516:	e8 ed 27 00 00       	call   3d08 <link>
    151b:	83 c4 10             	add    $0x10,%esp
    151e:	85 c0                	test   %eax,%eax
    1520:	79 17                	jns    1539 <linktest+0xe0>
    printf(1, "link lf1 lf2 failed\n");
    1522:	83 ec 08             	sub    $0x8,%esp
    1525:	68 b8 48 00 00       	push   $0x48b8
    152a:	6a 01                	push   $0x1
    152c:	e8 f3 28 00 00       	call   3e24 <printf>
    1531:	83 c4 10             	add    $0x10,%esp
    exit();
    1534:	e8 6f 27 00 00       	call   3ca8 <exit>
  }
  unlink("lf1");
    1539:	83 ec 0c             	sub    $0xc,%esp
    153c:	68 8b 48 00 00       	push   $0x488b
    1541:	e8 b2 27 00 00       	call   3cf8 <unlink>
    1546:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    1549:	83 ec 08             	sub    $0x8,%esp
    154c:	6a 00                	push   $0x0
    154e:	68 8b 48 00 00       	push   $0x488b
    1553:	e8 90 27 00 00       	call   3ce8 <open>
    1558:	83 c4 10             	add    $0x10,%esp
    155b:	85 c0                	test   %eax,%eax
    155d:	78 17                	js     1576 <linktest+0x11d>
    printf(1, "unlinked lf1 but it is still there!\n");
    155f:	83 ec 08             	sub    $0x8,%esp
    1562:	68 d0 48 00 00       	push   $0x48d0
    1567:	6a 01                	push   $0x1
    1569:	e8 b6 28 00 00       	call   3e24 <printf>
    156e:	83 c4 10             	add    $0x10,%esp
    exit();
    1571:	e8 32 27 00 00       	call   3ca8 <exit>
  }

  fd = open("lf2", 0);
    1576:	83 ec 08             	sub    $0x8,%esp
    1579:	6a 00                	push   $0x0
    157b:	68 8f 48 00 00       	push   $0x488f
    1580:	e8 63 27 00 00       	call   3ce8 <open>
    1585:	83 c4 10             	add    $0x10,%esp
    1588:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    158b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    158f:	79 17                	jns    15a8 <linktest+0x14f>
    printf(1, "open lf2 failed\n");
    1591:	83 ec 08             	sub    $0x8,%esp
    1594:	68 f5 48 00 00       	push   $0x48f5
    1599:	6a 01                	push   $0x1
    159b:	e8 84 28 00 00       	call   3e24 <printf>
    15a0:	83 c4 10             	add    $0x10,%esp
    exit();
    15a3:	e8 00 27 00 00       	call   3ca8 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    15a8:	83 ec 04             	sub    $0x4,%esp
    15ab:	68 00 20 00 00       	push   $0x2000
    15b0:	68 20 87 00 00       	push   $0x8720
    15b5:	ff 75 f4             	pushl  -0xc(%ebp)
    15b8:	e8 03 27 00 00       	call   3cc0 <read>
    15bd:	83 c4 10             	add    $0x10,%esp
    15c0:	83 f8 05             	cmp    $0x5,%eax
    15c3:	74 17                	je     15dc <linktest+0x183>
    printf(1, "read lf2 failed\n");
    15c5:	83 ec 08             	sub    $0x8,%esp
    15c8:	68 06 49 00 00       	push   $0x4906
    15cd:	6a 01                	push   $0x1
    15cf:	e8 50 28 00 00       	call   3e24 <printf>
    15d4:	83 c4 10             	add    $0x10,%esp
    exit();
    15d7:	e8 cc 26 00 00       	call   3ca8 <exit>
  }
  close(fd);
    15dc:	83 ec 0c             	sub    $0xc,%esp
    15df:	ff 75 f4             	pushl  -0xc(%ebp)
    15e2:	e8 e9 26 00 00       	call   3cd0 <close>
    15e7:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    15ea:	83 ec 08             	sub    $0x8,%esp
    15ed:	68 8f 48 00 00       	push   $0x488f
    15f2:	68 8f 48 00 00       	push   $0x488f
    15f7:	e8 0c 27 00 00       	call   3d08 <link>
    15fc:	83 c4 10             	add    $0x10,%esp
    15ff:	85 c0                	test   %eax,%eax
    1601:	78 17                	js     161a <linktest+0x1c1>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1603:	83 ec 08             	sub    $0x8,%esp
    1606:	68 17 49 00 00       	push   $0x4917
    160b:	6a 01                	push   $0x1
    160d:	e8 12 28 00 00       	call   3e24 <printf>
    1612:	83 c4 10             	add    $0x10,%esp
    exit();
    1615:	e8 8e 26 00 00       	call   3ca8 <exit>
  }

  unlink("lf2");
    161a:	83 ec 0c             	sub    $0xc,%esp
    161d:	68 8f 48 00 00       	push   $0x488f
    1622:	e8 d1 26 00 00       	call   3cf8 <unlink>
    1627:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    162a:	83 ec 08             	sub    $0x8,%esp
    162d:	68 8b 48 00 00       	push   $0x488b
    1632:	68 8f 48 00 00       	push   $0x488f
    1637:	e8 cc 26 00 00       	call   3d08 <link>
    163c:	83 c4 10             	add    $0x10,%esp
    163f:	85 c0                	test   %eax,%eax
    1641:	78 17                	js     165a <linktest+0x201>
    printf(1, "link non-existant succeeded! oops\n");
    1643:	83 ec 08             	sub    $0x8,%esp
    1646:	68 38 49 00 00       	push   $0x4938
    164b:	6a 01                	push   $0x1
    164d:	e8 d2 27 00 00       	call   3e24 <printf>
    1652:	83 c4 10             	add    $0x10,%esp
    exit();
    1655:	e8 4e 26 00 00       	call   3ca8 <exit>
  }

  if(link(".", "lf1") >= 0){
    165a:	83 ec 08             	sub    $0x8,%esp
    165d:	68 8b 48 00 00       	push   $0x488b
    1662:	68 5b 49 00 00       	push   $0x495b
    1667:	e8 9c 26 00 00       	call   3d08 <link>
    166c:	83 c4 10             	add    $0x10,%esp
    166f:	85 c0                	test   %eax,%eax
    1671:	78 17                	js     168a <linktest+0x231>
    printf(1, "link . lf1 succeeded! oops\n");
    1673:	83 ec 08             	sub    $0x8,%esp
    1676:	68 5d 49 00 00       	push   $0x495d
    167b:	6a 01                	push   $0x1
    167d:	e8 a2 27 00 00       	call   3e24 <printf>
    1682:	83 c4 10             	add    $0x10,%esp
    exit();
    1685:	e8 1e 26 00 00       	call   3ca8 <exit>
  }

  printf(1, "linktest ok\n");
    168a:	83 ec 08             	sub    $0x8,%esp
    168d:	68 79 49 00 00       	push   $0x4979
    1692:	6a 01                	push   $0x1
    1694:	e8 8b 27 00 00       	call   3e24 <printf>
    1699:	83 c4 10             	add    $0x10,%esp
}
    169c:	90                   	nop
    169d:	c9                   	leave  
    169e:	c3                   	ret    

0000169f <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    169f:	f3 0f 1e fb          	endbr32 
    16a3:	55                   	push   %ebp
    16a4:	89 e5                	mov    %esp,%ebp
    16a6:	83 ec 58             	sub    $0x58,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    16a9:	83 ec 08             	sub    $0x8,%esp
    16ac:	68 86 49 00 00       	push   $0x4986
    16b1:	6a 01                	push   $0x1
    16b3:	e8 6c 27 00 00       	call   3e24 <printf>
    16b8:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    16bb:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    16bf:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    16c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    16ca:	e9 fc 00 00 00       	jmp    17cb <concreate+0x12c>
    file[1] = '0' + i;
    16cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d2:	83 c0 30             	add    $0x30,%eax
    16d5:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    16d8:	83 ec 0c             	sub    $0xc,%esp
    16db:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    16de:	50                   	push   %eax
    16df:	e8 14 26 00 00       	call   3cf8 <unlink>
    16e4:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    16e7:	e8 b4 25 00 00       	call   3ca0 <fork>
    16ec:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid && (i % 3) == 1){
    16ef:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    16f3:	74 3b                	je     1730 <concreate+0x91>
    16f5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16f8:	ba 56 55 55 55       	mov    $0x55555556,%edx
    16fd:	89 c8                	mov    %ecx,%eax
    16ff:	f7 ea                	imul   %edx
    1701:	89 c8                	mov    %ecx,%eax
    1703:	c1 f8 1f             	sar    $0x1f,%eax
    1706:	29 c2                	sub    %eax,%edx
    1708:	89 d0                	mov    %edx,%eax
    170a:	01 c0                	add    %eax,%eax
    170c:	01 d0                	add    %edx,%eax
    170e:	29 c1                	sub    %eax,%ecx
    1710:	89 ca                	mov    %ecx,%edx
    1712:	83 fa 01             	cmp    $0x1,%edx
    1715:	75 19                	jne    1730 <concreate+0x91>
      link("C0", file);
    1717:	83 ec 08             	sub    $0x8,%esp
    171a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    171d:	50                   	push   %eax
    171e:	68 96 49 00 00       	push   $0x4996
    1723:	e8 e0 25 00 00       	call   3d08 <link>
    1728:	83 c4 10             	add    $0x10,%esp
    172b:	e9 87 00 00 00       	jmp    17b7 <concreate+0x118>
    } else if(pid == 0 && (i % 5) == 1){
    1730:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1734:	75 3b                	jne    1771 <concreate+0xd2>
    1736:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1739:	ba 67 66 66 66       	mov    $0x66666667,%edx
    173e:	89 c8                	mov    %ecx,%eax
    1740:	f7 ea                	imul   %edx
    1742:	d1 fa                	sar    %edx
    1744:	89 c8                	mov    %ecx,%eax
    1746:	c1 f8 1f             	sar    $0x1f,%eax
    1749:	29 c2                	sub    %eax,%edx
    174b:	89 d0                	mov    %edx,%eax
    174d:	c1 e0 02             	shl    $0x2,%eax
    1750:	01 d0                	add    %edx,%eax
    1752:	29 c1                	sub    %eax,%ecx
    1754:	89 ca                	mov    %ecx,%edx
    1756:	83 fa 01             	cmp    $0x1,%edx
    1759:	75 16                	jne    1771 <concreate+0xd2>
      link("C0", file);
    175b:	83 ec 08             	sub    $0x8,%esp
    175e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1761:	50                   	push   %eax
    1762:	68 96 49 00 00       	push   $0x4996
    1767:	e8 9c 25 00 00       	call   3d08 <link>
    176c:	83 c4 10             	add    $0x10,%esp
    176f:	eb 46                	jmp    17b7 <concreate+0x118>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1771:	83 ec 08             	sub    $0x8,%esp
    1774:	68 02 02 00 00       	push   $0x202
    1779:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    177c:	50                   	push   %eax
    177d:	e8 66 25 00 00       	call   3ce8 <open>
    1782:	83 c4 10             	add    $0x10,%esp
    1785:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(fd < 0){
    1788:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    178c:	79 1b                	jns    17a9 <concreate+0x10a>
        printf(1, "concreate create %s failed\n", file);
    178e:	83 ec 04             	sub    $0x4,%esp
    1791:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1794:	50                   	push   %eax
    1795:	68 99 49 00 00       	push   $0x4999
    179a:	6a 01                	push   $0x1
    179c:	e8 83 26 00 00       	call   3e24 <printf>
    17a1:	83 c4 10             	add    $0x10,%esp
        exit();
    17a4:	e8 ff 24 00 00       	call   3ca8 <exit>
      }
      close(fd);
    17a9:	83 ec 0c             	sub    $0xc,%esp
    17ac:	ff 75 ec             	pushl  -0x14(%ebp)
    17af:	e8 1c 25 00 00       	call   3cd0 <close>
    17b4:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    17b7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    17bb:	75 05                	jne    17c2 <concreate+0x123>
      exit();
    17bd:	e8 e6 24 00 00       	call   3ca8 <exit>
    else
      wait();
    17c2:	e8 e9 24 00 00       	call   3cb0 <wait>
  for(i = 0; i < 40; i++){
    17c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    17cb:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    17cf:	0f 8e fa fe ff ff    	jle    16cf <concreate+0x30>
  }

  memset(fa, 0, sizeof(fa));
    17d5:	83 ec 04             	sub    $0x4,%esp
    17d8:	6a 28                	push   $0x28
    17da:	6a 00                	push   $0x0
    17dc:	8d 45 bd             	lea    -0x43(%ebp),%eax
    17df:	50                   	push   %eax
    17e0:	e8 10 23 00 00       	call   3af5 <memset>
    17e5:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    17e8:	83 ec 08             	sub    $0x8,%esp
    17eb:	6a 00                	push   $0x0
    17ed:	68 5b 49 00 00       	push   $0x495b
    17f2:	e8 f1 24 00 00       	call   3ce8 <open>
    17f7:	83 c4 10             	add    $0x10,%esp
    17fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  n = 0;
    17fd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1804:	e9 93 00 00 00       	jmp    189c <concreate+0x1fd>
    if(de.inum == 0)
    1809:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    180d:	66 85 c0             	test   %ax,%ax
    1810:	75 05                	jne    1817 <concreate+0x178>
      continue;
    1812:	e9 85 00 00 00       	jmp    189c <concreate+0x1fd>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1817:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    181b:	3c 43                	cmp    $0x43,%al
    181d:	75 7d                	jne    189c <concreate+0x1fd>
    181f:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    1823:	84 c0                	test   %al,%al
    1825:	75 75                	jne    189c <concreate+0x1fd>
      i = de.name[1] - '0';
    1827:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    182b:	0f be c0             	movsbl %al,%eax
    182e:	83 e8 30             	sub    $0x30,%eax
    1831:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    1834:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1838:	78 08                	js     1842 <concreate+0x1a3>
    183a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183d:	83 f8 27             	cmp    $0x27,%eax
    1840:	76 1e                	jbe    1860 <concreate+0x1c1>
        printf(1, "concreate weird file %s\n", de.name);
    1842:	83 ec 04             	sub    $0x4,%esp
    1845:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1848:	83 c0 02             	add    $0x2,%eax
    184b:	50                   	push   %eax
    184c:	68 b5 49 00 00       	push   $0x49b5
    1851:	6a 01                	push   $0x1
    1853:	e8 cc 25 00 00       	call   3e24 <printf>
    1858:	83 c4 10             	add    $0x10,%esp
        exit();
    185b:	e8 48 24 00 00       	call   3ca8 <exit>
      }
      if(fa[i]){
    1860:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1863:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1866:	01 d0                	add    %edx,%eax
    1868:	0f b6 00             	movzbl (%eax),%eax
    186b:	84 c0                	test   %al,%al
    186d:	74 1e                	je     188d <concreate+0x1ee>
        printf(1, "concreate duplicate file %s\n", de.name);
    186f:	83 ec 04             	sub    $0x4,%esp
    1872:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1875:	83 c0 02             	add    $0x2,%eax
    1878:	50                   	push   %eax
    1879:	68 ce 49 00 00       	push   $0x49ce
    187e:	6a 01                	push   $0x1
    1880:	e8 9f 25 00 00       	call   3e24 <printf>
    1885:	83 c4 10             	add    $0x10,%esp
        exit();
    1888:	e8 1b 24 00 00       	call   3ca8 <exit>
      }
      fa[i] = 1;
    188d:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1890:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1893:	01 d0                	add    %edx,%eax
    1895:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    1898:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    189c:	83 ec 04             	sub    $0x4,%esp
    189f:	6a 10                	push   $0x10
    18a1:	8d 45 ac             	lea    -0x54(%ebp),%eax
    18a4:	50                   	push   %eax
    18a5:	ff 75 ec             	pushl  -0x14(%ebp)
    18a8:	e8 13 24 00 00       	call   3cc0 <read>
    18ad:	83 c4 10             	add    $0x10,%esp
    18b0:	85 c0                	test   %eax,%eax
    18b2:	0f 8f 51 ff ff ff    	jg     1809 <concreate+0x16a>
    }
  }
  close(fd);
    18b8:	83 ec 0c             	sub    $0xc,%esp
    18bb:	ff 75 ec             	pushl  -0x14(%ebp)
    18be:	e8 0d 24 00 00       	call   3cd0 <close>
    18c3:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    18c6:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    18ca:	74 17                	je     18e3 <concreate+0x244>
    printf(1, "concreate not enough files in directory listing\n");
    18cc:	83 ec 08             	sub    $0x8,%esp
    18cf:	68 ec 49 00 00       	push   $0x49ec
    18d4:	6a 01                	push   $0x1
    18d6:	e8 49 25 00 00       	call   3e24 <printf>
    18db:	83 c4 10             	add    $0x10,%esp
    exit();
    18de:	e8 c5 23 00 00       	call   3ca8 <exit>
  }

  for(i = 0; i < 40; i++){
    18e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    18ea:	e9 45 01 00 00       	jmp    1a34 <concreate+0x395>
    file[1] = '0' + i;
    18ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f2:	83 c0 30             	add    $0x30,%eax
    18f5:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    18f8:	e8 a3 23 00 00       	call   3ca0 <fork>
    18fd:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    1900:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1904:	79 17                	jns    191d <concreate+0x27e>
      printf(1, "fork failed\n");
    1906:	83 ec 08             	sub    $0x8,%esp
    1909:	68 d9 45 00 00       	push   $0x45d9
    190e:	6a 01                	push   $0x1
    1910:	e8 0f 25 00 00       	call   3e24 <printf>
    1915:	83 c4 10             	add    $0x10,%esp
      exit();
    1918:	e8 8b 23 00 00       	call   3ca8 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    191d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1920:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1925:	89 c8                	mov    %ecx,%eax
    1927:	f7 ea                	imul   %edx
    1929:	89 c8                	mov    %ecx,%eax
    192b:	c1 f8 1f             	sar    $0x1f,%eax
    192e:	29 c2                	sub    %eax,%edx
    1930:	89 d0                	mov    %edx,%eax
    1932:	89 c2                	mov    %eax,%edx
    1934:	01 d2                	add    %edx,%edx
    1936:	01 c2                	add    %eax,%edx
    1938:	89 c8                	mov    %ecx,%eax
    193a:	29 d0                	sub    %edx,%eax
    193c:	85 c0                	test   %eax,%eax
    193e:	75 06                	jne    1946 <concreate+0x2a7>
    1940:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1944:	74 28                	je     196e <concreate+0x2cf>
       ((i % 3) == 1 && pid != 0)){
    1946:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1949:	ba 56 55 55 55       	mov    $0x55555556,%edx
    194e:	89 c8                	mov    %ecx,%eax
    1950:	f7 ea                	imul   %edx
    1952:	89 c8                	mov    %ecx,%eax
    1954:	c1 f8 1f             	sar    $0x1f,%eax
    1957:	29 c2                	sub    %eax,%edx
    1959:	89 d0                	mov    %edx,%eax
    195b:	01 c0                	add    %eax,%eax
    195d:	01 d0                	add    %edx,%eax
    195f:	29 c1                	sub    %eax,%ecx
    1961:	89 ca                	mov    %ecx,%edx
    if(((i % 3) == 0 && pid == 0) ||
    1963:	83 fa 01             	cmp    $0x1,%edx
    1966:	75 7c                	jne    19e4 <concreate+0x345>
       ((i % 3) == 1 && pid != 0)){
    1968:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    196c:	74 76                	je     19e4 <concreate+0x345>
      close(open(file, 0));
    196e:	83 ec 08             	sub    $0x8,%esp
    1971:	6a 00                	push   $0x0
    1973:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1976:	50                   	push   %eax
    1977:	e8 6c 23 00 00       	call   3ce8 <open>
    197c:	83 c4 10             	add    $0x10,%esp
    197f:	83 ec 0c             	sub    $0xc,%esp
    1982:	50                   	push   %eax
    1983:	e8 48 23 00 00       	call   3cd0 <close>
    1988:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    198b:	83 ec 08             	sub    $0x8,%esp
    198e:	6a 00                	push   $0x0
    1990:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1993:	50                   	push   %eax
    1994:	e8 4f 23 00 00       	call   3ce8 <open>
    1999:	83 c4 10             	add    $0x10,%esp
    199c:	83 ec 0c             	sub    $0xc,%esp
    199f:	50                   	push   %eax
    19a0:	e8 2b 23 00 00       	call   3cd0 <close>
    19a5:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    19a8:	83 ec 08             	sub    $0x8,%esp
    19ab:	6a 00                	push   $0x0
    19ad:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19b0:	50                   	push   %eax
    19b1:	e8 32 23 00 00       	call   3ce8 <open>
    19b6:	83 c4 10             	add    $0x10,%esp
    19b9:	83 ec 0c             	sub    $0xc,%esp
    19bc:	50                   	push   %eax
    19bd:	e8 0e 23 00 00       	call   3cd0 <close>
    19c2:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    19c5:	83 ec 08             	sub    $0x8,%esp
    19c8:	6a 00                	push   $0x0
    19ca:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19cd:	50                   	push   %eax
    19ce:	e8 15 23 00 00       	call   3ce8 <open>
    19d3:	83 c4 10             	add    $0x10,%esp
    19d6:	83 ec 0c             	sub    $0xc,%esp
    19d9:	50                   	push   %eax
    19da:	e8 f1 22 00 00       	call   3cd0 <close>
    19df:	83 c4 10             	add    $0x10,%esp
    19e2:	eb 3c                	jmp    1a20 <concreate+0x381>
    } else {
      unlink(file);
    19e4:	83 ec 0c             	sub    $0xc,%esp
    19e7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19ea:	50                   	push   %eax
    19eb:	e8 08 23 00 00       	call   3cf8 <unlink>
    19f0:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    19f3:	83 ec 0c             	sub    $0xc,%esp
    19f6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19f9:	50                   	push   %eax
    19fa:	e8 f9 22 00 00       	call   3cf8 <unlink>
    19ff:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1a02:	83 ec 0c             	sub    $0xc,%esp
    1a05:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1a08:	50                   	push   %eax
    1a09:	e8 ea 22 00 00       	call   3cf8 <unlink>
    1a0e:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1a11:	83 ec 0c             	sub    $0xc,%esp
    1a14:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1a17:	50                   	push   %eax
    1a18:	e8 db 22 00 00       	call   3cf8 <unlink>
    1a1d:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1a20:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1a24:	75 05                	jne    1a2b <concreate+0x38c>
      exit();
    1a26:	e8 7d 22 00 00       	call   3ca8 <exit>
    else
      wait();
    1a2b:	e8 80 22 00 00       	call   3cb0 <wait>
  for(i = 0; i < 40; i++){
    1a30:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1a34:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1a38:	0f 8e b1 fe ff ff    	jle    18ef <concreate+0x250>
  }

  printf(1, "concreate ok\n");
    1a3e:	83 ec 08             	sub    $0x8,%esp
    1a41:	68 1d 4a 00 00       	push   $0x4a1d
    1a46:	6a 01                	push   $0x1
    1a48:	e8 d7 23 00 00       	call   3e24 <printf>
    1a4d:	83 c4 10             	add    $0x10,%esp
}
    1a50:	90                   	nop
    1a51:	c9                   	leave  
    1a52:	c3                   	ret    

00001a53 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1a53:	f3 0f 1e fb          	endbr32 
    1a57:	55                   	push   %ebp
    1a58:	89 e5                	mov    %esp,%ebp
    1a5a:	83 ec 18             	sub    $0x18,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1a5d:	83 ec 08             	sub    $0x8,%esp
    1a60:	68 2b 4a 00 00       	push   $0x4a2b
    1a65:	6a 01                	push   $0x1
    1a67:	e8 b8 23 00 00       	call   3e24 <printf>
    1a6c:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    1a6f:	83 ec 0c             	sub    $0xc,%esp
    1a72:	68 92 45 00 00       	push   $0x4592
    1a77:	e8 7c 22 00 00       	call   3cf8 <unlink>
    1a7c:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1a7f:	e8 1c 22 00 00       	call   3ca0 <fork>
    1a84:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    1a87:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a8b:	79 17                	jns    1aa4 <linkunlink+0x51>
    printf(1, "fork failed\n");
    1a8d:	83 ec 08             	sub    $0x8,%esp
    1a90:	68 d9 45 00 00       	push   $0x45d9
    1a95:	6a 01                	push   $0x1
    1a97:	e8 88 23 00 00       	call   3e24 <printf>
    1a9c:	83 c4 10             	add    $0x10,%esp
    exit();
    1a9f:	e8 04 22 00 00       	call   3ca8 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1aa4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aa8:	74 07                	je     1ab1 <linkunlink+0x5e>
    1aaa:	b8 01 00 00 00       	mov    $0x1,%eax
    1aaf:	eb 05                	jmp    1ab6 <linkunlink+0x63>
    1ab1:	b8 61 00 00 00       	mov    $0x61,%eax
    1ab6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    1ab9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ac0:	e9 9a 00 00 00       	jmp    1b5f <linkunlink+0x10c>
    x = x * 1103515245 + 12345;
    1ac5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ac8:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1ace:	05 39 30 00 00       	add    $0x3039,%eax
    1ad3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    1ad6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1ad9:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1ade:	89 c8                	mov    %ecx,%eax
    1ae0:	f7 e2                	mul    %edx
    1ae2:	89 d0                	mov    %edx,%eax
    1ae4:	d1 e8                	shr    %eax
    1ae6:	89 c2                	mov    %eax,%edx
    1ae8:	01 d2                	add    %edx,%edx
    1aea:	01 c2                	add    %eax,%edx
    1aec:	89 c8                	mov    %ecx,%eax
    1aee:	29 d0                	sub    %edx,%eax
    1af0:	85 c0                	test   %eax,%eax
    1af2:	75 23                	jne    1b17 <linkunlink+0xc4>
      close(open("x", O_RDWR | O_CREATE));
    1af4:	83 ec 08             	sub    $0x8,%esp
    1af7:	68 02 02 00 00       	push   $0x202
    1afc:	68 92 45 00 00       	push   $0x4592
    1b01:	e8 e2 21 00 00       	call   3ce8 <open>
    1b06:	83 c4 10             	add    $0x10,%esp
    1b09:	83 ec 0c             	sub    $0xc,%esp
    1b0c:	50                   	push   %eax
    1b0d:	e8 be 21 00 00       	call   3cd0 <close>
    1b12:	83 c4 10             	add    $0x10,%esp
    1b15:	eb 44                	jmp    1b5b <linkunlink+0x108>
    } else if((x % 3) == 1){
    1b17:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1b1a:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1b1f:	89 c8                	mov    %ecx,%eax
    1b21:	f7 e2                	mul    %edx
    1b23:	d1 ea                	shr    %edx
    1b25:	89 d0                	mov    %edx,%eax
    1b27:	01 c0                	add    %eax,%eax
    1b29:	01 d0                	add    %edx,%eax
    1b2b:	29 c1                	sub    %eax,%ecx
    1b2d:	89 ca                	mov    %ecx,%edx
    1b2f:	83 fa 01             	cmp    $0x1,%edx
    1b32:	75 17                	jne    1b4b <linkunlink+0xf8>
      link("cat", "x");
    1b34:	83 ec 08             	sub    $0x8,%esp
    1b37:	68 92 45 00 00       	push   $0x4592
    1b3c:	68 3c 4a 00 00       	push   $0x4a3c
    1b41:	e8 c2 21 00 00       	call   3d08 <link>
    1b46:	83 c4 10             	add    $0x10,%esp
    1b49:	eb 10                	jmp    1b5b <linkunlink+0x108>
    } else {
      unlink("x");
    1b4b:	83 ec 0c             	sub    $0xc,%esp
    1b4e:	68 92 45 00 00       	push   $0x4592
    1b53:	e8 a0 21 00 00       	call   3cf8 <unlink>
    1b58:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b5b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b5f:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1b63:	0f 8e 5c ff ff ff    	jle    1ac5 <linkunlink+0x72>
    }
  }

  if(pid)
    1b69:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b6d:	74 07                	je     1b76 <linkunlink+0x123>
    wait();
    1b6f:	e8 3c 21 00 00       	call   3cb0 <wait>
    1b74:	eb 05                	jmp    1b7b <linkunlink+0x128>
  else 
    exit();
    1b76:	e8 2d 21 00 00       	call   3ca8 <exit>

  printf(1, "linkunlink ok\n");
    1b7b:	83 ec 08             	sub    $0x8,%esp
    1b7e:	68 40 4a 00 00       	push   $0x4a40
    1b83:	6a 01                	push   $0x1
    1b85:	e8 9a 22 00 00       	call   3e24 <printf>
    1b8a:	83 c4 10             	add    $0x10,%esp
}
    1b8d:	90                   	nop
    1b8e:	c9                   	leave  
    1b8f:	c3                   	ret    

00001b90 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1b90:	f3 0f 1e fb          	endbr32 
    1b94:	55                   	push   %ebp
    1b95:	89 e5                	mov    %esp,%ebp
    1b97:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1b9a:	83 ec 08             	sub    $0x8,%esp
    1b9d:	68 4f 4a 00 00       	push   $0x4a4f
    1ba2:	6a 01                	push   $0x1
    1ba4:	e8 7b 22 00 00       	call   3e24 <printf>
    1ba9:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    1bac:	83 ec 0c             	sub    $0xc,%esp
    1baf:	68 5c 4a 00 00       	push   $0x4a5c
    1bb4:	e8 3f 21 00 00       	call   3cf8 <unlink>
    1bb9:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    1bbc:	83 ec 08             	sub    $0x8,%esp
    1bbf:	68 00 02 00 00       	push   $0x200
    1bc4:	68 5c 4a 00 00       	push   $0x4a5c
    1bc9:	e8 1a 21 00 00       	call   3ce8 <open>
    1bce:	83 c4 10             	add    $0x10,%esp
    1bd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    1bd4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1bd8:	79 17                	jns    1bf1 <bigdir+0x61>
    printf(1, "bigdir create failed\n");
    1bda:	83 ec 08             	sub    $0x8,%esp
    1bdd:	68 5f 4a 00 00       	push   $0x4a5f
    1be2:	6a 01                	push   $0x1
    1be4:	e8 3b 22 00 00       	call   3e24 <printf>
    1be9:	83 c4 10             	add    $0x10,%esp
    exit();
    1bec:	e8 b7 20 00 00       	call   3ca8 <exit>
  }
  close(fd);
    1bf1:	83 ec 0c             	sub    $0xc,%esp
    1bf4:	ff 75 f0             	pushl  -0x10(%ebp)
    1bf7:	e8 d4 20 00 00       	call   3cd0 <close>
    1bfc:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    1bff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c06:	eb 63                	jmp    1c6b <bigdir+0xdb>
    name[0] = 'x';
    1c08:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c0f:	8d 50 3f             	lea    0x3f(%eax),%edx
    1c12:	85 c0                	test   %eax,%eax
    1c14:	0f 48 c2             	cmovs  %edx,%eax
    1c17:	c1 f8 06             	sar    $0x6,%eax
    1c1a:	83 c0 30             	add    $0x30,%eax
    1c1d:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c23:	99                   	cltd   
    1c24:	c1 ea 1a             	shr    $0x1a,%edx
    1c27:	01 d0                	add    %edx,%eax
    1c29:	83 e0 3f             	and    $0x3f,%eax
    1c2c:	29 d0                	sub    %edx,%eax
    1c2e:	83 c0 30             	add    $0x30,%eax
    1c31:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1c34:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    1c38:	83 ec 08             	sub    $0x8,%esp
    1c3b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1c3e:	50                   	push   %eax
    1c3f:	68 5c 4a 00 00       	push   $0x4a5c
    1c44:	e8 bf 20 00 00       	call   3d08 <link>
    1c49:	83 c4 10             	add    $0x10,%esp
    1c4c:	85 c0                	test   %eax,%eax
    1c4e:	74 17                	je     1c67 <bigdir+0xd7>
      printf(1, "bigdir link failed\n");
    1c50:	83 ec 08             	sub    $0x8,%esp
    1c53:	68 75 4a 00 00       	push   $0x4a75
    1c58:	6a 01                	push   $0x1
    1c5a:	e8 c5 21 00 00       	call   3e24 <printf>
    1c5f:	83 c4 10             	add    $0x10,%esp
      exit();
    1c62:	e8 41 20 00 00       	call   3ca8 <exit>
  for(i = 0; i < 500; i++){
    1c67:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c6b:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1c72:	7e 94                	jle    1c08 <bigdir+0x78>
    }
  }

  unlink("bd");
    1c74:	83 ec 0c             	sub    $0xc,%esp
    1c77:	68 5c 4a 00 00       	push   $0x4a5c
    1c7c:	e8 77 20 00 00       	call   3cf8 <unlink>
    1c81:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1c84:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c8b:	eb 5e                	jmp    1ceb <bigdir+0x15b>
    name[0] = 'x';
    1c8d:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1c91:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c94:	8d 50 3f             	lea    0x3f(%eax),%edx
    1c97:	85 c0                	test   %eax,%eax
    1c99:	0f 48 c2             	cmovs  %edx,%eax
    1c9c:	c1 f8 06             	sar    $0x6,%eax
    1c9f:	83 c0 30             	add    $0x30,%eax
    1ca2:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ca8:	99                   	cltd   
    1ca9:	c1 ea 1a             	shr    $0x1a,%edx
    1cac:	01 d0                	add    %edx,%eax
    1cae:	83 e0 3f             	and    $0x3f,%eax
    1cb1:	29 d0                	sub    %edx,%eax
    1cb3:	83 c0 30             	add    $0x30,%eax
    1cb6:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1cb9:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    1cbd:	83 ec 0c             	sub    $0xc,%esp
    1cc0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1cc3:	50                   	push   %eax
    1cc4:	e8 2f 20 00 00       	call   3cf8 <unlink>
    1cc9:	83 c4 10             	add    $0x10,%esp
    1ccc:	85 c0                	test   %eax,%eax
    1cce:	74 17                	je     1ce7 <bigdir+0x157>
      printf(1, "bigdir unlink failed");
    1cd0:	83 ec 08             	sub    $0x8,%esp
    1cd3:	68 89 4a 00 00       	push   $0x4a89
    1cd8:	6a 01                	push   $0x1
    1cda:	e8 45 21 00 00       	call   3e24 <printf>
    1cdf:	83 c4 10             	add    $0x10,%esp
      exit();
    1ce2:	e8 c1 1f 00 00       	call   3ca8 <exit>
  for(i = 0; i < 500; i++){
    1ce7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ceb:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1cf2:	7e 99                	jle    1c8d <bigdir+0xfd>
    }
  }

  printf(1, "bigdir ok\n");
    1cf4:	83 ec 08             	sub    $0x8,%esp
    1cf7:	68 9e 4a 00 00       	push   $0x4a9e
    1cfc:	6a 01                	push   $0x1
    1cfe:	e8 21 21 00 00       	call   3e24 <printf>
    1d03:	83 c4 10             	add    $0x10,%esp
}
    1d06:	90                   	nop
    1d07:	c9                   	leave  
    1d08:	c3                   	ret    

00001d09 <subdir>:

void
subdir(void)
{
    1d09:	f3 0f 1e fb          	endbr32 
    1d0d:	55                   	push   %ebp
    1d0e:	89 e5                	mov    %esp,%ebp
    1d10:	83 ec 18             	sub    $0x18,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1d13:	83 ec 08             	sub    $0x8,%esp
    1d16:	68 a9 4a 00 00       	push   $0x4aa9
    1d1b:	6a 01                	push   $0x1
    1d1d:	e8 02 21 00 00       	call   3e24 <printf>
    1d22:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    1d25:	83 ec 0c             	sub    $0xc,%esp
    1d28:	68 b6 4a 00 00       	push   $0x4ab6
    1d2d:	e8 c6 1f 00 00       	call   3cf8 <unlink>
    1d32:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    1d35:	83 ec 0c             	sub    $0xc,%esp
    1d38:	68 b9 4a 00 00       	push   $0x4ab9
    1d3d:	e8 ce 1f 00 00       	call   3d10 <mkdir>
    1d42:	83 c4 10             	add    $0x10,%esp
    1d45:	85 c0                	test   %eax,%eax
    1d47:	74 17                	je     1d60 <subdir+0x57>
    printf(1, "subdir mkdir dd failed\n");
    1d49:	83 ec 08             	sub    $0x8,%esp
    1d4c:	68 bc 4a 00 00       	push   $0x4abc
    1d51:	6a 01                	push   $0x1
    1d53:	e8 cc 20 00 00       	call   3e24 <printf>
    1d58:	83 c4 10             	add    $0x10,%esp
    exit();
    1d5b:	e8 48 1f 00 00       	call   3ca8 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d60:	83 ec 08             	sub    $0x8,%esp
    1d63:	68 02 02 00 00       	push   $0x202
    1d68:	68 d4 4a 00 00       	push   $0x4ad4
    1d6d:	e8 76 1f 00 00       	call   3ce8 <open>
    1d72:	83 c4 10             	add    $0x10,%esp
    1d75:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1d78:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d7c:	79 17                	jns    1d95 <subdir+0x8c>
    printf(1, "create dd/ff failed\n");
    1d7e:	83 ec 08             	sub    $0x8,%esp
    1d81:	68 da 4a 00 00       	push   $0x4ada
    1d86:	6a 01                	push   $0x1
    1d88:	e8 97 20 00 00       	call   3e24 <printf>
    1d8d:	83 c4 10             	add    $0x10,%esp
    exit();
    1d90:	e8 13 1f 00 00       	call   3ca8 <exit>
  }
  write(fd, "ff", 2);
    1d95:	83 ec 04             	sub    $0x4,%esp
    1d98:	6a 02                	push   $0x2
    1d9a:	68 b6 4a 00 00       	push   $0x4ab6
    1d9f:	ff 75 f4             	pushl  -0xc(%ebp)
    1da2:	e8 21 1f 00 00       	call   3cc8 <write>
    1da7:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1daa:	83 ec 0c             	sub    $0xc,%esp
    1dad:	ff 75 f4             	pushl  -0xc(%ebp)
    1db0:	e8 1b 1f 00 00       	call   3cd0 <close>
    1db5:	83 c4 10             	add    $0x10,%esp
  
  if(unlink("dd") >= 0){
    1db8:	83 ec 0c             	sub    $0xc,%esp
    1dbb:	68 b9 4a 00 00       	push   $0x4ab9
    1dc0:	e8 33 1f 00 00       	call   3cf8 <unlink>
    1dc5:	83 c4 10             	add    $0x10,%esp
    1dc8:	85 c0                	test   %eax,%eax
    1dca:	78 17                	js     1de3 <subdir+0xda>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1dcc:	83 ec 08             	sub    $0x8,%esp
    1dcf:	68 f0 4a 00 00       	push   $0x4af0
    1dd4:	6a 01                	push   $0x1
    1dd6:	e8 49 20 00 00       	call   3e24 <printf>
    1ddb:	83 c4 10             	add    $0x10,%esp
    exit();
    1dde:	e8 c5 1e 00 00       	call   3ca8 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    1de3:	83 ec 0c             	sub    $0xc,%esp
    1de6:	68 16 4b 00 00       	push   $0x4b16
    1deb:	e8 20 1f 00 00       	call   3d10 <mkdir>
    1df0:	83 c4 10             	add    $0x10,%esp
    1df3:	85 c0                	test   %eax,%eax
    1df5:	74 17                	je     1e0e <subdir+0x105>
    printf(1, "subdir mkdir dd/dd failed\n");
    1df7:	83 ec 08             	sub    $0x8,%esp
    1dfa:	68 1d 4b 00 00       	push   $0x4b1d
    1dff:	6a 01                	push   $0x1
    1e01:	e8 1e 20 00 00       	call   3e24 <printf>
    1e06:	83 c4 10             	add    $0x10,%esp
    exit();
    1e09:	e8 9a 1e 00 00       	call   3ca8 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1e0e:	83 ec 08             	sub    $0x8,%esp
    1e11:	68 02 02 00 00       	push   $0x202
    1e16:	68 38 4b 00 00       	push   $0x4b38
    1e1b:	e8 c8 1e 00 00       	call   3ce8 <open>
    1e20:	83 c4 10             	add    $0x10,%esp
    1e23:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1e26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e2a:	79 17                	jns    1e43 <subdir+0x13a>
    printf(1, "create dd/dd/ff failed\n");
    1e2c:	83 ec 08             	sub    $0x8,%esp
    1e2f:	68 41 4b 00 00       	push   $0x4b41
    1e34:	6a 01                	push   $0x1
    1e36:	e8 e9 1f 00 00       	call   3e24 <printf>
    1e3b:	83 c4 10             	add    $0x10,%esp
    exit();
    1e3e:	e8 65 1e 00 00       	call   3ca8 <exit>
  }
  write(fd, "FF", 2);
    1e43:	83 ec 04             	sub    $0x4,%esp
    1e46:	6a 02                	push   $0x2
    1e48:	68 59 4b 00 00       	push   $0x4b59
    1e4d:	ff 75 f4             	pushl  -0xc(%ebp)
    1e50:	e8 73 1e 00 00       	call   3cc8 <write>
    1e55:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1e58:	83 ec 0c             	sub    $0xc,%esp
    1e5b:	ff 75 f4             	pushl  -0xc(%ebp)
    1e5e:	e8 6d 1e 00 00       	call   3cd0 <close>
    1e63:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    1e66:	83 ec 08             	sub    $0x8,%esp
    1e69:	6a 00                	push   $0x0
    1e6b:	68 5c 4b 00 00       	push   $0x4b5c
    1e70:	e8 73 1e 00 00       	call   3ce8 <open>
    1e75:	83 c4 10             	add    $0x10,%esp
    1e78:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1e7b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e7f:	79 17                	jns    1e98 <subdir+0x18f>
    printf(1, "open dd/dd/../ff failed\n");
    1e81:	83 ec 08             	sub    $0x8,%esp
    1e84:	68 68 4b 00 00       	push   $0x4b68
    1e89:	6a 01                	push   $0x1
    1e8b:	e8 94 1f 00 00       	call   3e24 <printf>
    1e90:	83 c4 10             	add    $0x10,%esp
    exit();
    1e93:	e8 10 1e 00 00       	call   3ca8 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    1e98:	83 ec 04             	sub    $0x4,%esp
    1e9b:	68 00 20 00 00       	push   $0x2000
    1ea0:	68 20 87 00 00       	push   $0x8720
    1ea5:	ff 75 f4             	pushl  -0xc(%ebp)
    1ea8:	e8 13 1e 00 00       	call   3cc0 <read>
    1ead:	83 c4 10             	add    $0x10,%esp
    1eb0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    1eb3:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1eb7:	75 0b                	jne    1ec4 <subdir+0x1bb>
    1eb9:	0f b6 05 20 87 00 00 	movzbl 0x8720,%eax
    1ec0:	3c 66                	cmp    $0x66,%al
    1ec2:	74 17                	je     1edb <subdir+0x1d2>
    printf(1, "dd/dd/../ff wrong content\n");
    1ec4:	83 ec 08             	sub    $0x8,%esp
    1ec7:	68 81 4b 00 00       	push   $0x4b81
    1ecc:	6a 01                	push   $0x1
    1ece:	e8 51 1f 00 00       	call   3e24 <printf>
    1ed3:	83 c4 10             	add    $0x10,%esp
    exit();
    1ed6:	e8 cd 1d 00 00       	call   3ca8 <exit>
  }
  close(fd);
    1edb:	83 ec 0c             	sub    $0xc,%esp
    1ede:	ff 75 f4             	pushl  -0xc(%ebp)
    1ee1:	e8 ea 1d 00 00       	call   3cd0 <close>
    1ee6:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1ee9:	83 ec 08             	sub    $0x8,%esp
    1eec:	68 9c 4b 00 00       	push   $0x4b9c
    1ef1:	68 38 4b 00 00       	push   $0x4b38
    1ef6:	e8 0d 1e 00 00       	call   3d08 <link>
    1efb:	83 c4 10             	add    $0x10,%esp
    1efe:	85 c0                	test   %eax,%eax
    1f00:	74 17                	je     1f19 <subdir+0x210>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1f02:	83 ec 08             	sub    $0x8,%esp
    1f05:	68 a8 4b 00 00       	push   $0x4ba8
    1f0a:	6a 01                	push   $0x1
    1f0c:	e8 13 1f 00 00       	call   3e24 <printf>
    1f11:	83 c4 10             	add    $0x10,%esp
    exit();
    1f14:	e8 8f 1d 00 00       	call   3ca8 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    1f19:	83 ec 0c             	sub    $0xc,%esp
    1f1c:	68 38 4b 00 00       	push   $0x4b38
    1f21:	e8 d2 1d 00 00       	call   3cf8 <unlink>
    1f26:	83 c4 10             	add    $0x10,%esp
    1f29:	85 c0                	test   %eax,%eax
    1f2b:	74 17                	je     1f44 <subdir+0x23b>
    printf(1, "unlink dd/dd/ff failed\n");
    1f2d:	83 ec 08             	sub    $0x8,%esp
    1f30:	68 c9 4b 00 00       	push   $0x4bc9
    1f35:	6a 01                	push   $0x1
    1f37:	e8 e8 1e 00 00       	call   3e24 <printf>
    1f3c:	83 c4 10             	add    $0x10,%esp
    exit();
    1f3f:	e8 64 1d 00 00       	call   3ca8 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f44:	83 ec 08             	sub    $0x8,%esp
    1f47:	6a 00                	push   $0x0
    1f49:	68 38 4b 00 00       	push   $0x4b38
    1f4e:	e8 95 1d 00 00       	call   3ce8 <open>
    1f53:	83 c4 10             	add    $0x10,%esp
    1f56:	85 c0                	test   %eax,%eax
    1f58:	78 17                	js     1f71 <subdir+0x268>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    1f5a:	83 ec 08             	sub    $0x8,%esp
    1f5d:	68 e4 4b 00 00       	push   $0x4be4
    1f62:	6a 01                	push   $0x1
    1f64:	e8 bb 1e 00 00       	call   3e24 <printf>
    1f69:	83 c4 10             	add    $0x10,%esp
    exit();
    1f6c:	e8 37 1d 00 00       	call   3ca8 <exit>
  }

  if(chdir("dd") != 0){
    1f71:	83 ec 0c             	sub    $0xc,%esp
    1f74:	68 b9 4a 00 00       	push   $0x4ab9
    1f79:	e8 9a 1d 00 00       	call   3d18 <chdir>
    1f7e:	83 c4 10             	add    $0x10,%esp
    1f81:	85 c0                	test   %eax,%eax
    1f83:	74 17                	je     1f9c <subdir+0x293>
    printf(1, "chdir dd failed\n");
    1f85:	83 ec 08             	sub    $0x8,%esp
    1f88:	68 08 4c 00 00       	push   $0x4c08
    1f8d:	6a 01                	push   $0x1
    1f8f:	e8 90 1e 00 00       	call   3e24 <printf>
    1f94:	83 c4 10             	add    $0x10,%esp
    exit();
    1f97:	e8 0c 1d 00 00       	call   3ca8 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    1f9c:	83 ec 0c             	sub    $0xc,%esp
    1f9f:	68 19 4c 00 00       	push   $0x4c19
    1fa4:	e8 6f 1d 00 00       	call   3d18 <chdir>
    1fa9:	83 c4 10             	add    $0x10,%esp
    1fac:	85 c0                	test   %eax,%eax
    1fae:	74 17                	je     1fc7 <subdir+0x2be>
    printf(1, "chdir dd/../../dd failed\n");
    1fb0:	83 ec 08             	sub    $0x8,%esp
    1fb3:	68 25 4c 00 00       	push   $0x4c25
    1fb8:	6a 01                	push   $0x1
    1fba:	e8 65 1e 00 00       	call   3e24 <printf>
    1fbf:	83 c4 10             	add    $0x10,%esp
    exit();
    1fc2:	e8 e1 1c 00 00       	call   3ca8 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    1fc7:	83 ec 0c             	sub    $0xc,%esp
    1fca:	68 3f 4c 00 00       	push   $0x4c3f
    1fcf:	e8 44 1d 00 00       	call   3d18 <chdir>
    1fd4:	83 c4 10             	add    $0x10,%esp
    1fd7:	85 c0                	test   %eax,%eax
    1fd9:	74 17                	je     1ff2 <subdir+0x2e9>
    printf(1, "chdir dd/../../dd failed\n");
    1fdb:	83 ec 08             	sub    $0x8,%esp
    1fde:	68 25 4c 00 00       	push   $0x4c25
    1fe3:	6a 01                	push   $0x1
    1fe5:	e8 3a 1e 00 00       	call   3e24 <printf>
    1fea:	83 c4 10             	add    $0x10,%esp
    exit();
    1fed:	e8 b6 1c 00 00       	call   3ca8 <exit>
  }
  if(chdir("./..") != 0){
    1ff2:	83 ec 0c             	sub    $0xc,%esp
    1ff5:	68 4e 4c 00 00       	push   $0x4c4e
    1ffa:	e8 19 1d 00 00       	call   3d18 <chdir>
    1fff:	83 c4 10             	add    $0x10,%esp
    2002:	85 c0                	test   %eax,%eax
    2004:	74 17                	je     201d <subdir+0x314>
    printf(1, "chdir ./.. failed\n");
    2006:	83 ec 08             	sub    $0x8,%esp
    2009:	68 53 4c 00 00       	push   $0x4c53
    200e:	6a 01                	push   $0x1
    2010:	e8 0f 1e 00 00       	call   3e24 <printf>
    2015:	83 c4 10             	add    $0x10,%esp
    exit();
    2018:	e8 8b 1c 00 00       	call   3ca8 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    201d:	83 ec 08             	sub    $0x8,%esp
    2020:	6a 00                	push   $0x0
    2022:	68 9c 4b 00 00       	push   $0x4b9c
    2027:	e8 bc 1c 00 00       	call   3ce8 <open>
    202c:	83 c4 10             	add    $0x10,%esp
    202f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2032:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2036:	79 17                	jns    204f <subdir+0x346>
    printf(1, "open dd/dd/ffff failed\n");
    2038:	83 ec 08             	sub    $0x8,%esp
    203b:	68 66 4c 00 00       	push   $0x4c66
    2040:	6a 01                	push   $0x1
    2042:	e8 dd 1d 00 00       	call   3e24 <printf>
    2047:	83 c4 10             	add    $0x10,%esp
    exit();
    204a:	e8 59 1c 00 00       	call   3ca8 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    204f:	83 ec 04             	sub    $0x4,%esp
    2052:	68 00 20 00 00       	push   $0x2000
    2057:	68 20 87 00 00       	push   $0x8720
    205c:	ff 75 f4             	pushl  -0xc(%ebp)
    205f:	e8 5c 1c 00 00       	call   3cc0 <read>
    2064:	83 c4 10             	add    $0x10,%esp
    2067:	83 f8 02             	cmp    $0x2,%eax
    206a:	74 17                	je     2083 <subdir+0x37a>
    printf(1, "read dd/dd/ffff wrong len\n");
    206c:	83 ec 08             	sub    $0x8,%esp
    206f:	68 7e 4c 00 00       	push   $0x4c7e
    2074:	6a 01                	push   $0x1
    2076:	e8 a9 1d 00 00       	call   3e24 <printf>
    207b:	83 c4 10             	add    $0x10,%esp
    exit();
    207e:	e8 25 1c 00 00       	call   3ca8 <exit>
  }
  close(fd);
    2083:	83 ec 0c             	sub    $0xc,%esp
    2086:	ff 75 f4             	pushl  -0xc(%ebp)
    2089:	e8 42 1c 00 00       	call   3cd0 <close>
    208e:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2091:	83 ec 08             	sub    $0x8,%esp
    2094:	6a 00                	push   $0x0
    2096:	68 38 4b 00 00       	push   $0x4b38
    209b:	e8 48 1c 00 00       	call   3ce8 <open>
    20a0:	83 c4 10             	add    $0x10,%esp
    20a3:	85 c0                	test   %eax,%eax
    20a5:	78 17                	js     20be <subdir+0x3b5>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    20a7:	83 ec 08             	sub    $0x8,%esp
    20aa:	68 9c 4c 00 00       	push   $0x4c9c
    20af:	6a 01                	push   $0x1
    20b1:	e8 6e 1d 00 00       	call   3e24 <printf>
    20b6:	83 c4 10             	add    $0x10,%esp
    exit();
    20b9:	e8 ea 1b 00 00       	call   3ca8 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    20be:	83 ec 08             	sub    $0x8,%esp
    20c1:	68 02 02 00 00       	push   $0x202
    20c6:	68 c1 4c 00 00       	push   $0x4cc1
    20cb:	e8 18 1c 00 00       	call   3ce8 <open>
    20d0:	83 c4 10             	add    $0x10,%esp
    20d3:	85 c0                	test   %eax,%eax
    20d5:	78 17                	js     20ee <subdir+0x3e5>
    printf(1, "create dd/ff/ff succeeded!\n");
    20d7:	83 ec 08             	sub    $0x8,%esp
    20da:	68 ca 4c 00 00       	push   $0x4cca
    20df:	6a 01                	push   $0x1
    20e1:	e8 3e 1d 00 00       	call   3e24 <printf>
    20e6:	83 c4 10             	add    $0x10,%esp
    exit();
    20e9:	e8 ba 1b 00 00       	call   3ca8 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    20ee:	83 ec 08             	sub    $0x8,%esp
    20f1:	68 02 02 00 00       	push   $0x202
    20f6:	68 e6 4c 00 00       	push   $0x4ce6
    20fb:	e8 e8 1b 00 00       	call   3ce8 <open>
    2100:	83 c4 10             	add    $0x10,%esp
    2103:	85 c0                	test   %eax,%eax
    2105:	78 17                	js     211e <subdir+0x415>
    printf(1, "create dd/xx/ff succeeded!\n");
    2107:	83 ec 08             	sub    $0x8,%esp
    210a:	68 ef 4c 00 00       	push   $0x4cef
    210f:	6a 01                	push   $0x1
    2111:	e8 0e 1d 00 00       	call   3e24 <printf>
    2116:	83 c4 10             	add    $0x10,%esp
    exit();
    2119:	e8 8a 1b 00 00       	call   3ca8 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    211e:	83 ec 08             	sub    $0x8,%esp
    2121:	68 00 02 00 00       	push   $0x200
    2126:	68 b9 4a 00 00       	push   $0x4ab9
    212b:	e8 b8 1b 00 00       	call   3ce8 <open>
    2130:	83 c4 10             	add    $0x10,%esp
    2133:	85 c0                	test   %eax,%eax
    2135:	78 17                	js     214e <subdir+0x445>
    printf(1, "create dd succeeded!\n");
    2137:	83 ec 08             	sub    $0x8,%esp
    213a:	68 0b 4d 00 00       	push   $0x4d0b
    213f:	6a 01                	push   $0x1
    2141:	e8 de 1c 00 00       	call   3e24 <printf>
    2146:	83 c4 10             	add    $0x10,%esp
    exit();
    2149:	e8 5a 1b 00 00       	call   3ca8 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    214e:	83 ec 08             	sub    $0x8,%esp
    2151:	6a 02                	push   $0x2
    2153:	68 b9 4a 00 00       	push   $0x4ab9
    2158:	e8 8b 1b 00 00       	call   3ce8 <open>
    215d:	83 c4 10             	add    $0x10,%esp
    2160:	85 c0                	test   %eax,%eax
    2162:	78 17                	js     217b <subdir+0x472>
    printf(1, "open dd rdwr succeeded!\n");
    2164:	83 ec 08             	sub    $0x8,%esp
    2167:	68 21 4d 00 00       	push   $0x4d21
    216c:	6a 01                	push   $0x1
    216e:	e8 b1 1c 00 00       	call   3e24 <printf>
    2173:	83 c4 10             	add    $0x10,%esp
    exit();
    2176:	e8 2d 1b 00 00       	call   3ca8 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    217b:	83 ec 08             	sub    $0x8,%esp
    217e:	6a 01                	push   $0x1
    2180:	68 b9 4a 00 00       	push   $0x4ab9
    2185:	e8 5e 1b 00 00       	call   3ce8 <open>
    218a:	83 c4 10             	add    $0x10,%esp
    218d:	85 c0                	test   %eax,%eax
    218f:	78 17                	js     21a8 <subdir+0x49f>
    printf(1, "open dd wronly succeeded!\n");
    2191:	83 ec 08             	sub    $0x8,%esp
    2194:	68 3a 4d 00 00       	push   $0x4d3a
    2199:	6a 01                	push   $0x1
    219b:	e8 84 1c 00 00       	call   3e24 <printf>
    21a0:	83 c4 10             	add    $0x10,%esp
    exit();
    21a3:	e8 00 1b 00 00       	call   3ca8 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    21a8:	83 ec 08             	sub    $0x8,%esp
    21ab:	68 55 4d 00 00       	push   $0x4d55
    21b0:	68 c1 4c 00 00       	push   $0x4cc1
    21b5:	e8 4e 1b 00 00       	call   3d08 <link>
    21ba:	83 c4 10             	add    $0x10,%esp
    21bd:	85 c0                	test   %eax,%eax
    21bf:	75 17                	jne    21d8 <subdir+0x4cf>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    21c1:	83 ec 08             	sub    $0x8,%esp
    21c4:	68 60 4d 00 00       	push   $0x4d60
    21c9:	6a 01                	push   $0x1
    21cb:	e8 54 1c 00 00       	call   3e24 <printf>
    21d0:	83 c4 10             	add    $0x10,%esp
    exit();
    21d3:	e8 d0 1a 00 00       	call   3ca8 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    21d8:	83 ec 08             	sub    $0x8,%esp
    21db:	68 55 4d 00 00       	push   $0x4d55
    21e0:	68 e6 4c 00 00       	push   $0x4ce6
    21e5:	e8 1e 1b 00 00       	call   3d08 <link>
    21ea:	83 c4 10             	add    $0x10,%esp
    21ed:	85 c0                	test   %eax,%eax
    21ef:	75 17                	jne    2208 <subdir+0x4ff>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    21f1:	83 ec 08             	sub    $0x8,%esp
    21f4:	68 84 4d 00 00       	push   $0x4d84
    21f9:	6a 01                	push   $0x1
    21fb:	e8 24 1c 00 00       	call   3e24 <printf>
    2200:	83 c4 10             	add    $0x10,%esp
    exit();
    2203:	e8 a0 1a 00 00       	call   3ca8 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2208:	83 ec 08             	sub    $0x8,%esp
    220b:	68 9c 4b 00 00       	push   $0x4b9c
    2210:	68 d4 4a 00 00       	push   $0x4ad4
    2215:	e8 ee 1a 00 00       	call   3d08 <link>
    221a:	83 c4 10             	add    $0x10,%esp
    221d:	85 c0                	test   %eax,%eax
    221f:	75 17                	jne    2238 <subdir+0x52f>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2221:	83 ec 08             	sub    $0x8,%esp
    2224:	68 a8 4d 00 00       	push   $0x4da8
    2229:	6a 01                	push   $0x1
    222b:	e8 f4 1b 00 00       	call   3e24 <printf>
    2230:	83 c4 10             	add    $0x10,%esp
    exit();
    2233:	e8 70 1a 00 00       	call   3ca8 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    2238:	83 ec 0c             	sub    $0xc,%esp
    223b:	68 c1 4c 00 00       	push   $0x4cc1
    2240:	e8 cb 1a 00 00       	call   3d10 <mkdir>
    2245:	83 c4 10             	add    $0x10,%esp
    2248:	85 c0                	test   %eax,%eax
    224a:	75 17                	jne    2263 <subdir+0x55a>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    224c:	83 ec 08             	sub    $0x8,%esp
    224f:	68 ca 4d 00 00       	push   $0x4dca
    2254:	6a 01                	push   $0x1
    2256:	e8 c9 1b 00 00       	call   3e24 <printf>
    225b:	83 c4 10             	add    $0x10,%esp
    exit();
    225e:	e8 45 1a 00 00       	call   3ca8 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    2263:	83 ec 0c             	sub    $0xc,%esp
    2266:	68 e6 4c 00 00       	push   $0x4ce6
    226b:	e8 a0 1a 00 00       	call   3d10 <mkdir>
    2270:	83 c4 10             	add    $0x10,%esp
    2273:	85 c0                	test   %eax,%eax
    2275:	75 17                	jne    228e <subdir+0x585>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2277:	83 ec 08             	sub    $0x8,%esp
    227a:	68 e5 4d 00 00       	push   $0x4de5
    227f:	6a 01                	push   $0x1
    2281:	e8 9e 1b 00 00       	call   3e24 <printf>
    2286:	83 c4 10             	add    $0x10,%esp
    exit();
    2289:	e8 1a 1a 00 00       	call   3ca8 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    228e:	83 ec 0c             	sub    $0xc,%esp
    2291:	68 9c 4b 00 00       	push   $0x4b9c
    2296:	e8 75 1a 00 00       	call   3d10 <mkdir>
    229b:	83 c4 10             	add    $0x10,%esp
    229e:	85 c0                	test   %eax,%eax
    22a0:	75 17                	jne    22b9 <subdir+0x5b0>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    22a2:	83 ec 08             	sub    $0x8,%esp
    22a5:	68 00 4e 00 00       	push   $0x4e00
    22aa:	6a 01                	push   $0x1
    22ac:	e8 73 1b 00 00       	call   3e24 <printf>
    22b1:	83 c4 10             	add    $0x10,%esp
    exit();
    22b4:	e8 ef 19 00 00       	call   3ca8 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    22b9:	83 ec 0c             	sub    $0xc,%esp
    22bc:	68 e6 4c 00 00       	push   $0x4ce6
    22c1:	e8 32 1a 00 00       	call   3cf8 <unlink>
    22c6:	83 c4 10             	add    $0x10,%esp
    22c9:	85 c0                	test   %eax,%eax
    22cb:	75 17                	jne    22e4 <subdir+0x5db>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    22cd:	83 ec 08             	sub    $0x8,%esp
    22d0:	68 1d 4e 00 00       	push   $0x4e1d
    22d5:	6a 01                	push   $0x1
    22d7:	e8 48 1b 00 00       	call   3e24 <printf>
    22dc:	83 c4 10             	add    $0x10,%esp
    exit();
    22df:	e8 c4 19 00 00       	call   3ca8 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    22e4:	83 ec 0c             	sub    $0xc,%esp
    22e7:	68 c1 4c 00 00       	push   $0x4cc1
    22ec:	e8 07 1a 00 00       	call   3cf8 <unlink>
    22f1:	83 c4 10             	add    $0x10,%esp
    22f4:	85 c0                	test   %eax,%eax
    22f6:	75 17                	jne    230f <subdir+0x606>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    22f8:	83 ec 08             	sub    $0x8,%esp
    22fb:	68 39 4e 00 00       	push   $0x4e39
    2300:	6a 01                	push   $0x1
    2302:	e8 1d 1b 00 00       	call   3e24 <printf>
    2307:	83 c4 10             	add    $0x10,%esp
    exit();
    230a:	e8 99 19 00 00       	call   3ca8 <exit>
  }
  if(chdir("dd/ff") == 0){
    230f:	83 ec 0c             	sub    $0xc,%esp
    2312:	68 d4 4a 00 00       	push   $0x4ad4
    2317:	e8 fc 19 00 00       	call   3d18 <chdir>
    231c:	83 c4 10             	add    $0x10,%esp
    231f:	85 c0                	test   %eax,%eax
    2321:	75 17                	jne    233a <subdir+0x631>
    printf(1, "chdir dd/ff succeeded!\n");
    2323:	83 ec 08             	sub    $0x8,%esp
    2326:	68 55 4e 00 00       	push   $0x4e55
    232b:	6a 01                	push   $0x1
    232d:	e8 f2 1a 00 00       	call   3e24 <printf>
    2332:	83 c4 10             	add    $0x10,%esp
    exit();
    2335:	e8 6e 19 00 00       	call   3ca8 <exit>
  }
  if(chdir("dd/xx") == 0){
    233a:	83 ec 0c             	sub    $0xc,%esp
    233d:	68 6d 4e 00 00       	push   $0x4e6d
    2342:	e8 d1 19 00 00       	call   3d18 <chdir>
    2347:	83 c4 10             	add    $0x10,%esp
    234a:	85 c0                	test   %eax,%eax
    234c:	75 17                	jne    2365 <subdir+0x65c>
    printf(1, "chdir dd/xx succeeded!\n");
    234e:	83 ec 08             	sub    $0x8,%esp
    2351:	68 73 4e 00 00       	push   $0x4e73
    2356:	6a 01                	push   $0x1
    2358:	e8 c7 1a 00 00       	call   3e24 <printf>
    235d:	83 c4 10             	add    $0x10,%esp
    exit();
    2360:	e8 43 19 00 00       	call   3ca8 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    2365:	83 ec 0c             	sub    $0xc,%esp
    2368:	68 9c 4b 00 00       	push   $0x4b9c
    236d:	e8 86 19 00 00       	call   3cf8 <unlink>
    2372:	83 c4 10             	add    $0x10,%esp
    2375:	85 c0                	test   %eax,%eax
    2377:	74 17                	je     2390 <subdir+0x687>
    printf(1, "unlink dd/dd/ff failed\n");
    2379:	83 ec 08             	sub    $0x8,%esp
    237c:	68 c9 4b 00 00       	push   $0x4bc9
    2381:	6a 01                	push   $0x1
    2383:	e8 9c 1a 00 00       	call   3e24 <printf>
    2388:	83 c4 10             	add    $0x10,%esp
    exit();
    238b:	e8 18 19 00 00       	call   3ca8 <exit>
  }
  if(unlink("dd/ff") != 0){
    2390:	83 ec 0c             	sub    $0xc,%esp
    2393:	68 d4 4a 00 00       	push   $0x4ad4
    2398:	e8 5b 19 00 00       	call   3cf8 <unlink>
    239d:	83 c4 10             	add    $0x10,%esp
    23a0:	85 c0                	test   %eax,%eax
    23a2:	74 17                	je     23bb <subdir+0x6b2>
    printf(1, "unlink dd/ff failed\n");
    23a4:	83 ec 08             	sub    $0x8,%esp
    23a7:	68 8b 4e 00 00       	push   $0x4e8b
    23ac:	6a 01                	push   $0x1
    23ae:	e8 71 1a 00 00       	call   3e24 <printf>
    23b3:	83 c4 10             	add    $0x10,%esp
    exit();
    23b6:	e8 ed 18 00 00       	call   3ca8 <exit>
  }
  if(unlink("dd") == 0){
    23bb:	83 ec 0c             	sub    $0xc,%esp
    23be:	68 b9 4a 00 00       	push   $0x4ab9
    23c3:	e8 30 19 00 00       	call   3cf8 <unlink>
    23c8:	83 c4 10             	add    $0x10,%esp
    23cb:	85 c0                	test   %eax,%eax
    23cd:	75 17                	jne    23e6 <subdir+0x6dd>
    printf(1, "unlink non-empty dd succeeded!\n");
    23cf:	83 ec 08             	sub    $0x8,%esp
    23d2:	68 a0 4e 00 00       	push   $0x4ea0
    23d7:	6a 01                	push   $0x1
    23d9:	e8 46 1a 00 00       	call   3e24 <printf>
    23de:	83 c4 10             	add    $0x10,%esp
    exit();
    23e1:	e8 c2 18 00 00       	call   3ca8 <exit>
  }
  if(unlink("dd/dd") < 0){
    23e6:	83 ec 0c             	sub    $0xc,%esp
    23e9:	68 c0 4e 00 00       	push   $0x4ec0
    23ee:	e8 05 19 00 00       	call   3cf8 <unlink>
    23f3:	83 c4 10             	add    $0x10,%esp
    23f6:	85 c0                	test   %eax,%eax
    23f8:	79 17                	jns    2411 <subdir+0x708>
    printf(1, "unlink dd/dd failed\n");
    23fa:	83 ec 08             	sub    $0x8,%esp
    23fd:	68 c6 4e 00 00       	push   $0x4ec6
    2402:	6a 01                	push   $0x1
    2404:	e8 1b 1a 00 00       	call   3e24 <printf>
    2409:	83 c4 10             	add    $0x10,%esp
    exit();
    240c:	e8 97 18 00 00       	call   3ca8 <exit>
  }
  if(unlink("dd") < 0){
    2411:	83 ec 0c             	sub    $0xc,%esp
    2414:	68 b9 4a 00 00       	push   $0x4ab9
    2419:	e8 da 18 00 00       	call   3cf8 <unlink>
    241e:	83 c4 10             	add    $0x10,%esp
    2421:	85 c0                	test   %eax,%eax
    2423:	79 17                	jns    243c <subdir+0x733>
    printf(1, "unlink dd failed\n");
    2425:	83 ec 08             	sub    $0x8,%esp
    2428:	68 db 4e 00 00       	push   $0x4edb
    242d:	6a 01                	push   $0x1
    242f:	e8 f0 19 00 00       	call   3e24 <printf>
    2434:	83 c4 10             	add    $0x10,%esp
    exit();
    2437:	e8 6c 18 00 00       	call   3ca8 <exit>
  }

  printf(1, "subdir ok\n");
    243c:	83 ec 08             	sub    $0x8,%esp
    243f:	68 ed 4e 00 00       	push   $0x4eed
    2444:	6a 01                	push   $0x1
    2446:	e8 d9 19 00 00       	call   3e24 <printf>
    244b:	83 c4 10             	add    $0x10,%esp
}
    244e:	90                   	nop
    244f:	c9                   	leave  
    2450:	c3                   	ret    

00002451 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    2451:	f3 0f 1e fb          	endbr32 
    2455:	55                   	push   %ebp
    2456:	89 e5                	mov    %esp,%ebp
    2458:	83 ec 18             	sub    $0x18,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    245b:	83 ec 08             	sub    $0x8,%esp
    245e:	68 f8 4e 00 00       	push   $0x4ef8
    2463:	6a 01                	push   $0x1
    2465:	e8 ba 19 00 00       	call   3e24 <printf>
    246a:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    246d:	83 ec 0c             	sub    $0xc,%esp
    2470:	68 07 4f 00 00       	push   $0x4f07
    2475:	e8 7e 18 00 00       	call   3cf8 <unlink>
    247a:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    247d:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    2484:	e9 a8 00 00 00       	jmp    2531 <bigwrite+0xe0>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2489:	83 ec 08             	sub    $0x8,%esp
    248c:	68 02 02 00 00       	push   $0x202
    2491:	68 07 4f 00 00       	push   $0x4f07
    2496:	e8 4d 18 00 00       	call   3ce8 <open>
    249b:	83 c4 10             	add    $0x10,%esp
    249e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    24a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    24a5:	79 17                	jns    24be <bigwrite+0x6d>
      printf(1, "cannot create bigwrite\n");
    24a7:	83 ec 08             	sub    $0x8,%esp
    24aa:	68 10 4f 00 00       	push   $0x4f10
    24af:	6a 01                	push   $0x1
    24b1:	e8 6e 19 00 00       	call   3e24 <printf>
    24b6:	83 c4 10             	add    $0x10,%esp
      exit();
    24b9:	e8 ea 17 00 00       	call   3ca8 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    24be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    24c5:	eb 3f                	jmp    2506 <bigwrite+0xb5>
      int cc = write(fd, buf, sz);
    24c7:	83 ec 04             	sub    $0x4,%esp
    24ca:	ff 75 f4             	pushl  -0xc(%ebp)
    24cd:	68 20 87 00 00       	push   $0x8720
    24d2:	ff 75 ec             	pushl  -0x14(%ebp)
    24d5:	e8 ee 17 00 00       	call   3cc8 <write>
    24da:	83 c4 10             	add    $0x10,%esp
    24dd:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    24e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    24e3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    24e6:	74 1a                	je     2502 <bigwrite+0xb1>
        printf(1, "write(%d) ret %d\n", sz, cc);
    24e8:	ff 75 e8             	pushl  -0x18(%ebp)
    24eb:	ff 75 f4             	pushl  -0xc(%ebp)
    24ee:	68 28 4f 00 00       	push   $0x4f28
    24f3:	6a 01                	push   $0x1
    24f5:	e8 2a 19 00 00       	call   3e24 <printf>
    24fa:	83 c4 10             	add    $0x10,%esp
        exit();
    24fd:	e8 a6 17 00 00       	call   3ca8 <exit>
    for(i = 0; i < 2; i++){
    2502:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2506:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    250a:	7e bb                	jle    24c7 <bigwrite+0x76>
      }
    }
    close(fd);
    250c:	83 ec 0c             	sub    $0xc,%esp
    250f:	ff 75 ec             	pushl  -0x14(%ebp)
    2512:	e8 b9 17 00 00       	call   3cd0 <close>
    2517:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    251a:	83 ec 0c             	sub    $0xc,%esp
    251d:	68 07 4f 00 00       	push   $0x4f07
    2522:	e8 d1 17 00 00       	call   3cf8 <unlink>
    2527:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    252a:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    2531:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    2538:	0f 8e 4b ff ff ff    	jle    2489 <bigwrite+0x38>
  }

  printf(1, "bigwrite ok\n");
    253e:	83 ec 08             	sub    $0x8,%esp
    2541:	68 3a 4f 00 00       	push   $0x4f3a
    2546:	6a 01                	push   $0x1
    2548:	e8 d7 18 00 00       	call   3e24 <printf>
    254d:	83 c4 10             	add    $0x10,%esp
}
    2550:	90                   	nop
    2551:	c9                   	leave  
    2552:	c3                   	ret    

00002553 <bigfile>:

void
bigfile(void)
{
    2553:	f3 0f 1e fb          	endbr32 
    2557:	55                   	push   %ebp
    2558:	89 e5                	mov    %esp,%ebp
    255a:	83 ec 18             	sub    $0x18,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    255d:	83 ec 08             	sub    $0x8,%esp
    2560:	68 47 4f 00 00       	push   $0x4f47
    2565:	6a 01                	push   $0x1
    2567:	e8 b8 18 00 00       	call   3e24 <printf>
    256c:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    256f:	83 ec 0c             	sub    $0xc,%esp
    2572:	68 55 4f 00 00       	push   $0x4f55
    2577:	e8 7c 17 00 00       	call   3cf8 <unlink>
    257c:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    257f:	83 ec 08             	sub    $0x8,%esp
    2582:	68 02 02 00 00       	push   $0x202
    2587:	68 55 4f 00 00       	push   $0x4f55
    258c:	e8 57 17 00 00       	call   3ce8 <open>
    2591:	83 c4 10             	add    $0x10,%esp
    2594:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2597:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    259b:	79 17                	jns    25b4 <bigfile+0x61>
    printf(1, "cannot create bigfile");
    259d:	83 ec 08             	sub    $0x8,%esp
    25a0:	68 5d 4f 00 00       	push   $0x4f5d
    25a5:	6a 01                	push   $0x1
    25a7:	e8 78 18 00 00       	call   3e24 <printf>
    25ac:	83 c4 10             	add    $0x10,%esp
    exit();
    25af:	e8 f4 16 00 00       	call   3ca8 <exit>
  }
  for(i = 0; i < 20; i++){
    25b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    25bb:	eb 52                	jmp    260f <bigfile+0xbc>
    memset(buf, i, 600);
    25bd:	83 ec 04             	sub    $0x4,%esp
    25c0:	68 58 02 00 00       	push   $0x258
    25c5:	ff 75 f4             	pushl  -0xc(%ebp)
    25c8:	68 20 87 00 00       	push   $0x8720
    25cd:	e8 23 15 00 00       	call   3af5 <memset>
    25d2:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    25d5:	83 ec 04             	sub    $0x4,%esp
    25d8:	68 58 02 00 00       	push   $0x258
    25dd:	68 20 87 00 00       	push   $0x8720
    25e2:	ff 75 ec             	pushl  -0x14(%ebp)
    25e5:	e8 de 16 00 00       	call   3cc8 <write>
    25ea:	83 c4 10             	add    $0x10,%esp
    25ed:	3d 58 02 00 00       	cmp    $0x258,%eax
    25f2:	74 17                	je     260b <bigfile+0xb8>
      printf(1, "write bigfile failed\n");
    25f4:	83 ec 08             	sub    $0x8,%esp
    25f7:	68 73 4f 00 00       	push   $0x4f73
    25fc:	6a 01                	push   $0x1
    25fe:	e8 21 18 00 00       	call   3e24 <printf>
    2603:	83 c4 10             	add    $0x10,%esp
      exit();
    2606:	e8 9d 16 00 00       	call   3ca8 <exit>
  for(i = 0; i < 20; i++){
    260b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    260f:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    2613:	7e a8                	jle    25bd <bigfile+0x6a>
    }
  }
  close(fd);
    2615:	83 ec 0c             	sub    $0xc,%esp
    2618:	ff 75 ec             	pushl  -0x14(%ebp)
    261b:	e8 b0 16 00 00       	call   3cd0 <close>
    2620:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    2623:	83 ec 08             	sub    $0x8,%esp
    2626:	6a 00                	push   $0x0
    2628:	68 55 4f 00 00       	push   $0x4f55
    262d:	e8 b6 16 00 00       	call   3ce8 <open>
    2632:	83 c4 10             	add    $0x10,%esp
    2635:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2638:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    263c:	79 17                	jns    2655 <bigfile+0x102>
    printf(1, "cannot open bigfile\n");
    263e:	83 ec 08             	sub    $0x8,%esp
    2641:	68 89 4f 00 00       	push   $0x4f89
    2646:	6a 01                	push   $0x1
    2648:	e8 d7 17 00 00       	call   3e24 <printf>
    264d:	83 c4 10             	add    $0x10,%esp
    exit();
    2650:	e8 53 16 00 00       	call   3ca8 <exit>
  }
  total = 0;
    2655:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    265c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    2663:	83 ec 04             	sub    $0x4,%esp
    2666:	68 2c 01 00 00       	push   $0x12c
    266b:	68 20 87 00 00       	push   $0x8720
    2670:	ff 75 ec             	pushl  -0x14(%ebp)
    2673:	e8 48 16 00 00       	call   3cc0 <read>
    2678:	83 c4 10             	add    $0x10,%esp
    267b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    267e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2682:	79 17                	jns    269b <bigfile+0x148>
      printf(1, "read bigfile failed\n");
    2684:	83 ec 08             	sub    $0x8,%esp
    2687:	68 9e 4f 00 00       	push   $0x4f9e
    268c:	6a 01                	push   $0x1
    268e:	e8 91 17 00 00       	call   3e24 <printf>
    2693:	83 c4 10             	add    $0x10,%esp
      exit();
    2696:	e8 0d 16 00 00       	call   3ca8 <exit>
    }
    if(cc == 0)
    269b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    269f:	74 7a                	je     271b <bigfile+0x1c8>
      break;
    if(cc != 300){
    26a1:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    26a8:	74 17                	je     26c1 <bigfile+0x16e>
      printf(1, "short read bigfile\n");
    26aa:	83 ec 08             	sub    $0x8,%esp
    26ad:	68 b3 4f 00 00       	push   $0x4fb3
    26b2:	6a 01                	push   $0x1
    26b4:	e8 6b 17 00 00       	call   3e24 <printf>
    26b9:	83 c4 10             	add    $0x10,%esp
      exit();
    26bc:	e8 e7 15 00 00       	call   3ca8 <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    26c1:	0f b6 05 20 87 00 00 	movzbl 0x8720,%eax
    26c8:	0f be d0             	movsbl %al,%edx
    26cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26ce:	89 c1                	mov    %eax,%ecx
    26d0:	c1 e9 1f             	shr    $0x1f,%ecx
    26d3:	01 c8                	add    %ecx,%eax
    26d5:	d1 f8                	sar    %eax
    26d7:	39 c2                	cmp    %eax,%edx
    26d9:	75 1a                	jne    26f5 <bigfile+0x1a2>
    26db:	0f b6 05 4b 88 00 00 	movzbl 0x884b,%eax
    26e2:	0f be d0             	movsbl %al,%edx
    26e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26e8:	89 c1                	mov    %eax,%ecx
    26ea:	c1 e9 1f             	shr    $0x1f,%ecx
    26ed:	01 c8                	add    %ecx,%eax
    26ef:	d1 f8                	sar    %eax
    26f1:	39 c2                	cmp    %eax,%edx
    26f3:	74 17                	je     270c <bigfile+0x1b9>
      printf(1, "read bigfile wrong data\n");
    26f5:	83 ec 08             	sub    $0x8,%esp
    26f8:	68 c7 4f 00 00       	push   $0x4fc7
    26fd:	6a 01                	push   $0x1
    26ff:	e8 20 17 00 00       	call   3e24 <printf>
    2704:	83 c4 10             	add    $0x10,%esp
      exit();
    2707:	e8 9c 15 00 00       	call   3ca8 <exit>
    }
    total += cc;
    270c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    270f:	01 45 f0             	add    %eax,-0x10(%ebp)
  for(i = 0; ; i++){
    2712:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    cc = read(fd, buf, 300);
    2716:	e9 48 ff ff ff       	jmp    2663 <bigfile+0x110>
      break;
    271b:	90                   	nop
  }
  close(fd);
    271c:	83 ec 0c             	sub    $0xc,%esp
    271f:	ff 75 ec             	pushl  -0x14(%ebp)
    2722:	e8 a9 15 00 00       	call   3cd0 <close>
    2727:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    272a:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    2731:	74 17                	je     274a <bigfile+0x1f7>
    printf(1, "read bigfile wrong total\n");
    2733:	83 ec 08             	sub    $0x8,%esp
    2736:	68 e0 4f 00 00       	push   $0x4fe0
    273b:	6a 01                	push   $0x1
    273d:	e8 e2 16 00 00       	call   3e24 <printf>
    2742:	83 c4 10             	add    $0x10,%esp
    exit();
    2745:	e8 5e 15 00 00       	call   3ca8 <exit>
  }
  unlink("bigfile");
    274a:	83 ec 0c             	sub    $0xc,%esp
    274d:	68 55 4f 00 00       	push   $0x4f55
    2752:	e8 a1 15 00 00       	call   3cf8 <unlink>
    2757:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    275a:	83 ec 08             	sub    $0x8,%esp
    275d:	68 fa 4f 00 00       	push   $0x4ffa
    2762:	6a 01                	push   $0x1
    2764:	e8 bb 16 00 00       	call   3e24 <printf>
    2769:	83 c4 10             	add    $0x10,%esp
}
    276c:	90                   	nop
    276d:	c9                   	leave  
    276e:	c3                   	ret    

0000276f <fourteen>:

void
fourteen(void)
{
    276f:	f3 0f 1e fb          	endbr32 
    2773:	55                   	push   %ebp
    2774:	89 e5                	mov    %esp,%ebp
    2776:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2779:	83 ec 08             	sub    $0x8,%esp
    277c:	68 0b 50 00 00       	push   $0x500b
    2781:	6a 01                	push   $0x1
    2783:	e8 9c 16 00 00       	call   3e24 <printf>
    2788:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    278b:	83 ec 0c             	sub    $0xc,%esp
    278e:	68 1a 50 00 00       	push   $0x501a
    2793:	e8 78 15 00 00       	call   3d10 <mkdir>
    2798:	83 c4 10             	add    $0x10,%esp
    279b:	85 c0                	test   %eax,%eax
    279d:	74 17                	je     27b6 <fourteen+0x47>
    printf(1, "mkdir 12345678901234 failed\n");
    279f:	83 ec 08             	sub    $0x8,%esp
    27a2:	68 29 50 00 00       	push   $0x5029
    27a7:	6a 01                	push   $0x1
    27a9:	e8 76 16 00 00       	call   3e24 <printf>
    27ae:	83 c4 10             	add    $0x10,%esp
    exit();
    27b1:	e8 f2 14 00 00       	call   3ca8 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    27b6:	83 ec 0c             	sub    $0xc,%esp
    27b9:	68 48 50 00 00       	push   $0x5048
    27be:	e8 4d 15 00 00       	call   3d10 <mkdir>
    27c3:	83 c4 10             	add    $0x10,%esp
    27c6:	85 c0                	test   %eax,%eax
    27c8:	74 17                	je     27e1 <fourteen+0x72>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    27ca:	83 ec 08             	sub    $0x8,%esp
    27cd:	68 68 50 00 00       	push   $0x5068
    27d2:	6a 01                	push   $0x1
    27d4:	e8 4b 16 00 00       	call   3e24 <printf>
    27d9:	83 c4 10             	add    $0x10,%esp
    exit();
    27dc:	e8 c7 14 00 00       	call   3ca8 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    27e1:	83 ec 08             	sub    $0x8,%esp
    27e4:	68 00 02 00 00       	push   $0x200
    27e9:	68 98 50 00 00       	push   $0x5098
    27ee:	e8 f5 14 00 00       	call   3ce8 <open>
    27f3:	83 c4 10             	add    $0x10,%esp
    27f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    27f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    27fd:	79 17                	jns    2816 <fourteen+0xa7>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    27ff:	83 ec 08             	sub    $0x8,%esp
    2802:	68 c8 50 00 00       	push   $0x50c8
    2807:	6a 01                	push   $0x1
    2809:	e8 16 16 00 00       	call   3e24 <printf>
    280e:	83 c4 10             	add    $0x10,%esp
    exit();
    2811:	e8 92 14 00 00       	call   3ca8 <exit>
  }
  close(fd);
    2816:	83 ec 0c             	sub    $0xc,%esp
    2819:	ff 75 f4             	pushl  -0xc(%ebp)
    281c:	e8 af 14 00 00       	call   3cd0 <close>
    2821:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2824:	83 ec 08             	sub    $0x8,%esp
    2827:	6a 00                	push   $0x0
    2829:	68 08 51 00 00       	push   $0x5108
    282e:	e8 b5 14 00 00       	call   3ce8 <open>
    2833:	83 c4 10             	add    $0x10,%esp
    2836:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2839:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    283d:	79 17                	jns    2856 <fourteen+0xe7>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    283f:	83 ec 08             	sub    $0x8,%esp
    2842:	68 38 51 00 00       	push   $0x5138
    2847:	6a 01                	push   $0x1
    2849:	e8 d6 15 00 00       	call   3e24 <printf>
    284e:	83 c4 10             	add    $0x10,%esp
    exit();
    2851:	e8 52 14 00 00       	call   3ca8 <exit>
  }
  close(fd);
    2856:	83 ec 0c             	sub    $0xc,%esp
    2859:	ff 75 f4             	pushl  -0xc(%ebp)
    285c:	e8 6f 14 00 00       	call   3cd0 <close>
    2861:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    2864:	83 ec 0c             	sub    $0xc,%esp
    2867:	68 72 51 00 00       	push   $0x5172
    286c:	e8 9f 14 00 00       	call   3d10 <mkdir>
    2871:	83 c4 10             	add    $0x10,%esp
    2874:	85 c0                	test   %eax,%eax
    2876:	75 17                	jne    288f <fourteen+0x120>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2878:	83 ec 08             	sub    $0x8,%esp
    287b:	68 90 51 00 00       	push   $0x5190
    2880:	6a 01                	push   $0x1
    2882:	e8 9d 15 00 00       	call   3e24 <printf>
    2887:	83 c4 10             	add    $0x10,%esp
    exit();
    288a:	e8 19 14 00 00       	call   3ca8 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    288f:	83 ec 0c             	sub    $0xc,%esp
    2892:	68 c0 51 00 00       	push   $0x51c0
    2897:	e8 74 14 00 00       	call   3d10 <mkdir>
    289c:	83 c4 10             	add    $0x10,%esp
    289f:	85 c0                	test   %eax,%eax
    28a1:	75 17                	jne    28ba <fourteen+0x14b>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    28a3:	83 ec 08             	sub    $0x8,%esp
    28a6:	68 e0 51 00 00       	push   $0x51e0
    28ab:	6a 01                	push   $0x1
    28ad:	e8 72 15 00 00       	call   3e24 <printf>
    28b2:	83 c4 10             	add    $0x10,%esp
    exit();
    28b5:	e8 ee 13 00 00       	call   3ca8 <exit>
  }

  printf(1, "fourteen ok\n");
    28ba:	83 ec 08             	sub    $0x8,%esp
    28bd:	68 11 52 00 00       	push   $0x5211
    28c2:	6a 01                	push   $0x1
    28c4:	e8 5b 15 00 00       	call   3e24 <printf>
    28c9:	83 c4 10             	add    $0x10,%esp
}
    28cc:	90                   	nop
    28cd:	c9                   	leave  
    28ce:	c3                   	ret    

000028cf <rmdot>:

void
rmdot(void)
{
    28cf:	f3 0f 1e fb          	endbr32 
    28d3:	55                   	push   %ebp
    28d4:	89 e5                	mov    %esp,%ebp
    28d6:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    28d9:	83 ec 08             	sub    $0x8,%esp
    28dc:	68 1e 52 00 00       	push   $0x521e
    28e1:	6a 01                	push   $0x1
    28e3:	e8 3c 15 00 00       	call   3e24 <printf>
    28e8:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    28eb:	83 ec 0c             	sub    $0xc,%esp
    28ee:	68 2a 52 00 00       	push   $0x522a
    28f3:	e8 18 14 00 00       	call   3d10 <mkdir>
    28f8:	83 c4 10             	add    $0x10,%esp
    28fb:	85 c0                	test   %eax,%eax
    28fd:	74 17                	je     2916 <rmdot+0x47>
    printf(1, "mkdir dots failed\n");
    28ff:	83 ec 08             	sub    $0x8,%esp
    2902:	68 2f 52 00 00       	push   $0x522f
    2907:	6a 01                	push   $0x1
    2909:	e8 16 15 00 00       	call   3e24 <printf>
    290e:	83 c4 10             	add    $0x10,%esp
    exit();
    2911:	e8 92 13 00 00       	call   3ca8 <exit>
  }
  if(chdir("dots") != 0){
    2916:	83 ec 0c             	sub    $0xc,%esp
    2919:	68 2a 52 00 00       	push   $0x522a
    291e:	e8 f5 13 00 00       	call   3d18 <chdir>
    2923:	83 c4 10             	add    $0x10,%esp
    2926:	85 c0                	test   %eax,%eax
    2928:	74 17                	je     2941 <rmdot+0x72>
    printf(1, "chdir dots failed\n");
    292a:	83 ec 08             	sub    $0x8,%esp
    292d:	68 42 52 00 00       	push   $0x5242
    2932:	6a 01                	push   $0x1
    2934:	e8 eb 14 00 00       	call   3e24 <printf>
    2939:	83 c4 10             	add    $0x10,%esp
    exit();
    293c:	e8 67 13 00 00       	call   3ca8 <exit>
  }
  if(unlink(".") == 0){
    2941:	83 ec 0c             	sub    $0xc,%esp
    2944:	68 5b 49 00 00       	push   $0x495b
    2949:	e8 aa 13 00 00       	call   3cf8 <unlink>
    294e:	83 c4 10             	add    $0x10,%esp
    2951:	85 c0                	test   %eax,%eax
    2953:	75 17                	jne    296c <rmdot+0x9d>
    printf(1, "rm . worked!\n");
    2955:	83 ec 08             	sub    $0x8,%esp
    2958:	68 55 52 00 00       	push   $0x5255
    295d:	6a 01                	push   $0x1
    295f:	e8 c0 14 00 00       	call   3e24 <printf>
    2964:	83 c4 10             	add    $0x10,%esp
    exit();
    2967:	e8 3c 13 00 00       	call   3ca8 <exit>
  }
  if(unlink("..") == 0){
    296c:	83 ec 0c             	sub    $0xc,%esp
    296f:	68 e8 44 00 00       	push   $0x44e8
    2974:	e8 7f 13 00 00       	call   3cf8 <unlink>
    2979:	83 c4 10             	add    $0x10,%esp
    297c:	85 c0                	test   %eax,%eax
    297e:	75 17                	jne    2997 <rmdot+0xc8>
    printf(1, "rm .. worked!\n");
    2980:	83 ec 08             	sub    $0x8,%esp
    2983:	68 63 52 00 00       	push   $0x5263
    2988:	6a 01                	push   $0x1
    298a:	e8 95 14 00 00       	call   3e24 <printf>
    298f:	83 c4 10             	add    $0x10,%esp
    exit();
    2992:	e8 11 13 00 00       	call   3ca8 <exit>
  }
  if(chdir("/") != 0){
    2997:	83 ec 0c             	sub    $0xc,%esp
    299a:	68 72 52 00 00       	push   $0x5272
    299f:	e8 74 13 00 00       	call   3d18 <chdir>
    29a4:	83 c4 10             	add    $0x10,%esp
    29a7:	85 c0                	test   %eax,%eax
    29a9:	74 17                	je     29c2 <rmdot+0xf3>
    printf(1, "chdir / failed\n");
    29ab:	83 ec 08             	sub    $0x8,%esp
    29ae:	68 74 52 00 00       	push   $0x5274
    29b3:	6a 01                	push   $0x1
    29b5:	e8 6a 14 00 00       	call   3e24 <printf>
    29ba:	83 c4 10             	add    $0x10,%esp
    exit();
    29bd:	e8 e6 12 00 00       	call   3ca8 <exit>
  }
  if(unlink("dots/.") == 0){
    29c2:	83 ec 0c             	sub    $0xc,%esp
    29c5:	68 84 52 00 00       	push   $0x5284
    29ca:	e8 29 13 00 00       	call   3cf8 <unlink>
    29cf:	83 c4 10             	add    $0x10,%esp
    29d2:	85 c0                	test   %eax,%eax
    29d4:	75 17                	jne    29ed <rmdot+0x11e>
    printf(1, "unlink dots/. worked!\n");
    29d6:	83 ec 08             	sub    $0x8,%esp
    29d9:	68 8b 52 00 00       	push   $0x528b
    29de:	6a 01                	push   $0x1
    29e0:	e8 3f 14 00 00       	call   3e24 <printf>
    29e5:	83 c4 10             	add    $0x10,%esp
    exit();
    29e8:	e8 bb 12 00 00       	call   3ca8 <exit>
  }
  if(unlink("dots/..") == 0){
    29ed:	83 ec 0c             	sub    $0xc,%esp
    29f0:	68 a2 52 00 00       	push   $0x52a2
    29f5:	e8 fe 12 00 00       	call   3cf8 <unlink>
    29fa:	83 c4 10             	add    $0x10,%esp
    29fd:	85 c0                	test   %eax,%eax
    29ff:	75 17                	jne    2a18 <rmdot+0x149>
    printf(1, "unlink dots/.. worked!\n");
    2a01:	83 ec 08             	sub    $0x8,%esp
    2a04:	68 aa 52 00 00       	push   $0x52aa
    2a09:	6a 01                	push   $0x1
    2a0b:	e8 14 14 00 00       	call   3e24 <printf>
    2a10:	83 c4 10             	add    $0x10,%esp
    exit();
    2a13:	e8 90 12 00 00       	call   3ca8 <exit>
  }
  if(unlink("dots") != 0){
    2a18:	83 ec 0c             	sub    $0xc,%esp
    2a1b:	68 2a 52 00 00       	push   $0x522a
    2a20:	e8 d3 12 00 00       	call   3cf8 <unlink>
    2a25:	83 c4 10             	add    $0x10,%esp
    2a28:	85 c0                	test   %eax,%eax
    2a2a:	74 17                	je     2a43 <rmdot+0x174>
    printf(1, "unlink dots failed!\n");
    2a2c:	83 ec 08             	sub    $0x8,%esp
    2a2f:	68 c2 52 00 00       	push   $0x52c2
    2a34:	6a 01                	push   $0x1
    2a36:	e8 e9 13 00 00       	call   3e24 <printf>
    2a3b:	83 c4 10             	add    $0x10,%esp
    exit();
    2a3e:	e8 65 12 00 00       	call   3ca8 <exit>
  }
  printf(1, "rmdot ok\n");
    2a43:	83 ec 08             	sub    $0x8,%esp
    2a46:	68 d7 52 00 00       	push   $0x52d7
    2a4b:	6a 01                	push   $0x1
    2a4d:	e8 d2 13 00 00       	call   3e24 <printf>
    2a52:	83 c4 10             	add    $0x10,%esp
}
    2a55:	90                   	nop
    2a56:	c9                   	leave  
    2a57:	c3                   	ret    

00002a58 <dirfile>:

void
dirfile(void)
{
    2a58:	f3 0f 1e fb          	endbr32 
    2a5c:	55                   	push   %ebp
    2a5d:	89 e5                	mov    %esp,%ebp
    2a5f:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "dir vs file\n");
    2a62:	83 ec 08             	sub    $0x8,%esp
    2a65:	68 e1 52 00 00       	push   $0x52e1
    2a6a:	6a 01                	push   $0x1
    2a6c:	e8 b3 13 00 00       	call   3e24 <printf>
    2a71:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    2a74:	83 ec 08             	sub    $0x8,%esp
    2a77:	68 00 02 00 00       	push   $0x200
    2a7c:	68 ee 52 00 00       	push   $0x52ee
    2a81:	e8 62 12 00 00       	call   3ce8 <open>
    2a86:	83 c4 10             	add    $0x10,%esp
    2a89:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2a8c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a90:	79 17                	jns    2aa9 <dirfile+0x51>
    printf(1, "create dirfile failed\n");
    2a92:	83 ec 08             	sub    $0x8,%esp
    2a95:	68 f6 52 00 00       	push   $0x52f6
    2a9a:	6a 01                	push   $0x1
    2a9c:	e8 83 13 00 00       	call   3e24 <printf>
    2aa1:	83 c4 10             	add    $0x10,%esp
    exit();
    2aa4:	e8 ff 11 00 00       	call   3ca8 <exit>
  }
  close(fd);
    2aa9:	83 ec 0c             	sub    $0xc,%esp
    2aac:	ff 75 f4             	pushl  -0xc(%ebp)
    2aaf:	e8 1c 12 00 00       	call   3cd0 <close>
    2ab4:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    2ab7:	83 ec 0c             	sub    $0xc,%esp
    2aba:	68 ee 52 00 00       	push   $0x52ee
    2abf:	e8 54 12 00 00       	call   3d18 <chdir>
    2ac4:	83 c4 10             	add    $0x10,%esp
    2ac7:	85 c0                	test   %eax,%eax
    2ac9:	75 17                	jne    2ae2 <dirfile+0x8a>
    printf(1, "chdir dirfile succeeded!\n");
    2acb:	83 ec 08             	sub    $0x8,%esp
    2ace:	68 0d 53 00 00       	push   $0x530d
    2ad3:	6a 01                	push   $0x1
    2ad5:	e8 4a 13 00 00       	call   3e24 <printf>
    2ada:	83 c4 10             	add    $0x10,%esp
    exit();
    2add:	e8 c6 11 00 00       	call   3ca8 <exit>
  }
  fd = open("dirfile/xx", 0);
    2ae2:	83 ec 08             	sub    $0x8,%esp
    2ae5:	6a 00                	push   $0x0
    2ae7:	68 27 53 00 00       	push   $0x5327
    2aec:	e8 f7 11 00 00       	call   3ce8 <open>
    2af1:	83 c4 10             	add    $0x10,%esp
    2af4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2af7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2afb:	78 17                	js     2b14 <dirfile+0xbc>
    printf(1, "create dirfile/xx succeeded!\n");
    2afd:	83 ec 08             	sub    $0x8,%esp
    2b00:	68 32 53 00 00       	push   $0x5332
    2b05:	6a 01                	push   $0x1
    2b07:	e8 18 13 00 00       	call   3e24 <printf>
    2b0c:	83 c4 10             	add    $0x10,%esp
    exit();
    2b0f:	e8 94 11 00 00       	call   3ca8 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2b14:	83 ec 08             	sub    $0x8,%esp
    2b17:	68 00 02 00 00       	push   $0x200
    2b1c:	68 27 53 00 00       	push   $0x5327
    2b21:	e8 c2 11 00 00       	call   3ce8 <open>
    2b26:	83 c4 10             	add    $0x10,%esp
    2b29:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2b2c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2b30:	78 17                	js     2b49 <dirfile+0xf1>
    printf(1, "create dirfile/xx succeeded!\n");
    2b32:	83 ec 08             	sub    $0x8,%esp
    2b35:	68 32 53 00 00       	push   $0x5332
    2b3a:	6a 01                	push   $0x1
    2b3c:	e8 e3 12 00 00       	call   3e24 <printf>
    2b41:	83 c4 10             	add    $0x10,%esp
    exit();
    2b44:	e8 5f 11 00 00       	call   3ca8 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2b49:	83 ec 0c             	sub    $0xc,%esp
    2b4c:	68 27 53 00 00       	push   $0x5327
    2b51:	e8 ba 11 00 00       	call   3d10 <mkdir>
    2b56:	83 c4 10             	add    $0x10,%esp
    2b59:	85 c0                	test   %eax,%eax
    2b5b:	75 17                	jne    2b74 <dirfile+0x11c>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2b5d:	83 ec 08             	sub    $0x8,%esp
    2b60:	68 50 53 00 00       	push   $0x5350
    2b65:	6a 01                	push   $0x1
    2b67:	e8 b8 12 00 00       	call   3e24 <printf>
    2b6c:	83 c4 10             	add    $0x10,%esp
    exit();
    2b6f:	e8 34 11 00 00       	call   3ca8 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2b74:	83 ec 0c             	sub    $0xc,%esp
    2b77:	68 27 53 00 00       	push   $0x5327
    2b7c:	e8 77 11 00 00       	call   3cf8 <unlink>
    2b81:	83 c4 10             	add    $0x10,%esp
    2b84:	85 c0                	test   %eax,%eax
    2b86:	75 17                	jne    2b9f <dirfile+0x147>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b88:	83 ec 08             	sub    $0x8,%esp
    2b8b:	68 6d 53 00 00       	push   $0x536d
    2b90:	6a 01                	push   $0x1
    2b92:	e8 8d 12 00 00       	call   3e24 <printf>
    2b97:	83 c4 10             	add    $0x10,%esp
    exit();
    2b9a:	e8 09 11 00 00       	call   3ca8 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2b9f:	83 ec 08             	sub    $0x8,%esp
    2ba2:	68 27 53 00 00       	push   $0x5327
    2ba7:	68 8b 53 00 00       	push   $0x538b
    2bac:	e8 57 11 00 00       	call   3d08 <link>
    2bb1:	83 c4 10             	add    $0x10,%esp
    2bb4:	85 c0                	test   %eax,%eax
    2bb6:	75 17                	jne    2bcf <dirfile+0x177>
    printf(1, "link to dirfile/xx succeeded!\n");
    2bb8:	83 ec 08             	sub    $0x8,%esp
    2bbb:	68 94 53 00 00       	push   $0x5394
    2bc0:	6a 01                	push   $0x1
    2bc2:	e8 5d 12 00 00       	call   3e24 <printf>
    2bc7:	83 c4 10             	add    $0x10,%esp
    exit();
    2bca:	e8 d9 10 00 00       	call   3ca8 <exit>
  }
  if(unlink("dirfile") != 0){
    2bcf:	83 ec 0c             	sub    $0xc,%esp
    2bd2:	68 ee 52 00 00       	push   $0x52ee
    2bd7:	e8 1c 11 00 00       	call   3cf8 <unlink>
    2bdc:	83 c4 10             	add    $0x10,%esp
    2bdf:	85 c0                	test   %eax,%eax
    2be1:	74 17                	je     2bfa <dirfile+0x1a2>
    printf(1, "unlink dirfile failed!\n");
    2be3:	83 ec 08             	sub    $0x8,%esp
    2be6:	68 b3 53 00 00       	push   $0x53b3
    2beb:	6a 01                	push   $0x1
    2bed:	e8 32 12 00 00       	call   3e24 <printf>
    2bf2:	83 c4 10             	add    $0x10,%esp
    exit();
    2bf5:	e8 ae 10 00 00       	call   3ca8 <exit>
  }

  fd = open(".", O_RDWR);
    2bfa:	83 ec 08             	sub    $0x8,%esp
    2bfd:	6a 02                	push   $0x2
    2bff:	68 5b 49 00 00       	push   $0x495b
    2c04:	e8 df 10 00 00       	call   3ce8 <open>
    2c09:	83 c4 10             	add    $0x10,%esp
    2c0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2c0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2c13:	78 17                	js     2c2c <dirfile+0x1d4>
    printf(1, "open . for writing succeeded!\n");
    2c15:	83 ec 08             	sub    $0x8,%esp
    2c18:	68 cc 53 00 00       	push   $0x53cc
    2c1d:	6a 01                	push   $0x1
    2c1f:	e8 00 12 00 00       	call   3e24 <printf>
    2c24:	83 c4 10             	add    $0x10,%esp
    exit();
    2c27:	e8 7c 10 00 00       	call   3ca8 <exit>
  }
  fd = open(".", 0);
    2c2c:	83 ec 08             	sub    $0x8,%esp
    2c2f:	6a 00                	push   $0x0
    2c31:	68 5b 49 00 00       	push   $0x495b
    2c36:	e8 ad 10 00 00       	call   3ce8 <open>
    2c3b:	83 c4 10             	add    $0x10,%esp
    2c3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    2c41:	83 ec 04             	sub    $0x4,%esp
    2c44:	6a 01                	push   $0x1
    2c46:	68 92 45 00 00       	push   $0x4592
    2c4b:	ff 75 f4             	pushl  -0xc(%ebp)
    2c4e:	e8 75 10 00 00       	call   3cc8 <write>
    2c53:	83 c4 10             	add    $0x10,%esp
    2c56:	85 c0                	test   %eax,%eax
    2c58:	7e 17                	jle    2c71 <dirfile+0x219>
    printf(1, "write . succeeded!\n");
    2c5a:	83 ec 08             	sub    $0x8,%esp
    2c5d:	68 eb 53 00 00       	push   $0x53eb
    2c62:	6a 01                	push   $0x1
    2c64:	e8 bb 11 00 00       	call   3e24 <printf>
    2c69:	83 c4 10             	add    $0x10,%esp
    exit();
    2c6c:	e8 37 10 00 00       	call   3ca8 <exit>
  }
  close(fd);
    2c71:	83 ec 0c             	sub    $0xc,%esp
    2c74:	ff 75 f4             	pushl  -0xc(%ebp)
    2c77:	e8 54 10 00 00       	call   3cd0 <close>
    2c7c:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    2c7f:	83 ec 08             	sub    $0x8,%esp
    2c82:	68 ff 53 00 00       	push   $0x53ff
    2c87:	6a 01                	push   $0x1
    2c89:	e8 96 11 00 00       	call   3e24 <printf>
    2c8e:	83 c4 10             	add    $0x10,%esp
}
    2c91:	90                   	nop
    2c92:	c9                   	leave  
    2c93:	c3                   	ret    

00002c94 <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2c94:	f3 0f 1e fb          	endbr32 
    2c98:	55                   	push   %ebp
    2c99:	89 e5                	mov    %esp,%ebp
    2c9b:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2c9e:	83 ec 08             	sub    $0x8,%esp
    2ca1:	68 0f 54 00 00       	push   $0x540f
    2ca6:	6a 01                	push   $0x1
    2ca8:	e8 77 11 00 00       	call   3e24 <printf>
    2cad:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2cb0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2cb7:	e9 e7 00 00 00       	jmp    2da3 <iref+0x10f>
    if(mkdir("irefd") != 0){
    2cbc:	83 ec 0c             	sub    $0xc,%esp
    2cbf:	68 20 54 00 00       	push   $0x5420
    2cc4:	e8 47 10 00 00       	call   3d10 <mkdir>
    2cc9:	83 c4 10             	add    $0x10,%esp
    2ccc:	85 c0                	test   %eax,%eax
    2cce:	74 17                	je     2ce7 <iref+0x53>
      printf(1, "mkdir irefd failed\n");
    2cd0:	83 ec 08             	sub    $0x8,%esp
    2cd3:	68 26 54 00 00       	push   $0x5426
    2cd8:	6a 01                	push   $0x1
    2cda:	e8 45 11 00 00       	call   3e24 <printf>
    2cdf:	83 c4 10             	add    $0x10,%esp
      exit();
    2ce2:	e8 c1 0f 00 00       	call   3ca8 <exit>
    }
    if(chdir("irefd") != 0){
    2ce7:	83 ec 0c             	sub    $0xc,%esp
    2cea:	68 20 54 00 00       	push   $0x5420
    2cef:	e8 24 10 00 00       	call   3d18 <chdir>
    2cf4:	83 c4 10             	add    $0x10,%esp
    2cf7:	85 c0                	test   %eax,%eax
    2cf9:	74 17                	je     2d12 <iref+0x7e>
      printf(1, "chdir irefd failed\n");
    2cfb:	83 ec 08             	sub    $0x8,%esp
    2cfe:	68 3a 54 00 00       	push   $0x543a
    2d03:	6a 01                	push   $0x1
    2d05:	e8 1a 11 00 00       	call   3e24 <printf>
    2d0a:	83 c4 10             	add    $0x10,%esp
      exit();
    2d0d:	e8 96 0f 00 00       	call   3ca8 <exit>
    }

    mkdir("");
    2d12:	83 ec 0c             	sub    $0xc,%esp
    2d15:	68 4e 54 00 00       	push   $0x544e
    2d1a:	e8 f1 0f 00 00       	call   3d10 <mkdir>
    2d1f:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    2d22:	83 ec 08             	sub    $0x8,%esp
    2d25:	68 4e 54 00 00       	push   $0x544e
    2d2a:	68 8b 53 00 00       	push   $0x538b
    2d2f:	e8 d4 0f 00 00       	call   3d08 <link>
    2d34:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    2d37:	83 ec 08             	sub    $0x8,%esp
    2d3a:	68 00 02 00 00       	push   $0x200
    2d3f:	68 4e 54 00 00       	push   $0x544e
    2d44:	e8 9f 0f 00 00       	call   3ce8 <open>
    2d49:	83 c4 10             	add    $0x10,%esp
    2d4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2d4f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d53:	78 0e                	js     2d63 <iref+0xcf>
      close(fd);
    2d55:	83 ec 0c             	sub    $0xc,%esp
    2d58:	ff 75 f0             	pushl  -0x10(%ebp)
    2d5b:	e8 70 0f 00 00       	call   3cd0 <close>
    2d60:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2d63:	83 ec 08             	sub    $0x8,%esp
    2d66:	68 00 02 00 00       	push   $0x200
    2d6b:	68 4f 54 00 00       	push   $0x544f
    2d70:	e8 73 0f 00 00       	call   3ce8 <open>
    2d75:	83 c4 10             	add    $0x10,%esp
    2d78:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2d7b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d7f:	78 0e                	js     2d8f <iref+0xfb>
      close(fd);
    2d81:	83 ec 0c             	sub    $0xc,%esp
    2d84:	ff 75 f0             	pushl  -0x10(%ebp)
    2d87:	e8 44 0f 00 00       	call   3cd0 <close>
    2d8c:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2d8f:	83 ec 0c             	sub    $0xc,%esp
    2d92:	68 4f 54 00 00       	push   $0x544f
    2d97:	e8 5c 0f 00 00       	call   3cf8 <unlink>
    2d9c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 50 + 1; i++){
    2d9f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2da3:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    2da7:	0f 8e 0f ff ff ff    	jle    2cbc <iref+0x28>
  }

  chdir("/");
    2dad:	83 ec 0c             	sub    $0xc,%esp
    2db0:	68 72 52 00 00       	push   $0x5272
    2db5:	e8 5e 0f 00 00       	call   3d18 <chdir>
    2dba:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    2dbd:	83 ec 08             	sub    $0x8,%esp
    2dc0:	68 52 54 00 00       	push   $0x5452
    2dc5:	6a 01                	push   $0x1
    2dc7:	e8 58 10 00 00       	call   3e24 <printf>
    2dcc:	83 c4 10             	add    $0x10,%esp
}
    2dcf:	90                   	nop
    2dd0:	c9                   	leave  
    2dd1:	c3                   	ret    

00002dd2 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2dd2:	f3 0f 1e fb          	endbr32 
    2dd6:	55                   	push   %ebp
    2dd7:	89 e5                	mov    %esp,%ebp
    2dd9:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    2ddc:	83 ec 08             	sub    $0x8,%esp
    2ddf:	68 66 54 00 00       	push   $0x5466
    2de4:	6a 01                	push   $0x1
    2de6:	e8 39 10 00 00       	call   3e24 <printf>
    2deb:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    2dee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2df5:	eb 1d                	jmp    2e14 <forktest+0x42>
    pid = fork();
    2df7:	e8 a4 0e 00 00       	call   3ca0 <fork>
    2dfc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    2dff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2e03:	78 1a                	js     2e1f <forktest+0x4d>
      break;
    if(pid == 0)
    2e05:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2e09:	75 05                	jne    2e10 <forktest+0x3e>
      exit();
    2e0b:	e8 98 0e 00 00       	call   3ca8 <exit>
  for(n=0; n<1000; n++){
    2e10:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2e14:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    2e1b:	7e da                	jle    2df7 <forktest+0x25>
    2e1d:	eb 01                	jmp    2e20 <forktest+0x4e>
      break;
    2e1f:	90                   	nop
  }
  
  if(n == 1000){
    2e20:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    2e27:	75 3b                	jne    2e64 <forktest+0x92>
    printf(1, "fork claimed to work 1000 times!\n");
    2e29:	83 ec 08             	sub    $0x8,%esp
    2e2c:	68 74 54 00 00       	push   $0x5474
    2e31:	6a 01                	push   $0x1
    2e33:	e8 ec 0f 00 00       	call   3e24 <printf>
    2e38:	83 c4 10             	add    $0x10,%esp
    exit();
    2e3b:	e8 68 0e 00 00       	call   3ca8 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
    2e40:	e8 6b 0e 00 00       	call   3cb0 <wait>
    2e45:	85 c0                	test   %eax,%eax
    2e47:	79 17                	jns    2e60 <forktest+0x8e>
      printf(1, "wait stopped early\n");
    2e49:	83 ec 08             	sub    $0x8,%esp
    2e4c:	68 96 54 00 00       	push   $0x5496
    2e51:	6a 01                	push   $0x1
    2e53:	e8 cc 0f 00 00       	call   3e24 <printf>
    2e58:	83 c4 10             	add    $0x10,%esp
      exit();
    2e5b:	e8 48 0e 00 00       	call   3ca8 <exit>
  for(; n > 0; n--){
    2e60:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    2e64:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2e68:	7f d6                	jg     2e40 <forktest+0x6e>
    }
  }
  
  if(wait() != -1){
    2e6a:	e8 41 0e 00 00       	call   3cb0 <wait>
    2e6f:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e72:	74 17                	je     2e8b <forktest+0xb9>
    printf(1, "wait got too many\n");
    2e74:	83 ec 08             	sub    $0x8,%esp
    2e77:	68 aa 54 00 00       	push   $0x54aa
    2e7c:	6a 01                	push   $0x1
    2e7e:	e8 a1 0f 00 00       	call   3e24 <printf>
    2e83:	83 c4 10             	add    $0x10,%esp
    exit();
    2e86:	e8 1d 0e 00 00       	call   3ca8 <exit>
  }
  
  printf(1, "fork test OK\n");
    2e8b:	83 ec 08             	sub    $0x8,%esp
    2e8e:	68 bd 54 00 00       	push   $0x54bd
    2e93:	6a 01                	push   $0x1
    2e95:	e8 8a 0f 00 00       	call   3e24 <printf>
    2e9a:	83 c4 10             	add    $0x10,%esp
}
    2e9d:	90                   	nop
    2e9e:	c9                   	leave  
    2e9f:	c3                   	ret    

00002ea0 <sbrktest>:

void
sbrktest(void)
{
    2ea0:	f3 0f 1e fb          	endbr32 
    2ea4:	55                   	push   %ebp
    2ea5:	89 e5                	mov    %esp,%ebp
    2ea7:	83 ec 68             	sub    $0x68,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2eaa:	a1 38 5f 00 00       	mov    0x5f38,%eax
    2eaf:	83 ec 08             	sub    $0x8,%esp
    2eb2:	68 cb 54 00 00       	push   $0x54cb
    2eb7:	50                   	push   %eax
    2eb8:	e8 67 0f 00 00       	call   3e24 <printf>
    2ebd:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    2ec0:	83 ec 0c             	sub    $0xc,%esp
    2ec3:	6a 00                	push   $0x0
    2ec5:	e8 66 0e 00 00       	call   3d30 <sbrk>
    2eca:	83 c4 10             	add    $0x10,%esp
    2ecd:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2ed0:	83 ec 0c             	sub    $0xc,%esp
    2ed3:	6a 00                	push   $0x0
    2ed5:	e8 56 0e 00 00       	call   3d30 <sbrk>
    2eda:	83 c4 10             	add    $0x10,%esp
    2edd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){ 
    2ee0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2ee7:	eb 4f                	jmp    2f38 <sbrktest+0x98>
    b = sbrk(1);
    2ee9:	83 ec 0c             	sub    $0xc,%esp
    2eec:	6a 01                	push   $0x1
    2eee:	e8 3d 0e 00 00       	call   3d30 <sbrk>
    2ef3:	83 c4 10             	add    $0x10,%esp
    2ef6:	89 45 d0             	mov    %eax,-0x30(%ebp)
    if(b != a){
    2ef9:	8b 45 d0             	mov    -0x30(%ebp),%eax
    2efc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2eff:	74 24                	je     2f25 <sbrktest+0x85>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2f01:	a1 38 5f 00 00       	mov    0x5f38,%eax
    2f06:	83 ec 0c             	sub    $0xc,%esp
    2f09:	ff 75 d0             	pushl  -0x30(%ebp)
    2f0c:	ff 75 f4             	pushl  -0xc(%ebp)
    2f0f:	ff 75 f0             	pushl  -0x10(%ebp)
    2f12:	68 d6 54 00 00       	push   $0x54d6
    2f17:	50                   	push   %eax
    2f18:	e8 07 0f 00 00       	call   3e24 <printf>
    2f1d:	83 c4 20             	add    $0x20,%esp
      exit();
    2f20:	e8 83 0d 00 00       	call   3ca8 <exit>
    }
    *b = 1;
    2f25:	8b 45 d0             	mov    -0x30(%ebp),%eax
    2f28:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    2f2b:	8b 45 d0             	mov    -0x30(%ebp),%eax
    2f2e:	83 c0 01             	add    $0x1,%eax
    2f31:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; i < 5000; i++){ 
    2f34:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2f38:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    2f3f:	7e a8                	jle    2ee9 <sbrktest+0x49>
  }
  pid = fork();
    2f41:	e8 5a 0d 00 00       	call   3ca0 <fork>
    2f46:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(pid < 0){
    2f49:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2f4d:	79 1b                	jns    2f6a <sbrktest+0xca>
    printf(stdout, "sbrk test fork failed\n");
    2f4f:	a1 38 5f 00 00       	mov    0x5f38,%eax
    2f54:	83 ec 08             	sub    $0x8,%esp
    2f57:	68 f1 54 00 00       	push   $0x54f1
    2f5c:	50                   	push   %eax
    2f5d:	e8 c2 0e 00 00       	call   3e24 <printf>
    2f62:	83 c4 10             	add    $0x10,%esp
    exit();
    2f65:	e8 3e 0d 00 00       	call   3ca8 <exit>
  }
  c = sbrk(1);
    2f6a:	83 ec 0c             	sub    $0xc,%esp
    2f6d:	6a 01                	push   $0x1
    2f6f:	e8 bc 0d 00 00       	call   3d30 <sbrk>
    2f74:	83 c4 10             	add    $0x10,%esp
    2f77:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  c = sbrk(1);
    2f7a:	83 ec 0c             	sub    $0xc,%esp
    2f7d:	6a 01                	push   $0x1
    2f7f:	e8 ac 0d 00 00       	call   3d30 <sbrk>
    2f84:	83 c4 10             	add    $0x10,%esp
    2f87:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a + 1){
    2f8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f8d:	83 c0 01             	add    $0x1,%eax
    2f90:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    2f93:	74 1b                	je     2fb0 <sbrktest+0x110>
    printf(stdout, "sbrk test failed post-fork\n");
    2f95:	a1 38 5f 00 00       	mov    0x5f38,%eax
    2f9a:	83 ec 08             	sub    $0x8,%esp
    2f9d:	68 08 55 00 00       	push   $0x5508
    2fa2:	50                   	push   %eax
    2fa3:	e8 7c 0e 00 00       	call   3e24 <printf>
    2fa8:	83 c4 10             	add    $0x10,%esp
    exit();
    2fab:	e8 f8 0c 00 00       	call   3ca8 <exit>
  }
  if(pid == 0)
    2fb0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2fb4:	75 05                	jne    2fbb <sbrktest+0x11b>
    exit();
    2fb6:	e8 ed 0c 00 00       	call   3ca8 <exit>
  wait();
    2fbb:	e8 f0 0c 00 00       	call   3cb0 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    2fc0:	83 ec 0c             	sub    $0xc,%esp
    2fc3:	6a 00                	push   $0x0
    2fc5:	e8 66 0d 00 00       	call   3d30 <sbrk>
    2fca:	83 c4 10             	add    $0x10,%esp
    2fcd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    2fd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2fd3:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2fd8:	29 c2                	sub    %eax,%edx
    2fda:	89 d0                	mov    %edx,%eax
    2fdc:	89 45 e0             	mov    %eax,-0x20(%ebp)
  p = sbrk(amt);
    2fdf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2fe2:	83 ec 0c             	sub    $0xc,%esp
    2fe5:	50                   	push   %eax
    2fe6:	e8 45 0d 00 00       	call   3d30 <sbrk>
    2feb:	83 c4 10             	add    $0x10,%esp
    2fee:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if (p != a) { 
    2ff1:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2ff4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2ff7:	74 1b                	je     3014 <sbrktest+0x174>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    2ff9:	a1 38 5f 00 00       	mov    0x5f38,%eax
    2ffe:	83 ec 08             	sub    $0x8,%esp
    3001:	68 24 55 00 00       	push   $0x5524
    3006:	50                   	push   %eax
    3007:	e8 18 0e 00 00       	call   3e24 <printf>
    300c:	83 c4 10             	add    $0x10,%esp
    exit();
    300f:	e8 94 0c 00 00       	call   3ca8 <exit>
  }
  lastaddr = (char*) (BIG-1);
    3014:	c7 45 d8 ff ff 3f 06 	movl   $0x63fffff,-0x28(%ebp)
  *lastaddr = 99;
    301b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    301e:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    3021:	83 ec 0c             	sub    $0xc,%esp
    3024:	6a 00                	push   $0x0
    3026:	e8 05 0d 00 00       	call   3d30 <sbrk>
    302b:	83 c4 10             	add    $0x10,%esp
    302e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    3031:	83 ec 0c             	sub    $0xc,%esp
    3034:	68 00 f0 ff ff       	push   $0xfffff000
    3039:	e8 f2 0c 00 00       	call   3d30 <sbrk>
    303e:	83 c4 10             	add    $0x10,%esp
    3041:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c == (char*)0xffffffff){
    3044:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
    3048:	75 1b                	jne    3065 <sbrktest+0x1c5>
    printf(stdout, "sbrk could not deallocate\n");
    304a:	a1 38 5f 00 00       	mov    0x5f38,%eax
    304f:	83 ec 08             	sub    $0x8,%esp
    3052:	68 62 55 00 00       	push   $0x5562
    3057:	50                   	push   %eax
    3058:	e8 c7 0d 00 00       	call   3e24 <printf>
    305d:	83 c4 10             	add    $0x10,%esp
    exit();
    3060:	e8 43 0c 00 00       	call   3ca8 <exit>
  }
  c = sbrk(0);
    3065:	83 ec 0c             	sub    $0xc,%esp
    3068:	6a 00                	push   $0x0
    306a:	e8 c1 0c 00 00       	call   3d30 <sbrk>
    306f:	83 c4 10             	add    $0x10,%esp
    3072:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a - 4096){
    3075:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3078:	2d 00 10 00 00       	sub    $0x1000,%eax
    307d:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    3080:	74 1e                	je     30a0 <sbrktest+0x200>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3082:	a1 38 5f 00 00       	mov    0x5f38,%eax
    3087:	ff 75 e4             	pushl  -0x1c(%ebp)
    308a:	ff 75 f4             	pushl  -0xc(%ebp)
    308d:	68 80 55 00 00       	push   $0x5580
    3092:	50                   	push   %eax
    3093:	e8 8c 0d 00 00       	call   3e24 <printf>
    3098:	83 c4 10             	add    $0x10,%esp
    exit();
    309b:	e8 08 0c 00 00       	call   3ca8 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    30a0:	83 ec 0c             	sub    $0xc,%esp
    30a3:	6a 00                	push   $0x0
    30a5:	e8 86 0c 00 00       	call   3d30 <sbrk>
    30aa:	83 c4 10             	add    $0x10,%esp
    30ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    30b0:	83 ec 0c             	sub    $0xc,%esp
    30b3:	68 00 10 00 00       	push   $0x1000
    30b8:	e8 73 0c 00 00       	call   3d30 <sbrk>
    30bd:	83 c4 10             	add    $0x10,%esp
    30c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    30c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    30c6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    30c9:	75 1a                	jne    30e5 <sbrktest+0x245>
    30cb:	83 ec 0c             	sub    $0xc,%esp
    30ce:	6a 00                	push   $0x0
    30d0:	e8 5b 0c 00 00       	call   3d30 <sbrk>
    30d5:	83 c4 10             	add    $0x10,%esp
    30d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    30db:	81 c2 00 10 00 00    	add    $0x1000,%edx
    30e1:	39 d0                	cmp    %edx,%eax
    30e3:	74 1e                	je     3103 <sbrktest+0x263>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    30e5:	a1 38 5f 00 00       	mov    0x5f38,%eax
    30ea:	ff 75 e4             	pushl  -0x1c(%ebp)
    30ed:	ff 75 f4             	pushl  -0xc(%ebp)
    30f0:	68 b8 55 00 00       	push   $0x55b8
    30f5:	50                   	push   %eax
    30f6:	e8 29 0d 00 00       	call   3e24 <printf>
    30fb:	83 c4 10             	add    $0x10,%esp
    exit();
    30fe:	e8 a5 0b 00 00       	call   3ca8 <exit>
  }
  if(*lastaddr == 99){
    3103:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3106:	0f b6 00             	movzbl (%eax),%eax
    3109:	3c 63                	cmp    $0x63,%al
    310b:	75 1b                	jne    3128 <sbrktest+0x288>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    310d:	a1 38 5f 00 00       	mov    0x5f38,%eax
    3112:	83 ec 08             	sub    $0x8,%esp
    3115:	68 e0 55 00 00       	push   $0x55e0
    311a:	50                   	push   %eax
    311b:	e8 04 0d 00 00       	call   3e24 <printf>
    3120:	83 c4 10             	add    $0x10,%esp
    exit();
    3123:	e8 80 0b 00 00       	call   3ca8 <exit>
  }

  a = sbrk(0);
    3128:	83 ec 0c             	sub    $0xc,%esp
    312b:	6a 00                	push   $0x0
    312d:	e8 fe 0b 00 00       	call   3d30 <sbrk>
    3132:	83 c4 10             	add    $0x10,%esp
    3135:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    3138:	83 ec 0c             	sub    $0xc,%esp
    313b:	6a 00                	push   $0x0
    313d:	e8 ee 0b 00 00       	call   3d30 <sbrk>
    3142:	83 c4 10             	add    $0x10,%esp
    3145:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3148:	29 c2                	sub    %eax,%edx
    314a:	89 d0                	mov    %edx,%eax
    314c:	83 ec 0c             	sub    $0xc,%esp
    314f:	50                   	push   %eax
    3150:	e8 db 0b 00 00       	call   3d30 <sbrk>
    3155:	83 c4 10             	add    $0x10,%esp
    3158:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a){
    315b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    315e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3161:	74 1e                	je     3181 <sbrktest+0x2e1>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3163:	a1 38 5f 00 00       	mov    0x5f38,%eax
    3168:	ff 75 e4             	pushl  -0x1c(%ebp)
    316b:	ff 75 f4             	pushl  -0xc(%ebp)
    316e:	68 10 56 00 00       	push   $0x5610
    3173:	50                   	push   %eax
    3174:	e8 ab 0c 00 00       	call   3e24 <printf>
    3179:	83 c4 10             	add    $0x10,%esp
    exit();
    317c:	e8 27 0b 00 00       	call   3ca8 <exit>
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3181:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    3188:	eb 76                	jmp    3200 <sbrktest+0x360>
    ppid = getpid();
    318a:	e8 99 0b 00 00       	call   3d28 <getpid>
    318f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    pid = fork();
    3192:	e8 09 0b 00 00       	call   3ca0 <fork>
    3197:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    319a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    319e:	79 1b                	jns    31bb <sbrktest+0x31b>
      printf(stdout, "fork failed\n");
    31a0:	a1 38 5f 00 00       	mov    0x5f38,%eax
    31a5:	83 ec 08             	sub    $0x8,%esp
    31a8:	68 d9 45 00 00       	push   $0x45d9
    31ad:	50                   	push   %eax
    31ae:	e8 71 0c 00 00       	call   3e24 <printf>
    31b3:	83 c4 10             	add    $0x10,%esp
      exit();
    31b6:	e8 ed 0a 00 00       	call   3ca8 <exit>
    }
    if(pid == 0){
    31bb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    31bf:	75 33                	jne    31f4 <sbrktest+0x354>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    31c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    31c4:	0f b6 00             	movzbl (%eax),%eax
    31c7:	0f be d0             	movsbl %al,%edx
    31ca:	a1 38 5f 00 00       	mov    0x5f38,%eax
    31cf:	52                   	push   %edx
    31d0:	ff 75 f4             	pushl  -0xc(%ebp)
    31d3:	68 31 56 00 00       	push   $0x5631
    31d8:	50                   	push   %eax
    31d9:	e8 46 0c 00 00       	call   3e24 <printf>
    31de:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    31e1:	83 ec 0c             	sub    $0xc,%esp
    31e4:	ff 75 d4             	pushl  -0x2c(%ebp)
    31e7:	e8 ec 0a 00 00       	call   3cd8 <kill>
    31ec:	83 c4 10             	add    $0x10,%esp
      exit();
    31ef:	e8 b4 0a 00 00       	call   3ca8 <exit>
    }
    wait();
    31f4:	e8 b7 0a 00 00       	call   3cb0 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    31f9:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    3200:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    3207:	76 81                	jbe    318a <sbrktest+0x2ea>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    3209:	83 ec 0c             	sub    $0xc,%esp
    320c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    320f:	50                   	push   %eax
    3210:	e8 a3 0a 00 00       	call   3cb8 <pipe>
    3215:	83 c4 10             	add    $0x10,%esp
    3218:	85 c0                	test   %eax,%eax
    321a:	74 17                	je     3233 <sbrktest+0x393>
    printf(1, "pipe() failed\n");
    321c:	83 ec 08             	sub    $0x8,%esp
    321f:	68 2d 45 00 00       	push   $0x452d
    3224:	6a 01                	push   $0x1
    3226:	e8 f9 0b 00 00       	call   3e24 <printf>
    322b:	83 c4 10             	add    $0x10,%esp
    exit();
    322e:	e8 75 0a 00 00       	call   3ca8 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3233:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    323a:	e9 86 00 00 00       	jmp    32c5 <sbrktest+0x425>
    if((pids[i] = fork()) == 0){
    323f:	e8 5c 0a 00 00       	call   3ca0 <fork>
    3244:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3247:	89 44 95 a0          	mov    %eax,-0x60(%ebp,%edx,4)
    324b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    324e:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3252:	85 c0                	test   %eax,%eax
    3254:	75 4a                	jne    32a0 <sbrktest+0x400>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    3256:	83 ec 0c             	sub    $0xc,%esp
    3259:	6a 00                	push   $0x0
    325b:	e8 d0 0a 00 00       	call   3d30 <sbrk>
    3260:	83 c4 10             	add    $0x10,%esp
    3263:	ba 00 00 40 06       	mov    $0x6400000,%edx
    3268:	29 c2                	sub    %eax,%edx
    326a:	89 d0                	mov    %edx,%eax
    326c:	83 ec 0c             	sub    $0xc,%esp
    326f:	50                   	push   %eax
    3270:	e8 bb 0a 00 00       	call   3d30 <sbrk>
    3275:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    3278:	8b 45 cc             	mov    -0x34(%ebp),%eax
    327b:	83 ec 04             	sub    $0x4,%esp
    327e:	6a 01                	push   $0x1
    3280:	68 92 45 00 00       	push   $0x4592
    3285:	50                   	push   %eax
    3286:	e8 3d 0a 00 00       	call   3cc8 <write>
    328b:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    328e:	83 ec 0c             	sub    $0xc,%esp
    3291:	68 e8 03 00 00       	push   $0x3e8
    3296:	e8 9d 0a 00 00       	call   3d38 <sleep>
    329b:	83 c4 10             	add    $0x10,%esp
    329e:	eb ee                	jmp    328e <sbrktest+0x3ee>
    }
    if(pids[i] != -1)
    32a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32a3:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    32a7:	83 f8 ff             	cmp    $0xffffffff,%eax
    32aa:	74 15                	je     32c1 <sbrktest+0x421>
      read(fds[0], &scratch, 1);
    32ac:	8b 45 c8             	mov    -0x38(%ebp),%eax
    32af:	83 ec 04             	sub    $0x4,%esp
    32b2:	6a 01                	push   $0x1
    32b4:	8d 55 9f             	lea    -0x61(%ebp),%edx
    32b7:	52                   	push   %edx
    32b8:	50                   	push   %eax
    32b9:	e8 02 0a 00 00       	call   3cc0 <read>
    32be:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    32c1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    32c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32c8:	83 f8 09             	cmp    $0x9,%eax
    32cb:	0f 86 6e ff ff ff    	jbe    323f <sbrktest+0x39f>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    32d1:	83 ec 0c             	sub    $0xc,%esp
    32d4:	68 00 10 00 00       	push   $0x1000
    32d9:	e8 52 0a 00 00       	call   3d30 <sbrk>
    32de:	83 c4 10             	add    $0x10,%esp
    32e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    32e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    32eb:	eb 2b                	jmp    3318 <sbrktest+0x478>
    if(pids[i] == -1)
    32ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32f0:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    32f4:	83 f8 ff             	cmp    $0xffffffff,%eax
    32f7:	74 1a                	je     3313 <sbrktest+0x473>
      continue;
    kill(pids[i]);
    32f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32fc:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3300:	83 ec 0c             	sub    $0xc,%esp
    3303:	50                   	push   %eax
    3304:	e8 cf 09 00 00       	call   3cd8 <kill>
    3309:	83 c4 10             	add    $0x10,%esp
    wait();
    330c:	e8 9f 09 00 00       	call   3cb0 <wait>
    3311:	eb 01                	jmp    3314 <sbrktest+0x474>
      continue;
    3313:	90                   	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3314:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3318:	8b 45 f0             	mov    -0x10(%ebp),%eax
    331b:	83 f8 09             	cmp    $0x9,%eax
    331e:	76 cd                	jbe    32ed <sbrktest+0x44d>
  }
  if(c == (char*)0xffffffff){
    3320:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
    3324:	75 1b                	jne    3341 <sbrktest+0x4a1>
    printf(stdout, "failed sbrk leaked memory\n");
    3326:	a1 38 5f 00 00       	mov    0x5f38,%eax
    332b:	83 ec 08             	sub    $0x8,%esp
    332e:	68 4a 56 00 00       	push   $0x564a
    3333:	50                   	push   %eax
    3334:	e8 eb 0a 00 00       	call   3e24 <printf>
    3339:	83 c4 10             	add    $0x10,%esp
    exit();
    333c:	e8 67 09 00 00       	call   3ca8 <exit>
  }

  if(sbrk(0) > oldbrk)
    3341:	83 ec 0c             	sub    $0xc,%esp
    3344:	6a 00                	push   $0x0
    3346:	e8 e5 09 00 00       	call   3d30 <sbrk>
    334b:	83 c4 10             	add    $0x10,%esp
    334e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    3351:	73 20                	jae    3373 <sbrktest+0x4d3>
    sbrk(-(sbrk(0) - oldbrk));
    3353:	83 ec 0c             	sub    $0xc,%esp
    3356:	6a 00                	push   $0x0
    3358:	e8 d3 09 00 00       	call   3d30 <sbrk>
    335d:	83 c4 10             	add    $0x10,%esp
    3360:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3363:	29 c2                	sub    %eax,%edx
    3365:	89 d0                	mov    %edx,%eax
    3367:	83 ec 0c             	sub    $0xc,%esp
    336a:	50                   	push   %eax
    336b:	e8 c0 09 00 00       	call   3d30 <sbrk>
    3370:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    3373:	a1 38 5f 00 00       	mov    0x5f38,%eax
    3378:	83 ec 08             	sub    $0x8,%esp
    337b:	68 65 56 00 00       	push   $0x5665
    3380:	50                   	push   %eax
    3381:	e8 9e 0a 00 00       	call   3e24 <printf>
    3386:	83 c4 10             	add    $0x10,%esp
}
    3389:	90                   	nop
    338a:	c9                   	leave  
    338b:	c3                   	ret    

0000338c <validateint>:

void
validateint(int *p)
{
    338c:	f3 0f 1e fb          	endbr32 
    3390:	55                   	push   %ebp
    3391:	89 e5                	mov    %esp,%ebp
    3393:	53                   	push   %ebx
    3394:	83 ec 10             	sub    $0x10,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    3397:	b8 0d 00 00 00       	mov    $0xd,%eax
    339c:	8b 55 08             	mov    0x8(%ebp),%edx
    339f:	89 d1                	mov    %edx,%ecx
    33a1:	89 e3                	mov    %esp,%ebx
    33a3:	89 cc                	mov    %ecx,%esp
    33a5:	cd 40                	int    $0x40
    33a7:	89 dc                	mov    %ebx,%esp
    33a9:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    33ac:	90                   	nop
    33ad:	83 c4 10             	add    $0x10,%esp
    33b0:	5b                   	pop    %ebx
    33b1:	5d                   	pop    %ebp
    33b2:	c3                   	ret    

000033b3 <validatetest>:

void
validatetest(void)
{
    33b3:	f3 0f 1e fb          	endbr32 
    33b7:	55                   	push   %ebp
    33b8:	89 e5                	mov    %esp,%ebp
    33ba:	83 ec 18             	sub    $0x18,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    33bd:	a1 38 5f 00 00       	mov    0x5f38,%eax
    33c2:	83 ec 08             	sub    $0x8,%esp
    33c5:	68 73 56 00 00       	push   $0x5673
    33ca:	50                   	push   %eax
    33cb:	e8 54 0a 00 00       	call   3e24 <printf>
    33d0:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    33d3:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    33da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    33e1:	e9 8a 00 00 00       	jmp    3470 <validatetest+0xbd>
    if((pid = fork()) == 0){
    33e6:	e8 b5 08 00 00       	call   3ca0 <fork>
    33eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    33ee:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    33f2:	75 14                	jne    3408 <validatetest+0x55>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    33f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33f7:	83 ec 0c             	sub    $0xc,%esp
    33fa:	50                   	push   %eax
    33fb:	e8 8c ff ff ff       	call   338c <validateint>
    3400:	83 c4 10             	add    $0x10,%esp
      exit();
    3403:	e8 a0 08 00 00       	call   3ca8 <exit>
    }
    sleep(0);
    3408:	83 ec 0c             	sub    $0xc,%esp
    340b:	6a 00                	push   $0x0
    340d:	e8 26 09 00 00       	call   3d38 <sleep>
    3412:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    3415:	83 ec 0c             	sub    $0xc,%esp
    3418:	6a 00                	push   $0x0
    341a:	e8 19 09 00 00       	call   3d38 <sleep>
    341f:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    3422:	83 ec 0c             	sub    $0xc,%esp
    3425:	ff 75 ec             	pushl  -0x14(%ebp)
    3428:	e8 ab 08 00 00       	call   3cd8 <kill>
    342d:	83 c4 10             	add    $0x10,%esp
    wait();
    3430:	e8 7b 08 00 00       	call   3cb0 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3435:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3438:	83 ec 08             	sub    $0x8,%esp
    343b:	50                   	push   %eax
    343c:	68 82 56 00 00       	push   $0x5682
    3441:	e8 c2 08 00 00       	call   3d08 <link>
    3446:	83 c4 10             	add    $0x10,%esp
    3449:	83 f8 ff             	cmp    $0xffffffff,%eax
    344c:	74 1b                	je     3469 <validatetest+0xb6>
      printf(stdout, "link should not succeed\n");
    344e:	a1 38 5f 00 00       	mov    0x5f38,%eax
    3453:	83 ec 08             	sub    $0x8,%esp
    3456:	68 8d 56 00 00       	push   $0x568d
    345b:	50                   	push   %eax
    345c:	e8 c3 09 00 00       	call   3e24 <printf>
    3461:	83 c4 10             	add    $0x10,%esp
      exit();
    3464:	e8 3f 08 00 00       	call   3ca8 <exit>
  for(p = 0; p <= (uint)hi; p += 4096){
    3469:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    3470:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3473:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    3476:	0f 86 6a ff ff ff    	jbe    33e6 <validatetest+0x33>
    }
  }

  printf(stdout, "validate ok\n");
    347c:	a1 38 5f 00 00       	mov    0x5f38,%eax
    3481:	83 ec 08             	sub    $0x8,%esp
    3484:	68 a6 56 00 00       	push   $0x56a6
    3489:	50                   	push   %eax
    348a:	e8 95 09 00 00       	call   3e24 <printf>
    348f:	83 c4 10             	add    $0x10,%esp
}
    3492:	90                   	nop
    3493:	c9                   	leave  
    3494:	c3                   	ret    

00003495 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3495:	f3 0f 1e fb          	endbr32 
    3499:	55                   	push   %ebp
    349a:	89 e5                	mov    %esp,%ebp
    349c:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    349f:	a1 38 5f 00 00       	mov    0x5f38,%eax
    34a4:	83 ec 08             	sub    $0x8,%esp
    34a7:	68 b3 56 00 00       	push   $0x56b3
    34ac:	50                   	push   %eax
    34ad:	e8 72 09 00 00       	call   3e24 <printf>
    34b2:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    34b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    34bc:	eb 2e                	jmp    34ec <bsstest+0x57>
    if(uninit[i] != '\0'){
    34be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    34c1:	05 00 60 00 00       	add    $0x6000,%eax
    34c6:	0f b6 00             	movzbl (%eax),%eax
    34c9:	84 c0                	test   %al,%al
    34cb:	74 1b                	je     34e8 <bsstest+0x53>
      printf(stdout, "bss test failed\n");
    34cd:	a1 38 5f 00 00       	mov    0x5f38,%eax
    34d2:	83 ec 08             	sub    $0x8,%esp
    34d5:	68 bd 56 00 00       	push   $0x56bd
    34da:	50                   	push   %eax
    34db:	e8 44 09 00 00       	call   3e24 <printf>
    34e0:	83 c4 10             	add    $0x10,%esp
      exit();
    34e3:	e8 c0 07 00 00       	call   3ca8 <exit>
  for(i = 0; i < sizeof(uninit); i++){
    34e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    34ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    34ef:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    34f4:	76 c8                	jbe    34be <bsstest+0x29>
    }
  }
  printf(stdout, "bss test ok\n");
    34f6:	a1 38 5f 00 00       	mov    0x5f38,%eax
    34fb:	83 ec 08             	sub    $0x8,%esp
    34fe:	68 ce 56 00 00       	push   $0x56ce
    3503:	50                   	push   %eax
    3504:	e8 1b 09 00 00       	call   3e24 <printf>
    3509:	83 c4 10             	add    $0x10,%esp
}
    350c:	90                   	nop
    350d:	c9                   	leave  
    350e:	c3                   	ret    

0000350f <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    350f:	f3 0f 1e fb          	endbr32 
    3513:	55                   	push   %ebp
    3514:	89 e5                	mov    %esp,%ebp
    3516:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    3519:	83 ec 0c             	sub    $0xc,%esp
    351c:	68 db 56 00 00       	push   $0x56db
    3521:	e8 d2 07 00 00       	call   3cf8 <unlink>
    3526:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    3529:	e8 72 07 00 00       	call   3ca0 <fork>
    352e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    3531:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3535:	0f 85 97 00 00 00    	jne    35d2 <bigargtest+0xc3>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    353b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3542:	eb 12                	jmp    3556 <bigargtest+0x47>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3544:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3547:	c7 04 85 60 5f 00 00 	movl   $0x56e8,0x5f60(,%eax,4)
    354e:	e8 56 00 00 
    for(i = 0; i < MAXARG-1; i++)
    3552:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3556:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    355a:	7e e8                	jle    3544 <bigargtest+0x35>
    args[MAXARG-1] = 0;
    355c:	c7 05 dc 5f 00 00 00 	movl   $0x0,0x5fdc
    3563:	00 00 00 
    printf(stdout, "bigarg test\n");
    3566:	a1 38 5f 00 00       	mov    0x5f38,%eax
    356b:	83 ec 08             	sub    $0x8,%esp
    356e:	68 c5 57 00 00       	push   $0x57c5
    3573:	50                   	push   %eax
    3574:	e8 ab 08 00 00       	call   3e24 <printf>
    3579:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    357c:	83 ec 08             	sub    $0x8,%esp
    357f:	68 60 5f 00 00       	push   $0x5f60
    3584:	68 ec 41 00 00       	push   $0x41ec
    3589:	e8 52 07 00 00       	call   3ce0 <exec>
    358e:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    3591:	a1 38 5f 00 00       	mov    0x5f38,%eax
    3596:	83 ec 08             	sub    $0x8,%esp
    3599:	68 d2 57 00 00       	push   $0x57d2
    359e:	50                   	push   %eax
    359f:	e8 80 08 00 00       	call   3e24 <printf>
    35a4:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    35a7:	83 ec 08             	sub    $0x8,%esp
    35aa:	68 00 02 00 00       	push   $0x200
    35af:	68 db 56 00 00       	push   $0x56db
    35b4:	e8 2f 07 00 00       	call   3ce8 <open>
    35b9:	83 c4 10             	add    $0x10,%esp
    35bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    35bf:	83 ec 0c             	sub    $0xc,%esp
    35c2:	ff 75 ec             	pushl  -0x14(%ebp)
    35c5:	e8 06 07 00 00       	call   3cd0 <close>
    35ca:	83 c4 10             	add    $0x10,%esp
    exit();
    35cd:	e8 d6 06 00 00       	call   3ca8 <exit>
  } else if(pid < 0){
    35d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    35d6:	79 1b                	jns    35f3 <bigargtest+0xe4>
    printf(stdout, "bigargtest: fork failed\n");
    35d8:	a1 38 5f 00 00       	mov    0x5f38,%eax
    35dd:	83 ec 08             	sub    $0x8,%esp
    35e0:	68 e2 57 00 00       	push   $0x57e2
    35e5:	50                   	push   %eax
    35e6:	e8 39 08 00 00       	call   3e24 <printf>
    35eb:	83 c4 10             	add    $0x10,%esp
    exit();
    35ee:	e8 b5 06 00 00       	call   3ca8 <exit>
  }
  wait();
    35f3:	e8 b8 06 00 00       	call   3cb0 <wait>
  fd = open("bigarg-ok", 0);
    35f8:	83 ec 08             	sub    $0x8,%esp
    35fb:	6a 00                	push   $0x0
    35fd:	68 db 56 00 00       	push   $0x56db
    3602:	e8 e1 06 00 00       	call   3ce8 <open>
    3607:	83 c4 10             	add    $0x10,%esp
    360a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    360d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3611:	79 1b                	jns    362e <bigargtest+0x11f>
    printf(stdout, "bigarg test failed!\n");
    3613:	a1 38 5f 00 00       	mov    0x5f38,%eax
    3618:	83 ec 08             	sub    $0x8,%esp
    361b:	68 fb 57 00 00       	push   $0x57fb
    3620:	50                   	push   %eax
    3621:	e8 fe 07 00 00       	call   3e24 <printf>
    3626:	83 c4 10             	add    $0x10,%esp
    exit();
    3629:	e8 7a 06 00 00       	call   3ca8 <exit>
  }
  close(fd);
    362e:	83 ec 0c             	sub    $0xc,%esp
    3631:	ff 75 ec             	pushl  -0x14(%ebp)
    3634:	e8 97 06 00 00       	call   3cd0 <close>
    3639:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    363c:	83 ec 0c             	sub    $0xc,%esp
    363f:	68 db 56 00 00       	push   $0x56db
    3644:	e8 af 06 00 00       	call   3cf8 <unlink>
    3649:	83 c4 10             	add    $0x10,%esp
}
    364c:	90                   	nop
    364d:	c9                   	leave  
    364e:	c3                   	ret    

0000364f <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    364f:	f3 0f 1e fb          	endbr32 
    3653:	55                   	push   %ebp
    3654:	89 e5                	mov    %esp,%ebp
    3656:	53                   	push   %ebx
    3657:	83 ec 64             	sub    $0x64,%esp
  int nfiles;
  int fsblocks = 0;
    365a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    3661:	83 ec 08             	sub    $0x8,%esp
    3664:	68 10 58 00 00       	push   $0x5810
    3669:	6a 01                	push   $0x1
    366b:	e8 b4 07 00 00       	call   3e24 <printf>
    3670:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    3673:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    367a:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    367e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3681:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3686:	89 c8                	mov    %ecx,%eax
    3688:	f7 ea                	imul   %edx
    368a:	c1 fa 06             	sar    $0x6,%edx
    368d:	89 c8                	mov    %ecx,%eax
    368f:	c1 f8 1f             	sar    $0x1f,%eax
    3692:	29 c2                	sub    %eax,%edx
    3694:	89 d0                	mov    %edx,%eax
    3696:	83 c0 30             	add    $0x30,%eax
    3699:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    369c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    369f:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    36a4:	89 d8                	mov    %ebx,%eax
    36a6:	f7 ea                	imul   %edx
    36a8:	c1 fa 06             	sar    $0x6,%edx
    36ab:	89 d8                	mov    %ebx,%eax
    36ad:	c1 f8 1f             	sar    $0x1f,%eax
    36b0:	89 d1                	mov    %edx,%ecx
    36b2:	29 c1                	sub    %eax,%ecx
    36b4:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    36ba:	29 c3                	sub    %eax,%ebx
    36bc:	89 d9                	mov    %ebx,%ecx
    36be:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    36c3:	89 c8                	mov    %ecx,%eax
    36c5:	f7 ea                	imul   %edx
    36c7:	c1 fa 05             	sar    $0x5,%edx
    36ca:	89 c8                	mov    %ecx,%eax
    36cc:	c1 f8 1f             	sar    $0x1f,%eax
    36cf:	29 c2                	sub    %eax,%edx
    36d1:	89 d0                	mov    %edx,%eax
    36d3:	83 c0 30             	add    $0x30,%eax
    36d6:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    36d9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    36dc:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    36e1:	89 d8                	mov    %ebx,%eax
    36e3:	f7 ea                	imul   %edx
    36e5:	c1 fa 05             	sar    $0x5,%edx
    36e8:	89 d8                	mov    %ebx,%eax
    36ea:	c1 f8 1f             	sar    $0x1f,%eax
    36ed:	89 d1                	mov    %edx,%ecx
    36ef:	29 c1                	sub    %eax,%ecx
    36f1:	6b c1 64             	imul   $0x64,%ecx,%eax
    36f4:	29 c3                	sub    %eax,%ebx
    36f6:	89 d9                	mov    %ebx,%ecx
    36f8:	ba 67 66 66 66       	mov    $0x66666667,%edx
    36fd:	89 c8                	mov    %ecx,%eax
    36ff:	f7 ea                	imul   %edx
    3701:	c1 fa 02             	sar    $0x2,%edx
    3704:	89 c8                	mov    %ecx,%eax
    3706:	c1 f8 1f             	sar    $0x1f,%eax
    3709:	29 c2                	sub    %eax,%edx
    370b:	89 d0                	mov    %edx,%eax
    370d:	83 c0 30             	add    $0x30,%eax
    3710:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3713:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3716:	ba 67 66 66 66       	mov    $0x66666667,%edx
    371b:	89 c8                	mov    %ecx,%eax
    371d:	f7 ea                	imul   %edx
    371f:	c1 fa 02             	sar    $0x2,%edx
    3722:	89 c8                	mov    %ecx,%eax
    3724:	c1 f8 1f             	sar    $0x1f,%eax
    3727:	29 c2                	sub    %eax,%edx
    3729:	89 d0                	mov    %edx,%eax
    372b:	c1 e0 02             	shl    $0x2,%eax
    372e:	01 d0                	add    %edx,%eax
    3730:	01 c0                	add    %eax,%eax
    3732:	29 c1                	sub    %eax,%ecx
    3734:	89 ca                	mov    %ecx,%edx
    3736:	89 d0                	mov    %edx,%eax
    3738:	83 c0 30             	add    $0x30,%eax
    373b:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    373e:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    3742:	83 ec 04             	sub    $0x4,%esp
    3745:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3748:	50                   	push   %eax
    3749:	68 1d 58 00 00       	push   $0x581d
    374e:	6a 01                	push   $0x1
    3750:	e8 cf 06 00 00       	call   3e24 <printf>
    3755:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3758:	83 ec 08             	sub    $0x8,%esp
    375b:	68 02 02 00 00       	push   $0x202
    3760:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3763:	50                   	push   %eax
    3764:	e8 7f 05 00 00       	call   3ce8 <open>
    3769:	83 c4 10             	add    $0x10,%esp
    376c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    376f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3773:	79 18                	jns    378d <fsfull+0x13e>
      printf(1, "open %s failed\n", name);
    3775:	83 ec 04             	sub    $0x4,%esp
    3778:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    377b:	50                   	push   %eax
    377c:	68 29 58 00 00       	push   $0x5829
    3781:	6a 01                	push   $0x1
    3783:	e8 9c 06 00 00       	call   3e24 <printf>
    3788:	83 c4 10             	add    $0x10,%esp
      break;
    378b:	eb 6b                	jmp    37f8 <fsfull+0x1a9>
    }
    int total = 0;
    378d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    3794:	83 ec 04             	sub    $0x4,%esp
    3797:	68 00 02 00 00       	push   $0x200
    379c:	68 20 87 00 00       	push   $0x8720
    37a1:	ff 75 e8             	pushl  -0x18(%ebp)
    37a4:	e8 1f 05 00 00       	call   3cc8 <write>
    37a9:	83 c4 10             	add    $0x10,%esp
    37ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    37af:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    37b6:	7e 0c                	jle    37c4 <fsfull+0x175>
        break;
      total += cc;
    37b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    37bb:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    37be:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    while(1){
    37c2:	eb d0                	jmp    3794 <fsfull+0x145>
        break;
    37c4:	90                   	nop
    }
    printf(1, "wrote %d bytes\n", total);
    37c5:	83 ec 04             	sub    $0x4,%esp
    37c8:	ff 75 ec             	pushl  -0x14(%ebp)
    37cb:	68 39 58 00 00       	push   $0x5839
    37d0:	6a 01                	push   $0x1
    37d2:	e8 4d 06 00 00       	call   3e24 <printf>
    37d7:	83 c4 10             	add    $0x10,%esp
    close(fd);
    37da:	83 ec 0c             	sub    $0xc,%esp
    37dd:	ff 75 e8             	pushl  -0x18(%ebp)
    37e0:	e8 eb 04 00 00       	call   3cd0 <close>
    37e5:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    37e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    37ec:	74 09                	je     37f7 <fsfull+0x1a8>
  for(nfiles = 0; ; nfiles++){
    37ee:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    37f2:	e9 83 fe ff ff       	jmp    367a <fsfull+0x2b>
      break;
    37f7:	90                   	nop
  }

  while(nfiles >= 0){
    37f8:	e9 db 00 00 00       	jmp    38d8 <fsfull+0x289>
    char name[64];
    name[0] = 'f';
    37fd:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3801:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3804:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3809:	89 c8                	mov    %ecx,%eax
    380b:	f7 ea                	imul   %edx
    380d:	c1 fa 06             	sar    $0x6,%edx
    3810:	89 c8                	mov    %ecx,%eax
    3812:	c1 f8 1f             	sar    $0x1f,%eax
    3815:	29 c2                	sub    %eax,%edx
    3817:	89 d0                	mov    %edx,%eax
    3819:	83 c0 30             	add    $0x30,%eax
    381c:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    381f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3822:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3827:	89 d8                	mov    %ebx,%eax
    3829:	f7 ea                	imul   %edx
    382b:	c1 fa 06             	sar    $0x6,%edx
    382e:	89 d8                	mov    %ebx,%eax
    3830:	c1 f8 1f             	sar    $0x1f,%eax
    3833:	89 d1                	mov    %edx,%ecx
    3835:	29 c1                	sub    %eax,%ecx
    3837:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    383d:	29 c3                	sub    %eax,%ebx
    383f:	89 d9                	mov    %ebx,%ecx
    3841:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3846:	89 c8                	mov    %ecx,%eax
    3848:	f7 ea                	imul   %edx
    384a:	c1 fa 05             	sar    $0x5,%edx
    384d:	89 c8                	mov    %ecx,%eax
    384f:	c1 f8 1f             	sar    $0x1f,%eax
    3852:	29 c2                	sub    %eax,%edx
    3854:	89 d0                	mov    %edx,%eax
    3856:	83 c0 30             	add    $0x30,%eax
    3859:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    385c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    385f:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3864:	89 d8                	mov    %ebx,%eax
    3866:	f7 ea                	imul   %edx
    3868:	c1 fa 05             	sar    $0x5,%edx
    386b:	89 d8                	mov    %ebx,%eax
    386d:	c1 f8 1f             	sar    $0x1f,%eax
    3870:	89 d1                	mov    %edx,%ecx
    3872:	29 c1                	sub    %eax,%ecx
    3874:	6b c1 64             	imul   $0x64,%ecx,%eax
    3877:	29 c3                	sub    %eax,%ebx
    3879:	89 d9                	mov    %ebx,%ecx
    387b:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3880:	89 c8                	mov    %ecx,%eax
    3882:	f7 ea                	imul   %edx
    3884:	c1 fa 02             	sar    $0x2,%edx
    3887:	89 c8                	mov    %ecx,%eax
    3889:	c1 f8 1f             	sar    $0x1f,%eax
    388c:	29 c2                	sub    %eax,%edx
    388e:	89 d0                	mov    %edx,%eax
    3890:	83 c0 30             	add    $0x30,%eax
    3893:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3896:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3899:	ba 67 66 66 66       	mov    $0x66666667,%edx
    389e:	89 c8                	mov    %ecx,%eax
    38a0:	f7 ea                	imul   %edx
    38a2:	c1 fa 02             	sar    $0x2,%edx
    38a5:	89 c8                	mov    %ecx,%eax
    38a7:	c1 f8 1f             	sar    $0x1f,%eax
    38aa:	29 c2                	sub    %eax,%edx
    38ac:	89 d0                	mov    %edx,%eax
    38ae:	c1 e0 02             	shl    $0x2,%eax
    38b1:	01 d0                	add    %edx,%eax
    38b3:	01 c0                	add    %eax,%eax
    38b5:	29 c1                	sub    %eax,%ecx
    38b7:	89 ca                	mov    %ecx,%edx
    38b9:	89 d0                	mov    %edx,%eax
    38bb:	83 c0 30             	add    $0x30,%eax
    38be:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    38c1:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    38c5:	83 ec 0c             	sub    $0xc,%esp
    38c8:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    38cb:	50                   	push   %eax
    38cc:	e8 27 04 00 00       	call   3cf8 <unlink>
    38d1:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    38d4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  while(nfiles >= 0){
    38d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    38dc:	0f 89 1b ff ff ff    	jns    37fd <fsfull+0x1ae>
  }

  printf(1, "fsfull test finished\n");
    38e2:	83 ec 08             	sub    $0x8,%esp
    38e5:	68 49 58 00 00       	push   $0x5849
    38ea:	6a 01                	push   $0x1
    38ec:	e8 33 05 00 00       	call   3e24 <printf>
    38f1:	83 c4 10             	add    $0x10,%esp
}
    38f4:	90                   	nop
    38f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    38f8:	c9                   	leave  
    38f9:	c3                   	ret    

000038fa <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    38fa:	f3 0f 1e fb          	endbr32 
    38fe:	55                   	push   %ebp
    38ff:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    3901:	a1 3c 5f 00 00       	mov    0x5f3c,%eax
    3906:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    390c:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3911:	a3 3c 5f 00 00       	mov    %eax,0x5f3c
  return randstate;
    3916:	a1 3c 5f 00 00       	mov    0x5f3c,%eax
}
    391b:	5d                   	pop    %ebp
    391c:	c3                   	ret    

0000391d <main>:

int
main(int argc, char *argv[])
{
    391d:	f3 0f 1e fb          	endbr32 
    3921:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3925:	83 e4 f0             	and    $0xfffffff0,%esp
    3928:	ff 71 fc             	pushl  -0x4(%ecx)
    392b:	55                   	push   %ebp
    392c:	89 e5                	mov    %esp,%ebp
    392e:	51                   	push   %ecx
    392f:	83 ec 04             	sub    $0x4,%esp
  printf(1, "usertests starting\n");
    3932:	83 ec 08             	sub    $0x8,%esp
    3935:	68 5f 58 00 00       	push   $0x585f
    393a:	6a 01                	push   $0x1
    393c:	e8 e3 04 00 00       	call   3e24 <printf>
    3941:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    3944:	83 ec 08             	sub    $0x8,%esp
    3947:	6a 00                	push   $0x0
    3949:	68 73 58 00 00       	push   $0x5873
    394e:	e8 95 03 00 00       	call   3ce8 <open>
    3953:	83 c4 10             	add    $0x10,%esp
    3956:	85 c0                	test   %eax,%eax
    3958:	78 17                	js     3971 <main+0x54>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    395a:	83 ec 08             	sub    $0x8,%esp
    395d:	68 84 58 00 00       	push   $0x5884
    3962:	6a 01                	push   $0x1
    3964:	e8 bb 04 00 00       	call   3e24 <printf>
    3969:	83 c4 10             	add    $0x10,%esp
    exit();
    396c:	e8 37 03 00 00       	call   3ca8 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    3971:	83 ec 08             	sub    $0x8,%esp
    3974:	68 00 02 00 00       	push   $0x200
    3979:	68 73 58 00 00       	push   $0x5873
    397e:	e8 65 03 00 00       	call   3ce8 <open>
    3983:	83 c4 10             	add    $0x10,%esp
    3986:	83 ec 0c             	sub    $0xc,%esp
    3989:	50                   	push   %eax
    398a:	e8 41 03 00 00       	call   3cd0 <close>
    398f:	83 c4 10             	add    $0x10,%esp

  bigargtest();
    3992:	e8 78 fb ff ff       	call   350f <bigargtest>
  bigwrite();
    3997:	e8 b5 ea ff ff       	call   2451 <bigwrite>
  bigargtest();
    399c:	e8 6e fb ff ff       	call   350f <bigargtest>
  bsstest();
    39a1:	e8 ef fa ff ff       	call   3495 <bsstest>
  sbrktest();
    39a6:	e8 f5 f4 ff ff       	call   2ea0 <sbrktest>
  validatetest();
    39ab:	e8 03 fa ff ff       	call   33b3 <validatetest>

  opentest();
    39b0:	e8 4b c6 ff ff       	call   0 <opentest>
  writetest();
    39b5:	e8 f9 c6 ff ff       	call   b3 <writetest>
  writetest1();
    39ba:	e8 08 c9 ff ff       	call   2c7 <writetest1>
  createtest();
    39bf:	e8 03 cb ff ff       	call   4c7 <createtest>

  mem();
    39c4:	e8 e1 d0 ff ff       	call   aaa <mem>
  pipe1();
    39c9:	e8 0c cd ff ff       	call   6da <pipe1>
  preempt();
    39ce:	e8 f4 ce ff ff       	call   8c7 <preempt>
  exitwait();
    39d3:	e8 56 d0 ff ff       	call   a2e <exitwait>

  rmdot();
    39d8:	e8 f2 ee ff ff       	call   28cf <rmdot>
  fourteen();
    39dd:	e8 8d ed ff ff       	call   276f <fourteen>
  bigfile();
    39e2:	e8 6c eb ff ff       	call   2553 <bigfile>
  subdir();
    39e7:	e8 1d e3 ff ff       	call   1d09 <subdir>
  concreate();
    39ec:	e8 ae dc ff ff       	call   169f <concreate>
  linkunlink();
    39f1:	e8 5d e0 ff ff       	call   1a53 <linkunlink>
  linktest();
    39f6:	e8 5e da ff ff       	call   1459 <linktest>
  unlinkread();
    39fb:	e8 93 d8 ff ff       	call   1293 <unlinkread>
  createdelete();
    3a00:	e8 e4 d5 ff ff       	call   fe9 <createdelete>
  twofiles();
    3a05:	e8 7c d3 ff ff       	call   d86 <twofiles>
  sharedfd();
    3a0a:	e8 90 d1 ff ff       	call   b9f <sharedfd>
  dirfile();
    3a0f:	e8 44 f0 ff ff       	call   2a58 <dirfile>
  iref();
    3a14:	e8 7b f2 ff ff       	call   2c94 <iref>
  forktest();
    3a19:	e8 b4 f3 ff ff       	call   2dd2 <forktest>
  bigdir(); // slow
    3a1e:	e8 6d e1 ff ff       	call   1b90 <bigdir>

  exectest();
    3a23:	e8 5b cc ff ff       	call   683 <exectest>

  exit();
    3a28:	e8 7b 02 00 00       	call   3ca8 <exit>

00003a2d <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    3a2d:	55                   	push   %ebp
    3a2e:	89 e5                	mov    %esp,%ebp
    3a30:	57                   	push   %edi
    3a31:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    3a32:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3a35:	8b 55 10             	mov    0x10(%ebp),%edx
    3a38:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a3b:	89 cb                	mov    %ecx,%ebx
    3a3d:	89 df                	mov    %ebx,%edi
    3a3f:	89 d1                	mov    %edx,%ecx
    3a41:	fc                   	cld    
    3a42:	f3 aa                	rep stos %al,%es:(%edi)
    3a44:	89 ca                	mov    %ecx,%edx
    3a46:	89 fb                	mov    %edi,%ebx
    3a48:	89 5d 08             	mov    %ebx,0x8(%ebp)
    3a4b:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    3a4e:	90                   	nop
    3a4f:	5b                   	pop    %ebx
    3a50:	5f                   	pop    %edi
    3a51:	5d                   	pop    %ebp
    3a52:	c3                   	ret    

00003a53 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3a53:	f3 0f 1e fb          	endbr32 
    3a57:	55                   	push   %ebp
    3a58:	89 e5                	mov    %esp,%ebp
    3a5a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    3a5d:	8b 45 08             	mov    0x8(%ebp),%eax
    3a60:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    3a63:	90                   	nop
    3a64:	8b 55 0c             	mov    0xc(%ebp),%edx
    3a67:	8d 42 01             	lea    0x1(%edx),%eax
    3a6a:	89 45 0c             	mov    %eax,0xc(%ebp)
    3a6d:	8b 45 08             	mov    0x8(%ebp),%eax
    3a70:	8d 48 01             	lea    0x1(%eax),%ecx
    3a73:	89 4d 08             	mov    %ecx,0x8(%ebp)
    3a76:	0f b6 12             	movzbl (%edx),%edx
    3a79:	88 10                	mov    %dl,(%eax)
    3a7b:	0f b6 00             	movzbl (%eax),%eax
    3a7e:	84 c0                	test   %al,%al
    3a80:	75 e2                	jne    3a64 <strcpy+0x11>
    ;
  return os;
    3a82:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3a85:	c9                   	leave  
    3a86:	c3                   	ret    

00003a87 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3a87:	f3 0f 1e fb          	endbr32 
    3a8b:	55                   	push   %ebp
    3a8c:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    3a8e:	eb 08                	jmp    3a98 <strcmp+0x11>
    p++, q++;
    3a90:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3a94:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    3a98:	8b 45 08             	mov    0x8(%ebp),%eax
    3a9b:	0f b6 00             	movzbl (%eax),%eax
    3a9e:	84 c0                	test   %al,%al
    3aa0:	74 10                	je     3ab2 <strcmp+0x2b>
    3aa2:	8b 45 08             	mov    0x8(%ebp),%eax
    3aa5:	0f b6 10             	movzbl (%eax),%edx
    3aa8:	8b 45 0c             	mov    0xc(%ebp),%eax
    3aab:	0f b6 00             	movzbl (%eax),%eax
    3aae:	38 c2                	cmp    %al,%dl
    3ab0:	74 de                	je     3a90 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    3ab2:	8b 45 08             	mov    0x8(%ebp),%eax
    3ab5:	0f b6 00             	movzbl (%eax),%eax
    3ab8:	0f b6 d0             	movzbl %al,%edx
    3abb:	8b 45 0c             	mov    0xc(%ebp),%eax
    3abe:	0f b6 00             	movzbl (%eax),%eax
    3ac1:	0f b6 c0             	movzbl %al,%eax
    3ac4:	29 c2                	sub    %eax,%edx
    3ac6:	89 d0                	mov    %edx,%eax
}
    3ac8:	5d                   	pop    %ebp
    3ac9:	c3                   	ret    

00003aca <strlen>:

uint
strlen(char *s)
{
    3aca:	f3 0f 1e fb          	endbr32 
    3ace:	55                   	push   %ebp
    3acf:	89 e5                	mov    %esp,%ebp
    3ad1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    3ad4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3adb:	eb 04                	jmp    3ae1 <strlen+0x17>
    3add:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3ae1:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3ae4:	8b 45 08             	mov    0x8(%ebp),%eax
    3ae7:	01 d0                	add    %edx,%eax
    3ae9:	0f b6 00             	movzbl (%eax),%eax
    3aec:	84 c0                	test   %al,%al
    3aee:	75 ed                	jne    3add <strlen+0x13>
    ;
  return n;
    3af0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3af3:	c9                   	leave  
    3af4:	c3                   	ret    

00003af5 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3af5:	f3 0f 1e fb          	endbr32 
    3af9:	55                   	push   %ebp
    3afa:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    3afc:	8b 45 10             	mov    0x10(%ebp),%eax
    3aff:	50                   	push   %eax
    3b00:	ff 75 0c             	pushl  0xc(%ebp)
    3b03:	ff 75 08             	pushl  0x8(%ebp)
    3b06:	e8 22 ff ff ff       	call   3a2d <stosb>
    3b0b:	83 c4 0c             	add    $0xc,%esp
  return dst;
    3b0e:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3b11:	c9                   	leave  
    3b12:	c3                   	ret    

00003b13 <strchr>:

char*
strchr(const char *s, char c)
{
    3b13:	f3 0f 1e fb          	endbr32 
    3b17:	55                   	push   %ebp
    3b18:	89 e5                	mov    %esp,%ebp
    3b1a:	83 ec 04             	sub    $0x4,%esp
    3b1d:	8b 45 0c             	mov    0xc(%ebp),%eax
    3b20:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    3b23:	eb 14                	jmp    3b39 <strchr+0x26>
    if(*s == c)
    3b25:	8b 45 08             	mov    0x8(%ebp),%eax
    3b28:	0f b6 00             	movzbl (%eax),%eax
    3b2b:	38 45 fc             	cmp    %al,-0x4(%ebp)
    3b2e:	75 05                	jne    3b35 <strchr+0x22>
      return (char*)s;
    3b30:	8b 45 08             	mov    0x8(%ebp),%eax
    3b33:	eb 13                	jmp    3b48 <strchr+0x35>
  for(; *s; s++)
    3b35:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3b39:	8b 45 08             	mov    0x8(%ebp),%eax
    3b3c:	0f b6 00             	movzbl (%eax),%eax
    3b3f:	84 c0                	test   %al,%al
    3b41:	75 e2                	jne    3b25 <strchr+0x12>
  return 0;
    3b43:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3b48:	c9                   	leave  
    3b49:	c3                   	ret    

00003b4a <gets>:

char*
gets(char *buf, int max)
{
    3b4a:	f3 0f 1e fb          	endbr32 
    3b4e:	55                   	push   %ebp
    3b4f:	89 e5                	mov    %esp,%ebp
    3b51:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3b54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3b5b:	eb 42                	jmp    3b9f <gets+0x55>
    cc = read(0, &c, 1);
    3b5d:	83 ec 04             	sub    $0x4,%esp
    3b60:	6a 01                	push   $0x1
    3b62:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3b65:	50                   	push   %eax
    3b66:	6a 00                	push   $0x0
    3b68:	e8 53 01 00 00       	call   3cc0 <read>
    3b6d:	83 c4 10             	add    $0x10,%esp
    3b70:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    3b73:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3b77:	7e 33                	jle    3bac <gets+0x62>
      break;
    buf[i++] = c;
    3b79:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b7c:	8d 50 01             	lea    0x1(%eax),%edx
    3b7f:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3b82:	89 c2                	mov    %eax,%edx
    3b84:	8b 45 08             	mov    0x8(%ebp),%eax
    3b87:	01 c2                	add    %eax,%edx
    3b89:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3b8d:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    3b8f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3b93:	3c 0a                	cmp    $0xa,%al
    3b95:	74 16                	je     3bad <gets+0x63>
    3b97:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3b9b:	3c 0d                	cmp    $0xd,%al
    3b9d:	74 0e                	je     3bad <gets+0x63>
  for(i=0; i+1 < max; ){
    3b9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ba2:	83 c0 01             	add    $0x1,%eax
    3ba5:	39 45 0c             	cmp    %eax,0xc(%ebp)
    3ba8:	7f b3                	jg     3b5d <gets+0x13>
    3baa:	eb 01                	jmp    3bad <gets+0x63>
      break;
    3bac:	90                   	nop
      break;
  }
  buf[i] = '\0';
    3bad:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3bb0:	8b 45 08             	mov    0x8(%ebp),%eax
    3bb3:	01 d0                	add    %edx,%eax
    3bb5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    3bb8:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3bbb:	c9                   	leave  
    3bbc:	c3                   	ret    

00003bbd <stat>:

int
stat(char *n, struct stat *st)
{
    3bbd:	f3 0f 1e fb          	endbr32 
    3bc1:	55                   	push   %ebp
    3bc2:	89 e5                	mov    %esp,%ebp
    3bc4:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3bc7:	83 ec 08             	sub    $0x8,%esp
    3bca:	6a 00                	push   $0x0
    3bcc:	ff 75 08             	pushl  0x8(%ebp)
    3bcf:	e8 14 01 00 00       	call   3ce8 <open>
    3bd4:	83 c4 10             	add    $0x10,%esp
    3bd7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    3bda:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3bde:	79 07                	jns    3be7 <stat+0x2a>
    return -1;
    3be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3be5:	eb 25                	jmp    3c0c <stat+0x4f>
  r = fstat(fd, st);
    3be7:	83 ec 08             	sub    $0x8,%esp
    3bea:	ff 75 0c             	pushl  0xc(%ebp)
    3bed:	ff 75 f4             	pushl  -0xc(%ebp)
    3bf0:	e8 0b 01 00 00       	call   3d00 <fstat>
    3bf5:	83 c4 10             	add    $0x10,%esp
    3bf8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    3bfb:	83 ec 0c             	sub    $0xc,%esp
    3bfe:	ff 75 f4             	pushl  -0xc(%ebp)
    3c01:	e8 ca 00 00 00       	call   3cd0 <close>
    3c06:	83 c4 10             	add    $0x10,%esp
  return r;
    3c09:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    3c0c:	c9                   	leave  
    3c0d:	c3                   	ret    

00003c0e <atoi>:

int
atoi(const char *s)
{
    3c0e:	f3 0f 1e fb          	endbr32 
    3c12:	55                   	push   %ebp
    3c13:	89 e5                	mov    %esp,%ebp
    3c15:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3c18:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3c1f:	eb 25                	jmp    3c46 <atoi+0x38>
    n = n*10 + *s++ - '0';
    3c21:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3c24:	89 d0                	mov    %edx,%eax
    3c26:	c1 e0 02             	shl    $0x2,%eax
    3c29:	01 d0                	add    %edx,%eax
    3c2b:	01 c0                	add    %eax,%eax
    3c2d:	89 c1                	mov    %eax,%ecx
    3c2f:	8b 45 08             	mov    0x8(%ebp),%eax
    3c32:	8d 50 01             	lea    0x1(%eax),%edx
    3c35:	89 55 08             	mov    %edx,0x8(%ebp)
    3c38:	0f b6 00             	movzbl (%eax),%eax
    3c3b:	0f be c0             	movsbl %al,%eax
    3c3e:	01 c8                	add    %ecx,%eax
    3c40:	83 e8 30             	sub    $0x30,%eax
    3c43:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3c46:	8b 45 08             	mov    0x8(%ebp),%eax
    3c49:	0f b6 00             	movzbl (%eax),%eax
    3c4c:	3c 2f                	cmp    $0x2f,%al
    3c4e:	7e 0a                	jle    3c5a <atoi+0x4c>
    3c50:	8b 45 08             	mov    0x8(%ebp),%eax
    3c53:	0f b6 00             	movzbl (%eax),%eax
    3c56:	3c 39                	cmp    $0x39,%al
    3c58:	7e c7                	jle    3c21 <atoi+0x13>
  return n;
    3c5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3c5d:	c9                   	leave  
    3c5e:	c3                   	ret    

00003c5f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3c5f:	f3 0f 1e fb          	endbr32 
    3c63:	55                   	push   %ebp
    3c64:	89 e5                	mov    %esp,%ebp
    3c66:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    3c69:	8b 45 08             	mov    0x8(%ebp),%eax
    3c6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    3c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3c72:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    3c75:	eb 17                	jmp    3c8e <memmove+0x2f>
    *dst++ = *src++;
    3c77:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3c7a:	8d 42 01             	lea    0x1(%edx),%eax
    3c7d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    3c80:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3c83:	8d 48 01             	lea    0x1(%eax),%ecx
    3c86:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    3c89:	0f b6 12             	movzbl (%edx),%edx
    3c8c:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    3c8e:	8b 45 10             	mov    0x10(%ebp),%eax
    3c91:	8d 50 ff             	lea    -0x1(%eax),%edx
    3c94:	89 55 10             	mov    %edx,0x10(%ebp)
    3c97:	85 c0                	test   %eax,%eax
    3c99:	7f dc                	jg     3c77 <memmove+0x18>
  return vdst;
    3c9b:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3c9e:	c9                   	leave  
    3c9f:	c3                   	ret    

00003ca0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3ca0:	b8 01 00 00 00       	mov    $0x1,%eax
    3ca5:	cd 40                	int    $0x40
    3ca7:	c3                   	ret    

00003ca8 <exit>:
SYSCALL(exit)
    3ca8:	b8 02 00 00 00       	mov    $0x2,%eax
    3cad:	cd 40                	int    $0x40
    3caf:	c3                   	ret    

00003cb0 <wait>:
SYSCALL(wait)
    3cb0:	b8 03 00 00 00       	mov    $0x3,%eax
    3cb5:	cd 40                	int    $0x40
    3cb7:	c3                   	ret    

00003cb8 <pipe>:
SYSCALL(pipe)
    3cb8:	b8 04 00 00 00       	mov    $0x4,%eax
    3cbd:	cd 40                	int    $0x40
    3cbf:	c3                   	ret    

00003cc0 <read>:
SYSCALL(read)
    3cc0:	b8 05 00 00 00       	mov    $0x5,%eax
    3cc5:	cd 40                	int    $0x40
    3cc7:	c3                   	ret    

00003cc8 <write>:
SYSCALL(write)
    3cc8:	b8 10 00 00 00       	mov    $0x10,%eax
    3ccd:	cd 40                	int    $0x40
    3ccf:	c3                   	ret    

00003cd0 <close>:
SYSCALL(close)
    3cd0:	b8 15 00 00 00       	mov    $0x15,%eax
    3cd5:	cd 40                	int    $0x40
    3cd7:	c3                   	ret    

00003cd8 <kill>:
SYSCALL(kill)
    3cd8:	b8 06 00 00 00       	mov    $0x6,%eax
    3cdd:	cd 40                	int    $0x40
    3cdf:	c3                   	ret    

00003ce0 <exec>:
SYSCALL(exec)
    3ce0:	b8 07 00 00 00       	mov    $0x7,%eax
    3ce5:	cd 40                	int    $0x40
    3ce7:	c3                   	ret    

00003ce8 <open>:
SYSCALL(open)
    3ce8:	b8 0f 00 00 00       	mov    $0xf,%eax
    3ced:	cd 40                	int    $0x40
    3cef:	c3                   	ret    

00003cf0 <mknod>:
SYSCALL(mknod)
    3cf0:	b8 11 00 00 00       	mov    $0x11,%eax
    3cf5:	cd 40                	int    $0x40
    3cf7:	c3                   	ret    

00003cf8 <unlink>:
SYSCALL(unlink)
    3cf8:	b8 12 00 00 00       	mov    $0x12,%eax
    3cfd:	cd 40                	int    $0x40
    3cff:	c3                   	ret    

00003d00 <fstat>:
SYSCALL(fstat)
    3d00:	b8 08 00 00 00       	mov    $0x8,%eax
    3d05:	cd 40                	int    $0x40
    3d07:	c3                   	ret    

00003d08 <link>:
SYSCALL(link)
    3d08:	b8 13 00 00 00       	mov    $0x13,%eax
    3d0d:	cd 40                	int    $0x40
    3d0f:	c3                   	ret    

00003d10 <mkdir>:
SYSCALL(mkdir)
    3d10:	b8 14 00 00 00       	mov    $0x14,%eax
    3d15:	cd 40                	int    $0x40
    3d17:	c3                   	ret    

00003d18 <chdir>:
SYSCALL(chdir)
    3d18:	b8 09 00 00 00       	mov    $0x9,%eax
    3d1d:	cd 40                	int    $0x40
    3d1f:	c3                   	ret    

00003d20 <dup>:
SYSCALL(dup)
    3d20:	b8 0a 00 00 00       	mov    $0xa,%eax
    3d25:	cd 40                	int    $0x40
    3d27:	c3                   	ret    

00003d28 <getpid>:
SYSCALL(getpid)
    3d28:	b8 0b 00 00 00       	mov    $0xb,%eax
    3d2d:	cd 40                	int    $0x40
    3d2f:	c3                   	ret    

00003d30 <sbrk>:
SYSCALL(sbrk)
    3d30:	b8 0c 00 00 00       	mov    $0xc,%eax
    3d35:	cd 40                	int    $0x40
    3d37:	c3                   	ret    

00003d38 <sleep>:
SYSCALL(sleep)
    3d38:	b8 0d 00 00 00       	mov    $0xd,%eax
    3d3d:	cd 40                	int    $0x40
    3d3f:	c3                   	ret    

00003d40 <uptime>:
SYSCALL(uptime)
    3d40:	b8 0e 00 00 00       	mov    $0xe,%eax
    3d45:	cd 40                	int    $0x40
    3d47:	c3                   	ret    

00003d48 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    3d48:	f3 0f 1e fb          	endbr32 
    3d4c:	55                   	push   %ebp
    3d4d:	89 e5                	mov    %esp,%ebp
    3d4f:	83 ec 18             	sub    $0x18,%esp
    3d52:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d55:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    3d58:	83 ec 04             	sub    $0x4,%esp
    3d5b:	6a 01                	push   $0x1
    3d5d:	8d 45 f4             	lea    -0xc(%ebp),%eax
    3d60:	50                   	push   %eax
    3d61:	ff 75 08             	pushl  0x8(%ebp)
    3d64:	e8 5f ff ff ff       	call   3cc8 <write>
    3d69:	83 c4 10             	add    $0x10,%esp
}
    3d6c:	90                   	nop
    3d6d:	c9                   	leave  
    3d6e:	c3                   	ret    

00003d6f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3d6f:	f3 0f 1e fb          	endbr32 
    3d73:	55                   	push   %ebp
    3d74:	89 e5                	mov    %esp,%ebp
    3d76:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3d79:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    3d80:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    3d84:	74 17                	je     3d9d <printint+0x2e>
    3d86:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3d8a:	79 11                	jns    3d9d <printint+0x2e>
    neg = 1;
    3d8c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    3d93:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d96:	f7 d8                	neg    %eax
    3d98:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3d9b:	eb 06                	jmp    3da3 <printint+0x34>
  } else {
    x = xx;
    3d9d:	8b 45 0c             	mov    0xc(%ebp),%eax
    3da0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    3da3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    3daa:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3dad:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3db0:	ba 00 00 00 00       	mov    $0x0,%edx
    3db5:	f7 f1                	div    %ecx
    3db7:	89 d1                	mov    %edx,%ecx
    3db9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3dbc:	8d 50 01             	lea    0x1(%eax),%edx
    3dbf:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3dc2:	0f b6 91 40 5f 00 00 	movzbl 0x5f40(%ecx),%edx
    3dc9:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    3dcd:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3dd0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3dd3:	ba 00 00 00 00       	mov    $0x0,%edx
    3dd8:	f7 f1                	div    %ecx
    3dda:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3ddd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3de1:	75 c7                	jne    3daa <printint+0x3b>
  if(neg)
    3de3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3de7:	74 2d                	je     3e16 <printint+0xa7>
    buf[i++] = '-';
    3de9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3dec:	8d 50 01             	lea    0x1(%eax),%edx
    3def:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3df2:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    3df7:	eb 1d                	jmp    3e16 <printint+0xa7>
    putc(fd, buf[i]);
    3df9:	8d 55 dc             	lea    -0x24(%ebp),%edx
    3dfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3dff:	01 d0                	add    %edx,%eax
    3e01:	0f b6 00             	movzbl (%eax),%eax
    3e04:	0f be c0             	movsbl %al,%eax
    3e07:	83 ec 08             	sub    $0x8,%esp
    3e0a:	50                   	push   %eax
    3e0b:	ff 75 08             	pushl  0x8(%ebp)
    3e0e:	e8 35 ff ff ff       	call   3d48 <putc>
    3e13:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    3e16:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    3e1a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3e1e:	79 d9                	jns    3df9 <printint+0x8a>
}
    3e20:	90                   	nop
    3e21:	90                   	nop
    3e22:	c9                   	leave  
    3e23:	c3                   	ret    

00003e24 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3e24:	f3 0f 1e fb          	endbr32 
    3e28:	55                   	push   %ebp
    3e29:	89 e5                	mov    %esp,%ebp
    3e2b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    3e2e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    3e35:	8d 45 0c             	lea    0xc(%ebp),%eax
    3e38:	83 c0 04             	add    $0x4,%eax
    3e3b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    3e3e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3e45:	e9 59 01 00 00       	jmp    3fa3 <printf+0x17f>
    c = fmt[i] & 0xff;
    3e4a:	8b 55 0c             	mov    0xc(%ebp),%edx
    3e4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3e50:	01 d0                	add    %edx,%eax
    3e52:	0f b6 00             	movzbl (%eax),%eax
    3e55:	0f be c0             	movsbl %al,%eax
    3e58:	25 ff 00 00 00       	and    $0xff,%eax
    3e5d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    3e60:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3e64:	75 2c                	jne    3e92 <printf+0x6e>
      if(c == '%'){
    3e66:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    3e6a:	75 0c                	jne    3e78 <printf+0x54>
        state = '%';
    3e6c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    3e73:	e9 27 01 00 00       	jmp    3f9f <printf+0x17b>
      } else {
        putc(fd, c);
    3e78:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3e7b:	0f be c0             	movsbl %al,%eax
    3e7e:	83 ec 08             	sub    $0x8,%esp
    3e81:	50                   	push   %eax
    3e82:	ff 75 08             	pushl  0x8(%ebp)
    3e85:	e8 be fe ff ff       	call   3d48 <putc>
    3e8a:	83 c4 10             	add    $0x10,%esp
    3e8d:	e9 0d 01 00 00       	jmp    3f9f <printf+0x17b>
      }
    } else if(state == '%'){
    3e92:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    3e96:	0f 85 03 01 00 00    	jne    3f9f <printf+0x17b>
      if(c == 'd'){
    3e9c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    3ea0:	75 1e                	jne    3ec0 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    3ea2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3ea5:	8b 00                	mov    (%eax),%eax
    3ea7:	6a 01                	push   $0x1
    3ea9:	6a 0a                	push   $0xa
    3eab:	50                   	push   %eax
    3eac:	ff 75 08             	pushl  0x8(%ebp)
    3eaf:	e8 bb fe ff ff       	call   3d6f <printint>
    3eb4:	83 c4 10             	add    $0x10,%esp
        ap++;
    3eb7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3ebb:	e9 d8 00 00 00       	jmp    3f98 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    3ec0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    3ec4:	74 06                	je     3ecc <printf+0xa8>
    3ec6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    3eca:	75 1e                	jne    3eea <printf+0xc6>
        printint(fd, *ap, 16, 0);
    3ecc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3ecf:	8b 00                	mov    (%eax),%eax
    3ed1:	6a 00                	push   $0x0
    3ed3:	6a 10                	push   $0x10
    3ed5:	50                   	push   %eax
    3ed6:	ff 75 08             	pushl  0x8(%ebp)
    3ed9:	e8 91 fe ff ff       	call   3d6f <printint>
    3ede:	83 c4 10             	add    $0x10,%esp
        ap++;
    3ee1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3ee5:	e9 ae 00 00 00       	jmp    3f98 <printf+0x174>
      } else if(c == 's'){
    3eea:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    3eee:	75 43                	jne    3f33 <printf+0x10f>
        s = (char*)*ap;
    3ef0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3ef3:	8b 00                	mov    (%eax),%eax
    3ef5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    3ef8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    3efc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3f00:	75 25                	jne    3f27 <printf+0x103>
          s = "(null)";
    3f02:	c7 45 f4 ae 58 00 00 	movl   $0x58ae,-0xc(%ebp)
        while(*s != 0){
    3f09:	eb 1c                	jmp    3f27 <printf+0x103>
          putc(fd, *s);
    3f0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3f0e:	0f b6 00             	movzbl (%eax),%eax
    3f11:	0f be c0             	movsbl %al,%eax
    3f14:	83 ec 08             	sub    $0x8,%esp
    3f17:	50                   	push   %eax
    3f18:	ff 75 08             	pushl  0x8(%ebp)
    3f1b:	e8 28 fe ff ff       	call   3d48 <putc>
    3f20:	83 c4 10             	add    $0x10,%esp
          s++;
    3f23:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    3f27:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3f2a:	0f b6 00             	movzbl (%eax),%eax
    3f2d:	84 c0                	test   %al,%al
    3f2f:	75 da                	jne    3f0b <printf+0xe7>
    3f31:	eb 65                	jmp    3f98 <printf+0x174>
        }
      } else if(c == 'c'){
    3f33:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    3f37:	75 1d                	jne    3f56 <printf+0x132>
        putc(fd, *ap);
    3f39:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3f3c:	8b 00                	mov    (%eax),%eax
    3f3e:	0f be c0             	movsbl %al,%eax
    3f41:	83 ec 08             	sub    $0x8,%esp
    3f44:	50                   	push   %eax
    3f45:	ff 75 08             	pushl  0x8(%ebp)
    3f48:	e8 fb fd ff ff       	call   3d48 <putc>
    3f4d:	83 c4 10             	add    $0x10,%esp
        ap++;
    3f50:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3f54:	eb 42                	jmp    3f98 <printf+0x174>
      } else if(c == '%'){
    3f56:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    3f5a:	75 17                	jne    3f73 <printf+0x14f>
        putc(fd, c);
    3f5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3f5f:	0f be c0             	movsbl %al,%eax
    3f62:	83 ec 08             	sub    $0x8,%esp
    3f65:	50                   	push   %eax
    3f66:	ff 75 08             	pushl  0x8(%ebp)
    3f69:	e8 da fd ff ff       	call   3d48 <putc>
    3f6e:	83 c4 10             	add    $0x10,%esp
    3f71:	eb 25                	jmp    3f98 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3f73:	83 ec 08             	sub    $0x8,%esp
    3f76:	6a 25                	push   $0x25
    3f78:	ff 75 08             	pushl  0x8(%ebp)
    3f7b:	e8 c8 fd ff ff       	call   3d48 <putc>
    3f80:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    3f83:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3f86:	0f be c0             	movsbl %al,%eax
    3f89:	83 ec 08             	sub    $0x8,%esp
    3f8c:	50                   	push   %eax
    3f8d:	ff 75 08             	pushl  0x8(%ebp)
    3f90:	e8 b3 fd ff ff       	call   3d48 <putc>
    3f95:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    3f98:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    3f9f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3fa3:	8b 55 0c             	mov    0xc(%ebp),%edx
    3fa6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3fa9:	01 d0                	add    %edx,%eax
    3fab:	0f b6 00             	movzbl (%eax),%eax
    3fae:	84 c0                	test   %al,%al
    3fb0:	0f 85 94 fe ff ff    	jne    3e4a <printf+0x26>
    }
  }
}
    3fb6:	90                   	nop
    3fb7:	90                   	nop
    3fb8:	c9                   	leave  
    3fb9:	c3                   	ret    

00003fba <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3fba:	f3 0f 1e fb          	endbr32 
    3fbe:	55                   	push   %ebp
    3fbf:	89 e5                	mov    %esp,%ebp
    3fc1:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3fc4:	8b 45 08             	mov    0x8(%ebp),%eax
    3fc7:	83 e8 08             	sub    $0x8,%eax
    3fca:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3fcd:	a1 e8 5f 00 00       	mov    0x5fe8,%eax
    3fd2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3fd5:	eb 24                	jmp    3ffb <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3fd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fda:	8b 00                	mov    (%eax),%eax
    3fdc:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    3fdf:	72 12                	jb     3ff3 <free+0x39>
    3fe1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fe4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3fe7:	77 24                	ja     400d <free+0x53>
    3fe9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fec:	8b 00                	mov    (%eax),%eax
    3fee:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    3ff1:	72 1a                	jb     400d <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3ff3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3ff6:	8b 00                	mov    (%eax),%eax
    3ff8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3ffb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3ffe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4001:	76 d4                	jbe    3fd7 <free+0x1d>
    4003:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4006:	8b 00                	mov    (%eax),%eax
    4008:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    400b:	73 ca                	jae    3fd7 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    400d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4010:	8b 40 04             	mov    0x4(%eax),%eax
    4013:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    401a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    401d:	01 c2                	add    %eax,%edx
    401f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4022:	8b 00                	mov    (%eax),%eax
    4024:	39 c2                	cmp    %eax,%edx
    4026:	75 24                	jne    404c <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    4028:	8b 45 f8             	mov    -0x8(%ebp),%eax
    402b:	8b 50 04             	mov    0x4(%eax),%edx
    402e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4031:	8b 00                	mov    (%eax),%eax
    4033:	8b 40 04             	mov    0x4(%eax),%eax
    4036:	01 c2                	add    %eax,%edx
    4038:	8b 45 f8             	mov    -0x8(%ebp),%eax
    403b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    403e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4041:	8b 00                	mov    (%eax),%eax
    4043:	8b 10                	mov    (%eax),%edx
    4045:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4048:	89 10                	mov    %edx,(%eax)
    404a:	eb 0a                	jmp    4056 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    404c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    404f:	8b 10                	mov    (%eax),%edx
    4051:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4054:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    4056:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4059:	8b 40 04             	mov    0x4(%eax),%eax
    405c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4063:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4066:	01 d0                	add    %edx,%eax
    4068:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    406b:	75 20                	jne    408d <free+0xd3>
    p->s.size += bp->s.size;
    406d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4070:	8b 50 04             	mov    0x4(%eax),%edx
    4073:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4076:	8b 40 04             	mov    0x4(%eax),%eax
    4079:	01 c2                	add    %eax,%edx
    407b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    407e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4081:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4084:	8b 10                	mov    (%eax),%edx
    4086:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4089:	89 10                	mov    %edx,(%eax)
    408b:	eb 08                	jmp    4095 <free+0xdb>
  } else
    p->s.ptr = bp;
    408d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4090:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4093:	89 10                	mov    %edx,(%eax)
  freep = p;
    4095:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4098:	a3 e8 5f 00 00       	mov    %eax,0x5fe8
}
    409d:	90                   	nop
    409e:	c9                   	leave  
    409f:	c3                   	ret    

000040a0 <morecore>:

static Header*
morecore(uint nu)
{
    40a0:	f3 0f 1e fb          	endbr32 
    40a4:	55                   	push   %ebp
    40a5:	89 e5                	mov    %esp,%ebp
    40a7:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    40aa:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    40b1:	77 07                	ja     40ba <morecore+0x1a>
    nu = 4096;
    40b3:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    40ba:	8b 45 08             	mov    0x8(%ebp),%eax
    40bd:	c1 e0 03             	shl    $0x3,%eax
    40c0:	83 ec 0c             	sub    $0xc,%esp
    40c3:	50                   	push   %eax
    40c4:	e8 67 fc ff ff       	call   3d30 <sbrk>
    40c9:	83 c4 10             	add    $0x10,%esp
    40cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    40cf:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    40d3:	75 07                	jne    40dc <morecore+0x3c>
    return 0;
    40d5:	b8 00 00 00 00       	mov    $0x0,%eax
    40da:	eb 26                	jmp    4102 <morecore+0x62>
  hp = (Header*)p;
    40dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    40e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40e5:	8b 55 08             	mov    0x8(%ebp),%edx
    40e8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    40eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40ee:	83 c0 08             	add    $0x8,%eax
    40f1:	83 ec 0c             	sub    $0xc,%esp
    40f4:	50                   	push   %eax
    40f5:	e8 c0 fe ff ff       	call   3fba <free>
    40fa:	83 c4 10             	add    $0x10,%esp
  return freep;
    40fd:	a1 e8 5f 00 00       	mov    0x5fe8,%eax
}
    4102:	c9                   	leave  
    4103:	c3                   	ret    

00004104 <malloc>:

void*
malloc(uint nbytes)
{
    4104:	f3 0f 1e fb          	endbr32 
    4108:	55                   	push   %ebp
    4109:	89 e5                	mov    %esp,%ebp
    410b:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    410e:	8b 45 08             	mov    0x8(%ebp),%eax
    4111:	83 c0 07             	add    $0x7,%eax
    4114:	c1 e8 03             	shr    $0x3,%eax
    4117:	83 c0 01             	add    $0x1,%eax
    411a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    411d:	a1 e8 5f 00 00       	mov    0x5fe8,%eax
    4122:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4125:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4129:	75 23                	jne    414e <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    412b:	c7 45 f0 e0 5f 00 00 	movl   $0x5fe0,-0x10(%ebp)
    4132:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4135:	a3 e8 5f 00 00       	mov    %eax,0x5fe8
    413a:	a1 e8 5f 00 00       	mov    0x5fe8,%eax
    413f:	a3 e0 5f 00 00       	mov    %eax,0x5fe0
    base.s.size = 0;
    4144:	c7 05 e4 5f 00 00 00 	movl   $0x0,0x5fe4
    414b:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    414e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4151:	8b 00                	mov    (%eax),%eax
    4153:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4156:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4159:	8b 40 04             	mov    0x4(%eax),%eax
    415c:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    415f:	77 4d                	ja     41ae <malloc+0xaa>
      if(p->s.size == nunits)
    4161:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4164:	8b 40 04             	mov    0x4(%eax),%eax
    4167:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    416a:	75 0c                	jne    4178 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    416c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    416f:	8b 10                	mov    (%eax),%edx
    4171:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4174:	89 10                	mov    %edx,(%eax)
    4176:	eb 26                	jmp    419e <malloc+0x9a>
      else {
        p->s.size -= nunits;
    4178:	8b 45 f4             	mov    -0xc(%ebp),%eax
    417b:	8b 40 04             	mov    0x4(%eax),%eax
    417e:	2b 45 ec             	sub    -0x14(%ebp),%eax
    4181:	89 c2                	mov    %eax,%edx
    4183:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4186:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    4189:	8b 45 f4             	mov    -0xc(%ebp),%eax
    418c:	8b 40 04             	mov    0x4(%eax),%eax
    418f:	c1 e0 03             	shl    $0x3,%eax
    4192:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    4195:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4198:	8b 55 ec             	mov    -0x14(%ebp),%edx
    419b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    419e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    41a1:	a3 e8 5f 00 00       	mov    %eax,0x5fe8
      return (void*)(p + 1);
    41a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41a9:	83 c0 08             	add    $0x8,%eax
    41ac:	eb 3b                	jmp    41e9 <malloc+0xe5>
    }
    if(p == freep)
    41ae:	a1 e8 5f 00 00       	mov    0x5fe8,%eax
    41b3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    41b6:	75 1e                	jne    41d6 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    41b8:	83 ec 0c             	sub    $0xc,%esp
    41bb:	ff 75 ec             	pushl  -0x14(%ebp)
    41be:	e8 dd fe ff ff       	call   40a0 <morecore>
    41c3:	83 c4 10             	add    $0x10,%esp
    41c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    41c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    41cd:	75 07                	jne    41d6 <malloc+0xd2>
        return 0;
    41cf:	b8 00 00 00 00       	mov    $0x0,%eax
    41d4:	eb 13                	jmp    41e9 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    41d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    41dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41df:	8b 00                	mov    (%eax),%eax
    41e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    41e4:	e9 6d ff ff ff       	jmp    4156 <malloc+0x52>
  }
}
    41e9:	c9                   	leave  
    41ea:	c3                   	ret    
