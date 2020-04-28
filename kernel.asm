
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 50 c6 10 80       	mov    $0x8010c650,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 d5 35 10 80       	mov    $0x801035d5,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	f3 0f 1e fb          	endbr32 
80100038:	55                   	push   %ebp
80100039:	89 e5                	mov    %esp,%ebp
8010003b:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003e:	83 ec 08             	sub    $0x8,%esp
80100041:	68 a8 83 10 80       	push   $0x801083a8
80100046:	68 60 c6 10 80       	push   $0x8010c660
8010004b:	e8 36 4d 00 00       	call   80104d86 <initlock>
80100050:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100053:	c7 05 90 db 10 80 84 	movl   $0x8010db84,0x8010db90
8010005a:	db 10 80 
  bcache.head.next = &bcache.head;
8010005d:	c7 05 94 db 10 80 84 	movl   $0x8010db84,0x8010db94
80100064:	db 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100067:	c7 45 f4 94 c6 10 80 	movl   $0x8010c694,-0xc(%ebp)
8010006e:	eb 3a                	jmp    801000aa <binit+0x76>
    b->next = bcache.head.next;
80100070:	8b 15 94 db 10 80    	mov    0x8010db94,%edx
80100076:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100079:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
8010007c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007f:	c7 40 0c 84 db 10 80 	movl   $0x8010db84,0xc(%eax)
    b->dev = -1;
80100086:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100089:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
80100090:	a1 94 db 10 80       	mov    0x8010db94,%eax
80100095:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100098:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
8010009b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009e:	a3 94 db 10 80       	mov    %eax,0x8010db94
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a3:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000aa:	b8 84 db 10 80       	mov    $0x8010db84,%eax
801000af:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000b2:	72 bc                	jb     80100070 <binit+0x3c>
  }
}
801000b4:	90                   	nop
801000b5:	90                   	nop
801000b6:	c9                   	leave  
801000b7:	c3                   	ret    

801000b8 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b8:	f3 0f 1e fb          	endbr32 
801000bc:	55                   	push   %ebp
801000bd:	89 e5                	mov    %esp,%ebp
801000bf:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000c2:	83 ec 0c             	sub    $0xc,%esp
801000c5:	68 60 c6 10 80       	push   $0x8010c660
801000ca:	e8 dd 4c 00 00       	call   80104dac <acquire>
801000cf:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000d2:	a1 94 db 10 80       	mov    0x8010db94,%eax
801000d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000da:	eb 67                	jmp    80100143 <bget+0x8b>
    if(b->dev == dev && b->sector == sector){
801000dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000df:	8b 40 04             	mov    0x4(%eax),%eax
801000e2:	39 45 08             	cmp    %eax,0x8(%ebp)
801000e5:	75 53                	jne    8010013a <bget+0x82>
801000e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ea:	8b 40 08             	mov    0x8(%eax),%eax
801000ed:	39 45 0c             	cmp    %eax,0xc(%ebp)
801000f0:	75 48                	jne    8010013a <bget+0x82>
      if(!(b->flags & B_BUSY)){
801000f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f5:	8b 00                	mov    (%eax),%eax
801000f7:	83 e0 01             	and    $0x1,%eax
801000fa:	85 c0                	test   %eax,%eax
801000fc:	75 27                	jne    80100125 <bget+0x6d>
        b->flags |= B_BUSY;
801000fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100101:	8b 00                	mov    (%eax),%eax
80100103:	83 c8 01             	or     $0x1,%eax
80100106:	89 c2                	mov    %eax,%edx
80100108:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010b:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
8010010d:	83 ec 0c             	sub    $0xc,%esp
80100110:	68 60 c6 10 80       	push   $0x8010c660
80100115:	e8 fd 4c 00 00       	call   80104e17 <release>
8010011a:	83 c4 10             	add    $0x10,%esp
        return b;
8010011d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100120:	e9 98 00 00 00       	jmp    801001bd <bget+0x105>
      }
      sleep(b, &bcache.lock);
80100125:	83 ec 08             	sub    $0x8,%esp
80100128:	68 60 c6 10 80       	push   $0x8010c660
8010012d:	ff 75 f4             	pushl  -0xc(%ebp)
80100130:	e8 64 49 00 00       	call   80104a99 <sleep>
80100135:	83 c4 10             	add    $0x10,%esp
      goto loop;
80100138:	eb 98                	jmp    801000d2 <bget+0x1a>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010013a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010013d:	8b 40 10             	mov    0x10(%eax),%eax
80100140:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100143:	81 7d f4 84 db 10 80 	cmpl   $0x8010db84,-0xc(%ebp)
8010014a:	75 90                	jne    801000dc <bget+0x24>
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
8010014c:	a1 90 db 10 80       	mov    0x8010db90,%eax
80100151:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100154:	eb 51                	jmp    801001a7 <bget+0xef>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
80100156:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100159:	8b 00                	mov    (%eax),%eax
8010015b:	83 e0 01             	and    $0x1,%eax
8010015e:	85 c0                	test   %eax,%eax
80100160:	75 3c                	jne    8010019e <bget+0xe6>
80100162:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100165:	8b 00                	mov    (%eax),%eax
80100167:	83 e0 04             	and    $0x4,%eax
8010016a:	85 c0                	test   %eax,%eax
8010016c:	75 30                	jne    8010019e <bget+0xe6>
      b->dev = dev;
8010016e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100171:	8b 55 08             	mov    0x8(%ebp),%edx
80100174:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
80100177:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010017d:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100180:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100183:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100189:	83 ec 0c             	sub    $0xc,%esp
8010018c:	68 60 c6 10 80       	push   $0x8010c660
80100191:	e8 81 4c 00 00       	call   80104e17 <release>
80100196:	83 c4 10             	add    $0x10,%esp
      return b;
80100199:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010019c:	eb 1f                	jmp    801001bd <bget+0x105>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
8010019e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001a1:	8b 40 0c             	mov    0xc(%eax),%eax
801001a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001a7:	81 7d f4 84 db 10 80 	cmpl   $0x8010db84,-0xc(%ebp)
801001ae:	75 a6                	jne    80100156 <bget+0x9e>
    }
  }
  panic("bget: no buffers");
801001b0:	83 ec 0c             	sub    $0xc,%esp
801001b3:	68 af 83 10 80       	push   $0x801083af
801001b8:	e8 da 03 00 00       	call   80100597 <panic>
}
801001bd:	c9                   	leave  
801001be:	c3                   	ret    

801001bf <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001bf:	f3 0f 1e fb          	endbr32 
801001c3:	55                   	push   %ebp
801001c4:	89 e5                	mov    %esp,%ebp
801001c6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, sector);
801001c9:	83 ec 08             	sub    $0x8,%esp
801001cc:	ff 75 0c             	pushl  0xc(%ebp)
801001cf:	ff 75 08             	pushl  0x8(%ebp)
801001d2:	e8 e1 fe ff ff       	call   801000b8 <bget>
801001d7:	83 c4 10             	add    $0x10,%esp
801001da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001e0:	8b 00                	mov    (%eax),%eax
801001e2:	83 e0 02             	and    $0x2,%eax
801001e5:	85 c0                	test   %eax,%eax
801001e7:	75 0e                	jne    801001f7 <bread+0x38>
    iderw(b);
801001e9:	83 ec 0c             	sub    $0xc,%esp
801001ec:	ff 75 f4             	pushl  -0xc(%ebp)
801001ef:	e8 4c 27 00 00       	call   80102940 <iderw>
801001f4:	83 c4 10             	add    $0x10,%esp
  return b;
801001f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001fa:	c9                   	leave  
801001fb:	c3                   	ret    

801001fc <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001fc:	f3 0f 1e fb          	endbr32 
80100200:	55                   	push   %ebp
80100201:	89 e5                	mov    %esp,%ebp
80100203:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100206:	8b 45 08             	mov    0x8(%ebp),%eax
80100209:	8b 00                	mov    (%eax),%eax
8010020b:	83 e0 01             	and    $0x1,%eax
8010020e:	85 c0                	test   %eax,%eax
80100210:	75 0d                	jne    8010021f <bwrite+0x23>
    panic("bwrite");
80100212:	83 ec 0c             	sub    $0xc,%esp
80100215:	68 c0 83 10 80       	push   $0x801083c0
8010021a:	e8 78 03 00 00       	call   80100597 <panic>
  b->flags |= B_DIRTY;
8010021f:	8b 45 08             	mov    0x8(%ebp),%eax
80100222:	8b 00                	mov    (%eax),%eax
80100224:	83 c8 04             	or     $0x4,%eax
80100227:	89 c2                	mov    %eax,%edx
80100229:	8b 45 08             	mov    0x8(%ebp),%eax
8010022c:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010022e:	83 ec 0c             	sub    $0xc,%esp
80100231:	ff 75 08             	pushl  0x8(%ebp)
80100234:	e8 07 27 00 00       	call   80102940 <iderw>
80100239:	83 c4 10             	add    $0x10,%esp
}
8010023c:	90                   	nop
8010023d:	c9                   	leave  
8010023e:	c3                   	ret    

8010023f <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010023f:	f3 0f 1e fb          	endbr32 
80100243:	55                   	push   %ebp
80100244:	89 e5                	mov    %esp,%ebp
80100246:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100249:	8b 45 08             	mov    0x8(%ebp),%eax
8010024c:	8b 00                	mov    (%eax),%eax
8010024e:	83 e0 01             	and    $0x1,%eax
80100251:	85 c0                	test   %eax,%eax
80100253:	75 0d                	jne    80100262 <brelse+0x23>
    panic("brelse");
80100255:	83 ec 0c             	sub    $0xc,%esp
80100258:	68 c7 83 10 80       	push   $0x801083c7
8010025d:	e8 35 03 00 00       	call   80100597 <panic>

  acquire(&bcache.lock);
80100262:	83 ec 0c             	sub    $0xc,%esp
80100265:	68 60 c6 10 80       	push   $0x8010c660
8010026a:	e8 3d 4b 00 00       	call   80104dac <acquire>
8010026f:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
80100272:	8b 45 08             	mov    0x8(%ebp),%eax
80100275:	8b 40 10             	mov    0x10(%eax),%eax
80100278:	8b 55 08             	mov    0x8(%ebp),%edx
8010027b:	8b 52 0c             	mov    0xc(%edx),%edx
8010027e:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100281:	8b 45 08             	mov    0x8(%ebp),%eax
80100284:	8b 40 0c             	mov    0xc(%eax),%eax
80100287:	8b 55 08             	mov    0x8(%ebp),%edx
8010028a:	8b 52 10             	mov    0x10(%edx),%edx
8010028d:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
80100290:	8b 15 94 db 10 80    	mov    0x8010db94,%edx
80100296:	8b 45 08             	mov    0x8(%ebp),%eax
80100299:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
8010029c:	8b 45 08             	mov    0x8(%ebp),%eax
8010029f:	c7 40 0c 84 db 10 80 	movl   $0x8010db84,0xc(%eax)
  bcache.head.next->prev = b;
801002a6:	a1 94 db 10 80       	mov    0x8010db94,%eax
801002ab:	8b 55 08             	mov    0x8(%ebp),%edx
801002ae:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
801002b1:	8b 45 08             	mov    0x8(%ebp),%eax
801002b4:	a3 94 db 10 80       	mov    %eax,0x8010db94

  b->flags &= ~B_BUSY;
801002b9:	8b 45 08             	mov    0x8(%ebp),%eax
801002bc:	8b 00                	mov    (%eax),%eax
801002be:	83 e0 fe             	and    $0xfffffffe,%eax
801002c1:	89 c2                	mov    %eax,%edx
801002c3:	8b 45 08             	mov    0x8(%ebp),%eax
801002c6:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801002c8:	83 ec 0c             	sub    $0xc,%esp
801002cb:	ff 75 08             	pushl  0x8(%ebp)
801002ce:	e8 ba 48 00 00       	call   80104b8d <wakeup>
801002d3:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002d6:	83 ec 0c             	sub    $0xc,%esp
801002d9:	68 60 c6 10 80       	push   $0x8010c660
801002de:	e8 34 4b 00 00       	call   80104e17 <release>
801002e3:	83 c4 10             	add    $0x10,%esp
}
801002e6:	90                   	nop
801002e7:	c9                   	leave  
801002e8:	c3                   	ret    

801002e9 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002e9:	55                   	push   %ebp
801002ea:	89 e5                	mov    %esp,%ebp
801002ec:	83 ec 14             	sub    $0x14,%esp
801002ef:	8b 45 08             	mov    0x8(%ebp),%eax
801002f2:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002f6:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002fa:	89 c2                	mov    %eax,%edx
801002fc:	ec                   	in     (%dx),%al
801002fd:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80100300:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80100304:	c9                   	leave  
80100305:	c3                   	ret    

80100306 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80100306:	55                   	push   %ebp
80100307:	89 e5                	mov    %esp,%ebp
80100309:	83 ec 08             	sub    $0x8,%esp
8010030c:	8b 45 08             	mov    0x8(%ebp),%eax
8010030f:	8b 55 0c             	mov    0xc(%ebp),%edx
80100312:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80100316:	89 d0                	mov    %edx,%eax
80100318:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010031b:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010031f:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80100323:	ee                   	out    %al,(%dx)
}
80100324:	90                   	nop
80100325:	c9                   	leave  
80100326:	c3                   	ret    

80100327 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100327:	55                   	push   %ebp
80100328:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010032a:	fa                   	cli    
}
8010032b:	90                   	nop
8010032c:	5d                   	pop    %ebp
8010032d:	c3                   	ret    

8010032e <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010032e:	f3 0f 1e fb          	endbr32 
80100332:	55                   	push   %ebp
80100333:	89 e5                	mov    %esp,%ebp
80100335:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100338:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010033c:	74 1c                	je     8010035a <printint+0x2c>
8010033e:	8b 45 08             	mov    0x8(%ebp),%eax
80100341:	c1 e8 1f             	shr    $0x1f,%eax
80100344:	0f b6 c0             	movzbl %al,%eax
80100347:	89 45 10             	mov    %eax,0x10(%ebp)
8010034a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010034e:	74 0a                	je     8010035a <printint+0x2c>
    x = -xx;
80100350:	8b 45 08             	mov    0x8(%ebp),%eax
80100353:	f7 d8                	neg    %eax
80100355:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100358:	eb 06                	jmp    80100360 <printint+0x32>
  else
    x = xx;
8010035a:	8b 45 08             	mov    0x8(%ebp),%eax
8010035d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100360:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010036a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010036d:	ba 00 00 00 00       	mov    $0x0,%edx
80100372:	f7 f1                	div    %ecx
80100374:	89 d1                	mov    %edx,%ecx
80100376:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100379:	8d 50 01             	lea    0x1(%eax),%edx
8010037c:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010037f:	0f b6 91 04 90 10 80 	movzbl -0x7fef6ffc(%ecx),%edx
80100386:	88 54 05 e0          	mov    %dl,-0x20(%ebp,%eax,1)
  }while((x /= base) != 0);
8010038a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010038d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100390:	ba 00 00 00 00       	mov    $0x0,%edx
80100395:	f7 f1                	div    %ecx
80100397:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010039a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010039e:	75 c7                	jne    80100367 <printint+0x39>

  if(sign)
801003a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801003a4:	74 2a                	je     801003d0 <printint+0xa2>
    buf[i++] = '-';
801003a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003a9:	8d 50 01             	lea    0x1(%eax),%edx
801003ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
801003af:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
801003b4:	eb 1a                	jmp    801003d0 <printint+0xa2>
    consputc(buf[i]);
801003b6:	8d 55 e0             	lea    -0x20(%ebp),%edx
801003b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003bc:	01 d0                	add    %edx,%eax
801003be:	0f b6 00             	movzbl (%eax),%eax
801003c1:	0f be c0             	movsbl %al,%eax
801003c4:	83 ec 0c             	sub    $0xc,%esp
801003c7:	50                   	push   %eax
801003c8:	e8 ea 03 00 00       	call   801007b7 <consputc>
801003cd:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
801003d0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003d8:	79 dc                	jns    801003b6 <printint+0x88>
}
801003da:	90                   	nop
801003db:	90                   	nop
801003dc:	c9                   	leave  
801003dd:	c3                   	ret    

801003de <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003de:	f3 0f 1e fb          	endbr32 
801003e2:	55                   	push   %ebp
801003e3:	89 e5                	mov    %esp,%ebp
801003e5:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003e8:	a1 f4 b5 10 80       	mov    0x8010b5f4,%eax
801003ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003f0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003f4:	74 10                	je     80100406 <cprintf+0x28>
    acquire(&cons.lock);
801003f6:	83 ec 0c             	sub    $0xc,%esp
801003f9:	68 c0 b5 10 80       	push   $0x8010b5c0
801003fe:	e8 a9 49 00 00       	call   80104dac <acquire>
80100403:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
80100406:	8b 45 08             	mov    0x8(%ebp),%eax
80100409:	85 c0                	test   %eax,%eax
8010040b:	75 0d                	jne    8010041a <cprintf+0x3c>
    panic("null fmt");
8010040d:	83 ec 0c             	sub    $0xc,%esp
80100410:	68 ce 83 10 80       	push   $0x801083ce
80100415:	e8 7d 01 00 00       	call   80100597 <panic>

  argp = (uint*)(void*)(&fmt + 1);
8010041a:	8d 45 0c             	lea    0xc(%ebp),%eax
8010041d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100420:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100427:	e9 2f 01 00 00       	jmp    8010055b <cprintf+0x17d>
    if(c != '%'){
8010042c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100430:	74 13                	je     80100445 <cprintf+0x67>
      consputc(c);
80100432:	83 ec 0c             	sub    $0xc,%esp
80100435:	ff 75 e4             	pushl  -0x1c(%ebp)
80100438:	e8 7a 03 00 00       	call   801007b7 <consputc>
8010043d:	83 c4 10             	add    $0x10,%esp
      continue;
80100440:	e9 12 01 00 00       	jmp    80100557 <cprintf+0x179>
    }
    c = fmt[++i] & 0xff;
80100445:	8b 55 08             	mov    0x8(%ebp),%edx
80100448:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010044c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010044f:	01 d0                	add    %edx,%eax
80100451:	0f b6 00             	movzbl (%eax),%eax
80100454:	0f be c0             	movsbl %al,%eax
80100457:	25 ff 00 00 00       	and    $0xff,%eax
8010045c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010045f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100463:	0f 84 14 01 00 00    	je     8010057d <cprintf+0x19f>
      break;
    switch(c){
80100469:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
8010046d:	74 5e                	je     801004cd <cprintf+0xef>
8010046f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
80100473:	0f 8f c2 00 00 00    	jg     8010053b <cprintf+0x15d>
80100479:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
8010047d:	74 6b                	je     801004ea <cprintf+0x10c>
8010047f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
80100483:	0f 8f b2 00 00 00    	jg     8010053b <cprintf+0x15d>
80100489:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
8010048d:	74 3e                	je     801004cd <cprintf+0xef>
8010048f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
80100493:	0f 8f a2 00 00 00    	jg     8010053b <cprintf+0x15d>
80100499:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
8010049d:	0f 84 89 00 00 00    	je     8010052c <cprintf+0x14e>
801004a3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
801004a7:	0f 85 8e 00 00 00    	jne    8010053b <cprintf+0x15d>
    case 'd':
      printint(*argp++, 10, 1);
801004ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004b0:	8d 50 04             	lea    0x4(%eax),%edx
801004b3:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004b6:	8b 00                	mov    (%eax),%eax
801004b8:	83 ec 04             	sub    $0x4,%esp
801004bb:	6a 01                	push   $0x1
801004bd:	6a 0a                	push   $0xa
801004bf:	50                   	push   %eax
801004c0:	e8 69 fe ff ff       	call   8010032e <printint>
801004c5:	83 c4 10             	add    $0x10,%esp
      break;
801004c8:	e9 8a 00 00 00       	jmp    80100557 <cprintf+0x179>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801004cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004d0:	8d 50 04             	lea    0x4(%eax),%edx
801004d3:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004d6:	8b 00                	mov    (%eax),%eax
801004d8:	83 ec 04             	sub    $0x4,%esp
801004db:	6a 00                	push   $0x0
801004dd:	6a 10                	push   $0x10
801004df:	50                   	push   %eax
801004e0:	e8 49 fe ff ff       	call   8010032e <printint>
801004e5:	83 c4 10             	add    $0x10,%esp
      break;
801004e8:	eb 6d                	jmp    80100557 <cprintf+0x179>
    case 's':
      if((s = (char*)*argp++) == 0)
801004ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004ed:	8d 50 04             	lea    0x4(%eax),%edx
801004f0:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004f3:	8b 00                	mov    (%eax),%eax
801004f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004f8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004fc:	75 22                	jne    80100520 <cprintf+0x142>
        s = "(null)";
801004fe:	c7 45 ec d7 83 10 80 	movl   $0x801083d7,-0x14(%ebp)
      for(; *s; s++)
80100505:	eb 19                	jmp    80100520 <cprintf+0x142>
        consputc(*s);
80100507:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010050a:	0f b6 00             	movzbl (%eax),%eax
8010050d:	0f be c0             	movsbl %al,%eax
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	50                   	push   %eax
80100514:	e8 9e 02 00 00       	call   801007b7 <consputc>
80100519:	83 c4 10             	add    $0x10,%esp
      for(; *s; s++)
8010051c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100520:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100523:	0f b6 00             	movzbl (%eax),%eax
80100526:	84 c0                	test   %al,%al
80100528:	75 dd                	jne    80100507 <cprintf+0x129>
      break;
8010052a:	eb 2b                	jmp    80100557 <cprintf+0x179>
    case '%':
      consputc('%');
8010052c:	83 ec 0c             	sub    $0xc,%esp
8010052f:	6a 25                	push   $0x25
80100531:	e8 81 02 00 00       	call   801007b7 <consputc>
80100536:	83 c4 10             	add    $0x10,%esp
      break;
80100539:	eb 1c                	jmp    80100557 <cprintf+0x179>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
8010053b:	83 ec 0c             	sub    $0xc,%esp
8010053e:	6a 25                	push   $0x25
80100540:	e8 72 02 00 00       	call   801007b7 <consputc>
80100545:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100548:	83 ec 0c             	sub    $0xc,%esp
8010054b:	ff 75 e4             	pushl  -0x1c(%ebp)
8010054e:	e8 64 02 00 00       	call   801007b7 <consputc>
80100553:	83 c4 10             	add    $0x10,%esp
      break;
80100556:	90                   	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100557:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010055b:	8b 55 08             	mov    0x8(%ebp),%edx
8010055e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100561:	01 d0                	add    %edx,%eax
80100563:	0f b6 00             	movzbl (%eax),%eax
80100566:	0f be c0             	movsbl %al,%eax
80100569:	25 ff 00 00 00       	and    $0xff,%eax
8010056e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100571:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100575:	0f 85 b1 fe ff ff    	jne    8010042c <cprintf+0x4e>
8010057b:	eb 01                	jmp    8010057e <cprintf+0x1a0>
      break;
8010057d:	90                   	nop
    }
  }

  if(locking)
8010057e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100582:	74 10                	je     80100594 <cprintf+0x1b6>
    release(&cons.lock);
80100584:	83 ec 0c             	sub    $0xc,%esp
80100587:	68 c0 b5 10 80       	push   $0x8010b5c0
8010058c:	e8 86 48 00 00       	call   80104e17 <release>
80100591:	83 c4 10             	add    $0x10,%esp
}
80100594:	90                   	nop
80100595:	c9                   	leave  
80100596:	c3                   	ret    

80100597 <panic>:

void
panic(char *s)
{
80100597:	f3 0f 1e fb          	endbr32 
8010059b:	55                   	push   %ebp
8010059c:	89 e5                	mov    %esp,%ebp
8010059e:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
801005a1:	e8 81 fd ff ff       	call   80100327 <cli>
  cons.locking = 0;
801005a6:	c7 05 f4 b5 10 80 00 	movl   $0x0,0x8010b5f4
801005ad:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
801005b0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801005b6:	0f b6 00             	movzbl (%eax),%eax
801005b9:	0f b6 c0             	movzbl %al,%eax
801005bc:	83 ec 08             	sub    $0x8,%esp
801005bf:	50                   	push   %eax
801005c0:	68 de 83 10 80       	push   $0x801083de
801005c5:	e8 14 fe ff ff       	call   801003de <cprintf>
801005ca:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
801005cd:	8b 45 08             	mov    0x8(%ebp),%eax
801005d0:	83 ec 0c             	sub    $0xc,%esp
801005d3:	50                   	push   %eax
801005d4:	e8 05 fe ff ff       	call   801003de <cprintf>
801005d9:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005dc:	83 ec 0c             	sub    $0xc,%esp
801005df:	68 ed 83 10 80       	push   $0x801083ed
801005e4:	e8 f5 fd ff ff       	call   801003de <cprintf>
801005e9:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005ec:	83 ec 08             	sub    $0x8,%esp
801005ef:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005f2:	50                   	push   %eax
801005f3:	8d 45 08             	lea    0x8(%ebp),%eax
801005f6:	50                   	push   %eax
801005f7:	e8 71 48 00 00       	call   80104e6d <getcallerpcs>
801005fc:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100606:	eb 1c                	jmp    80100624 <panic+0x8d>
    cprintf(" %p", pcs[i]);
80100608:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010060b:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
8010060f:	83 ec 08             	sub    $0x8,%esp
80100612:	50                   	push   %eax
80100613:	68 ef 83 10 80       	push   $0x801083ef
80100618:	e8 c1 fd ff ff       	call   801003de <cprintf>
8010061d:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100620:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100624:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80100628:	7e de                	jle    80100608 <panic+0x71>
  panicked = 1; // freeze other CPU
8010062a:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
80100631:	00 00 00 
  for(;;)
80100634:	eb fe                	jmp    80100634 <panic+0x9d>

80100636 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
80100636:	f3 0f 1e fb          	endbr32 
8010063a:	55                   	push   %ebp
8010063b:	89 e5                	mov    %esp,%ebp
8010063d:	53                   	push   %ebx
8010063e:	83 ec 14             	sub    $0x14,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100641:	6a 0e                	push   $0xe
80100643:	68 d4 03 00 00       	push   $0x3d4
80100648:	e8 b9 fc ff ff       	call   80100306 <outb>
8010064d:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100650:	68 d5 03 00 00       	push   $0x3d5
80100655:	e8 8f fc ff ff       	call   801002e9 <inb>
8010065a:	83 c4 04             	add    $0x4,%esp
8010065d:	0f b6 c0             	movzbl %al,%eax
80100660:	c1 e0 08             	shl    $0x8,%eax
80100663:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100666:	6a 0f                	push   $0xf
80100668:	68 d4 03 00 00       	push   $0x3d4
8010066d:	e8 94 fc ff ff       	call   80100306 <outb>
80100672:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100675:	68 d5 03 00 00       	push   $0x3d5
8010067a:	e8 6a fc ff ff       	call   801002e9 <inb>
8010067f:	83 c4 04             	add    $0x4,%esp
80100682:	0f b6 c0             	movzbl %al,%eax
80100685:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100688:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010068c:	75 30                	jne    801006be <cgaputc+0x88>
    pos += 80 - pos%80;
8010068e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100691:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100696:	89 c8                	mov    %ecx,%eax
80100698:	f7 ea                	imul   %edx
8010069a:	c1 fa 05             	sar    $0x5,%edx
8010069d:	89 c8                	mov    %ecx,%eax
8010069f:	c1 f8 1f             	sar    $0x1f,%eax
801006a2:	29 c2                	sub    %eax,%edx
801006a4:	89 d0                	mov    %edx,%eax
801006a6:	c1 e0 02             	shl    $0x2,%eax
801006a9:	01 d0                	add    %edx,%eax
801006ab:	c1 e0 04             	shl    $0x4,%eax
801006ae:	29 c1                	sub    %eax,%ecx
801006b0:	89 ca                	mov    %ecx,%edx
801006b2:	b8 50 00 00 00       	mov    $0x50,%eax
801006b7:	29 d0                	sub    %edx,%eax
801006b9:	01 45 f4             	add    %eax,-0xc(%ebp)
801006bc:	eb 38                	jmp    801006f6 <cgaputc+0xc0>
  else if(c == BACKSPACE){
801006be:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801006c5:	75 0c                	jne    801006d3 <cgaputc+0x9d>
    if(pos > 0) --pos;
801006c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006cb:	7e 29                	jle    801006f6 <cgaputc+0xc0>
801006cd:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801006d1:	eb 23                	jmp    801006f6 <cgaputc+0xc0>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801006d3:	8b 45 08             	mov    0x8(%ebp),%eax
801006d6:	0f b6 c0             	movzbl %al,%eax
801006d9:	80 cc 07             	or     $0x7,%ah
801006dc:	89 c3                	mov    %eax,%ebx
801006de:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
801006e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006e7:	8d 50 01             	lea    0x1(%eax),%edx
801006ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
801006ed:	01 c0                	add    %eax,%eax
801006ef:	01 c8                	add    %ecx,%eax
801006f1:	89 da                	mov    %ebx,%edx
801006f3:	66 89 10             	mov    %dx,(%eax)
  
  if((pos/80) >= 24){  // Scroll up.
801006f6:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006fd:	7e 4c                	jle    8010074b <cgaputc+0x115>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006ff:	a1 00 90 10 80       	mov    0x80109000,%eax
80100704:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
8010070a:	a1 00 90 10 80       	mov    0x80109000,%eax
8010070f:	83 ec 04             	sub    $0x4,%esp
80100712:	68 60 0e 00 00       	push   $0xe60
80100717:	52                   	push   %edx
80100718:	50                   	push   %eax
80100719:	e8 d1 49 00 00       	call   801050ef <memmove>
8010071e:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
80100721:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100725:	b8 80 07 00 00       	mov    $0x780,%eax
8010072a:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010072d:	8d 14 00             	lea    (%eax,%eax,1),%edx
80100730:	a1 00 90 10 80       	mov    0x80109000,%eax
80100735:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100738:	01 c9                	add    %ecx,%ecx
8010073a:	01 c8                	add    %ecx,%eax
8010073c:	83 ec 04             	sub    $0x4,%esp
8010073f:	52                   	push   %edx
80100740:	6a 00                	push   $0x0
80100742:	50                   	push   %eax
80100743:	e8 e0 48 00 00       	call   80105028 <memset>
80100748:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
8010074b:	83 ec 08             	sub    $0x8,%esp
8010074e:	6a 0e                	push   $0xe
80100750:	68 d4 03 00 00       	push   $0x3d4
80100755:	e8 ac fb ff ff       	call   80100306 <outb>
8010075a:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
8010075d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100760:	c1 f8 08             	sar    $0x8,%eax
80100763:	0f b6 c0             	movzbl %al,%eax
80100766:	83 ec 08             	sub    $0x8,%esp
80100769:	50                   	push   %eax
8010076a:	68 d5 03 00 00       	push   $0x3d5
8010076f:	e8 92 fb ff ff       	call   80100306 <outb>
80100774:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
80100777:	83 ec 08             	sub    $0x8,%esp
8010077a:	6a 0f                	push   $0xf
8010077c:	68 d4 03 00 00       	push   $0x3d4
80100781:	e8 80 fb ff ff       	call   80100306 <outb>
80100786:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
80100789:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010078c:	0f b6 c0             	movzbl %al,%eax
8010078f:	83 ec 08             	sub    $0x8,%esp
80100792:	50                   	push   %eax
80100793:	68 d5 03 00 00       	push   $0x3d5
80100798:	e8 69 fb ff ff       	call   80100306 <outb>
8010079d:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
801007a0:	a1 00 90 10 80       	mov    0x80109000,%eax
801007a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801007a8:	01 d2                	add    %edx,%edx
801007aa:	01 d0                	add    %edx,%eax
801007ac:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
801007b1:	90                   	nop
801007b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801007b5:	c9                   	leave  
801007b6:	c3                   	ret    

801007b7 <consputc>:

void
consputc(int c)
{
801007b7:	f3 0f 1e fb          	endbr32 
801007bb:	55                   	push   %ebp
801007bc:	89 e5                	mov    %esp,%ebp
801007be:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
801007c1:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
801007c6:	85 c0                	test   %eax,%eax
801007c8:	74 07                	je     801007d1 <consputc+0x1a>
    cli();
801007ca:	e8 58 fb ff ff       	call   80100327 <cli>
    for(;;)
801007cf:	eb fe                	jmp    801007cf <consputc+0x18>
      ;
  }

  if(c == BACKSPACE){
801007d1:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801007d8:	75 29                	jne    80100803 <consputc+0x4c>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801007da:	83 ec 0c             	sub    $0xc,%esp
801007dd:	6a 08                	push   $0x8
801007df:	e8 14 62 00 00       	call   801069f8 <uartputc>
801007e4:	83 c4 10             	add    $0x10,%esp
801007e7:	83 ec 0c             	sub    $0xc,%esp
801007ea:	6a 20                	push   $0x20
801007ec:	e8 07 62 00 00       	call   801069f8 <uartputc>
801007f1:	83 c4 10             	add    $0x10,%esp
801007f4:	83 ec 0c             	sub    $0xc,%esp
801007f7:	6a 08                	push   $0x8
801007f9:	e8 fa 61 00 00       	call   801069f8 <uartputc>
801007fe:	83 c4 10             	add    $0x10,%esp
80100801:	eb 0e                	jmp    80100811 <consputc+0x5a>
  } else
    uartputc(c);
80100803:	83 ec 0c             	sub    $0xc,%esp
80100806:	ff 75 08             	pushl  0x8(%ebp)
80100809:	e8 ea 61 00 00       	call   801069f8 <uartputc>
8010080e:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
80100811:	83 ec 0c             	sub    $0xc,%esp
80100814:	ff 75 08             	pushl  0x8(%ebp)
80100817:	e8 1a fe ff ff       	call   80100636 <cgaputc>
8010081c:	83 c4 10             	add    $0x10,%esp
}
8010081f:	90                   	nop
80100820:	c9                   	leave  
80100821:	c3                   	ret    

80100822 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100822:	f3 0f 1e fb          	endbr32 
80100826:	55                   	push   %ebp
80100827:	89 e5                	mov    %esp,%ebp
80100829:	83 ec 18             	sub    $0x18,%esp
  int c;

  acquire(&input.lock);
8010082c:	83 ec 0c             	sub    $0xc,%esp
8010082f:	68 a0 dd 10 80       	push   $0x8010dda0
80100834:	e8 73 45 00 00       	call   80104dac <acquire>
80100839:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
8010083c:	e9 4c 01 00 00       	jmp    8010098d <consoleintr+0x16b>
    switch(c){
80100841:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80100845:	74 7f                	je     801008c6 <consoleintr+0xa4>
80100847:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
8010084b:	0f 8f aa 00 00 00    	jg     801008fb <consoleintr+0xd9>
80100851:	83 7d f4 15          	cmpl   $0x15,-0xc(%ebp)
80100855:	74 41                	je     80100898 <consoleintr+0x76>
80100857:	83 7d f4 15          	cmpl   $0x15,-0xc(%ebp)
8010085b:	0f 8f 9a 00 00 00    	jg     801008fb <consoleintr+0xd9>
80100861:	83 7d f4 08          	cmpl   $0x8,-0xc(%ebp)
80100865:	74 5f                	je     801008c6 <consoleintr+0xa4>
80100867:	83 7d f4 10          	cmpl   $0x10,-0xc(%ebp)
8010086b:	0f 85 8a 00 00 00    	jne    801008fb <consoleintr+0xd9>
    case C('P'):  // Process listing.
      procdump();
80100871:	e8 da 43 00 00       	call   80104c50 <procdump>
      break;
80100876:	e9 12 01 00 00       	jmp    8010098d <consoleintr+0x16b>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
8010087b:	a1 5c de 10 80       	mov    0x8010de5c,%eax
80100880:	83 e8 01             	sub    $0x1,%eax
80100883:	a3 5c de 10 80       	mov    %eax,0x8010de5c
        consputc(BACKSPACE);
80100888:	83 ec 0c             	sub    $0xc,%esp
8010088b:	68 00 01 00 00       	push   $0x100
80100890:	e8 22 ff ff ff       	call   801007b7 <consputc>
80100895:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
80100898:	8b 15 5c de 10 80    	mov    0x8010de5c,%edx
8010089e:	a1 58 de 10 80       	mov    0x8010de58,%eax
801008a3:	39 c2                	cmp    %eax,%edx
801008a5:	0f 84 e2 00 00 00    	je     8010098d <consoleintr+0x16b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008ab:	a1 5c de 10 80       	mov    0x8010de5c,%eax
801008b0:	83 e8 01             	sub    $0x1,%eax
801008b3:	83 e0 7f             	and    $0x7f,%eax
801008b6:	0f b6 80 d4 dd 10 80 	movzbl -0x7fef222c(%eax),%eax
      while(input.e != input.w &&
801008bd:	3c 0a                	cmp    $0xa,%al
801008bf:	75 ba                	jne    8010087b <consoleintr+0x59>
      }
      break;
801008c1:	e9 c7 00 00 00       	jmp    8010098d <consoleintr+0x16b>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801008c6:	8b 15 5c de 10 80    	mov    0x8010de5c,%edx
801008cc:	a1 58 de 10 80       	mov    0x8010de58,%eax
801008d1:	39 c2                	cmp    %eax,%edx
801008d3:	0f 84 b4 00 00 00    	je     8010098d <consoleintr+0x16b>
        input.e--;
801008d9:	a1 5c de 10 80       	mov    0x8010de5c,%eax
801008de:	83 e8 01             	sub    $0x1,%eax
801008e1:	a3 5c de 10 80       	mov    %eax,0x8010de5c
        consputc(BACKSPACE);
801008e6:	83 ec 0c             	sub    $0xc,%esp
801008e9:	68 00 01 00 00       	push   $0x100
801008ee:	e8 c4 fe ff ff       	call   801007b7 <consputc>
801008f3:	83 c4 10             	add    $0x10,%esp
      }
      break;
801008f6:	e9 92 00 00 00       	jmp    8010098d <consoleintr+0x16b>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801008ff:	0f 84 87 00 00 00    	je     8010098c <consoleintr+0x16a>
80100905:	8b 15 5c de 10 80    	mov    0x8010de5c,%edx
8010090b:	a1 54 de 10 80       	mov    0x8010de54,%eax
80100910:	29 c2                	sub    %eax,%edx
80100912:	89 d0                	mov    %edx,%eax
80100914:	83 f8 7f             	cmp    $0x7f,%eax
80100917:	77 73                	ja     8010098c <consoleintr+0x16a>
        c = (c == '\r') ? '\n' : c;
80100919:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
8010091d:	74 05                	je     80100924 <consoleintr+0x102>
8010091f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100922:	eb 05                	jmp    80100929 <consoleintr+0x107>
80100924:	b8 0a 00 00 00       	mov    $0xa,%eax
80100929:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
8010092c:	a1 5c de 10 80       	mov    0x8010de5c,%eax
80100931:	8d 50 01             	lea    0x1(%eax),%edx
80100934:	89 15 5c de 10 80    	mov    %edx,0x8010de5c
8010093a:	83 e0 7f             	and    $0x7f,%eax
8010093d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100940:	88 90 d4 dd 10 80    	mov    %dl,-0x7fef222c(%eax)
        consputc(c);
80100946:	83 ec 0c             	sub    $0xc,%esp
80100949:	ff 75 f4             	pushl  -0xc(%ebp)
8010094c:	e8 66 fe ff ff       	call   801007b7 <consputc>
80100951:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100954:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
80100958:	74 18                	je     80100972 <consoleintr+0x150>
8010095a:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
8010095e:	74 12                	je     80100972 <consoleintr+0x150>
80100960:	a1 5c de 10 80       	mov    0x8010de5c,%eax
80100965:	8b 15 54 de 10 80    	mov    0x8010de54,%edx
8010096b:	83 ea 80             	sub    $0xffffff80,%edx
8010096e:	39 d0                	cmp    %edx,%eax
80100970:	75 1a                	jne    8010098c <consoleintr+0x16a>
          input.w = input.e;
80100972:	a1 5c de 10 80       	mov    0x8010de5c,%eax
80100977:	a3 58 de 10 80       	mov    %eax,0x8010de58
          wakeup(&input.r);
8010097c:	83 ec 0c             	sub    $0xc,%esp
8010097f:	68 54 de 10 80       	push   $0x8010de54
80100984:	e8 04 42 00 00       	call   80104b8d <wakeup>
80100989:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
8010098c:	90                   	nop
  while((c = getc()) >= 0){
8010098d:	8b 45 08             	mov    0x8(%ebp),%eax
80100990:	ff d0                	call   *%eax
80100992:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100995:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100999:	0f 89 a2 fe ff ff    	jns    80100841 <consoleintr+0x1f>
    }
  }
  release(&input.lock);
8010099f:	83 ec 0c             	sub    $0xc,%esp
801009a2:	68 a0 dd 10 80       	push   $0x8010dda0
801009a7:	e8 6b 44 00 00       	call   80104e17 <release>
801009ac:	83 c4 10             	add    $0x10,%esp
}
801009af:	90                   	nop
801009b0:	c9                   	leave  
801009b1:	c3                   	ret    

801009b2 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
801009b2:	f3 0f 1e fb          	endbr32 
801009b6:	55                   	push   %ebp
801009b7:	89 e5                	mov    %esp,%ebp
801009b9:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
801009bc:	83 ec 0c             	sub    $0xc,%esp
801009bf:	ff 75 08             	pushl  0x8(%ebp)
801009c2:	e8 2f 11 00 00       	call   80101af6 <iunlock>
801009c7:	83 c4 10             	add    $0x10,%esp
  target = n;
801009ca:	8b 45 10             	mov    0x10(%ebp),%eax
801009cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
801009d0:	83 ec 0c             	sub    $0xc,%esp
801009d3:	68 a0 dd 10 80       	push   $0x8010dda0
801009d8:	e8 cf 43 00 00       	call   80104dac <acquire>
801009dd:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
801009e0:	e9 ac 00 00 00       	jmp    80100a91 <consoleread+0xdf>
    while(input.r == input.w){
      if(proc->killed){
801009e5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801009eb:	8b 40 24             	mov    0x24(%eax),%eax
801009ee:	85 c0                	test   %eax,%eax
801009f0:	74 28                	je     80100a1a <consoleread+0x68>
        release(&input.lock);
801009f2:	83 ec 0c             	sub    $0xc,%esp
801009f5:	68 a0 dd 10 80       	push   $0x8010dda0
801009fa:	e8 18 44 00 00       	call   80104e17 <release>
801009ff:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
80100a02:	83 ec 0c             	sub    $0xc,%esp
80100a05:	ff 75 08             	pushl  0x8(%ebp)
80100a08:	e8 8d 0f 00 00       	call   8010199a <ilock>
80100a0d:	83 c4 10             	add    $0x10,%esp
        return -1;
80100a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100a15:	e9 ab 00 00 00       	jmp    80100ac5 <consoleread+0x113>
      }
      sleep(&input.r, &input.lock);
80100a1a:	83 ec 08             	sub    $0x8,%esp
80100a1d:	68 a0 dd 10 80       	push   $0x8010dda0
80100a22:	68 54 de 10 80       	push   $0x8010de54
80100a27:	e8 6d 40 00 00       	call   80104a99 <sleep>
80100a2c:	83 c4 10             	add    $0x10,%esp
    while(input.r == input.w){
80100a2f:	8b 15 54 de 10 80    	mov    0x8010de54,%edx
80100a35:	a1 58 de 10 80       	mov    0x8010de58,%eax
80100a3a:	39 c2                	cmp    %eax,%edx
80100a3c:	74 a7                	je     801009e5 <consoleread+0x33>
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100a3e:	a1 54 de 10 80       	mov    0x8010de54,%eax
80100a43:	8d 50 01             	lea    0x1(%eax),%edx
80100a46:	89 15 54 de 10 80    	mov    %edx,0x8010de54
80100a4c:	83 e0 7f             	and    $0x7f,%eax
80100a4f:	0f b6 80 d4 dd 10 80 	movzbl -0x7fef222c(%eax),%eax
80100a56:	0f be c0             	movsbl %al,%eax
80100a59:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100a5c:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a60:	75 17                	jne    80100a79 <consoleread+0xc7>
      if(n < target){
80100a62:	8b 45 10             	mov    0x10(%ebp),%eax
80100a65:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100a68:	76 2f                	jbe    80100a99 <consoleread+0xe7>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a6a:	a1 54 de 10 80       	mov    0x8010de54,%eax
80100a6f:	83 e8 01             	sub    $0x1,%eax
80100a72:	a3 54 de 10 80       	mov    %eax,0x8010de54
      }
      break;
80100a77:	eb 20                	jmp    80100a99 <consoleread+0xe7>
    }
    *dst++ = c;
80100a79:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a7c:	8d 50 01             	lea    0x1(%eax),%edx
80100a7f:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a82:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a85:	88 10                	mov    %dl,(%eax)
    --n;
80100a87:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a8b:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a8f:	74 0b                	je     80100a9c <consoleread+0xea>
  while(n > 0){
80100a91:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a95:	7f 98                	jg     80100a2f <consoleread+0x7d>
80100a97:	eb 04                	jmp    80100a9d <consoleread+0xeb>
      break;
80100a99:	90                   	nop
80100a9a:	eb 01                	jmp    80100a9d <consoleread+0xeb>
      break;
80100a9c:	90                   	nop
  }
  release(&input.lock);
80100a9d:	83 ec 0c             	sub    $0xc,%esp
80100aa0:	68 a0 dd 10 80       	push   $0x8010dda0
80100aa5:	e8 6d 43 00 00       	call   80104e17 <release>
80100aaa:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100aad:	83 ec 0c             	sub    $0xc,%esp
80100ab0:	ff 75 08             	pushl  0x8(%ebp)
80100ab3:	e8 e2 0e 00 00       	call   8010199a <ilock>
80100ab8:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100abb:	8b 45 10             	mov    0x10(%ebp),%eax
80100abe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100ac1:	29 c2                	sub    %eax,%edx
80100ac3:	89 d0                	mov    %edx,%eax
}
80100ac5:	c9                   	leave  
80100ac6:	c3                   	ret    

80100ac7 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100ac7:	f3 0f 1e fb          	endbr32 
80100acb:	55                   	push   %ebp
80100acc:	89 e5                	mov    %esp,%ebp
80100ace:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100ad1:	83 ec 0c             	sub    $0xc,%esp
80100ad4:	ff 75 08             	pushl  0x8(%ebp)
80100ad7:	e8 1a 10 00 00       	call   80101af6 <iunlock>
80100adc:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100adf:	83 ec 0c             	sub    $0xc,%esp
80100ae2:	68 c0 b5 10 80       	push   $0x8010b5c0
80100ae7:	e8 c0 42 00 00       	call   80104dac <acquire>
80100aec:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100aef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100af6:	eb 21                	jmp    80100b19 <consolewrite+0x52>
    consputc(buf[i] & 0xff);
80100af8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100afb:	8b 45 0c             	mov    0xc(%ebp),%eax
80100afe:	01 d0                	add    %edx,%eax
80100b00:	0f b6 00             	movzbl (%eax),%eax
80100b03:	0f be c0             	movsbl %al,%eax
80100b06:	0f b6 c0             	movzbl %al,%eax
80100b09:	83 ec 0c             	sub    $0xc,%esp
80100b0c:	50                   	push   %eax
80100b0d:	e8 a5 fc ff ff       	call   801007b7 <consputc>
80100b12:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100b15:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100b19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b1c:	3b 45 10             	cmp    0x10(%ebp),%eax
80100b1f:	7c d7                	jl     80100af8 <consolewrite+0x31>
  release(&cons.lock);
80100b21:	83 ec 0c             	sub    $0xc,%esp
80100b24:	68 c0 b5 10 80       	push   $0x8010b5c0
80100b29:	e8 e9 42 00 00       	call   80104e17 <release>
80100b2e:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100b31:	83 ec 0c             	sub    $0xc,%esp
80100b34:	ff 75 08             	pushl  0x8(%ebp)
80100b37:	e8 5e 0e 00 00       	call   8010199a <ilock>
80100b3c:	83 c4 10             	add    $0x10,%esp

  return n;
80100b3f:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100b42:	c9                   	leave  
80100b43:	c3                   	ret    

80100b44 <consoleinit>:

void
consoleinit(void)
{
80100b44:	f3 0f 1e fb          	endbr32 
80100b48:	55                   	push   %ebp
80100b49:	89 e5                	mov    %esp,%ebp
80100b4b:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100b4e:	83 ec 08             	sub    $0x8,%esp
80100b51:	68 f3 83 10 80       	push   $0x801083f3
80100b56:	68 c0 b5 10 80       	push   $0x8010b5c0
80100b5b:	e8 26 42 00 00       	call   80104d86 <initlock>
80100b60:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100b63:	83 ec 08             	sub    $0x8,%esp
80100b66:	68 fb 83 10 80       	push   $0x801083fb
80100b6b:	68 a0 dd 10 80       	push   $0x8010dda0
80100b70:	e8 11 42 00 00       	call   80104d86 <initlock>
80100b75:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b78:	c7 05 0c e8 10 80 c7 	movl   $0x80100ac7,0x8010e80c
80100b7f:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b82:	c7 05 08 e8 10 80 b2 	movl   $0x801009b2,0x8010e808
80100b89:	09 10 80 
  cons.locking = 1;
80100b8c:	c7 05 f4 b5 10 80 01 	movl   $0x1,0x8010b5f4
80100b93:	00 00 00 

  picenable(IRQ_KBD);
80100b96:	83 ec 0c             	sub    $0xc,%esp
80100b99:	6a 01                	push   $0x1
80100b9b:	e8 1f 31 00 00       	call   80103cbf <picenable>
80100ba0:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100ba3:	83 ec 08             	sub    $0x8,%esp
80100ba6:	6a 00                	push   $0x0
80100ba8:	6a 01                	push   $0x1
80100baa:	e8 6e 1f 00 00       	call   80102b1d <ioapicenable>
80100baf:	83 c4 10             	add    $0x10,%esp
}
80100bb2:	90                   	nop
80100bb3:	c9                   	leave  
80100bb4:	c3                   	ret    

80100bb5 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100bb5:	f3 0f 1e fb          	endbr32 
80100bb9:	55                   	push   %ebp
80100bba:	89 e5                	mov    %esp,%ebp
80100bbc:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
80100bc2:	83 ec 0c             	sub    $0xc,%esp
80100bc5:	ff 75 08             	pushl  0x8(%ebp)
80100bc8:	e8 b0 19 00 00       	call   8010257d <namei>
80100bcd:	83 c4 10             	add    $0x10,%esp
80100bd0:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100bd3:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100bd7:	75 0a                	jne    80100be3 <exec+0x2e>
    return -1;
80100bd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bde:	e9 c4 03 00 00       	jmp    80100fa7 <exec+0x3f2>
  ilock(ip);
80100be3:	83 ec 0c             	sub    $0xc,%esp
80100be6:	ff 75 d8             	pushl  -0x28(%ebp)
80100be9:	e8 ac 0d 00 00       	call   8010199a <ilock>
80100bee:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100bf1:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100bf8:	6a 34                	push   $0x34
80100bfa:	6a 00                	push   $0x0
80100bfc:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100c02:	50                   	push   %eax
80100c03:	ff 75 d8             	pushl  -0x28(%ebp)
80100c06:	e8 0e 13 00 00       	call   80101f19 <readi>
80100c0b:	83 c4 10             	add    $0x10,%esp
80100c0e:	83 f8 33             	cmp    $0x33,%eax
80100c11:	0f 86 44 03 00 00    	jbe    80100f5b <exec+0x3a6>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100c17:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100c1d:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100c22:	0f 85 36 03 00 00    	jne    80100f5e <exec+0x3a9>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100c28:	e8 38 6f 00 00       	call   80107b65 <setupkvm>
80100c2d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100c30:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100c34:	0f 84 27 03 00 00    	je     80100f61 <exec+0x3ac>
    goto bad;

  // Load program into memory.
  sz = 0;
80100c3a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c41:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100c48:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100c4e:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c51:	e9 ab 00 00 00       	jmp    80100d01 <exec+0x14c>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c56:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c59:	6a 20                	push   $0x20
80100c5b:	50                   	push   %eax
80100c5c:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100c62:	50                   	push   %eax
80100c63:	ff 75 d8             	pushl  -0x28(%ebp)
80100c66:	e8 ae 12 00 00       	call   80101f19 <readi>
80100c6b:	83 c4 10             	add    $0x10,%esp
80100c6e:	83 f8 20             	cmp    $0x20,%eax
80100c71:	0f 85 ed 02 00 00    	jne    80100f64 <exec+0x3af>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c77:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c7d:	83 f8 01             	cmp    $0x1,%eax
80100c80:	75 71                	jne    80100cf3 <exec+0x13e>
      continue;
    if(ph.memsz < ph.filesz)
80100c82:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c88:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c8e:	39 c2                	cmp    %eax,%edx
80100c90:	0f 82 d1 02 00 00    	jb     80100f67 <exec+0x3b2>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c96:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c9c:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100ca2:	01 d0                	add    %edx,%eax
80100ca4:	83 ec 04             	sub    $0x4,%esp
80100ca7:	50                   	push   %eax
80100ca8:	ff 75 e0             	pushl  -0x20(%ebp)
80100cab:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cae:	e8 72 72 00 00       	call   80107f25 <allocuvm>
80100cb3:	83 c4 10             	add    $0x10,%esp
80100cb6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cb9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cbd:	0f 84 a7 02 00 00    	je     80100f6a <exec+0x3b5>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100cc3:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100cc9:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ccf:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100cd5:	83 ec 0c             	sub    $0xc,%esp
80100cd8:	52                   	push   %edx
80100cd9:	50                   	push   %eax
80100cda:	ff 75 d8             	pushl  -0x28(%ebp)
80100cdd:	51                   	push   %ecx
80100cde:	ff 75 d4             	pushl  -0x2c(%ebp)
80100ce1:	e8 64 71 00 00       	call   80107e4a <loaduvm>
80100ce6:	83 c4 20             	add    $0x20,%esp
80100ce9:	85 c0                	test   %eax,%eax
80100ceb:	0f 88 7c 02 00 00    	js     80100f6d <exec+0x3b8>
80100cf1:	eb 01                	jmp    80100cf4 <exec+0x13f>
      continue;
80100cf3:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cf4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100cf8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100cfb:	83 c0 20             	add    $0x20,%eax
80100cfe:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100d01:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100d08:	0f b7 c0             	movzwl %ax,%eax
80100d0b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80100d0e:	0f 8c 42 ff ff ff    	jl     80100c56 <exec+0xa1>
      goto bad;
  }
  iunlockput(ip);
80100d14:	83 ec 0c             	sub    $0xc,%esp
80100d17:	ff 75 d8             	pushl  -0x28(%ebp)
80100d1a:	e8 41 0f 00 00       	call   80101c60 <iunlockput>
80100d1f:	83 c4 10             	add    $0x10,%esp
  ip = 0;
80100d22:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d29:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d2c:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d31:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100d36:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d39:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d3c:	05 00 20 00 00       	add    $0x2000,%eax
80100d41:	83 ec 04             	sub    $0x4,%esp
80100d44:	50                   	push   %eax
80100d45:	ff 75 e0             	pushl  -0x20(%ebp)
80100d48:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d4b:	e8 d5 71 00 00       	call   80107f25 <allocuvm>
80100d50:	83 c4 10             	add    $0x10,%esp
80100d53:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d56:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d5a:	0f 84 10 02 00 00    	je     80100f70 <exec+0x3bb>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d60:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d63:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d68:	83 ec 08             	sub    $0x8,%esp
80100d6b:	50                   	push   %eax
80100d6c:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d6f:	e8 e1 73 00 00       	call   80108155 <clearpteu>
80100d74:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100d77:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d7a:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d7d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d84:	e9 96 00 00 00       	jmp    80100e1f <exec+0x26a>
    if(argc >= MAXARG)
80100d89:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d8d:	0f 87 e0 01 00 00    	ja     80100f73 <exec+0x3be>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d93:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d96:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100da0:	01 d0                	add    %edx,%eax
80100da2:	8b 00                	mov    (%eax),%eax
80100da4:	83 ec 0c             	sub    $0xc,%esp
80100da7:	50                   	push   %eax
80100da8:	e8 e4 44 00 00       	call   80105291 <strlen>
80100dad:	83 c4 10             	add    $0x10,%esp
80100db0:	89 c2                	mov    %eax,%edx
80100db2:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100db5:	29 d0                	sub    %edx,%eax
80100db7:	83 e8 01             	sub    $0x1,%eax
80100dba:	83 e0 fc             	and    $0xfffffffc,%eax
80100dbd:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100dc0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dc3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dca:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dcd:	01 d0                	add    %edx,%eax
80100dcf:	8b 00                	mov    (%eax),%eax
80100dd1:	83 ec 0c             	sub    $0xc,%esp
80100dd4:	50                   	push   %eax
80100dd5:	e8 b7 44 00 00       	call   80105291 <strlen>
80100dda:	83 c4 10             	add    $0x10,%esp
80100ddd:	83 c0 01             	add    $0x1,%eax
80100de0:	89 c1                	mov    %eax,%ecx
80100de2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100de5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dec:	8b 45 0c             	mov    0xc(%ebp),%eax
80100def:	01 d0                	add    %edx,%eax
80100df1:	8b 00                	mov    (%eax),%eax
80100df3:	51                   	push   %ecx
80100df4:	50                   	push   %eax
80100df5:	ff 75 dc             	pushl  -0x24(%ebp)
80100df8:	ff 75 d4             	pushl  -0x2c(%ebp)
80100dfb:	e8 04 75 00 00       	call   80108304 <copyout>
80100e00:	83 c4 10             	add    $0x10,%esp
80100e03:	85 c0                	test   %eax,%eax
80100e05:	0f 88 6b 01 00 00    	js     80100f76 <exec+0x3c1>
      goto bad;
    ustack[3+argc] = sp;
80100e0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e0e:	8d 50 03             	lea    0x3(%eax),%edx
80100e11:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e14:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
  for(argc = 0; argv[argc]; argc++) {
80100e1b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100e1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e22:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e29:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e2c:	01 d0                	add    %edx,%eax
80100e2e:	8b 00                	mov    (%eax),%eax
80100e30:	85 c0                	test   %eax,%eax
80100e32:	0f 85 51 ff ff ff    	jne    80100d89 <exec+0x1d4>
  }
  ustack[3+argc] = 0;
80100e38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e3b:	83 c0 03             	add    $0x3,%eax
80100e3e:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100e45:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100e49:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100e50:	ff ff ff 
  ustack[1] = argc;
80100e53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e56:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e5f:	83 c0 01             	add    $0x1,%eax
80100e62:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e69:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e6c:	29 d0                	sub    %edx,%eax
80100e6e:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e77:	83 c0 04             	add    $0x4,%eax
80100e7a:	c1 e0 02             	shl    $0x2,%eax
80100e7d:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e83:	83 c0 04             	add    $0x4,%eax
80100e86:	c1 e0 02             	shl    $0x2,%eax
80100e89:	50                   	push   %eax
80100e8a:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e90:	50                   	push   %eax
80100e91:	ff 75 dc             	pushl  -0x24(%ebp)
80100e94:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e97:	e8 68 74 00 00       	call   80108304 <copyout>
80100e9c:	83 c4 10             	add    $0x10,%esp
80100e9f:	85 c0                	test   %eax,%eax
80100ea1:	0f 88 d2 00 00 00    	js     80100f79 <exec+0x3c4>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ea7:	8b 45 08             	mov    0x8(%ebp),%eax
80100eaa:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100ead:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100eb0:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100eb3:	eb 17                	jmp    80100ecc <exec+0x317>
    if(*s == '/')
80100eb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100eb8:	0f b6 00             	movzbl (%eax),%eax
80100ebb:	3c 2f                	cmp    $0x2f,%al
80100ebd:	75 09                	jne    80100ec8 <exec+0x313>
      last = s+1;
80100ebf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ec2:	83 c0 01             	add    $0x1,%eax
80100ec5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(last=s=path; *s; s++)
80100ec8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100ecc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ecf:	0f b6 00             	movzbl (%eax),%eax
80100ed2:	84 c0                	test   %al,%al
80100ed4:	75 df                	jne    80100eb5 <exec+0x300>
  safestrcpy(proc->name, last, sizeof(proc->name));
80100ed6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100edc:	83 c0 6c             	add    $0x6c,%eax
80100edf:	83 ec 04             	sub    $0x4,%esp
80100ee2:	6a 10                	push   $0x10
80100ee4:	ff 75 f0             	pushl  -0x10(%ebp)
80100ee7:	50                   	push   %eax
80100ee8:	e8 56 43 00 00       	call   80105243 <safestrcpy>
80100eed:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100ef0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ef6:	8b 40 04             	mov    0x4(%eax),%eax
80100ef9:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100efc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f02:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100f05:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100f08:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f0e:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100f11:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100f13:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f19:	8b 40 18             	mov    0x18(%eax),%eax
80100f1c:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100f22:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100f25:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f2b:	8b 40 18             	mov    0x18(%eax),%eax
80100f2e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100f31:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100f34:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f3a:	83 ec 0c             	sub    $0xc,%esp
80100f3d:	50                   	push   %eax
80100f3e:	e8 15 6d 00 00       	call   80107c58 <switchuvm>
80100f43:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100f46:	83 ec 0c             	sub    $0xc,%esp
80100f49:	ff 75 d0             	pushl  -0x30(%ebp)
80100f4c:	e8 60 71 00 00       	call   801080b1 <freevm>
80100f51:	83 c4 10             	add    $0x10,%esp
  return 0;
80100f54:	b8 00 00 00 00       	mov    $0x0,%eax
80100f59:	eb 4c                	jmp    80100fa7 <exec+0x3f2>
    goto bad;
80100f5b:	90                   	nop
80100f5c:	eb 1c                	jmp    80100f7a <exec+0x3c5>
    goto bad;
80100f5e:	90                   	nop
80100f5f:	eb 19                	jmp    80100f7a <exec+0x3c5>
    goto bad;
80100f61:	90                   	nop
80100f62:	eb 16                	jmp    80100f7a <exec+0x3c5>
      goto bad;
80100f64:	90                   	nop
80100f65:	eb 13                	jmp    80100f7a <exec+0x3c5>
      goto bad;
80100f67:	90                   	nop
80100f68:	eb 10                	jmp    80100f7a <exec+0x3c5>
      goto bad;
80100f6a:	90                   	nop
80100f6b:	eb 0d                	jmp    80100f7a <exec+0x3c5>
      goto bad;
80100f6d:	90                   	nop
80100f6e:	eb 0a                	jmp    80100f7a <exec+0x3c5>
    goto bad;
80100f70:	90                   	nop
80100f71:	eb 07                	jmp    80100f7a <exec+0x3c5>
      goto bad;
80100f73:	90                   	nop
80100f74:	eb 04                	jmp    80100f7a <exec+0x3c5>
      goto bad;
80100f76:	90                   	nop
80100f77:	eb 01                	jmp    80100f7a <exec+0x3c5>
    goto bad;
80100f79:	90                   	nop

 bad:
  if(pgdir)
80100f7a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f7e:	74 0e                	je     80100f8e <exec+0x3d9>
    freevm(pgdir);
80100f80:	83 ec 0c             	sub    $0xc,%esp
80100f83:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f86:	e8 26 71 00 00       	call   801080b1 <freevm>
80100f8b:	83 c4 10             	add    $0x10,%esp
  if(ip)
80100f8e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f92:	74 0e                	je     80100fa2 <exec+0x3ed>
    iunlockput(ip);
80100f94:	83 ec 0c             	sub    $0xc,%esp
80100f97:	ff 75 d8             	pushl  -0x28(%ebp)
80100f9a:	e8 c1 0c 00 00       	call   80101c60 <iunlockput>
80100f9f:	83 c4 10             	add    $0x10,%esp
  return -1;
80100fa2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fa7:	c9                   	leave  
80100fa8:	c3                   	ret    

80100fa9 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100fa9:	f3 0f 1e fb          	endbr32 
80100fad:	55                   	push   %ebp
80100fae:	89 e5                	mov    %esp,%ebp
80100fb0:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80100fb3:	83 ec 08             	sub    $0x8,%esp
80100fb6:	68 01 84 10 80       	push   $0x80108401
80100fbb:	68 60 de 10 80       	push   $0x8010de60
80100fc0:	e8 c1 3d 00 00       	call   80104d86 <initlock>
80100fc5:	83 c4 10             	add    $0x10,%esp
}
80100fc8:	90                   	nop
80100fc9:	c9                   	leave  
80100fca:	c3                   	ret    

80100fcb <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100fcb:	f3 0f 1e fb          	endbr32 
80100fcf:	55                   	push   %ebp
80100fd0:	89 e5                	mov    %esp,%ebp
80100fd2:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80100fd5:	83 ec 0c             	sub    $0xc,%esp
80100fd8:	68 60 de 10 80       	push   $0x8010de60
80100fdd:	e8 ca 3d 00 00       	call   80104dac <acquire>
80100fe2:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fe5:	c7 45 f4 94 de 10 80 	movl   $0x8010de94,-0xc(%ebp)
80100fec:	eb 2d                	jmp    8010101b <filealloc+0x50>
    if(f->ref == 0){
80100fee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ff1:	8b 40 04             	mov    0x4(%eax),%eax
80100ff4:	85 c0                	test   %eax,%eax
80100ff6:	75 1f                	jne    80101017 <filealloc+0x4c>
      f->ref = 1;
80100ff8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ffb:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80101002:	83 ec 0c             	sub    $0xc,%esp
80101005:	68 60 de 10 80       	push   $0x8010de60
8010100a:	e8 08 3e 00 00       	call   80104e17 <release>
8010100f:	83 c4 10             	add    $0x10,%esp
      return f;
80101012:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101015:	eb 23                	jmp    8010103a <filealloc+0x6f>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101017:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
8010101b:	b8 f4 e7 10 80       	mov    $0x8010e7f4,%eax
80101020:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80101023:	72 c9                	jb     80100fee <filealloc+0x23>
    }
  }
  release(&ftable.lock);
80101025:	83 ec 0c             	sub    $0xc,%esp
80101028:	68 60 de 10 80       	push   $0x8010de60
8010102d:	e8 e5 3d 00 00       	call   80104e17 <release>
80101032:	83 c4 10             	add    $0x10,%esp
  return 0;
80101035:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010103a:	c9                   	leave  
8010103b:	c3                   	ret    

8010103c <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
8010103c:	f3 0f 1e fb          	endbr32 
80101040:	55                   	push   %ebp
80101041:	89 e5                	mov    %esp,%ebp
80101043:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80101046:	83 ec 0c             	sub    $0xc,%esp
80101049:	68 60 de 10 80       	push   $0x8010de60
8010104e:	e8 59 3d 00 00       	call   80104dac <acquire>
80101053:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101056:	8b 45 08             	mov    0x8(%ebp),%eax
80101059:	8b 40 04             	mov    0x4(%eax),%eax
8010105c:	85 c0                	test   %eax,%eax
8010105e:	7f 0d                	jg     8010106d <filedup+0x31>
    panic("filedup");
80101060:	83 ec 0c             	sub    $0xc,%esp
80101063:	68 08 84 10 80       	push   $0x80108408
80101068:	e8 2a f5 ff ff       	call   80100597 <panic>
  f->ref++;
8010106d:	8b 45 08             	mov    0x8(%ebp),%eax
80101070:	8b 40 04             	mov    0x4(%eax),%eax
80101073:	8d 50 01             	lea    0x1(%eax),%edx
80101076:	8b 45 08             	mov    0x8(%ebp),%eax
80101079:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
8010107c:	83 ec 0c             	sub    $0xc,%esp
8010107f:	68 60 de 10 80       	push   $0x8010de60
80101084:	e8 8e 3d 00 00       	call   80104e17 <release>
80101089:	83 c4 10             	add    $0x10,%esp
  return f;
8010108c:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010108f:	c9                   	leave  
80101090:	c3                   	ret    

80101091 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101091:	f3 0f 1e fb          	endbr32 
80101095:	55                   	push   %ebp
80101096:	89 e5                	mov    %esp,%ebp
80101098:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
8010109b:	83 ec 0c             	sub    $0xc,%esp
8010109e:	68 60 de 10 80       	push   $0x8010de60
801010a3:	e8 04 3d 00 00       	call   80104dac <acquire>
801010a8:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801010ab:	8b 45 08             	mov    0x8(%ebp),%eax
801010ae:	8b 40 04             	mov    0x4(%eax),%eax
801010b1:	85 c0                	test   %eax,%eax
801010b3:	7f 0d                	jg     801010c2 <fileclose+0x31>
    panic("fileclose");
801010b5:	83 ec 0c             	sub    $0xc,%esp
801010b8:	68 10 84 10 80       	push   $0x80108410
801010bd:	e8 d5 f4 ff ff       	call   80100597 <panic>
  if(--f->ref > 0){
801010c2:	8b 45 08             	mov    0x8(%ebp),%eax
801010c5:	8b 40 04             	mov    0x4(%eax),%eax
801010c8:	8d 50 ff             	lea    -0x1(%eax),%edx
801010cb:	8b 45 08             	mov    0x8(%ebp),%eax
801010ce:	89 50 04             	mov    %edx,0x4(%eax)
801010d1:	8b 45 08             	mov    0x8(%ebp),%eax
801010d4:	8b 40 04             	mov    0x4(%eax),%eax
801010d7:	85 c0                	test   %eax,%eax
801010d9:	7e 15                	jle    801010f0 <fileclose+0x5f>
    release(&ftable.lock);
801010db:	83 ec 0c             	sub    $0xc,%esp
801010de:	68 60 de 10 80       	push   $0x8010de60
801010e3:	e8 2f 3d 00 00       	call   80104e17 <release>
801010e8:	83 c4 10             	add    $0x10,%esp
801010eb:	e9 8b 00 00 00       	jmp    8010117b <fileclose+0xea>
    return;
  }
  ff = *f;
801010f0:	8b 45 08             	mov    0x8(%ebp),%eax
801010f3:	8b 10                	mov    (%eax),%edx
801010f5:	89 55 e0             	mov    %edx,-0x20(%ebp)
801010f8:	8b 50 04             	mov    0x4(%eax),%edx
801010fb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801010fe:	8b 50 08             	mov    0x8(%eax),%edx
80101101:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101104:	8b 50 0c             	mov    0xc(%eax),%edx
80101107:	89 55 ec             	mov    %edx,-0x14(%ebp)
8010110a:	8b 50 10             	mov    0x10(%eax),%edx
8010110d:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101110:	8b 40 14             	mov    0x14(%eax),%eax
80101113:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101116:	8b 45 08             	mov    0x8(%ebp),%eax
80101119:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
80101120:	8b 45 08             	mov    0x8(%ebp),%eax
80101123:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101129:	83 ec 0c             	sub    $0xc,%esp
8010112c:	68 60 de 10 80       	push   $0x8010de60
80101131:	e8 e1 3c 00 00       	call   80104e17 <release>
80101136:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
80101139:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010113c:	83 f8 01             	cmp    $0x1,%eax
8010113f:	75 19                	jne    8010115a <fileclose+0xc9>
    pipeclose(ff.pipe, ff.writable);
80101141:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101145:	0f be d0             	movsbl %al,%edx
80101148:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010114b:	83 ec 08             	sub    $0x8,%esp
8010114e:	52                   	push   %edx
8010114f:	50                   	push   %eax
80101150:	e8 de 2d 00 00       	call   80103f33 <pipeclose>
80101155:	83 c4 10             	add    $0x10,%esp
80101158:	eb 21                	jmp    8010117b <fileclose+0xea>
  else if(ff.type == FD_INODE){
8010115a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010115d:	83 f8 02             	cmp    $0x2,%eax
80101160:	75 19                	jne    8010117b <fileclose+0xea>
    begin_trans();
80101162:	e8 60 22 00 00       	call   801033c7 <begin_trans>
    iput(ff.ip);
80101167:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010116a:	83 ec 0c             	sub    $0xc,%esp
8010116d:	50                   	push   %eax
8010116e:	e8 f9 09 00 00       	call   80101b6c <iput>
80101173:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80101176:	e8 a3 22 00 00       	call   8010341e <commit_trans>
  }
}
8010117b:	c9                   	leave  
8010117c:	c3                   	ret    

8010117d <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
8010117d:	f3 0f 1e fb          	endbr32 
80101181:	55                   	push   %ebp
80101182:	89 e5                	mov    %esp,%ebp
80101184:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
80101187:	8b 45 08             	mov    0x8(%ebp),%eax
8010118a:	8b 00                	mov    (%eax),%eax
8010118c:	83 f8 02             	cmp    $0x2,%eax
8010118f:	75 40                	jne    801011d1 <filestat+0x54>
    ilock(f->ip);
80101191:	8b 45 08             	mov    0x8(%ebp),%eax
80101194:	8b 40 10             	mov    0x10(%eax),%eax
80101197:	83 ec 0c             	sub    $0xc,%esp
8010119a:	50                   	push   %eax
8010119b:	e8 fa 07 00 00       	call   8010199a <ilock>
801011a0:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
801011a3:	8b 45 08             	mov    0x8(%ebp),%eax
801011a6:	8b 40 10             	mov    0x10(%eax),%eax
801011a9:	83 ec 08             	sub    $0x8,%esp
801011ac:	ff 75 0c             	pushl  0xc(%ebp)
801011af:	50                   	push   %eax
801011b0:	e8 1a 0d 00 00       	call   80101ecf <stati>
801011b5:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
801011b8:	8b 45 08             	mov    0x8(%ebp),%eax
801011bb:	8b 40 10             	mov    0x10(%eax),%eax
801011be:	83 ec 0c             	sub    $0xc,%esp
801011c1:	50                   	push   %eax
801011c2:	e8 2f 09 00 00       	call   80101af6 <iunlock>
801011c7:	83 c4 10             	add    $0x10,%esp
    return 0;
801011ca:	b8 00 00 00 00       	mov    $0x0,%eax
801011cf:	eb 05                	jmp    801011d6 <filestat+0x59>
  }
  return -1;
801011d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801011d6:	c9                   	leave  
801011d7:	c3                   	ret    

801011d8 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801011d8:	f3 0f 1e fb          	endbr32 
801011dc:	55                   	push   %ebp
801011dd:	89 e5                	mov    %esp,%ebp
801011df:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
801011e2:	8b 45 08             	mov    0x8(%ebp),%eax
801011e5:	0f b6 40 08          	movzbl 0x8(%eax),%eax
801011e9:	84 c0                	test   %al,%al
801011eb:	75 0a                	jne    801011f7 <fileread+0x1f>
    return -1;
801011ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011f2:	e9 9b 00 00 00       	jmp    80101292 <fileread+0xba>
  if(f->type == FD_PIPE)
801011f7:	8b 45 08             	mov    0x8(%ebp),%eax
801011fa:	8b 00                	mov    (%eax),%eax
801011fc:	83 f8 01             	cmp    $0x1,%eax
801011ff:	75 1a                	jne    8010121b <fileread+0x43>
    return piperead(f->pipe, addr, n);
80101201:	8b 45 08             	mov    0x8(%ebp),%eax
80101204:	8b 40 0c             	mov    0xc(%eax),%eax
80101207:	83 ec 04             	sub    $0x4,%esp
8010120a:	ff 75 10             	pushl  0x10(%ebp)
8010120d:	ff 75 0c             	pushl  0xc(%ebp)
80101210:	50                   	push   %eax
80101211:	e8 d3 2e 00 00       	call   801040e9 <piperead>
80101216:	83 c4 10             	add    $0x10,%esp
80101219:	eb 77                	jmp    80101292 <fileread+0xba>
  if(f->type == FD_INODE){
8010121b:	8b 45 08             	mov    0x8(%ebp),%eax
8010121e:	8b 00                	mov    (%eax),%eax
80101220:	83 f8 02             	cmp    $0x2,%eax
80101223:	75 60                	jne    80101285 <fileread+0xad>
    ilock(f->ip);
80101225:	8b 45 08             	mov    0x8(%ebp),%eax
80101228:	8b 40 10             	mov    0x10(%eax),%eax
8010122b:	83 ec 0c             	sub    $0xc,%esp
8010122e:	50                   	push   %eax
8010122f:	e8 66 07 00 00       	call   8010199a <ilock>
80101234:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101237:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010123a:	8b 45 08             	mov    0x8(%ebp),%eax
8010123d:	8b 50 14             	mov    0x14(%eax),%edx
80101240:	8b 45 08             	mov    0x8(%ebp),%eax
80101243:	8b 40 10             	mov    0x10(%eax),%eax
80101246:	51                   	push   %ecx
80101247:	52                   	push   %edx
80101248:	ff 75 0c             	pushl  0xc(%ebp)
8010124b:	50                   	push   %eax
8010124c:	e8 c8 0c 00 00       	call   80101f19 <readi>
80101251:	83 c4 10             	add    $0x10,%esp
80101254:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101257:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010125b:	7e 11                	jle    8010126e <fileread+0x96>
      f->off += r;
8010125d:	8b 45 08             	mov    0x8(%ebp),%eax
80101260:	8b 50 14             	mov    0x14(%eax),%edx
80101263:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101266:	01 c2                	add    %eax,%edx
80101268:	8b 45 08             	mov    0x8(%ebp),%eax
8010126b:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
8010126e:	8b 45 08             	mov    0x8(%ebp),%eax
80101271:	8b 40 10             	mov    0x10(%eax),%eax
80101274:	83 ec 0c             	sub    $0xc,%esp
80101277:	50                   	push   %eax
80101278:	e8 79 08 00 00       	call   80101af6 <iunlock>
8010127d:	83 c4 10             	add    $0x10,%esp
    return r;
80101280:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101283:	eb 0d                	jmp    80101292 <fileread+0xba>
  }
  panic("fileread");
80101285:	83 ec 0c             	sub    $0xc,%esp
80101288:	68 1a 84 10 80       	push   $0x8010841a
8010128d:	e8 05 f3 ff ff       	call   80100597 <panic>
}
80101292:	c9                   	leave  
80101293:	c3                   	ret    

80101294 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101294:	f3 0f 1e fb          	endbr32 
80101298:	55                   	push   %ebp
80101299:	89 e5                	mov    %esp,%ebp
8010129b:	53                   	push   %ebx
8010129c:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
8010129f:	8b 45 08             	mov    0x8(%ebp),%eax
801012a2:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801012a6:	84 c0                	test   %al,%al
801012a8:	75 0a                	jne    801012b4 <filewrite+0x20>
    return -1;
801012aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012af:	e9 1b 01 00 00       	jmp    801013cf <filewrite+0x13b>
  if(f->type == FD_PIPE)
801012b4:	8b 45 08             	mov    0x8(%ebp),%eax
801012b7:	8b 00                	mov    (%eax),%eax
801012b9:	83 f8 01             	cmp    $0x1,%eax
801012bc:	75 1d                	jne    801012db <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
801012be:	8b 45 08             	mov    0x8(%ebp),%eax
801012c1:	8b 40 0c             	mov    0xc(%eax),%eax
801012c4:	83 ec 04             	sub    $0x4,%esp
801012c7:	ff 75 10             	pushl  0x10(%ebp)
801012ca:	ff 75 0c             	pushl  0xc(%ebp)
801012cd:	50                   	push   %eax
801012ce:	e8 0f 2d 00 00       	call   80103fe2 <pipewrite>
801012d3:	83 c4 10             	add    $0x10,%esp
801012d6:	e9 f4 00 00 00       	jmp    801013cf <filewrite+0x13b>
  if(f->type == FD_INODE){
801012db:	8b 45 08             	mov    0x8(%ebp),%eax
801012de:	8b 00                	mov    (%eax),%eax
801012e0:	83 f8 02             	cmp    $0x2,%eax
801012e3:	0f 85 d9 00 00 00    	jne    801013c2 <filewrite+0x12e>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
801012e9:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
801012f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
801012f7:	e9 a3 00 00 00       	jmp    8010139f <filewrite+0x10b>
      int n1 = n - i;
801012fc:	8b 45 10             	mov    0x10(%ebp),%eax
801012ff:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101302:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101305:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101308:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010130b:	7e 06                	jle    80101313 <filewrite+0x7f>
        n1 = max;
8010130d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101310:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_trans();
80101313:	e8 af 20 00 00       	call   801033c7 <begin_trans>
      ilock(f->ip);
80101318:	8b 45 08             	mov    0x8(%ebp),%eax
8010131b:	8b 40 10             	mov    0x10(%eax),%eax
8010131e:	83 ec 0c             	sub    $0xc,%esp
80101321:	50                   	push   %eax
80101322:	e8 73 06 00 00       	call   8010199a <ilock>
80101327:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010132a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010132d:	8b 45 08             	mov    0x8(%ebp),%eax
80101330:	8b 50 14             	mov    0x14(%eax),%edx
80101333:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101336:	8b 45 0c             	mov    0xc(%ebp),%eax
80101339:	01 c3                	add    %eax,%ebx
8010133b:	8b 45 08             	mov    0x8(%ebp),%eax
8010133e:	8b 40 10             	mov    0x10(%eax),%eax
80101341:	51                   	push   %ecx
80101342:	52                   	push   %edx
80101343:	53                   	push   %ebx
80101344:	50                   	push   %eax
80101345:	e8 28 0d 00 00       	call   80102072 <writei>
8010134a:	83 c4 10             	add    $0x10,%esp
8010134d:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101350:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101354:	7e 11                	jle    80101367 <filewrite+0xd3>
        f->off += r;
80101356:	8b 45 08             	mov    0x8(%ebp),%eax
80101359:	8b 50 14             	mov    0x14(%eax),%edx
8010135c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010135f:	01 c2                	add    %eax,%edx
80101361:	8b 45 08             	mov    0x8(%ebp),%eax
80101364:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
80101367:	8b 45 08             	mov    0x8(%ebp),%eax
8010136a:	8b 40 10             	mov    0x10(%eax),%eax
8010136d:	83 ec 0c             	sub    $0xc,%esp
80101370:	50                   	push   %eax
80101371:	e8 80 07 00 00       	call   80101af6 <iunlock>
80101376:	83 c4 10             	add    $0x10,%esp
      commit_trans();
80101379:	e8 a0 20 00 00       	call   8010341e <commit_trans>

      if(r < 0)
8010137e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101382:	78 29                	js     801013ad <filewrite+0x119>
        break;
      if(r != n1)
80101384:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101387:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010138a:	74 0d                	je     80101399 <filewrite+0x105>
        panic("short filewrite");
8010138c:	83 ec 0c             	sub    $0xc,%esp
8010138f:	68 23 84 10 80       	push   $0x80108423
80101394:	e8 fe f1 ff ff       	call   80100597 <panic>
      i += r;
80101399:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010139c:	01 45 f4             	add    %eax,-0xc(%ebp)
    while(i < n){
8010139f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013a2:	3b 45 10             	cmp    0x10(%ebp),%eax
801013a5:	0f 8c 51 ff ff ff    	jl     801012fc <filewrite+0x68>
801013ab:	eb 01                	jmp    801013ae <filewrite+0x11a>
        break;
801013ad:	90                   	nop
    }
    return i == n ? n : -1;
801013ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013b1:	3b 45 10             	cmp    0x10(%ebp),%eax
801013b4:	75 05                	jne    801013bb <filewrite+0x127>
801013b6:	8b 45 10             	mov    0x10(%ebp),%eax
801013b9:	eb 14                	jmp    801013cf <filewrite+0x13b>
801013bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801013c0:	eb 0d                	jmp    801013cf <filewrite+0x13b>
  }
  panic("filewrite");
801013c2:	83 ec 0c             	sub    $0xc,%esp
801013c5:	68 33 84 10 80       	push   $0x80108433
801013ca:	e8 c8 f1 ff ff       	call   80100597 <panic>
}
801013cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801013d2:	c9                   	leave  
801013d3:	c3                   	ret    

801013d4 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013d4:	f3 0f 1e fb          	endbr32 
801013d8:	55                   	push   %ebp
801013d9:	89 e5                	mov    %esp,%ebp
801013db:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
801013de:	8b 45 08             	mov    0x8(%ebp),%eax
801013e1:	83 ec 08             	sub    $0x8,%esp
801013e4:	6a 01                	push   $0x1
801013e6:	50                   	push   %eax
801013e7:	e8 d3 ed ff ff       	call   801001bf <bread>
801013ec:	83 c4 10             	add    $0x10,%esp
801013ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
801013f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013f5:	83 c0 18             	add    $0x18,%eax
801013f8:	83 ec 04             	sub    $0x4,%esp
801013fb:	6a 10                	push   $0x10
801013fd:	50                   	push   %eax
801013fe:	ff 75 0c             	pushl  0xc(%ebp)
80101401:	e8 e9 3c 00 00       	call   801050ef <memmove>
80101406:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101409:	83 ec 0c             	sub    $0xc,%esp
8010140c:	ff 75 f4             	pushl  -0xc(%ebp)
8010140f:	e8 2b ee ff ff       	call   8010023f <brelse>
80101414:	83 c4 10             	add    $0x10,%esp
}
80101417:	90                   	nop
80101418:	c9                   	leave  
80101419:	c3                   	ret    

8010141a <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
8010141a:	f3 0f 1e fb          	endbr32 
8010141e:	55                   	push   %ebp
8010141f:	89 e5                	mov    %esp,%ebp
80101421:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
80101424:	8b 55 0c             	mov    0xc(%ebp),%edx
80101427:	8b 45 08             	mov    0x8(%ebp),%eax
8010142a:	83 ec 08             	sub    $0x8,%esp
8010142d:	52                   	push   %edx
8010142e:	50                   	push   %eax
8010142f:	e8 8b ed ff ff       	call   801001bf <bread>
80101434:	83 c4 10             	add    $0x10,%esp
80101437:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
8010143a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010143d:	83 c0 18             	add    $0x18,%eax
80101440:	83 ec 04             	sub    $0x4,%esp
80101443:	68 00 02 00 00       	push   $0x200
80101448:	6a 00                	push   $0x0
8010144a:	50                   	push   %eax
8010144b:	e8 d8 3b 00 00       	call   80105028 <memset>
80101450:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101453:	83 ec 0c             	sub    $0xc,%esp
80101456:	ff 75 f4             	pushl  -0xc(%ebp)
80101459:	e8 29 20 00 00       	call   80103487 <log_write>
8010145e:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101461:	83 ec 0c             	sub    $0xc,%esp
80101464:	ff 75 f4             	pushl  -0xc(%ebp)
80101467:	e8 d3 ed ff ff       	call   8010023f <brelse>
8010146c:	83 c4 10             	add    $0x10,%esp
}
8010146f:	90                   	nop
80101470:	c9                   	leave  
80101471:	c3                   	ret    

80101472 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101472:	f3 0f 1e fb          	endbr32 
80101476:	55                   	push   %ebp
80101477:	89 e5                	mov    %esp,%ebp
80101479:	83 ec 28             	sub    $0x28,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
8010147c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
80101483:	8b 45 08             	mov    0x8(%ebp),%eax
80101486:	83 ec 08             	sub    $0x8,%esp
80101489:	8d 55 d8             	lea    -0x28(%ebp),%edx
8010148c:	52                   	push   %edx
8010148d:	50                   	push   %eax
8010148e:	e8 41 ff ff ff       	call   801013d4 <readsb>
80101493:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
80101496:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010149d:	e9 15 01 00 00       	jmp    801015b7 <balloc+0x145>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
801014a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014a5:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801014ab:	85 c0                	test   %eax,%eax
801014ad:	0f 48 c2             	cmovs  %edx,%eax
801014b0:	c1 f8 0c             	sar    $0xc,%eax
801014b3:	89 c2                	mov    %eax,%edx
801014b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801014b8:	c1 e8 03             	shr    $0x3,%eax
801014bb:	01 d0                	add    %edx,%eax
801014bd:	83 c0 03             	add    $0x3,%eax
801014c0:	83 ec 08             	sub    $0x8,%esp
801014c3:	50                   	push   %eax
801014c4:	ff 75 08             	pushl  0x8(%ebp)
801014c7:	e8 f3 ec ff ff       	call   801001bf <bread>
801014cc:	83 c4 10             	add    $0x10,%esp
801014cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801014d9:	e9 a6 00 00 00       	jmp    80101584 <balloc+0x112>
      m = 1 << (bi % 8);
801014de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014e1:	99                   	cltd   
801014e2:	c1 ea 1d             	shr    $0x1d,%edx
801014e5:	01 d0                	add    %edx,%eax
801014e7:	83 e0 07             	and    $0x7,%eax
801014ea:	29 d0                	sub    %edx,%eax
801014ec:	ba 01 00 00 00       	mov    $0x1,%edx
801014f1:	89 c1                	mov    %eax,%ecx
801014f3:	d3 e2                	shl    %cl,%edx
801014f5:	89 d0                	mov    %edx,%eax
801014f7:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801014fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014fd:	8d 50 07             	lea    0x7(%eax),%edx
80101500:	85 c0                	test   %eax,%eax
80101502:	0f 48 c2             	cmovs  %edx,%eax
80101505:	c1 f8 03             	sar    $0x3,%eax
80101508:	89 c2                	mov    %eax,%edx
8010150a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010150d:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101512:	0f b6 c0             	movzbl %al,%eax
80101515:	23 45 e8             	and    -0x18(%ebp),%eax
80101518:	85 c0                	test   %eax,%eax
8010151a:	75 64                	jne    80101580 <balloc+0x10e>
        bp->data[bi/8] |= m;  // Mark block in use.
8010151c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010151f:	8d 50 07             	lea    0x7(%eax),%edx
80101522:	85 c0                	test   %eax,%eax
80101524:	0f 48 c2             	cmovs  %edx,%eax
80101527:	c1 f8 03             	sar    $0x3,%eax
8010152a:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010152d:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101532:	89 d1                	mov    %edx,%ecx
80101534:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101537:	09 ca                	or     %ecx,%edx
80101539:	89 d1                	mov    %edx,%ecx
8010153b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010153e:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
80101542:	83 ec 0c             	sub    $0xc,%esp
80101545:	ff 75 ec             	pushl  -0x14(%ebp)
80101548:	e8 3a 1f 00 00       	call   80103487 <log_write>
8010154d:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
80101550:	83 ec 0c             	sub    $0xc,%esp
80101553:	ff 75 ec             	pushl  -0x14(%ebp)
80101556:	e8 e4 ec ff ff       	call   8010023f <brelse>
8010155b:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
8010155e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101561:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101564:	01 c2                	add    %eax,%edx
80101566:	8b 45 08             	mov    0x8(%ebp),%eax
80101569:	83 ec 08             	sub    $0x8,%esp
8010156c:	52                   	push   %edx
8010156d:	50                   	push   %eax
8010156e:	e8 a7 fe ff ff       	call   8010141a <bzero>
80101573:	83 c4 10             	add    $0x10,%esp
        return b + bi;
80101576:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101579:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010157c:	01 d0                	add    %edx,%eax
8010157e:	eb 52                	jmp    801015d2 <balloc+0x160>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101580:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101584:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
8010158b:	7f 15                	jg     801015a2 <balloc+0x130>
8010158d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101590:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101593:	01 d0                	add    %edx,%eax
80101595:	89 c2                	mov    %eax,%edx
80101597:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010159a:	39 c2                	cmp    %eax,%edx
8010159c:	0f 82 3c ff ff ff    	jb     801014de <balloc+0x6c>
      }
    }
    brelse(bp);
801015a2:	83 ec 0c             	sub    $0xc,%esp
801015a5:	ff 75 ec             	pushl  -0x14(%ebp)
801015a8:	e8 92 ec ff ff       	call   8010023f <brelse>
801015ad:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
801015b0:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801015b7:	8b 55 d8             	mov    -0x28(%ebp),%edx
801015ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015bd:	39 c2                	cmp    %eax,%edx
801015bf:	0f 87 dd fe ff ff    	ja     801014a2 <balloc+0x30>
  }
  panic("balloc: out of blocks");
801015c5:	83 ec 0c             	sub    $0xc,%esp
801015c8:	68 3d 84 10 80       	push   $0x8010843d
801015cd:	e8 c5 ef ff ff       	call   80100597 <panic>
}
801015d2:	c9                   	leave  
801015d3:	c3                   	ret    

801015d4 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
801015d4:	f3 0f 1e fb          	endbr32 
801015d8:	55                   	push   %ebp
801015d9:	89 e5                	mov    %esp,%ebp
801015db:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
801015de:	83 ec 08             	sub    $0x8,%esp
801015e1:	8d 45 dc             	lea    -0x24(%ebp),%eax
801015e4:	50                   	push   %eax
801015e5:	ff 75 08             	pushl  0x8(%ebp)
801015e8:	e8 e7 fd ff ff       	call   801013d4 <readsb>
801015ed:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb.ninodes));
801015f0:	8b 45 0c             	mov    0xc(%ebp),%eax
801015f3:	c1 e8 0c             	shr    $0xc,%eax
801015f6:	89 c2                	mov    %eax,%edx
801015f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801015fb:	c1 e8 03             	shr    $0x3,%eax
801015fe:	01 d0                	add    %edx,%eax
80101600:	8d 50 03             	lea    0x3(%eax),%edx
80101603:	8b 45 08             	mov    0x8(%ebp),%eax
80101606:	83 ec 08             	sub    $0x8,%esp
80101609:	52                   	push   %edx
8010160a:	50                   	push   %eax
8010160b:	e8 af eb ff ff       	call   801001bf <bread>
80101610:	83 c4 10             	add    $0x10,%esp
80101613:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101616:	8b 45 0c             	mov    0xc(%ebp),%eax
80101619:	25 ff 0f 00 00       	and    $0xfff,%eax
8010161e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101621:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101624:	99                   	cltd   
80101625:	c1 ea 1d             	shr    $0x1d,%edx
80101628:	01 d0                	add    %edx,%eax
8010162a:	83 e0 07             	and    $0x7,%eax
8010162d:	29 d0                	sub    %edx,%eax
8010162f:	ba 01 00 00 00       	mov    $0x1,%edx
80101634:	89 c1                	mov    %eax,%ecx
80101636:	d3 e2                	shl    %cl,%edx
80101638:	89 d0                	mov    %edx,%eax
8010163a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
8010163d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101640:	8d 50 07             	lea    0x7(%eax),%edx
80101643:	85 c0                	test   %eax,%eax
80101645:	0f 48 c2             	cmovs  %edx,%eax
80101648:	c1 f8 03             	sar    $0x3,%eax
8010164b:	89 c2                	mov    %eax,%edx
8010164d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101650:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101655:	0f b6 c0             	movzbl %al,%eax
80101658:	23 45 ec             	and    -0x14(%ebp),%eax
8010165b:	85 c0                	test   %eax,%eax
8010165d:	75 0d                	jne    8010166c <bfree+0x98>
    panic("freeing free block");
8010165f:	83 ec 0c             	sub    $0xc,%esp
80101662:	68 53 84 10 80       	push   $0x80108453
80101667:	e8 2b ef ff ff       	call   80100597 <panic>
  bp->data[bi/8] &= ~m;
8010166c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010166f:	8d 50 07             	lea    0x7(%eax),%edx
80101672:	85 c0                	test   %eax,%eax
80101674:	0f 48 c2             	cmovs  %edx,%eax
80101677:	c1 f8 03             	sar    $0x3,%eax
8010167a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010167d:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101682:	89 d1                	mov    %edx,%ecx
80101684:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101687:	f7 d2                	not    %edx
80101689:	21 ca                	and    %ecx,%edx
8010168b:	89 d1                	mov    %edx,%ecx
8010168d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101690:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
80101694:	83 ec 0c             	sub    $0xc,%esp
80101697:	ff 75 f4             	pushl  -0xc(%ebp)
8010169a:	e8 e8 1d 00 00       	call   80103487 <log_write>
8010169f:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801016a2:	83 ec 0c             	sub    $0xc,%esp
801016a5:	ff 75 f4             	pushl  -0xc(%ebp)
801016a8:	e8 92 eb ff ff       	call   8010023f <brelse>
801016ad:	83 c4 10             	add    $0x10,%esp
}
801016b0:	90                   	nop
801016b1:	c9                   	leave  
801016b2:	c3                   	ret    

801016b3 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
801016b3:	f3 0f 1e fb          	endbr32 
801016b7:	55                   	push   %ebp
801016b8:	89 e5                	mov    %esp,%ebp
801016ba:	83 ec 08             	sub    $0x8,%esp
  initlock(&icache.lock, "icache");
801016bd:	83 ec 08             	sub    $0x8,%esp
801016c0:	68 66 84 10 80       	push   $0x80108466
801016c5:	68 60 e8 10 80       	push   $0x8010e860
801016ca:	e8 b7 36 00 00       	call   80104d86 <initlock>
801016cf:	83 c4 10             	add    $0x10,%esp
}
801016d2:	90                   	nop
801016d3:	c9                   	leave  
801016d4:	c3                   	ret    

801016d5 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801016d5:	f3 0f 1e fb          	endbr32 
801016d9:	55                   	push   %ebp
801016da:	89 e5                	mov    %esp,%ebp
801016dc:	83 ec 38             	sub    $0x38,%esp
801016df:	8b 45 0c             	mov    0xc(%ebp),%eax
801016e2:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
801016e6:	8b 45 08             	mov    0x8(%ebp),%eax
801016e9:	83 ec 08             	sub    $0x8,%esp
801016ec:	8d 55 dc             	lea    -0x24(%ebp),%edx
801016ef:	52                   	push   %edx
801016f0:	50                   	push   %eax
801016f1:	e8 de fc ff ff       	call   801013d4 <readsb>
801016f6:	83 c4 10             	add    $0x10,%esp

  for(inum = 1; inum < sb.ninodes; inum++){
801016f9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101700:	e9 98 00 00 00       	jmp    8010179d <ialloc+0xc8>
    bp = bread(dev, IBLOCK(inum));
80101705:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101708:	c1 e8 03             	shr    $0x3,%eax
8010170b:	83 c0 02             	add    $0x2,%eax
8010170e:	83 ec 08             	sub    $0x8,%esp
80101711:	50                   	push   %eax
80101712:	ff 75 08             	pushl  0x8(%ebp)
80101715:	e8 a5 ea ff ff       	call   801001bf <bread>
8010171a:	83 c4 10             	add    $0x10,%esp
8010171d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101720:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101723:	8d 50 18             	lea    0x18(%eax),%edx
80101726:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101729:	83 e0 07             	and    $0x7,%eax
8010172c:	c1 e0 06             	shl    $0x6,%eax
8010172f:	01 d0                	add    %edx,%eax
80101731:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101734:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101737:	0f b7 00             	movzwl (%eax),%eax
8010173a:	66 85 c0             	test   %ax,%ax
8010173d:	75 4c                	jne    8010178b <ialloc+0xb6>
      memset(dip, 0, sizeof(*dip));
8010173f:	83 ec 04             	sub    $0x4,%esp
80101742:	6a 40                	push   $0x40
80101744:	6a 00                	push   $0x0
80101746:	ff 75 ec             	pushl  -0x14(%ebp)
80101749:	e8 da 38 00 00       	call   80105028 <memset>
8010174e:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
80101751:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101754:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
80101758:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
8010175b:	83 ec 0c             	sub    $0xc,%esp
8010175e:	ff 75 f0             	pushl  -0x10(%ebp)
80101761:	e8 21 1d 00 00       	call   80103487 <log_write>
80101766:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
80101769:	83 ec 0c             	sub    $0xc,%esp
8010176c:	ff 75 f0             	pushl  -0x10(%ebp)
8010176f:	e8 cb ea ff ff       	call   8010023f <brelse>
80101774:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
80101777:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010177a:	83 ec 08             	sub    $0x8,%esp
8010177d:	50                   	push   %eax
8010177e:	ff 75 08             	pushl  0x8(%ebp)
80101781:	e8 f3 00 00 00       	call   80101879 <iget>
80101786:	83 c4 10             	add    $0x10,%esp
80101789:	eb 2d                	jmp    801017b8 <ialloc+0xe3>
    }
    brelse(bp);
8010178b:	83 ec 0c             	sub    $0xc,%esp
8010178e:	ff 75 f0             	pushl  -0x10(%ebp)
80101791:	e8 a9 ea ff ff       	call   8010023f <brelse>
80101796:	83 c4 10             	add    $0x10,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101799:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010179d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801017a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017a3:	39 c2                	cmp    %eax,%edx
801017a5:	0f 87 5a ff ff ff    	ja     80101705 <ialloc+0x30>
  }
  panic("ialloc: no inodes");
801017ab:	83 ec 0c             	sub    $0xc,%esp
801017ae:	68 6d 84 10 80       	push   $0x8010846d
801017b3:	e8 df ed ff ff       	call   80100597 <panic>
}
801017b8:	c9                   	leave  
801017b9:	c3                   	ret    

801017ba <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801017ba:	f3 0f 1e fb          	endbr32 
801017be:	55                   	push   %ebp
801017bf:	89 e5                	mov    %esp,%ebp
801017c1:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
801017c4:	8b 45 08             	mov    0x8(%ebp),%eax
801017c7:	8b 40 04             	mov    0x4(%eax),%eax
801017ca:	c1 e8 03             	shr    $0x3,%eax
801017cd:	8d 50 02             	lea    0x2(%eax),%edx
801017d0:	8b 45 08             	mov    0x8(%ebp),%eax
801017d3:	8b 00                	mov    (%eax),%eax
801017d5:	83 ec 08             	sub    $0x8,%esp
801017d8:	52                   	push   %edx
801017d9:	50                   	push   %eax
801017da:	e8 e0 e9 ff ff       	call   801001bf <bread>
801017df:	83 c4 10             	add    $0x10,%esp
801017e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017e8:	8d 50 18             	lea    0x18(%eax),%edx
801017eb:	8b 45 08             	mov    0x8(%ebp),%eax
801017ee:	8b 40 04             	mov    0x4(%eax),%eax
801017f1:	83 e0 07             	and    $0x7,%eax
801017f4:	c1 e0 06             	shl    $0x6,%eax
801017f7:	01 d0                	add    %edx,%eax
801017f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
801017fc:	8b 45 08             	mov    0x8(%ebp),%eax
801017ff:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101803:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101806:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101809:	8b 45 08             	mov    0x8(%ebp),%eax
8010180c:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101810:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101813:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101817:	8b 45 08             	mov    0x8(%ebp),%eax
8010181a:	0f b7 50 14          	movzwl 0x14(%eax),%edx
8010181e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101821:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101825:	8b 45 08             	mov    0x8(%ebp),%eax
80101828:	0f b7 50 16          	movzwl 0x16(%eax),%edx
8010182c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010182f:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101833:	8b 45 08             	mov    0x8(%ebp),%eax
80101836:	8b 50 18             	mov    0x18(%eax),%edx
80101839:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010183c:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010183f:	8b 45 08             	mov    0x8(%ebp),%eax
80101842:	8d 50 1c             	lea    0x1c(%eax),%edx
80101845:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101848:	83 c0 0c             	add    $0xc,%eax
8010184b:	83 ec 04             	sub    $0x4,%esp
8010184e:	6a 34                	push   $0x34
80101850:	52                   	push   %edx
80101851:	50                   	push   %eax
80101852:	e8 98 38 00 00       	call   801050ef <memmove>
80101857:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
8010185a:	83 ec 0c             	sub    $0xc,%esp
8010185d:	ff 75 f4             	pushl  -0xc(%ebp)
80101860:	e8 22 1c 00 00       	call   80103487 <log_write>
80101865:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101868:	83 ec 0c             	sub    $0xc,%esp
8010186b:	ff 75 f4             	pushl  -0xc(%ebp)
8010186e:	e8 cc e9 ff ff       	call   8010023f <brelse>
80101873:	83 c4 10             	add    $0x10,%esp
}
80101876:	90                   	nop
80101877:	c9                   	leave  
80101878:	c3                   	ret    

80101879 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101879:	f3 0f 1e fb          	endbr32 
8010187d:	55                   	push   %ebp
8010187e:	89 e5                	mov    %esp,%ebp
80101880:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101883:	83 ec 0c             	sub    $0xc,%esp
80101886:	68 60 e8 10 80       	push   $0x8010e860
8010188b:	e8 1c 35 00 00       	call   80104dac <acquire>
80101890:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101893:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010189a:	c7 45 f4 94 e8 10 80 	movl   $0x8010e894,-0xc(%ebp)
801018a1:	eb 5d                	jmp    80101900 <iget+0x87>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a6:	8b 40 08             	mov    0x8(%eax),%eax
801018a9:	85 c0                	test   %eax,%eax
801018ab:	7e 39                	jle    801018e6 <iget+0x6d>
801018ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018b0:	8b 00                	mov    (%eax),%eax
801018b2:	39 45 08             	cmp    %eax,0x8(%ebp)
801018b5:	75 2f                	jne    801018e6 <iget+0x6d>
801018b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ba:	8b 40 04             	mov    0x4(%eax),%eax
801018bd:	39 45 0c             	cmp    %eax,0xc(%ebp)
801018c0:	75 24                	jne    801018e6 <iget+0x6d>
      ip->ref++;
801018c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018c5:	8b 40 08             	mov    0x8(%eax),%eax
801018c8:	8d 50 01             	lea    0x1(%eax),%edx
801018cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ce:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
801018d1:	83 ec 0c             	sub    $0xc,%esp
801018d4:	68 60 e8 10 80       	push   $0x8010e860
801018d9:	e8 39 35 00 00       	call   80104e17 <release>
801018de:	83 c4 10             	add    $0x10,%esp
      return ip;
801018e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018e4:	eb 74                	jmp    8010195a <iget+0xe1>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801018e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801018ea:	75 10                	jne    801018fc <iget+0x83>
801018ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ef:	8b 40 08             	mov    0x8(%eax),%eax
801018f2:	85 c0                	test   %eax,%eax
801018f4:	75 06                	jne    801018fc <iget+0x83>
      empty = ip;
801018f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018fc:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101900:	81 7d f4 34 f8 10 80 	cmpl   $0x8010f834,-0xc(%ebp)
80101907:	72 9a                	jb     801018a3 <iget+0x2a>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101909:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010190d:	75 0d                	jne    8010191c <iget+0xa3>
    panic("iget: no inodes");
8010190f:	83 ec 0c             	sub    $0xc,%esp
80101912:	68 7f 84 10 80       	push   $0x8010847f
80101917:	e8 7b ec ff ff       	call   80100597 <panic>

  ip = empty;
8010191c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010191f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101922:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101925:	8b 55 08             	mov    0x8(%ebp),%edx
80101928:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
8010192a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010192d:	8b 55 0c             	mov    0xc(%ebp),%edx
80101930:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101933:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101936:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
8010193d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101940:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101947:	83 ec 0c             	sub    $0xc,%esp
8010194a:	68 60 e8 10 80       	push   $0x8010e860
8010194f:	e8 c3 34 00 00       	call   80104e17 <release>
80101954:	83 c4 10             	add    $0x10,%esp

  return ip;
80101957:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010195a:	c9                   	leave  
8010195b:	c3                   	ret    

8010195c <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
8010195c:	f3 0f 1e fb          	endbr32 
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101966:	83 ec 0c             	sub    $0xc,%esp
80101969:	68 60 e8 10 80       	push   $0x8010e860
8010196e:	e8 39 34 00 00       	call   80104dac <acquire>
80101973:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101976:	8b 45 08             	mov    0x8(%ebp),%eax
80101979:	8b 40 08             	mov    0x8(%eax),%eax
8010197c:	8d 50 01             	lea    0x1(%eax),%edx
8010197f:	8b 45 08             	mov    0x8(%ebp),%eax
80101982:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101985:	83 ec 0c             	sub    $0xc,%esp
80101988:	68 60 e8 10 80       	push   $0x8010e860
8010198d:	e8 85 34 00 00       	call   80104e17 <release>
80101992:	83 c4 10             	add    $0x10,%esp
  return ip;
80101995:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101998:	c9                   	leave  
80101999:	c3                   	ret    

8010199a <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
8010199a:	f3 0f 1e fb          	endbr32 
8010199e:	55                   	push   %ebp
8010199f:	89 e5                	mov    %esp,%ebp
801019a1:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801019a4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801019a8:	74 0a                	je     801019b4 <ilock+0x1a>
801019aa:	8b 45 08             	mov    0x8(%ebp),%eax
801019ad:	8b 40 08             	mov    0x8(%eax),%eax
801019b0:	85 c0                	test   %eax,%eax
801019b2:	7f 0d                	jg     801019c1 <ilock+0x27>
    panic("ilock");
801019b4:	83 ec 0c             	sub    $0xc,%esp
801019b7:	68 8f 84 10 80       	push   $0x8010848f
801019bc:	e8 d6 eb ff ff       	call   80100597 <panic>

  acquire(&icache.lock);
801019c1:	83 ec 0c             	sub    $0xc,%esp
801019c4:	68 60 e8 10 80       	push   $0x8010e860
801019c9:	e8 de 33 00 00       	call   80104dac <acquire>
801019ce:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
801019d1:	eb 13                	jmp    801019e6 <ilock+0x4c>
    sleep(ip, &icache.lock);
801019d3:	83 ec 08             	sub    $0x8,%esp
801019d6:	68 60 e8 10 80       	push   $0x8010e860
801019db:	ff 75 08             	pushl  0x8(%ebp)
801019de:	e8 b6 30 00 00       	call   80104a99 <sleep>
801019e3:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
801019e6:	8b 45 08             	mov    0x8(%ebp),%eax
801019e9:	8b 40 0c             	mov    0xc(%eax),%eax
801019ec:	83 e0 01             	and    $0x1,%eax
801019ef:	85 c0                	test   %eax,%eax
801019f1:	75 e0                	jne    801019d3 <ilock+0x39>
  ip->flags |= I_BUSY;
801019f3:	8b 45 08             	mov    0x8(%ebp),%eax
801019f6:	8b 40 0c             	mov    0xc(%eax),%eax
801019f9:	83 c8 01             	or     $0x1,%eax
801019fc:	89 c2                	mov    %eax,%edx
801019fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101a01:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
80101a04:	83 ec 0c             	sub    $0xc,%esp
80101a07:	68 60 e8 10 80       	push   $0x8010e860
80101a0c:	e8 06 34 00 00       	call   80104e17 <release>
80101a11:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
80101a14:	8b 45 08             	mov    0x8(%ebp),%eax
80101a17:	8b 40 0c             	mov    0xc(%eax),%eax
80101a1a:	83 e0 02             	and    $0x2,%eax
80101a1d:	85 c0                	test   %eax,%eax
80101a1f:	0f 85 ce 00 00 00    	jne    80101af3 <ilock+0x159>
    bp = bread(ip->dev, IBLOCK(ip->inum));
80101a25:	8b 45 08             	mov    0x8(%ebp),%eax
80101a28:	8b 40 04             	mov    0x4(%eax),%eax
80101a2b:	c1 e8 03             	shr    $0x3,%eax
80101a2e:	8d 50 02             	lea    0x2(%eax),%edx
80101a31:	8b 45 08             	mov    0x8(%ebp),%eax
80101a34:	8b 00                	mov    (%eax),%eax
80101a36:	83 ec 08             	sub    $0x8,%esp
80101a39:	52                   	push   %edx
80101a3a:	50                   	push   %eax
80101a3b:	e8 7f e7 ff ff       	call   801001bf <bread>
80101a40:	83 c4 10             	add    $0x10,%esp
80101a43:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a49:	8d 50 18             	lea    0x18(%eax),%edx
80101a4c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4f:	8b 40 04             	mov    0x4(%eax),%eax
80101a52:	83 e0 07             	and    $0x7,%eax
80101a55:	c1 e0 06             	shl    $0x6,%eax
80101a58:	01 d0                	add    %edx,%eax
80101a5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a60:	0f b7 10             	movzwl (%eax),%edx
80101a63:	8b 45 08             	mov    0x8(%ebp),%eax
80101a66:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101a6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a6d:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101a71:	8b 45 08             	mov    0x8(%ebp),%eax
80101a74:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101a78:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a7b:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101a7f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a82:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101a86:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a89:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101a8d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a90:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101a94:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a97:	8b 50 08             	mov    0x8(%eax),%edx
80101a9a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9d:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101aa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101aa3:	8d 50 0c             	lea    0xc(%eax),%edx
80101aa6:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa9:	83 c0 1c             	add    $0x1c,%eax
80101aac:	83 ec 04             	sub    $0x4,%esp
80101aaf:	6a 34                	push   $0x34
80101ab1:	52                   	push   %edx
80101ab2:	50                   	push   %eax
80101ab3:	e8 37 36 00 00       	call   801050ef <memmove>
80101ab8:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101abb:	83 ec 0c             	sub    $0xc,%esp
80101abe:	ff 75 f4             	pushl  -0xc(%ebp)
80101ac1:	e8 79 e7 ff ff       	call   8010023f <brelse>
80101ac6:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101ac9:	8b 45 08             	mov    0x8(%ebp),%eax
80101acc:	8b 40 0c             	mov    0xc(%eax),%eax
80101acf:	83 c8 02             	or     $0x2,%eax
80101ad2:	89 c2                	mov    %eax,%edx
80101ad4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad7:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101ada:	8b 45 08             	mov    0x8(%ebp),%eax
80101add:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101ae1:	66 85 c0             	test   %ax,%ax
80101ae4:	75 0d                	jne    80101af3 <ilock+0x159>
      panic("ilock: no type");
80101ae6:	83 ec 0c             	sub    $0xc,%esp
80101ae9:	68 95 84 10 80       	push   $0x80108495
80101aee:	e8 a4 ea ff ff       	call   80100597 <panic>
  }
}
80101af3:	90                   	nop
80101af4:	c9                   	leave  
80101af5:	c3                   	ret    

80101af6 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101af6:	f3 0f 1e fb          	endbr32 
80101afa:	55                   	push   %ebp
80101afb:	89 e5                	mov    %esp,%ebp
80101afd:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101b00:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101b04:	74 17                	je     80101b1d <iunlock+0x27>
80101b06:	8b 45 08             	mov    0x8(%ebp),%eax
80101b09:	8b 40 0c             	mov    0xc(%eax),%eax
80101b0c:	83 e0 01             	and    $0x1,%eax
80101b0f:	85 c0                	test   %eax,%eax
80101b11:	74 0a                	je     80101b1d <iunlock+0x27>
80101b13:	8b 45 08             	mov    0x8(%ebp),%eax
80101b16:	8b 40 08             	mov    0x8(%eax),%eax
80101b19:	85 c0                	test   %eax,%eax
80101b1b:	7f 0d                	jg     80101b2a <iunlock+0x34>
    panic("iunlock");
80101b1d:	83 ec 0c             	sub    $0xc,%esp
80101b20:	68 a4 84 10 80       	push   $0x801084a4
80101b25:	e8 6d ea ff ff       	call   80100597 <panic>

  acquire(&icache.lock);
80101b2a:	83 ec 0c             	sub    $0xc,%esp
80101b2d:	68 60 e8 10 80       	push   $0x8010e860
80101b32:	e8 75 32 00 00       	call   80104dac <acquire>
80101b37:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101b3a:	8b 45 08             	mov    0x8(%ebp),%eax
80101b3d:	8b 40 0c             	mov    0xc(%eax),%eax
80101b40:	83 e0 fe             	and    $0xfffffffe,%eax
80101b43:	89 c2                	mov    %eax,%edx
80101b45:	8b 45 08             	mov    0x8(%ebp),%eax
80101b48:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101b4b:	83 ec 0c             	sub    $0xc,%esp
80101b4e:	ff 75 08             	pushl  0x8(%ebp)
80101b51:	e8 37 30 00 00       	call   80104b8d <wakeup>
80101b56:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101b59:	83 ec 0c             	sub    $0xc,%esp
80101b5c:	68 60 e8 10 80       	push   $0x8010e860
80101b61:	e8 b1 32 00 00       	call   80104e17 <release>
80101b66:	83 c4 10             	add    $0x10,%esp
}
80101b69:	90                   	nop
80101b6a:	c9                   	leave  
80101b6b:	c3                   	ret    

80101b6c <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
80101b6c:	f3 0f 1e fb          	endbr32 
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101b76:	83 ec 0c             	sub    $0xc,%esp
80101b79:	68 60 e8 10 80       	push   $0x8010e860
80101b7e:	e8 29 32 00 00       	call   80104dac <acquire>
80101b83:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101b86:	8b 45 08             	mov    0x8(%ebp),%eax
80101b89:	8b 40 08             	mov    0x8(%eax),%eax
80101b8c:	83 f8 01             	cmp    $0x1,%eax
80101b8f:	0f 85 a9 00 00 00    	jne    80101c3e <iput+0xd2>
80101b95:	8b 45 08             	mov    0x8(%ebp),%eax
80101b98:	8b 40 0c             	mov    0xc(%eax),%eax
80101b9b:	83 e0 02             	and    $0x2,%eax
80101b9e:	85 c0                	test   %eax,%eax
80101ba0:	0f 84 98 00 00 00    	je     80101c3e <iput+0xd2>
80101ba6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba9:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101bad:	66 85 c0             	test   %ax,%ax
80101bb0:	0f 85 88 00 00 00    	jne    80101c3e <iput+0xd2>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
80101bb6:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb9:	8b 40 0c             	mov    0xc(%eax),%eax
80101bbc:	83 e0 01             	and    $0x1,%eax
80101bbf:	85 c0                	test   %eax,%eax
80101bc1:	74 0d                	je     80101bd0 <iput+0x64>
      panic("iput busy");
80101bc3:	83 ec 0c             	sub    $0xc,%esp
80101bc6:	68 ac 84 10 80       	push   $0x801084ac
80101bcb:	e8 c7 e9 ff ff       	call   80100597 <panic>
    ip->flags |= I_BUSY;
80101bd0:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd3:	8b 40 0c             	mov    0xc(%eax),%eax
80101bd6:	83 c8 01             	or     $0x1,%eax
80101bd9:	89 c2                	mov    %eax,%edx
80101bdb:	8b 45 08             	mov    0x8(%ebp),%eax
80101bde:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101be1:	83 ec 0c             	sub    $0xc,%esp
80101be4:	68 60 e8 10 80       	push   $0x8010e860
80101be9:	e8 29 32 00 00       	call   80104e17 <release>
80101bee:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101bf1:	83 ec 0c             	sub    $0xc,%esp
80101bf4:	ff 75 08             	pushl  0x8(%ebp)
80101bf7:	e8 ab 01 00 00       	call   80101da7 <itrunc>
80101bfc:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101bff:	8b 45 08             	mov    0x8(%ebp),%eax
80101c02:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101c08:	83 ec 0c             	sub    $0xc,%esp
80101c0b:	ff 75 08             	pushl  0x8(%ebp)
80101c0e:	e8 a7 fb ff ff       	call   801017ba <iupdate>
80101c13:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101c16:	83 ec 0c             	sub    $0xc,%esp
80101c19:	68 60 e8 10 80       	push   $0x8010e860
80101c1e:	e8 89 31 00 00       	call   80104dac <acquire>
80101c23:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101c26:	8b 45 08             	mov    0x8(%ebp),%eax
80101c29:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101c30:	83 ec 0c             	sub    $0xc,%esp
80101c33:	ff 75 08             	pushl  0x8(%ebp)
80101c36:	e8 52 2f 00 00       	call   80104b8d <wakeup>
80101c3b:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101c3e:	8b 45 08             	mov    0x8(%ebp),%eax
80101c41:	8b 40 08             	mov    0x8(%eax),%eax
80101c44:	8d 50 ff             	lea    -0x1(%eax),%edx
80101c47:	8b 45 08             	mov    0x8(%ebp),%eax
80101c4a:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101c4d:	83 ec 0c             	sub    $0xc,%esp
80101c50:	68 60 e8 10 80       	push   $0x8010e860
80101c55:	e8 bd 31 00 00       	call   80104e17 <release>
80101c5a:	83 c4 10             	add    $0x10,%esp
}
80101c5d:	90                   	nop
80101c5e:	c9                   	leave  
80101c5f:	c3                   	ret    

80101c60 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101c60:	f3 0f 1e fb          	endbr32 
80101c64:	55                   	push   %ebp
80101c65:	89 e5                	mov    %esp,%ebp
80101c67:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101c6a:	83 ec 0c             	sub    $0xc,%esp
80101c6d:	ff 75 08             	pushl  0x8(%ebp)
80101c70:	e8 81 fe ff ff       	call   80101af6 <iunlock>
80101c75:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101c78:	83 ec 0c             	sub    $0xc,%esp
80101c7b:	ff 75 08             	pushl  0x8(%ebp)
80101c7e:	e8 e9 fe ff ff       	call   80101b6c <iput>
80101c83:	83 c4 10             	add    $0x10,%esp
}
80101c86:	90                   	nop
80101c87:	c9                   	leave  
80101c88:	c3                   	ret    

80101c89 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101c89:	f3 0f 1e fb          	endbr32 
80101c8d:	55                   	push   %ebp
80101c8e:	89 e5                	mov    %esp,%ebp
80101c90:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101c93:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101c97:	77 42                	ja     80101cdb <bmap+0x52>
    if((addr = ip->addrs[bn]) == 0)
80101c99:	8b 45 08             	mov    0x8(%ebp),%eax
80101c9c:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c9f:	83 c2 04             	add    $0x4,%edx
80101ca2:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101ca6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ca9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101cad:	75 24                	jne    80101cd3 <bmap+0x4a>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101caf:	8b 45 08             	mov    0x8(%ebp),%eax
80101cb2:	8b 00                	mov    (%eax),%eax
80101cb4:	83 ec 0c             	sub    $0xc,%esp
80101cb7:	50                   	push   %eax
80101cb8:	e8 b5 f7 ff ff       	call   80101472 <balloc>
80101cbd:	83 c4 10             	add    $0x10,%esp
80101cc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cc3:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc6:	8b 55 0c             	mov    0xc(%ebp),%edx
80101cc9:	8d 4a 04             	lea    0x4(%edx),%ecx
80101ccc:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101ccf:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cd6:	e9 ca 00 00 00       	jmp    80101da5 <bmap+0x11c>
  }
  bn -= NDIRECT;
80101cdb:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101cdf:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101ce3:	0f 87 af 00 00 00    	ja     80101d98 <bmap+0x10f>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101ce9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cec:	8b 40 4c             	mov    0x4c(%eax),%eax
80101cef:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cf2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101cf6:	75 1d                	jne    80101d15 <bmap+0x8c>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101cf8:	8b 45 08             	mov    0x8(%ebp),%eax
80101cfb:	8b 00                	mov    (%eax),%eax
80101cfd:	83 ec 0c             	sub    $0xc,%esp
80101d00:	50                   	push   %eax
80101d01:	e8 6c f7 ff ff       	call   80101472 <balloc>
80101d06:	83 c4 10             	add    $0x10,%esp
80101d09:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d0c:	8b 45 08             	mov    0x8(%ebp),%eax
80101d0f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d12:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101d15:	8b 45 08             	mov    0x8(%ebp),%eax
80101d18:	8b 00                	mov    (%eax),%eax
80101d1a:	83 ec 08             	sub    $0x8,%esp
80101d1d:	ff 75 f4             	pushl  -0xc(%ebp)
80101d20:	50                   	push   %eax
80101d21:	e8 99 e4 ff ff       	call   801001bf <bread>
80101d26:	83 c4 10             	add    $0x10,%esp
80101d29:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101d2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d2f:	83 c0 18             	add    $0x18,%eax
80101d32:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101d35:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d38:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d3f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d42:	01 d0                	add    %edx,%eax
80101d44:	8b 00                	mov    (%eax),%eax
80101d46:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d49:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101d4d:	75 36                	jne    80101d85 <bmap+0xfc>
      a[bn] = addr = balloc(ip->dev);
80101d4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d52:	8b 00                	mov    (%eax),%eax
80101d54:	83 ec 0c             	sub    $0xc,%esp
80101d57:	50                   	push   %eax
80101d58:	e8 15 f7 ff ff       	call   80101472 <balloc>
80101d5d:	83 c4 10             	add    $0x10,%esp
80101d60:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d63:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d66:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d70:	01 c2                	add    %eax,%edx
80101d72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d75:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101d77:	83 ec 0c             	sub    $0xc,%esp
80101d7a:	ff 75 f0             	pushl  -0x10(%ebp)
80101d7d:	e8 05 17 00 00       	call   80103487 <log_write>
80101d82:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101d85:	83 ec 0c             	sub    $0xc,%esp
80101d88:	ff 75 f0             	pushl  -0x10(%ebp)
80101d8b:	e8 af e4 ff ff       	call   8010023f <brelse>
80101d90:	83 c4 10             	add    $0x10,%esp
    return addr;
80101d93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d96:	eb 0d                	jmp    80101da5 <bmap+0x11c>
  }

  panic("bmap: out of range");
80101d98:	83 ec 0c             	sub    $0xc,%esp
80101d9b:	68 b6 84 10 80       	push   $0x801084b6
80101da0:	e8 f2 e7 ff ff       	call   80100597 <panic>
}
80101da5:	c9                   	leave  
80101da6:	c3                   	ret    

80101da7 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101da7:	f3 0f 1e fb          	endbr32 
80101dab:	55                   	push   %ebp
80101dac:	89 e5                	mov    %esp,%ebp
80101dae:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101db1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101db8:	eb 45                	jmp    80101dff <itrunc+0x58>
    if(ip->addrs[i]){
80101dba:	8b 45 08             	mov    0x8(%ebp),%eax
80101dbd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101dc0:	83 c2 04             	add    $0x4,%edx
80101dc3:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101dc7:	85 c0                	test   %eax,%eax
80101dc9:	74 30                	je     80101dfb <itrunc+0x54>
      bfree(ip->dev, ip->addrs[i]);
80101dcb:	8b 45 08             	mov    0x8(%ebp),%eax
80101dce:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101dd1:	83 c2 04             	add    $0x4,%edx
80101dd4:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101dd8:	8b 55 08             	mov    0x8(%ebp),%edx
80101ddb:	8b 12                	mov    (%edx),%edx
80101ddd:	83 ec 08             	sub    $0x8,%esp
80101de0:	50                   	push   %eax
80101de1:	52                   	push   %edx
80101de2:	e8 ed f7 ff ff       	call   801015d4 <bfree>
80101de7:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101dea:	8b 45 08             	mov    0x8(%ebp),%eax
80101ded:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101df0:	83 c2 04             	add    $0x4,%edx
80101df3:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101dfa:	00 
  for(i = 0; i < NDIRECT; i++){
80101dfb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101dff:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101e03:	7e b5                	jle    80101dba <itrunc+0x13>
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101e05:	8b 45 08             	mov    0x8(%ebp),%eax
80101e08:	8b 40 4c             	mov    0x4c(%eax),%eax
80101e0b:	85 c0                	test   %eax,%eax
80101e0d:	0f 84 a1 00 00 00    	je     80101eb4 <itrunc+0x10d>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101e13:	8b 45 08             	mov    0x8(%ebp),%eax
80101e16:	8b 50 4c             	mov    0x4c(%eax),%edx
80101e19:	8b 45 08             	mov    0x8(%ebp),%eax
80101e1c:	8b 00                	mov    (%eax),%eax
80101e1e:	83 ec 08             	sub    $0x8,%esp
80101e21:	52                   	push   %edx
80101e22:	50                   	push   %eax
80101e23:	e8 97 e3 ff ff       	call   801001bf <bread>
80101e28:	83 c4 10             	add    $0x10,%esp
80101e2b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101e2e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101e31:	83 c0 18             	add    $0x18,%eax
80101e34:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101e37:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101e3e:	eb 3c                	jmp    80101e7c <itrunc+0xd5>
      if(a[j])
80101e40:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e4a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e4d:	01 d0                	add    %edx,%eax
80101e4f:	8b 00                	mov    (%eax),%eax
80101e51:	85 c0                	test   %eax,%eax
80101e53:	74 23                	je     80101e78 <itrunc+0xd1>
        bfree(ip->dev, a[j]);
80101e55:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e58:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e62:	01 d0                	add    %edx,%eax
80101e64:	8b 00                	mov    (%eax),%eax
80101e66:	8b 55 08             	mov    0x8(%ebp),%edx
80101e69:	8b 12                	mov    (%edx),%edx
80101e6b:	83 ec 08             	sub    $0x8,%esp
80101e6e:	50                   	push   %eax
80101e6f:	52                   	push   %edx
80101e70:	e8 5f f7 ff ff       	call   801015d4 <bfree>
80101e75:	83 c4 10             	add    $0x10,%esp
    for(j = 0; j < NINDIRECT; j++){
80101e78:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101e7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e7f:	83 f8 7f             	cmp    $0x7f,%eax
80101e82:	76 bc                	jbe    80101e40 <itrunc+0x99>
    }
    brelse(bp);
80101e84:	83 ec 0c             	sub    $0xc,%esp
80101e87:	ff 75 ec             	pushl  -0x14(%ebp)
80101e8a:	e8 b0 e3 ff ff       	call   8010023f <brelse>
80101e8f:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101e92:	8b 45 08             	mov    0x8(%ebp),%eax
80101e95:	8b 40 4c             	mov    0x4c(%eax),%eax
80101e98:	8b 55 08             	mov    0x8(%ebp),%edx
80101e9b:	8b 12                	mov    (%edx),%edx
80101e9d:	83 ec 08             	sub    $0x8,%esp
80101ea0:	50                   	push   %eax
80101ea1:	52                   	push   %edx
80101ea2:	e8 2d f7 ff ff       	call   801015d4 <bfree>
80101ea7:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101eaa:	8b 45 08             	mov    0x8(%ebp),%eax
80101ead:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101eb4:	8b 45 08             	mov    0x8(%ebp),%eax
80101eb7:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101ebe:	83 ec 0c             	sub    $0xc,%esp
80101ec1:	ff 75 08             	pushl  0x8(%ebp)
80101ec4:	e8 f1 f8 ff ff       	call   801017ba <iupdate>
80101ec9:	83 c4 10             	add    $0x10,%esp
}
80101ecc:	90                   	nop
80101ecd:	c9                   	leave  
80101ece:	c3                   	ret    

80101ecf <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101ecf:	f3 0f 1e fb          	endbr32 
80101ed3:	55                   	push   %ebp
80101ed4:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101ed6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed9:	8b 00                	mov    (%eax),%eax
80101edb:	89 c2                	mov    %eax,%edx
80101edd:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ee0:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101ee3:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee6:	8b 50 04             	mov    0x4(%eax),%edx
80101ee9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101eec:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101eef:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef2:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101ef6:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ef9:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101efc:	8b 45 08             	mov    0x8(%ebp),%eax
80101eff:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101f03:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f06:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101f0a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0d:	8b 50 18             	mov    0x18(%eax),%edx
80101f10:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f13:	89 50 10             	mov    %edx,0x10(%eax)
}
80101f16:	90                   	nop
80101f17:	5d                   	pop    %ebp
80101f18:	c3                   	ret    

80101f19 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101f19:	f3 0f 1e fb          	endbr32 
80101f1d:	55                   	push   %ebp
80101f1e:	89 e5                	mov    %esp,%ebp
80101f20:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f23:	8b 45 08             	mov    0x8(%ebp),%eax
80101f26:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101f2a:	66 83 f8 03          	cmp    $0x3,%ax
80101f2e:	75 5c                	jne    80101f8c <readi+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101f30:	8b 45 08             	mov    0x8(%ebp),%eax
80101f33:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f37:	66 85 c0             	test   %ax,%ax
80101f3a:	78 20                	js     80101f5c <readi+0x43>
80101f3c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f3f:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f43:	66 83 f8 09          	cmp    $0x9,%ax
80101f47:	7f 13                	jg     80101f5c <readi+0x43>
80101f49:	8b 45 08             	mov    0x8(%ebp),%eax
80101f4c:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f50:	98                   	cwtl   
80101f51:	8b 04 c5 00 e8 10 80 	mov    -0x7fef1800(,%eax,8),%eax
80101f58:	85 c0                	test   %eax,%eax
80101f5a:	75 0a                	jne    80101f66 <readi+0x4d>
      return -1;
80101f5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f61:	e9 0a 01 00 00       	jmp    80102070 <readi+0x157>
    return devsw[ip->major].read(ip, dst, n);
80101f66:	8b 45 08             	mov    0x8(%ebp),%eax
80101f69:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f6d:	98                   	cwtl   
80101f6e:	8b 04 c5 00 e8 10 80 	mov    -0x7fef1800(,%eax,8),%eax
80101f75:	8b 55 14             	mov    0x14(%ebp),%edx
80101f78:	83 ec 04             	sub    $0x4,%esp
80101f7b:	52                   	push   %edx
80101f7c:	ff 75 0c             	pushl  0xc(%ebp)
80101f7f:	ff 75 08             	pushl  0x8(%ebp)
80101f82:	ff d0                	call   *%eax
80101f84:	83 c4 10             	add    $0x10,%esp
80101f87:	e9 e4 00 00 00       	jmp    80102070 <readi+0x157>
  }

  if(off > ip->size || off + n < off)
80101f8c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f8f:	8b 40 18             	mov    0x18(%eax),%eax
80101f92:	39 45 10             	cmp    %eax,0x10(%ebp)
80101f95:	77 0d                	ja     80101fa4 <readi+0x8b>
80101f97:	8b 55 10             	mov    0x10(%ebp),%edx
80101f9a:	8b 45 14             	mov    0x14(%ebp),%eax
80101f9d:	01 d0                	add    %edx,%eax
80101f9f:	39 45 10             	cmp    %eax,0x10(%ebp)
80101fa2:	76 0a                	jbe    80101fae <readi+0x95>
    return -1;
80101fa4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fa9:	e9 c2 00 00 00       	jmp    80102070 <readi+0x157>
  if(off + n > ip->size)
80101fae:	8b 55 10             	mov    0x10(%ebp),%edx
80101fb1:	8b 45 14             	mov    0x14(%ebp),%eax
80101fb4:	01 c2                	add    %eax,%edx
80101fb6:	8b 45 08             	mov    0x8(%ebp),%eax
80101fb9:	8b 40 18             	mov    0x18(%eax),%eax
80101fbc:	39 c2                	cmp    %eax,%edx
80101fbe:	76 0c                	jbe    80101fcc <readi+0xb3>
    n = ip->size - off;
80101fc0:	8b 45 08             	mov    0x8(%ebp),%eax
80101fc3:	8b 40 18             	mov    0x18(%eax),%eax
80101fc6:	2b 45 10             	sub    0x10(%ebp),%eax
80101fc9:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fcc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101fd3:	e9 89 00 00 00       	jmp    80102061 <readi+0x148>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fd8:	8b 45 10             	mov    0x10(%ebp),%eax
80101fdb:	c1 e8 09             	shr    $0x9,%eax
80101fde:	83 ec 08             	sub    $0x8,%esp
80101fe1:	50                   	push   %eax
80101fe2:	ff 75 08             	pushl  0x8(%ebp)
80101fe5:	e8 9f fc ff ff       	call   80101c89 <bmap>
80101fea:	83 c4 10             	add    $0x10,%esp
80101fed:	8b 55 08             	mov    0x8(%ebp),%edx
80101ff0:	8b 12                	mov    (%edx),%edx
80101ff2:	83 ec 08             	sub    $0x8,%esp
80101ff5:	50                   	push   %eax
80101ff6:	52                   	push   %edx
80101ff7:	e8 c3 e1 ff ff       	call   801001bf <bread>
80101ffc:	83 c4 10             	add    $0x10,%esp
80101fff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102002:	8b 45 10             	mov    0x10(%ebp),%eax
80102005:	25 ff 01 00 00       	and    $0x1ff,%eax
8010200a:	ba 00 02 00 00       	mov    $0x200,%edx
8010200f:	29 c2                	sub    %eax,%edx
80102011:	8b 45 14             	mov    0x14(%ebp),%eax
80102014:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102017:	39 c2                	cmp    %eax,%edx
80102019:	0f 46 c2             	cmovbe %edx,%eax
8010201c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
8010201f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102022:	8d 50 18             	lea    0x18(%eax),%edx
80102025:	8b 45 10             	mov    0x10(%ebp),%eax
80102028:	25 ff 01 00 00       	and    $0x1ff,%eax
8010202d:	01 d0                	add    %edx,%eax
8010202f:	83 ec 04             	sub    $0x4,%esp
80102032:	ff 75 ec             	pushl  -0x14(%ebp)
80102035:	50                   	push   %eax
80102036:	ff 75 0c             	pushl  0xc(%ebp)
80102039:	e8 b1 30 00 00       	call   801050ef <memmove>
8010203e:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102041:	83 ec 0c             	sub    $0xc,%esp
80102044:	ff 75 f0             	pushl  -0x10(%ebp)
80102047:	e8 f3 e1 ff ff       	call   8010023f <brelse>
8010204c:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010204f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102052:	01 45 f4             	add    %eax,-0xc(%ebp)
80102055:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102058:	01 45 10             	add    %eax,0x10(%ebp)
8010205b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010205e:	01 45 0c             	add    %eax,0xc(%ebp)
80102061:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102064:	3b 45 14             	cmp    0x14(%ebp),%eax
80102067:	0f 82 6b ff ff ff    	jb     80101fd8 <readi+0xbf>
  }
  return n;
8010206d:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102070:	c9                   	leave  
80102071:	c3                   	ret    

80102072 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102072:	f3 0f 1e fb          	endbr32 
80102076:	55                   	push   %ebp
80102077:	89 e5                	mov    %esp,%ebp
80102079:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010207c:	8b 45 08             	mov    0x8(%ebp),%eax
8010207f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102083:	66 83 f8 03          	cmp    $0x3,%ax
80102087:	75 5c                	jne    801020e5 <writei+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102089:	8b 45 08             	mov    0x8(%ebp),%eax
8010208c:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102090:	66 85 c0             	test   %ax,%ax
80102093:	78 20                	js     801020b5 <writei+0x43>
80102095:	8b 45 08             	mov    0x8(%ebp),%eax
80102098:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010209c:	66 83 f8 09          	cmp    $0x9,%ax
801020a0:	7f 13                	jg     801020b5 <writei+0x43>
801020a2:	8b 45 08             	mov    0x8(%ebp),%eax
801020a5:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801020a9:	98                   	cwtl   
801020aa:	8b 04 c5 04 e8 10 80 	mov    -0x7fef17fc(,%eax,8),%eax
801020b1:	85 c0                	test   %eax,%eax
801020b3:	75 0a                	jne    801020bf <writei+0x4d>
      return -1;
801020b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020ba:	e9 3b 01 00 00       	jmp    801021fa <writei+0x188>
    return devsw[ip->major].write(ip, src, n);
801020bf:	8b 45 08             	mov    0x8(%ebp),%eax
801020c2:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801020c6:	98                   	cwtl   
801020c7:	8b 04 c5 04 e8 10 80 	mov    -0x7fef17fc(,%eax,8),%eax
801020ce:	8b 55 14             	mov    0x14(%ebp),%edx
801020d1:	83 ec 04             	sub    $0x4,%esp
801020d4:	52                   	push   %edx
801020d5:	ff 75 0c             	pushl  0xc(%ebp)
801020d8:	ff 75 08             	pushl  0x8(%ebp)
801020db:	ff d0                	call   *%eax
801020dd:	83 c4 10             	add    $0x10,%esp
801020e0:	e9 15 01 00 00       	jmp    801021fa <writei+0x188>
  }

  if(off > ip->size || off + n < off)
801020e5:	8b 45 08             	mov    0x8(%ebp),%eax
801020e8:	8b 40 18             	mov    0x18(%eax),%eax
801020eb:	39 45 10             	cmp    %eax,0x10(%ebp)
801020ee:	77 0d                	ja     801020fd <writei+0x8b>
801020f0:	8b 55 10             	mov    0x10(%ebp),%edx
801020f3:	8b 45 14             	mov    0x14(%ebp),%eax
801020f6:	01 d0                	add    %edx,%eax
801020f8:	39 45 10             	cmp    %eax,0x10(%ebp)
801020fb:	76 0a                	jbe    80102107 <writei+0x95>
    return -1;
801020fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102102:	e9 f3 00 00 00       	jmp    801021fa <writei+0x188>
  if(off + n > MAXFILE*BSIZE)
80102107:	8b 55 10             	mov    0x10(%ebp),%edx
8010210a:	8b 45 14             	mov    0x14(%ebp),%eax
8010210d:	01 d0                	add    %edx,%eax
8010210f:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102114:	76 0a                	jbe    80102120 <writei+0xae>
    return -1;
80102116:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010211b:	e9 da 00 00 00       	jmp    801021fa <writei+0x188>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102120:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102127:	e9 97 00 00 00       	jmp    801021c3 <writei+0x151>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010212c:	8b 45 10             	mov    0x10(%ebp),%eax
8010212f:	c1 e8 09             	shr    $0x9,%eax
80102132:	83 ec 08             	sub    $0x8,%esp
80102135:	50                   	push   %eax
80102136:	ff 75 08             	pushl  0x8(%ebp)
80102139:	e8 4b fb ff ff       	call   80101c89 <bmap>
8010213e:	83 c4 10             	add    $0x10,%esp
80102141:	8b 55 08             	mov    0x8(%ebp),%edx
80102144:	8b 12                	mov    (%edx),%edx
80102146:	83 ec 08             	sub    $0x8,%esp
80102149:	50                   	push   %eax
8010214a:	52                   	push   %edx
8010214b:	e8 6f e0 ff ff       	call   801001bf <bread>
80102150:	83 c4 10             	add    $0x10,%esp
80102153:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102156:	8b 45 10             	mov    0x10(%ebp),%eax
80102159:	25 ff 01 00 00       	and    $0x1ff,%eax
8010215e:	ba 00 02 00 00       	mov    $0x200,%edx
80102163:	29 c2                	sub    %eax,%edx
80102165:	8b 45 14             	mov    0x14(%ebp),%eax
80102168:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010216b:	39 c2                	cmp    %eax,%edx
8010216d:	0f 46 c2             	cmovbe %edx,%eax
80102170:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80102173:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102176:	8d 50 18             	lea    0x18(%eax),%edx
80102179:	8b 45 10             	mov    0x10(%ebp),%eax
8010217c:	25 ff 01 00 00       	and    $0x1ff,%eax
80102181:	01 d0                	add    %edx,%eax
80102183:	83 ec 04             	sub    $0x4,%esp
80102186:	ff 75 ec             	pushl  -0x14(%ebp)
80102189:	ff 75 0c             	pushl  0xc(%ebp)
8010218c:	50                   	push   %eax
8010218d:	e8 5d 2f 00 00       	call   801050ef <memmove>
80102192:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102195:	83 ec 0c             	sub    $0xc,%esp
80102198:	ff 75 f0             	pushl  -0x10(%ebp)
8010219b:	e8 e7 12 00 00       	call   80103487 <log_write>
801021a0:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801021a3:	83 ec 0c             	sub    $0xc,%esp
801021a6:	ff 75 f0             	pushl  -0x10(%ebp)
801021a9:	e8 91 e0 ff ff       	call   8010023f <brelse>
801021ae:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801021b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801021b4:	01 45 f4             	add    %eax,-0xc(%ebp)
801021b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801021ba:	01 45 10             	add    %eax,0x10(%ebp)
801021bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801021c0:	01 45 0c             	add    %eax,0xc(%ebp)
801021c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801021c6:	3b 45 14             	cmp    0x14(%ebp),%eax
801021c9:	0f 82 5d ff ff ff    	jb     8010212c <writei+0xba>
  }

  if(n > 0 && off > ip->size){
801021cf:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801021d3:	74 22                	je     801021f7 <writei+0x185>
801021d5:	8b 45 08             	mov    0x8(%ebp),%eax
801021d8:	8b 40 18             	mov    0x18(%eax),%eax
801021db:	39 45 10             	cmp    %eax,0x10(%ebp)
801021de:	76 17                	jbe    801021f7 <writei+0x185>
    ip->size = off;
801021e0:	8b 45 08             	mov    0x8(%ebp),%eax
801021e3:	8b 55 10             	mov    0x10(%ebp),%edx
801021e6:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
801021e9:	83 ec 0c             	sub    $0xc,%esp
801021ec:	ff 75 08             	pushl  0x8(%ebp)
801021ef:	e8 c6 f5 ff ff       	call   801017ba <iupdate>
801021f4:	83 c4 10             	add    $0x10,%esp
  }
  return n;
801021f7:	8b 45 14             	mov    0x14(%ebp),%eax
}
801021fa:	c9                   	leave  
801021fb:	c3                   	ret    

801021fc <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801021fc:	f3 0f 1e fb          	endbr32 
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
80102206:	83 ec 04             	sub    $0x4,%esp
80102209:	6a 0e                	push   $0xe
8010220b:	ff 75 0c             	pushl  0xc(%ebp)
8010220e:	ff 75 08             	pushl  0x8(%ebp)
80102211:	e8 77 2f 00 00       	call   8010518d <strncmp>
80102216:	83 c4 10             	add    $0x10,%esp
}
80102219:	c9                   	leave  
8010221a:	c3                   	ret    

8010221b <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
8010221b:	f3 0f 1e fb          	endbr32 
8010221f:	55                   	push   %ebp
80102220:	89 e5                	mov    %esp,%ebp
80102222:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102225:	8b 45 08             	mov    0x8(%ebp),%eax
80102228:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010222c:	66 83 f8 01          	cmp    $0x1,%ax
80102230:	74 0d                	je     8010223f <dirlookup+0x24>
    panic("dirlookup not DIR");
80102232:	83 ec 0c             	sub    $0xc,%esp
80102235:	68 c9 84 10 80       	push   $0x801084c9
8010223a:	e8 58 e3 ff ff       	call   80100597 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
8010223f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102246:	eb 7b                	jmp    801022c3 <dirlookup+0xa8>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102248:	6a 10                	push   $0x10
8010224a:	ff 75 f4             	pushl  -0xc(%ebp)
8010224d:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102250:	50                   	push   %eax
80102251:	ff 75 08             	pushl  0x8(%ebp)
80102254:	e8 c0 fc ff ff       	call   80101f19 <readi>
80102259:	83 c4 10             	add    $0x10,%esp
8010225c:	83 f8 10             	cmp    $0x10,%eax
8010225f:	74 0d                	je     8010226e <dirlookup+0x53>
      panic("dirlink read");
80102261:	83 ec 0c             	sub    $0xc,%esp
80102264:	68 db 84 10 80       	push   $0x801084db
80102269:	e8 29 e3 ff ff       	call   80100597 <panic>
    if(de.inum == 0)
8010226e:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102272:	66 85 c0             	test   %ax,%ax
80102275:	74 47                	je     801022be <dirlookup+0xa3>
      continue;
    if(namecmp(name, de.name) == 0){
80102277:	83 ec 08             	sub    $0x8,%esp
8010227a:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010227d:	83 c0 02             	add    $0x2,%eax
80102280:	50                   	push   %eax
80102281:	ff 75 0c             	pushl  0xc(%ebp)
80102284:	e8 73 ff ff ff       	call   801021fc <namecmp>
80102289:	83 c4 10             	add    $0x10,%esp
8010228c:	85 c0                	test   %eax,%eax
8010228e:	75 2f                	jne    801022bf <dirlookup+0xa4>
      // entry matches path element
      if(poff)
80102290:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102294:	74 08                	je     8010229e <dirlookup+0x83>
        *poff = off;
80102296:	8b 45 10             	mov    0x10(%ebp),%eax
80102299:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010229c:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
8010229e:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801022a2:	0f b7 c0             	movzwl %ax,%eax
801022a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
801022a8:	8b 45 08             	mov    0x8(%ebp),%eax
801022ab:	8b 00                	mov    (%eax),%eax
801022ad:	83 ec 08             	sub    $0x8,%esp
801022b0:	ff 75 f0             	pushl  -0x10(%ebp)
801022b3:	50                   	push   %eax
801022b4:	e8 c0 f5 ff ff       	call   80101879 <iget>
801022b9:	83 c4 10             	add    $0x10,%esp
801022bc:	eb 19                	jmp    801022d7 <dirlookup+0xbc>
      continue;
801022be:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
801022bf:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801022c3:	8b 45 08             	mov    0x8(%ebp),%eax
801022c6:	8b 40 18             	mov    0x18(%eax),%eax
801022c9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801022cc:	0f 82 76 ff ff ff    	jb     80102248 <dirlookup+0x2d>
    }
  }

  return 0;
801022d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801022d7:	c9                   	leave  
801022d8:	c3                   	ret    

801022d9 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
801022d9:	f3 0f 1e fb          	endbr32 
801022dd:	55                   	push   %ebp
801022de:	89 e5                	mov    %esp,%ebp
801022e0:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
801022e3:	83 ec 04             	sub    $0x4,%esp
801022e6:	6a 00                	push   $0x0
801022e8:	ff 75 0c             	pushl  0xc(%ebp)
801022eb:	ff 75 08             	pushl  0x8(%ebp)
801022ee:	e8 28 ff ff ff       	call   8010221b <dirlookup>
801022f3:	83 c4 10             	add    $0x10,%esp
801022f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801022f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801022fd:	74 18                	je     80102317 <dirlink+0x3e>
    iput(ip);
801022ff:	83 ec 0c             	sub    $0xc,%esp
80102302:	ff 75 f0             	pushl  -0x10(%ebp)
80102305:	e8 62 f8 ff ff       	call   80101b6c <iput>
8010230a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010230d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102312:	e9 9c 00 00 00       	jmp    801023b3 <dirlink+0xda>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102317:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010231e:	eb 39                	jmp    80102359 <dirlink+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102320:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102323:	6a 10                	push   $0x10
80102325:	50                   	push   %eax
80102326:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102329:	50                   	push   %eax
8010232a:	ff 75 08             	pushl  0x8(%ebp)
8010232d:	e8 e7 fb ff ff       	call   80101f19 <readi>
80102332:	83 c4 10             	add    $0x10,%esp
80102335:	83 f8 10             	cmp    $0x10,%eax
80102338:	74 0d                	je     80102347 <dirlink+0x6e>
      panic("dirlink read");
8010233a:	83 ec 0c             	sub    $0xc,%esp
8010233d:	68 db 84 10 80       	push   $0x801084db
80102342:	e8 50 e2 ff ff       	call   80100597 <panic>
    if(de.inum == 0)
80102347:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010234b:	66 85 c0             	test   %ax,%ax
8010234e:	74 18                	je     80102368 <dirlink+0x8f>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102350:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102353:	83 c0 10             	add    $0x10,%eax
80102356:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102359:	8b 45 08             	mov    0x8(%ebp),%eax
8010235c:	8b 50 18             	mov    0x18(%eax),%edx
8010235f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102362:	39 c2                	cmp    %eax,%edx
80102364:	77 ba                	ja     80102320 <dirlink+0x47>
80102366:	eb 01                	jmp    80102369 <dirlink+0x90>
      break;
80102368:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
80102369:	83 ec 04             	sub    $0x4,%esp
8010236c:	6a 0e                	push   $0xe
8010236e:	ff 75 0c             	pushl  0xc(%ebp)
80102371:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102374:	83 c0 02             	add    $0x2,%eax
80102377:	50                   	push   %eax
80102378:	e8 6a 2e 00 00       	call   801051e7 <strncpy>
8010237d:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102380:	8b 45 10             	mov    0x10(%ebp),%eax
80102383:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102387:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010238a:	6a 10                	push   $0x10
8010238c:	50                   	push   %eax
8010238d:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102390:	50                   	push   %eax
80102391:	ff 75 08             	pushl  0x8(%ebp)
80102394:	e8 d9 fc ff ff       	call   80102072 <writei>
80102399:	83 c4 10             	add    $0x10,%esp
8010239c:	83 f8 10             	cmp    $0x10,%eax
8010239f:	74 0d                	je     801023ae <dirlink+0xd5>
    panic("dirlink");
801023a1:	83 ec 0c             	sub    $0xc,%esp
801023a4:	68 e8 84 10 80       	push   $0x801084e8
801023a9:	e8 e9 e1 ff ff       	call   80100597 <panic>
  
  return 0;
801023ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
801023b3:	c9                   	leave  
801023b4:	c3                   	ret    

801023b5 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
801023b5:	f3 0f 1e fb          	endbr32 
801023b9:	55                   	push   %ebp
801023ba:	89 e5                	mov    %esp,%ebp
801023bc:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
801023bf:	eb 04                	jmp    801023c5 <skipelem+0x10>
    path++;
801023c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
801023c5:	8b 45 08             	mov    0x8(%ebp),%eax
801023c8:	0f b6 00             	movzbl (%eax),%eax
801023cb:	3c 2f                	cmp    $0x2f,%al
801023cd:	74 f2                	je     801023c1 <skipelem+0xc>
  if(*path == 0)
801023cf:	8b 45 08             	mov    0x8(%ebp),%eax
801023d2:	0f b6 00             	movzbl (%eax),%eax
801023d5:	84 c0                	test   %al,%al
801023d7:	75 07                	jne    801023e0 <skipelem+0x2b>
    return 0;
801023d9:	b8 00 00 00 00       	mov    $0x0,%eax
801023de:	eb 77                	jmp    80102457 <skipelem+0xa2>
  s = path;
801023e0:	8b 45 08             	mov    0x8(%ebp),%eax
801023e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
801023e6:	eb 04                	jmp    801023ec <skipelem+0x37>
    path++;
801023e8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path != '/' && *path != 0)
801023ec:	8b 45 08             	mov    0x8(%ebp),%eax
801023ef:	0f b6 00             	movzbl (%eax),%eax
801023f2:	3c 2f                	cmp    $0x2f,%al
801023f4:	74 0a                	je     80102400 <skipelem+0x4b>
801023f6:	8b 45 08             	mov    0x8(%ebp),%eax
801023f9:	0f b6 00             	movzbl (%eax),%eax
801023fc:	84 c0                	test   %al,%al
801023fe:	75 e8                	jne    801023e8 <skipelem+0x33>
  len = path - s;
80102400:	8b 45 08             	mov    0x8(%ebp),%eax
80102403:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102406:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102409:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
8010240d:	7e 15                	jle    80102424 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
8010240f:	83 ec 04             	sub    $0x4,%esp
80102412:	6a 0e                	push   $0xe
80102414:	ff 75 f4             	pushl  -0xc(%ebp)
80102417:	ff 75 0c             	pushl  0xc(%ebp)
8010241a:	e8 d0 2c 00 00       	call   801050ef <memmove>
8010241f:	83 c4 10             	add    $0x10,%esp
80102422:	eb 26                	jmp    8010244a <skipelem+0x95>
  else {
    memmove(name, s, len);
80102424:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102427:	83 ec 04             	sub    $0x4,%esp
8010242a:	50                   	push   %eax
8010242b:	ff 75 f4             	pushl  -0xc(%ebp)
8010242e:	ff 75 0c             	pushl  0xc(%ebp)
80102431:	e8 b9 2c 00 00       	call   801050ef <memmove>
80102436:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
80102439:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010243c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010243f:	01 d0                	add    %edx,%eax
80102441:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
80102444:	eb 04                	jmp    8010244a <skipelem+0x95>
    path++;
80102446:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
8010244a:	8b 45 08             	mov    0x8(%ebp),%eax
8010244d:	0f b6 00             	movzbl (%eax),%eax
80102450:	3c 2f                	cmp    $0x2f,%al
80102452:	74 f2                	je     80102446 <skipelem+0x91>
  return path;
80102454:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102457:	c9                   	leave  
80102458:	c3                   	ret    

80102459 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102459:	f3 0f 1e fb          	endbr32 
8010245d:	55                   	push   %ebp
8010245e:	89 e5                	mov    %esp,%ebp
80102460:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102463:	8b 45 08             	mov    0x8(%ebp),%eax
80102466:	0f b6 00             	movzbl (%eax),%eax
80102469:	3c 2f                	cmp    $0x2f,%al
8010246b:	75 17                	jne    80102484 <namex+0x2b>
    ip = iget(ROOTDEV, ROOTINO);
8010246d:	83 ec 08             	sub    $0x8,%esp
80102470:	6a 01                	push   $0x1
80102472:	6a 01                	push   $0x1
80102474:	e8 00 f4 ff ff       	call   80101879 <iget>
80102479:	83 c4 10             	add    $0x10,%esp
8010247c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010247f:	e9 bb 00 00 00       	jmp    8010253f <namex+0xe6>
  else
    ip = idup(proc->cwd);
80102484:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010248a:	8b 40 68             	mov    0x68(%eax),%eax
8010248d:	83 ec 0c             	sub    $0xc,%esp
80102490:	50                   	push   %eax
80102491:	e8 c6 f4 ff ff       	call   8010195c <idup>
80102496:	83 c4 10             	add    $0x10,%esp
80102499:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
8010249c:	e9 9e 00 00 00       	jmp    8010253f <namex+0xe6>
    ilock(ip);
801024a1:	83 ec 0c             	sub    $0xc,%esp
801024a4:	ff 75 f4             	pushl  -0xc(%ebp)
801024a7:	e8 ee f4 ff ff       	call   8010199a <ilock>
801024ac:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
801024af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024b2:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801024b6:	66 83 f8 01          	cmp    $0x1,%ax
801024ba:	74 18                	je     801024d4 <namex+0x7b>
      iunlockput(ip);
801024bc:	83 ec 0c             	sub    $0xc,%esp
801024bf:	ff 75 f4             	pushl  -0xc(%ebp)
801024c2:	e8 99 f7 ff ff       	call   80101c60 <iunlockput>
801024c7:	83 c4 10             	add    $0x10,%esp
      return 0;
801024ca:	b8 00 00 00 00       	mov    $0x0,%eax
801024cf:	e9 a7 00 00 00       	jmp    8010257b <namex+0x122>
    }
    if(nameiparent && *path == '\0'){
801024d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801024d8:	74 20                	je     801024fa <namex+0xa1>
801024da:	8b 45 08             	mov    0x8(%ebp),%eax
801024dd:	0f b6 00             	movzbl (%eax),%eax
801024e0:	84 c0                	test   %al,%al
801024e2:	75 16                	jne    801024fa <namex+0xa1>
      // Stop one level early.
      iunlock(ip);
801024e4:	83 ec 0c             	sub    $0xc,%esp
801024e7:	ff 75 f4             	pushl  -0xc(%ebp)
801024ea:	e8 07 f6 ff ff       	call   80101af6 <iunlock>
801024ef:	83 c4 10             	add    $0x10,%esp
      return ip;
801024f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024f5:	e9 81 00 00 00       	jmp    8010257b <namex+0x122>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801024fa:	83 ec 04             	sub    $0x4,%esp
801024fd:	6a 00                	push   $0x0
801024ff:	ff 75 10             	pushl  0x10(%ebp)
80102502:	ff 75 f4             	pushl  -0xc(%ebp)
80102505:	e8 11 fd ff ff       	call   8010221b <dirlookup>
8010250a:	83 c4 10             	add    $0x10,%esp
8010250d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102510:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102514:	75 15                	jne    8010252b <namex+0xd2>
      iunlockput(ip);
80102516:	83 ec 0c             	sub    $0xc,%esp
80102519:	ff 75 f4             	pushl  -0xc(%ebp)
8010251c:	e8 3f f7 ff ff       	call   80101c60 <iunlockput>
80102521:	83 c4 10             	add    $0x10,%esp
      return 0;
80102524:	b8 00 00 00 00       	mov    $0x0,%eax
80102529:	eb 50                	jmp    8010257b <namex+0x122>
    }
    iunlockput(ip);
8010252b:	83 ec 0c             	sub    $0xc,%esp
8010252e:	ff 75 f4             	pushl  -0xc(%ebp)
80102531:	e8 2a f7 ff ff       	call   80101c60 <iunlockput>
80102536:	83 c4 10             	add    $0x10,%esp
    ip = next;
80102539:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010253c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while((path = skipelem(path, name)) != 0){
8010253f:	83 ec 08             	sub    $0x8,%esp
80102542:	ff 75 10             	pushl  0x10(%ebp)
80102545:	ff 75 08             	pushl  0x8(%ebp)
80102548:	e8 68 fe ff ff       	call   801023b5 <skipelem>
8010254d:	83 c4 10             	add    $0x10,%esp
80102550:	89 45 08             	mov    %eax,0x8(%ebp)
80102553:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102557:	0f 85 44 ff ff ff    	jne    801024a1 <namex+0x48>
  }
  if(nameiparent){
8010255d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102561:	74 15                	je     80102578 <namex+0x11f>
    iput(ip);
80102563:	83 ec 0c             	sub    $0xc,%esp
80102566:	ff 75 f4             	pushl  -0xc(%ebp)
80102569:	e8 fe f5 ff ff       	call   80101b6c <iput>
8010256e:	83 c4 10             	add    $0x10,%esp
    return 0;
80102571:	b8 00 00 00 00       	mov    $0x0,%eax
80102576:	eb 03                	jmp    8010257b <namex+0x122>
  }
  return ip;
80102578:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010257b:	c9                   	leave  
8010257c:	c3                   	ret    

8010257d <namei>:

struct inode*
namei(char *path)
{
8010257d:	f3 0f 1e fb          	endbr32 
80102581:	55                   	push   %ebp
80102582:	89 e5                	mov    %esp,%ebp
80102584:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102587:	83 ec 04             	sub    $0x4,%esp
8010258a:	8d 45 ea             	lea    -0x16(%ebp),%eax
8010258d:	50                   	push   %eax
8010258e:	6a 00                	push   $0x0
80102590:	ff 75 08             	pushl  0x8(%ebp)
80102593:	e8 c1 fe ff ff       	call   80102459 <namex>
80102598:	83 c4 10             	add    $0x10,%esp
}
8010259b:	c9                   	leave  
8010259c:	c3                   	ret    

8010259d <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
8010259d:	f3 0f 1e fb          	endbr32 
801025a1:	55                   	push   %ebp
801025a2:	89 e5                	mov    %esp,%ebp
801025a4:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
801025a7:	83 ec 04             	sub    $0x4,%esp
801025aa:	ff 75 0c             	pushl  0xc(%ebp)
801025ad:	6a 01                	push   $0x1
801025af:	ff 75 08             	pushl  0x8(%ebp)
801025b2:	e8 a2 fe ff ff       	call   80102459 <namex>
801025b7:	83 c4 10             	add    $0x10,%esp
}
801025ba:	c9                   	leave  
801025bb:	c3                   	ret    

801025bc <inb>:
{
801025bc:	55                   	push   %ebp
801025bd:	89 e5                	mov    %esp,%ebp
801025bf:	83 ec 14             	sub    $0x14,%esp
801025c2:	8b 45 08             	mov    0x8(%ebp),%eax
801025c5:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025c9:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801025cd:	89 c2                	mov    %eax,%edx
801025cf:	ec                   	in     (%dx),%al
801025d0:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801025d3:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801025d7:	c9                   	leave  
801025d8:	c3                   	ret    

801025d9 <insl>:
{
801025d9:	55                   	push   %ebp
801025da:	89 e5                	mov    %esp,%ebp
801025dc:	57                   	push   %edi
801025dd:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
801025de:	8b 55 08             	mov    0x8(%ebp),%edx
801025e1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025e4:	8b 45 10             	mov    0x10(%ebp),%eax
801025e7:	89 cb                	mov    %ecx,%ebx
801025e9:	89 df                	mov    %ebx,%edi
801025eb:	89 c1                	mov    %eax,%ecx
801025ed:	fc                   	cld    
801025ee:	f3 6d                	rep insl (%dx),%es:(%edi)
801025f0:	89 c8                	mov    %ecx,%eax
801025f2:	89 fb                	mov    %edi,%ebx
801025f4:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801025f7:	89 45 10             	mov    %eax,0x10(%ebp)
}
801025fa:	90                   	nop
801025fb:	5b                   	pop    %ebx
801025fc:	5f                   	pop    %edi
801025fd:	5d                   	pop    %ebp
801025fe:	c3                   	ret    

801025ff <outb>:
{
801025ff:	55                   	push   %ebp
80102600:	89 e5                	mov    %esp,%ebp
80102602:	83 ec 08             	sub    $0x8,%esp
80102605:	8b 45 08             	mov    0x8(%ebp),%eax
80102608:	8b 55 0c             	mov    0xc(%ebp),%edx
8010260b:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010260f:	89 d0                	mov    %edx,%eax
80102611:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102614:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102618:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010261c:	ee                   	out    %al,(%dx)
}
8010261d:	90                   	nop
8010261e:	c9                   	leave  
8010261f:	c3                   	ret    

80102620 <outsl>:
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	56                   	push   %esi
80102624:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
80102625:	8b 55 08             	mov    0x8(%ebp),%edx
80102628:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010262b:	8b 45 10             	mov    0x10(%ebp),%eax
8010262e:	89 cb                	mov    %ecx,%ebx
80102630:	89 de                	mov    %ebx,%esi
80102632:	89 c1                	mov    %eax,%ecx
80102634:	fc                   	cld    
80102635:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102637:	89 c8                	mov    %ecx,%eax
80102639:	89 f3                	mov    %esi,%ebx
8010263b:	89 5d 0c             	mov    %ebx,0xc(%ebp)
8010263e:	89 45 10             	mov    %eax,0x10(%ebp)
}
80102641:	90                   	nop
80102642:	5b                   	pop    %ebx
80102643:	5e                   	pop    %esi
80102644:	5d                   	pop    %ebp
80102645:	c3                   	ret    

80102646 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80102646:	f3 0f 1e fb          	endbr32 
8010264a:	55                   	push   %ebp
8010264b:	89 e5                	mov    %esp,%ebp
8010264d:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
80102650:	90                   	nop
80102651:	68 f7 01 00 00       	push   $0x1f7
80102656:	e8 61 ff ff ff       	call   801025bc <inb>
8010265b:	83 c4 04             	add    $0x4,%esp
8010265e:	0f b6 c0             	movzbl %al,%eax
80102661:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102664:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102667:	25 c0 00 00 00       	and    $0xc0,%eax
8010266c:	83 f8 40             	cmp    $0x40,%eax
8010266f:	75 e0                	jne    80102651 <idewait+0xb>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102671:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102675:	74 11                	je     80102688 <idewait+0x42>
80102677:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010267a:	83 e0 21             	and    $0x21,%eax
8010267d:	85 c0                	test   %eax,%eax
8010267f:	74 07                	je     80102688 <idewait+0x42>
    return -1;
80102681:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102686:	eb 05                	jmp    8010268d <idewait+0x47>
  return 0;
80102688:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010268d:	c9                   	leave  
8010268e:	c3                   	ret    

8010268f <ideinit>:

void
ideinit(void)
{
8010268f:	f3 0f 1e fb          	endbr32 
80102693:	55                   	push   %ebp
80102694:	89 e5                	mov    %esp,%ebp
80102696:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102699:	83 ec 08             	sub    $0x8,%esp
8010269c:	68 f0 84 10 80       	push   $0x801084f0
801026a1:	68 00 b6 10 80       	push   $0x8010b600
801026a6:	e8 db 26 00 00       	call   80104d86 <initlock>
801026ab:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
801026ae:	83 ec 0c             	sub    $0xc,%esp
801026b1:	6a 0e                	push   $0xe
801026b3:	e8 07 16 00 00       	call   80103cbf <picenable>
801026b8:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
801026bb:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801026c0:	83 e8 01             	sub    $0x1,%eax
801026c3:	83 ec 08             	sub    $0x8,%esp
801026c6:	50                   	push   %eax
801026c7:	6a 0e                	push   $0xe
801026c9:	e8 4f 04 00 00       	call   80102b1d <ioapicenable>
801026ce:	83 c4 10             	add    $0x10,%esp
  idewait(0);
801026d1:	83 ec 0c             	sub    $0xc,%esp
801026d4:	6a 00                	push   $0x0
801026d6:	e8 6b ff ff ff       	call   80102646 <idewait>
801026db:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
801026de:	83 ec 08             	sub    $0x8,%esp
801026e1:	68 f0 00 00 00       	push   $0xf0
801026e6:	68 f6 01 00 00       	push   $0x1f6
801026eb:	e8 0f ff ff ff       	call   801025ff <outb>
801026f0:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
801026f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801026fa:	eb 24                	jmp    80102720 <ideinit+0x91>
    if(inb(0x1f7) != 0){
801026fc:	83 ec 0c             	sub    $0xc,%esp
801026ff:	68 f7 01 00 00       	push   $0x1f7
80102704:	e8 b3 fe ff ff       	call   801025bc <inb>
80102709:	83 c4 10             	add    $0x10,%esp
8010270c:	84 c0                	test   %al,%al
8010270e:	74 0c                	je     8010271c <ideinit+0x8d>
      havedisk1 = 1;
80102710:	c7 05 38 b6 10 80 01 	movl   $0x1,0x8010b638
80102717:	00 00 00 
      break;
8010271a:	eb 0d                	jmp    80102729 <ideinit+0x9a>
  for(i=0; i<1000; i++){
8010271c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102720:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102727:	7e d3                	jle    801026fc <ideinit+0x6d>
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
80102729:	83 ec 08             	sub    $0x8,%esp
8010272c:	68 e0 00 00 00       	push   $0xe0
80102731:	68 f6 01 00 00       	push   $0x1f6
80102736:	e8 c4 fe ff ff       	call   801025ff <outb>
8010273b:	83 c4 10             	add    $0x10,%esp
}
8010273e:	90                   	nop
8010273f:	c9                   	leave  
80102740:	c3                   	ret    

80102741 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102741:	f3 0f 1e fb          	endbr32 
80102745:	55                   	push   %ebp
80102746:	89 e5                	mov    %esp,%ebp
80102748:	83 ec 08             	sub    $0x8,%esp
  if(b == 0)
8010274b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010274f:	75 0d                	jne    8010275e <idestart+0x1d>
    panic("idestart");
80102751:	83 ec 0c             	sub    $0xc,%esp
80102754:	68 f4 84 10 80       	push   $0x801084f4
80102759:	e8 39 de ff ff       	call   80100597 <panic>

  idewait(0);
8010275e:	83 ec 0c             	sub    $0xc,%esp
80102761:	6a 00                	push   $0x0
80102763:	e8 de fe ff ff       	call   80102646 <idewait>
80102768:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
8010276b:	83 ec 08             	sub    $0x8,%esp
8010276e:	6a 00                	push   $0x0
80102770:	68 f6 03 00 00       	push   $0x3f6
80102775:	e8 85 fe ff ff       	call   801025ff <outb>
8010277a:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, 1);  // number of sectors
8010277d:	83 ec 08             	sub    $0x8,%esp
80102780:	6a 01                	push   $0x1
80102782:	68 f2 01 00 00       	push   $0x1f2
80102787:	e8 73 fe ff ff       	call   801025ff <outb>
8010278c:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, b->sector & 0xff);
8010278f:	8b 45 08             	mov    0x8(%ebp),%eax
80102792:	8b 40 08             	mov    0x8(%eax),%eax
80102795:	0f b6 c0             	movzbl %al,%eax
80102798:	83 ec 08             	sub    $0x8,%esp
8010279b:	50                   	push   %eax
8010279c:	68 f3 01 00 00       	push   $0x1f3
801027a1:	e8 59 fe ff ff       	call   801025ff <outb>
801027a6:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (b->sector >> 8) & 0xff);
801027a9:	8b 45 08             	mov    0x8(%ebp),%eax
801027ac:	8b 40 08             	mov    0x8(%eax),%eax
801027af:	c1 e8 08             	shr    $0x8,%eax
801027b2:	0f b6 c0             	movzbl %al,%eax
801027b5:	83 ec 08             	sub    $0x8,%esp
801027b8:	50                   	push   %eax
801027b9:	68 f4 01 00 00       	push   $0x1f4
801027be:	e8 3c fe ff ff       	call   801025ff <outb>
801027c3:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (b->sector >> 16) & 0xff);
801027c6:	8b 45 08             	mov    0x8(%ebp),%eax
801027c9:	8b 40 08             	mov    0x8(%eax),%eax
801027cc:	c1 e8 10             	shr    $0x10,%eax
801027cf:	0f b6 c0             	movzbl %al,%eax
801027d2:	83 ec 08             	sub    $0x8,%esp
801027d5:	50                   	push   %eax
801027d6:	68 f5 01 00 00       	push   $0x1f5
801027db:	e8 1f fe ff ff       	call   801025ff <outb>
801027e0:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
801027e3:	8b 45 08             	mov    0x8(%ebp),%eax
801027e6:	8b 40 04             	mov    0x4(%eax),%eax
801027e9:	c1 e0 04             	shl    $0x4,%eax
801027ec:	83 e0 10             	and    $0x10,%eax
801027ef:	89 c2                	mov    %eax,%edx
801027f1:	8b 45 08             	mov    0x8(%ebp),%eax
801027f4:	8b 40 08             	mov    0x8(%eax),%eax
801027f7:	c1 e8 18             	shr    $0x18,%eax
801027fa:	83 e0 0f             	and    $0xf,%eax
801027fd:	09 d0                	or     %edx,%eax
801027ff:	83 c8 e0             	or     $0xffffffe0,%eax
80102802:	0f b6 c0             	movzbl %al,%eax
80102805:	83 ec 08             	sub    $0x8,%esp
80102808:	50                   	push   %eax
80102809:	68 f6 01 00 00       	push   $0x1f6
8010280e:	e8 ec fd ff ff       	call   801025ff <outb>
80102813:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102816:	8b 45 08             	mov    0x8(%ebp),%eax
80102819:	8b 00                	mov    (%eax),%eax
8010281b:	83 e0 04             	and    $0x4,%eax
8010281e:	85 c0                	test   %eax,%eax
80102820:	74 30                	je     80102852 <idestart+0x111>
    outb(0x1f7, IDE_CMD_WRITE);
80102822:	83 ec 08             	sub    $0x8,%esp
80102825:	6a 30                	push   $0x30
80102827:	68 f7 01 00 00       	push   $0x1f7
8010282c:	e8 ce fd ff ff       	call   801025ff <outb>
80102831:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, 512/4);
80102834:	8b 45 08             	mov    0x8(%ebp),%eax
80102837:	83 c0 18             	add    $0x18,%eax
8010283a:	83 ec 04             	sub    $0x4,%esp
8010283d:	68 80 00 00 00       	push   $0x80
80102842:	50                   	push   %eax
80102843:	68 f0 01 00 00       	push   $0x1f0
80102848:	e8 d3 fd ff ff       	call   80102620 <outsl>
8010284d:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
80102850:	eb 12                	jmp    80102864 <idestart+0x123>
    outb(0x1f7, IDE_CMD_READ);
80102852:	83 ec 08             	sub    $0x8,%esp
80102855:	6a 20                	push   $0x20
80102857:	68 f7 01 00 00       	push   $0x1f7
8010285c:	e8 9e fd ff ff       	call   801025ff <outb>
80102861:	83 c4 10             	add    $0x10,%esp
}
80102864:	90                   	nop
80102865:	c9                   	leave  
80102866:	c3                   	ret    

80102867 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102867:	f3 0f 1e fb          	endbr32 
8010286b:	55                   	push   %ebp
8010286c:	89 e5                	mov    %esp,%ebp
8010286e:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102871:	83 ec 0c             	sub    $0xc,%esp
80102874:	68 00 b6 10 80       	push   $0x8010b600
80102879:	e8 2e 25 00 00       	call   80104dac <acquire>
8010287e:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
80102881:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102886:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102889:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010288d:	75 15                	jne    801028a4 <ideintr+0x3d>
    release(&idelock);
8010288f:	83 ec 0c             	sub    $0xc,%esp
80102892:	68 00 b6 10 80       	push   $0x8010b600
80102897:	e8 7b 25 00 00       	call   80104e17 <release>
8010289c:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
8010289f:	e9 9a 00 00 00       	jmp    8010293e <ideintr+0xd7>
  }
  idequeue = b->qnext;
801028a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028a7:	8b 40 14             	mov    0x14(%eax),%eax
801028aa:	a3 34 b6 10 80       	mov    %eax,0x8010b634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801028af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028b2:	8b 00                	mov    (%eax),%eax
801028b4:	83 e0 04             	and    $0x4,%eax
801028b7:	85 c0                	test   %eax,%eax
801028b9:	75 2d                	jne    801028e8 <ideintr+0x81>
801028bb:	83 ec 0c             	sub    $0xc,%esp
801028be:	6a 01                	push   $0x1
801028c0:	e8 81 fd ff ff       	call   80102646 <idewait>
801028c5:	83 c4 10             	add    $0x10,%esp
801028c8:	85 c0                	test   %eax,%eax
801028ca:	78 1c                	js     801028e8 <ideintr+0x81>
    insl(0x1f0, b->data, 512/4);
801028cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028cf:	83 c0 18             	add    $0x18,%eax
801028d2:	83 ec 04             	sub    $0x4,%esp
801028d5:	68 80 00 00 00       	push   $0x80
801028da:	50                   	push   %eax
801028db:	68 f0 01 00 00       	push   $0x1f0
801028e0:	e8 f4 fc ff ff       	call   801025d9 <insl>
801028e5:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801028e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028eb:	8b 00                	mov    (%eax),%eax
801028ed:	83 c8 02             	or     $0x2,%eax
801028f0:	89 c2                	mov    %eax,%edx
801028f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028f5:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
801028f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028fa:	8b 00                	mov    (%eax),%eax
801028fc:	83 e0 fb             	and    $0xfffffffb,%eax
801028ff:	89 c2                	mov    %eax,%edx
80102901:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102904:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102906:	83 ec 0c             	sub    $0xc,%esp
80102909:	ff 75 f4             	pushl  -0xc(%ebp)
8010290c:	e8 7c 22 00 00       	call   80104b8d <wakeup>
80102911:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
80102914:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102919:	85 c0                	test   %eax,%eax
8010291b:	74 11                	je     8010292e <ideintr+0xc7>
    idestart(idequeue);
8010291d:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102922:	83 ec 0c             	sub    $0xc,%esp
80102925:	50                   	push   %eax
80102926:	e8 16 fe ff ff       	call   80102741 <idestart>
8010292b:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
8010292e:	83 ec 0c             	sub    $0xc,%esp
80102931:	68 00 b6 10 80       	push   $0x8010b600
80102936:	e8 dc 24 00 00       	call   80104e17 <release>
8010293b:	83 c4 10             	add    $0x10,%esp
}
8010293e:	c9                   	leave  
8010293f:	c3                   	ret    

80102940 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102940:	f3 0f 1e fb          	endbr32 
80102944:	55                   	push   %ebp
80102945:	89 e5                	mov    %esp,%ebp
80102947:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
8010294a:	8b 45 08             	mov    0x8(%ebp),%eax
8010294d:	8b 00                	mov    (%eax),%eax
8010294f:	83 e0 01             	and    $0x1,%eax
80102952:	85 c0                	test   %eax,%eax
80102954:	75 0d                	jne    80102963 <iderw+0x23>
    panic("iderw: buf not busy");
80102956:	83 ec 0c             	sub    $0xc,%esp
80102959:	68 fd 84 10 80       	push   $0x801084fd
8010295e:	e8 34 dc ff ff       	call   80100597 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102963:	8b 45 08             	mov    0x8(%ebp),%eax
80102966:	8b 00                	mov    (%eax),%eax
80102968:	83 e0 06             	and    $0x6,%eax
8010296b:	83 f8 02             	cmp    $0x2,%eax
8010296e:	75 0d                	jne    8010297d <iderw+0x3d>
    panic("iderw: nothing to do");
80102970:	83 ec 0c             	sub    $0xc,%esp
80102973:	68 11 85 10 80       	push   $0x80108511
80102978:	e8 1a dc ff ff       	call   80100597 <panic>
  if(b->dev != 0 && !havedisk1)
8010297d:	8b 45 08             	mov    0x8(%ebp),%eax
80102980:	8b 40 04             	mov    0x4(%eax),%eax
80102983:	85 c0                	test   %eax,%eax
80102985:	74 16                	je     8010299d <iderw+0x5d>
80102987:	a1 38 b6 10 80       	mov    0x8010b638,%eax
8010298c:	85 c0                	test   %eax,%eax
8010298e:	75 0d                	jne    8010299d <iderw+0x5d>
    panic("iderw: ide disk 1 not present");
80102990:	83 ec 0c             	sub    $0xc,%esp
80102993:	68 26 85 10 80       	push   $0x80108526
80102998:	e8 fa db ff ff       	call   80100597 <panic>

  acquire(&idelock);  //DOC:acquire-lock
8010299d:	83 ec 0c             	sub    $0xc,%esp
801029a0:	68 00 b6 10 80       	push   $0x8010b600
801029a5:	e8 02 24 00 00       	call   80104dac <acquire>
801029aa:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
801029ad:	8b 45 08             	mov    0x8(%ebp),%eax
801029b0:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801029b7:	c7 45 f4 34 b6 10 80 	movl   $0x8010b634,-0xc(%ebp)
801029be:	eb 0b                	jmp    801029cb <iderw+0x8b>
801029c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029c3:	8b 00                	mov    (%eax),%eax
801029c5:	83 c0 14             	add    $0x14,%eax
801029c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801029cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029ce:	8b 00                	mov    (%eax),%eax
801029d0:	85 c0                	test   %eax,%eax
801029d2:	75 ec                	jne    801029c0 <iderw+0x80>
    ;
  *pp = b;
801029d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029d7:	8b 55 08             	mov    0x8(%ebp),%edx
801029da:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
801029dc:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801029e1:	39 45 08             	cmp    %eax,0x8(%ebp)
801029e4:	75 23                	jne    80102a09 <iderw+0xc9>
    idestart(b);
801029e6:	83 ec 0c             	sub    $0xc,%esp
801029e9:	ff 75 08             	pushl  0x8(%ebp)
801029ec:	e8 50 fd ff ff       	call   80102741 <idestart>
801029f1:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801029f4:	eb 13                	jmp    80102a09 <iderw+0xc9>
    sleep(b, &idelock);
801029f6:	83 ec 08             	sub    $0x8,%esp
801029f9:	68 00 b6 10 80       	push   $0x8010b600
801029fe:	ff 75 08             	pushl  0x8(%ebp)
80102a01:	e8 93 20 00 00       	call   80104a99 <sleep>
80102a06:	83 c4 10             	add    $0x10,%esp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a09:	8b 45 08             	mov    0x8(%ebp),%eax
80102a0c:	8b 00                	mov    (%eax),%eax
80102a0e:	83 e0 06             	and    $0x6,%eax
80102a11:	83 f8 02             	cmp    $0x2,%eax
80102a14:	75 e0                	jne    801029f6 <iderw+0xb6>
  }

  release(&idelock);
80102a16:	83 ec 0c             	sub    $0xc,%esp
80102a19:	68 00 b6 10 80       	push   $0x8010b600
80102a1e:	e8 f4 23 00 00       	call   80104e17 <release>
80102a23:	83 c4 10             	add    $0x10,%esp
}
80102a26:	90                   	nop
80102a27:	c9                   	leave  
80102a28:	c3                   	ret    

80102a29 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102a29:	f3 0f 1e fb          	endbr32 
80102a2d:	55                   	push   %ebp
80102a2e:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102a30:	a1 34 f8 10 80       	mov    0x8010f834,%eax
80102a35:	8b 55 08             	mov    0x8(%ebp),%edx
80102a38:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102a3a:	a1 34 f8 10 80       	mov    0x8010f834,%eax
80102a3f:	8b 40 10             	mov    0x10(%eax),%eax
}
80102a42:	5d                   	pop    %ebp
80102a43:	c3                   	ret    

80102a44 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102a44:	f3 0f 1e fb          	endbr32 
80102a48:	55                   	push   %ebp
80102a49:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102a4b:	a1 34 f8 10 80       	mov    0x8010f834,%eax
80102a50:	8b 55 08             	mov    0x8(%ebp),%edx
80102a53:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102a55:	a1 34 f8 10 80       	mov    0x8010f834,%eax
80102a5a:	8b 55 0c             	mov    0xc(%ebp),%edx
80102a5d:	89 50 10             	mov    %edx,0x10(%eax)
}
80102a60:	90                   	nop
80102a61:	5d                   	pop    %ebp
80102a62:	c3                   	ret    

80102a63 <ioapicinit>:

void
ioapicinit(void)
{
80102a63:	f3 0f 1e fb          	endbr32 
80102a67:	55                   	push   %ebp
80102a68:	89 e5                	mov    %esp,%ebp
80102a6a:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102a6d:	a1 04 f9 10 80       	mov    0x8010f904,%eax
80102a72:	85 c0                	test   %eax,%eax
80102a74:	0f 84 a0 00 00 00    	je     80102b1a <ioapicinit+0xb7>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102a7a:	c7 05 34 f8 10 80 00 	movl   $0xfec00000,0x8010f834
80102a81:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102a84:	6a 01                	push   $0x1
80102a86:	e8 9e ff ff ff       	call   80102a29 <ioapicread>
80102a8b:	83 c4 04             	add    $0x4,%esp
80102a8e:	c1 e8 10             	shr    $0x10,%eax
80102a91:	25 ff 00 00 00       	and    $0xff,%eax
80102a96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102a99:	6a 00                	push   $0x0
80102a9b:	e8 89 ff ff ff       	call   80102a29 <ioapicread>
80102aa0:	83 c4 04             	add    $0x4,%esp
80102aa3:	c1 e8 18             	shr    $0x18,%eax
80102aa6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102aa9:	0f b6 05 00 f9 10 80 	movzbl 0x8010f900,%eax
80102ab0:	0f b6 c0             	movzbl %al,%eax
80102ab3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80102ab6:	74 10                	je     80102ac8 <ioapicinit+0x65>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102ab8:	83 ec 0c             	sub    $0xc,%esp
80102abb:	68 44 85 10 80       	push   $0x80108544
80102ac0:	e8 19 d9 ff ff       	call   801003de <cprintf>
80102ac5:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102ac8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102acf:	eb 3f                	jmp    80102b10 <ioapicinit+0xad>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ad4:	83 c0 20             	add    $0x20,%eax
80102ad7:	0d 00 00 01 00       	or     $0x10000,%eax
80102adc:	89 c2                	mov    %eax,%edx
80102ade:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ae1:	83 c0 08             	add    $0x8,%eax
80102ae4:	01 c0                	add    %eax,%eax
80102ae6:	83 ec 08             	sub    $0x8,%esp
80102ae9:	52                   	push   %edx
80102aea:	50                   	push   %eax
80102aeb:	e8 54 ff ff ff       	call   80102a44 <ioapicwrite>
80102af0:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102af3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102af6:	83 c0 08             	add    $0x8,%eax
80102af9:	01 c0                	add    %eax,%eax
80102afb:	83 c0 01             	add    $0x1,%eax
80102afe:	83 ec 08             	sub    $0x8,%esp
80102b01:	6a 00                	push   $0x0
80102b03:	50                   	push   %eax
80102b04:	e8 3b ff ff ff       	call   80102a44 <ioapicwrite>
80102b09:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i <= maxintr; i++){
80102b0c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b13:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102b16:	7e b9                	jle    80102ad1 <ioapicinit+0x6e>
80102b18:	eb 01                	jmp    80102b1b <ioapicinit+0xb8>
    return;
80102b1a:	90                   	nop
  }
}
80102b1b:	c9                   	leave  
80102b1c:	c3                   	ret    

80102b1d <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102b1d:	f3 0f 1e fb          	endbr32 
80102b21:	55                   	push   %ebp
80102b22:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102b24:	a1 04 f9 10 80       	mov    0x8010f904,%eax
80102b29:	85 c0                	test   %eax,%eax
80102b2b:	74 39                	je     80102b66 <ioapicenable+0x49>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102b2d:	8b 45 08             	mov    0x8(%ebp),%eax
80102b30:	83 c0 20             	add    $0x20,%eax
80102b33:	89 c2                	mov    %eax,%edx
80102b35:	8b 45 08             	mov    0x8(%ebp),%eax
80102b38:	83 c0 08             	add    $0x8,%eax
80102b3b:	01 c0                	add    %eax,%eax
80102b3d:	52                   	push   %edx
80102b3e:	50                   	push   %eax
80102b3f:	e8 00 ff ff ff       	call   80102a44 <ioapicwrite>
80102b44:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102b47:	8b 45 0c             	mov    0xc(%ebp),%eax
80102b4a:	c1 e0 18             	shl    $0x18,%eax
80102b4d:	89 c2                	mov    %eax,%edx
80102b4f:	8b 45 08             	mov    0x8(%ebp),%eax
80102b52:	83 c0 08             	add    $0x8,%eax
80102b55:	01 c0                	add    %eax,%eax
80102b57:	83 c0 01             	add    $0x1,%eax
80102b5a:	52                   	push   %edx
80102b5b:	50                   	push   %eax
80102b5c:	e8 e3 fe ff ff       	call   80102a44 <ioapicwrite>
80102b61:	83 c4 08             	add    $0x8,%esp
80102b64:	eb 01                	jmp    80102b67 <ioapicenable+0x4a>
    return;
80102b66:	90                   	nop
}
80102b67:	c9                   	leave  
80102b68:	c3                   	ret    

80102b69 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102b69:	55                   	push   %ebp
80102b6a:	89 e5                	mov    %esp,%ebp
80102b6c:	8b 45 08             	mov    0x8(%ebp),%eax
80102b6f:	05 00 00 00 80       	add    $0x80000000,%eax
80102b74:	5d                   	pop    %ebp
80102b75:	c3                   	ret    

80102b76 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102b76:	f3 0f 1e fb          	endbr32 
80102b7a:	55                   	push   %ebp
80102b7b:	89 e5                	mov    %esp,%ebp
80102b7d:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102b80:	83 ec 08             	sub    $0x8,%esp
80102b83:	68 76 85 10 80       	push   $0x80108576
80102b88:	68 40 f8 10 80       	push   $0x8010f840
80102b8d:	e8 f4 21 00 00       	call   80104d86 <initlock>
80102b92:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102b95:	c7 05 74 f8 10 80 00 	movl   $0x0,0x8010f874
80102b9c:	00 00 00 
  freerange(vstart, vend);
80102b9f:	83 ec 08             	sub    $0x8,%esp
80102ba2:	ff 75 0c             	pushl  0xc(%ebp)
80102ba5:	ff 75 08             	pushl  0x8(%ebp)
80102ba8:	e8 2e 00 00 00       	call   80102bdb <freerange>
80102bad:	83 c4 10             	add    $0x10,%esp
}
80102bb0:	90                   	nop
80102bb1:	c9                   	leave  
80102bb2:	c3                   	ret    

80102bb3 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102bb3:	f3 0f 1e fb          	endbr32 
80102bb7:	55                   	push   %ebp
80102bb8:	89 e5                	mov    %esp,%ebp
80102bba:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102bbd:	83 ec 08             	sub    $0x8,%esp
80102bc0:	ff 75 0c             	pushl  0xc(%ebp)
80102bc3:	ff 75 08             	pushl  0x8(%ebp)
80102bc6:	e8 10 00 00 00       	call   80102bdb <freerange>
80102bcb:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102bce:	c7 05 74 f8 10 80 01 	movl   $0x1,0x8010f874
80102bd5:	00 00 00 
}
80102bd8:	90                   	nop
80102bd9:	c9                   	leave  
80102bda:	c3                   	ret    

80102bdb <freerange>:

void
freerange(void *vstart, void *vend)
{
80102bdb:	f3 0f 1e fb          	endbr32 
80102bdf:	55                   	push   %ebp
80102be0:	89 e5                	mov    %esp,%ebp
80102be2:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102be5:	8b 45 08             	mov    0x8(%ebp),%eax
80102be8:	05 ff 0f 00 00       	add    $0xfff,%eax
80102bed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102bf2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bf5:	eb 15                	jmp    80102c0c <freerange+0x31>
    kfree(p);
80102bf7:	83 ec 0c             	sub    $0xc,%esp
80102bfa:	ff 75 f4             	pushl  -0xc(%ebp)
80102bfd:	e8 1b 00 00 00       	call   80102c1d <kfree>
80102c02:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c05:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c0f:	05 00 10 00 00       	add    $0x1000,%eax
80102c14:	39 45 0c             	cmp    %eax,0xc(%ebp)
80102c17:	73 de                	jae    80102bf7 <freerange+0x1c>
}
80102c19:	90                   	nop
80102c1a:	90                   	nop
80102c1b:	c9                   	leave  
80102c1c:	c3                   	ret    

80102c1d <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102c1d:	f3 0f 1e fb          	endbr32 
80102c21:	55                   	push   %ebp
80102c22:	89 e5                	mov    %esp,%ebp
80102c24:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102c27:	8b 45 08             	mov    0x8(%ebp),%eax
80102c2a:	25 ff 0f 00 00       	and    $0xfff,%eax
80102c2f:	85 c0                	test   %eax,%eax
80102c31:	75 1b                	jne    80102c4e <kfree+0x31>
80102c33:	81 7d 08 fc 26 11 80 	cmpl   $0x801126fc,0x8(%ebp)
80102c3a:	72 12                	jb     80102c4e <kfree+0x31>
80102c3c:	ff 75 08             	pushl  0x8(%ebp)
80102c3f:	e8 25 ff ff ff       	call   80102b69 <v2p>
80102c44:	83 c4 04             	add    $0x4,%esp
80102c47:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102c4c:	76 0d                	jbe    80102c5b <kfree+0x3e>
    panic("kfree");
80102c4e:	83 ec 0c             	sub    $0xc,%esp
80102c51:	68 7b 85 10 80       	push   $0x8010857b
80102c56:	e8 3c d9 ff ff       	call   80100597 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102c5b:	83 ec 04             	sub    $0x4,%esp
80102c5e:	68 00 10 00 00       	push   $0x1000
80102c63:	6a 01                	push   $0x1
80102c65:	ff 75 08             	pushl  0x8(%ebp)
80102c68:	e8 bb 23 00 00       	call   80105028 <memset>
80102c6d:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102c70:	a1 74 f8 10 80       	mov    0x8010f874,%eax
80102c75:	85 c0                	test   %eax,%eax
80102c77:	74 10                	je     80102c89 <kfree+0x6c>
    acquire(&kmem.lock);
80102c79:	83 ec 0c             	sub    $0xc,%esp
80102c7c:	68 40 f8 10 80       	push   $0x8010f840
80102c81:	e8 26 21 00 00       	call   80104dac <acquire>
80102c86:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102c89:	8b 45 08             	mov    0x8(%ebp),%eax
80102c8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102c8f:	8b 15 78 f8 10 80    	mov    0x8010f878,%edx
80102c95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c98:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c9d:	a3 78 f8 10 80       	mov    %eax,0x8010f878
  if(kmem.use_lock)
80102ca2:	a1 74 f8 10 80       	mov    0x8010f874,%eax
80102ca7:	85 c0                	test   %eax,%eax
80102ca9:	74 10                	je     80102cbb <kfree+0x9e>
    release(&kmem.lock);
80102cab:	83 ec 0c             	sub    $0xc,%esp
80102cae:	68 40 f8 10 80       	push   $0x8010f840
80102cb3:	e8 5f 21 00 00       	call   80104e17 <release>
80102cb8:	83 c4 10             	add    $0x10,%esp
}
80102cbb:	90                   	nop
80102cbc:	c9                   	leave  
80102cbd:	c3                   	ret    

80102cbe <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102cbe:	f3 0f 1e fb          	endbr32 
80102cc2:	55                   	push   %ebp
80102cc3:	89 e5                	mov    %esp,%ebp
80102cc5:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102cc8:	a1 74 f8 10 80       	mov    0x8010f874,%eax
80102ccd:	85 c0                	test   %eax,%eax
80102ccf:	74 10                	je     80102ce1 <kalloc+0x23>
    acquire(&kmem.lock);
80102cd1:	83 ec 0c             	sub    $0xc,%esp
80102cd4:	68 40 f8 10 80       	push   $0x8010f840
80102cd9:	e8 ce 20 00 00       	call   80104dac <acquire>
80102cde:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102ce1:	a1 78 f8 10 80       	mov    0x8010f878,%eax
80102ce6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102ce9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102ced:	74 0a                	je     80102cf9 <kalloc+0x3b>
    kmem.freelist = r->next;
80102cef:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cf2:	8b 00                	mov    (%eax),%eax
80102cf4:	a3 78 f8 10 80       	mov    %eax,0x8010f878
  if(kmem.use_lock)
80102cf9:	a1 74 f8 10 80       	mov    0x8010f874,%eax
80102cfe:	85 c0                	test   %eax,%eax
80102d00:	74 10                	je     80102d12 <kalloc+0x54>
    release(&kmem.lock);
80102d02:	83 ec 0c             	sub    $0xc,%esp
80102d05:	68 40 f8 10 80       	push   $0x8010f840
80102d0a:	e8 08 21 00 00       	call   80104e17 <release>
80102d0f:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102d12:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102d15:	c9                   	leave  
80102d16:	c3                   	ret    

80102d17 <inb>:
{
80102d17:	55                   	push   %ebp
80102d18:	89 e5                	mov    %esp,%ebp
80102d1a:	83 ec 14             	sub    $0x14,%esp
80102d1d:	8b 45 08             	mov    0x8(%ebp),%eax
80102d20:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d24:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102d28:	89 c2                	mov    %eax,%edx
80102d2a:	ec                   	in     (%dx),%al
80102d2b:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102d2e:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102d32:	c9                   	leave  
80102d33:	c3                   	ret    

80102d34 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102d34:	f3 0f 1e fb          	endbr32 
80102d38:	55                   	push   %ebp
80102d39:	89 e5                	mov    %esp,%ebp
80102d3b:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102d3e:	6a 64                	push   $0x64
80102d40:	e8 d2 ff ff ff       	call   80102d17 <inb>
80102d45:	83 c4 04             	add    $0x4,%esp
80102d48:	0f b6 c0             	movzbl %al,%eax
80102d4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102d4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d51:	83 e0 01             	and    $0x1,%eax
80102d54:	85 c0                	test   %eax,%eax
80102d56:	75 0a                	jne    80102d62 <kbdgetc+0x2e>
    return -1;
80102d58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102d5d:	e9 23 01 00 00       	jmp    80102e85 <kbdgetc+0x151>
  data = inb(KBDATAP);
80102d62:	6a 60                	push   $0x60
80102d64:	e8 ae ff ff ff       	call   80102d17 <inb>
80102d69:	83 c4 04             	add    $0x4,%esp
80102d6c:	0f b6 c0             	movzbl %al,%eax
80102d6f:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102d72:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102d79:	75 17                	jne    80102d92 <kbdgetc+0x5e>
    shift |= E0ESC;
80102d7b:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d80:	83 c8 40             	or     $0x40,%eax
80102d83:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102d88:	b8 00 00 00 00       	mov    $0x0,%eax
80102d8d:	e9 f3 00 00 00       	jmp    80102e85 <kbdgetc+0x151>
  } else if(data & 0x80){
80102d92:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d95:	25 80 00 00 00       	and    $0x80,%eax
80102d9a:	85 c0                	test   %eax,%eax
80102d9c:	74 45                	je     80102de3 <kbdgetc+0xaf>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102d9e:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102da3:	83 e0 40             	and    $0x40,%eax
80102da6:	85 c0                	test   %eax,%eax
80102da8:	75 08                	jne    80102db2 <kbdgetc+0x7e>
80102daa:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102dad:	83 e0 7f             	and    $0x7f,%eax
80102db0:	eb 03                	jmp    80102db5 <kbdgetc+0x81>
80102db2:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102db5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102db8:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102dbb:	05 20 90 10 80       	add    $0x80109020,%eax
80102dc0:	0f b6 00             	movzbl (%eax),%eax
80102dc3:	83 c8 40             	or     $0x40,%eax
80102dc6:	0f b6 c0             	movzbl %al,%eax
80102dc9:	f7 d0                	not    %eax
80102dcb:	89 c2                	mov    %eax,%edx
80102dcd:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102dd2:	21 d0                	and    %edx,%eax
80102dd4:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102dd9:	b8 00 00 00 00       	mov    $0x0,%eax
80102dde:	e9 a2 00 00 00       	jmp    80102e85 <kbdgetc+0x151>
  } else if(shift & E0ESC){
80102de3:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102de8:	83 e0 40             	and    $0x40,%eax
80102deb:	85 c0                	test   %eax,%eax
80102ded:	74 14                	je     80102e03 <kbdgetc+0xcf>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102def:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102df6:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102dfb:	83 e0 bf             	and    $0xffffffbf,%eax
80102dfe:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  }

  shift |= shiftcode[data];
80102e03:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e06:	05 20 90 10 80       	add    $0x80109020,%eax
80102e0b:	0f b6 00             	movzbl (%eax),%eax
80102e0e:	0f b6 d0             	movzbl %al,%edx
80102e11:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102e16:	09 d0                	or     %edx,%eax
80102e18:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  shift ^= togglecode[data];
80102e1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e20:	05 20 91 10 80       	add    $0x80109120,%eax
80102e25:	0f b6 00             	movzbl (%eax),%eax
80102e28:	0f b6 d0             	movzbl %al,%edx
80102e2b:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102e30:	31 d0                	xor    %edx,%eax
80102e32:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  c = charcode[shift & (CTL | SHIFT)][data];
80102e37:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102e3c:	83 e0 03             	and    $0x3,%eax
80102e3f:	8b 14 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%edx
80102e46:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e49:	01 d0                	add    %edx,%eax
80102e4b:	0f b6 00             	movzbl (%eax),%eax
80102e4e:	0f b6 c0             	movzbl %al,%eax
80102e51:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102e54:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102e59:	83 e0 08             	and    $0x8,%eax
80102e5c:	85 c0                	test   %eax,%eax
80102e5e:	74 22                	je     80102e82 <kbdgetc+0x14e>
    if('a' <= c && c <= 'z')
80102e60:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102e64:	76 0c                	jbe    80102e72 <kbdgetc+0x13e>
80102e66:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102e6a:	77 06                	ja     80102e72 <kbdgetc+0x13e>
      c += 'A' - 'a';
80102e6c:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102e70:	eb 10                	jmp    80102e82 <kbdgetc+0x14e>
    else if('A' <= c && c <= 'Z')
80102e72:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102e76:	76 0a                	jbe    80102e82 <kbdgetc+0x14e>
80102e78:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102e7c:	77 04                	ja     80102e82 <kbdgetc+0x14e>
      c += 'a' - 'A';
80102e7e:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102e82:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102e85:	c9                   	leave  
80102e86:	c3                   	ret    

80102e87 <kbdintr>:

void
kbdintr(void)
{
80102e87:	f3 0f 1e fb          	endbr32 
80102e8b:	55                   	push   %ebp
80102e8c:	89 e5                	mov    %esp,%ebp
80102e8e:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102e91:	83 ec 0c             	sub    $0xc,%esp
80102e94:	68 34 2d 10 80       	push   $0x80102d34
80102e99:	e8 84 d9 ff ff       	call   80100822 <consoleintr>
80102e9e:	83 c4 10             	add    $0x10,%esp
}
80102ea1:	90                   	nop
80102ea2:	c9                   	leave  
80102ea3:	c3                   	ret    

80102ea4 <outb>:
{
80102ea4:	55                   	push   %ebp
80102ea5:	89 e5                	mov    %esp,%ebp
80102ea7:	83 ec 08             	sub    $0x8,%esp
80102eaa:	8b 45 08             	mov    0x8(%ebp),%eax
80102ead:	8b 55 0c             	mov    0xc(%ebp),%edx
80102eb0:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80102eb4:	89 d0                	mov    %edx,%eax
80102eb6:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102eb9:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102ebd:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102ec1:	ee                   	out    %al,(%dx)
}
80102ec2:	90                   	nop
80102ec3:	c9                   	leave  
80102ec4:	c3                   	ret    

80102ec5 <readeflags>:
{
80102ec5:	55                   	push   %ebp
80102ec6:	89 e5                	mov    %esp,%ebp
80102ec8:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102ecb:	9c                   	pushf  
80102ecc:	58                   	pop    %eax
80102ecd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102ed0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102ed3:	c9                   	leave  
80102ed4:	c3                   	ret    

80102ed5 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102ed5:	f3 0f 1e fb          	endbr32 
80102ed9:	55                   	push   %ebp
80102eda:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102edc:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102ee1:	8b 55 08             	mov    0x8(%ebp),%edx
80102ee4:	c1 e2 02             	shl    $0x2,%edx
80102ee7:	01 c2                	add    %eax,%edx
80102ee9:	8b 45 0c             	mov    0xc(%ebp),%eax
80102eec:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102eee:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102ef3:	83 c0 20             	add    $0x20,%eax
80102ef6:	8b 00                	mov    (%eax),%eax
}
80102ef8:	90                   	nop
80102ef9:	5d                   	pop    %ebp
80102efa:	c3                   	ret    

80102efb <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102efb:	f3 0f 1e fb          	endbr32 
80102eff:	55                   	push   %ebp
80102f00:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80102f02:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102f07:	85 c0                	test   %eax,%eax
80102f09:	0f 84 0c 01 00 00    	je     8010301b <lapicinit+0x120>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102f0f:	68 3f 01 00 00       	push   $0x13f
80102f14:	6a 3c                	push   $0x3c
80102f16:	e8 ba ff ff ff       	call   80102ed5 <lapicw>
80102f1b:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102f1e:	6a 0b                	push   $0xb
80102f20:	68 f8 00 00 00       	push   $0xf8
80102f25:	e8 ab ff ff ff       	call   80102ed5 <lapicw>
80102f2a:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102f2d:	68 20 00 02 00       	push   $0x20020
80102f32:	68 c8 00 00 00       	push   $0xc8
80102f37:	e8 99 ff ff ff       	call   80102ed5 <lapicw>
80102f3c:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
80102f3f:	68 80 96 98 00       	push   $0x989680
80102f44:	68 e0 00 00 00       	push   $0xe0
80102f49:	e8 87 ff ff ff       	call   80102ed5 <lapicw>
80102f4e:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102f51:	68 00 00 01 00       	push   $0x10000
80102f56:	68 d4 00 00 00       	push   $0xd4
80102f5b:	e8 75 ff ff ff       	call   80102ed5 <lapicw>
80102f60:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80102f63:	68 00 00 01 00       	push   $0x10000
80102f68:	68 d8 00 00 00       	push   $0xd8
80102f6d:	e8 63 ff ff ff       	call   80102ed5 <lapicw>
80102f72:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102f75:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102f7a:	83 c0 30             	add    $0x30,%eax
80102f7d:	8b 00                	mov    (%eax),%eax
80102f7f:	c1 e8 10             	shr    $0x10,%eax
80102f82:	25 fc 00 00 00       	and    $0xfc,%eax
80102f87:	85 c0                	test   %eax,%eax
80102f89:	74 12                	je     80102f9d <lapicinit+0xa2>
    lapicw(PCINT, MASKED);
80102f8b:	68 00 00 01 00       	push   $0x10000
80102f90:	68 d0 00 00 00       	push   $0xd0
80102f95:	e8 3b ff ff ff       	call   80102ed5 <lapicw>
80102f9a:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102f9d:	6a 33                	push   $0x33
80102f9f:	68 dc 00 00 00       	push   $0xdc
80102fa4:	e8 2c ff ff ff       	call   80102ed5 <lapicw>
80102fa9:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102fac:	6a 00                	push   $0x0
80102fae:	68 a0 00 00 00       	push   $0xa0
80102fb3:	e8 1d ff ff ff       	call   80102ed5 <lapicw>
80102fb8:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102fbb:	6a 00                	push   $0x0
80102fbd:	68 a0 00 00 00       	push   $0xa0
80102fc2:	e8 0e ff ff ff       	call   80102ed5 <lapicw>
80102fc7:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102fca:	6a 00                	push   $0x0
80102fcc:	6a 2c                	push   $0x2c
80102fce:	e8 02 ff ff ff       	call   80102ed5 <lapicw>
80102fd3:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102fd6:	6a 00                	push   $0x0
80102fd8:	68 c4 00 00 00       	push   $0xc4
80102fdd:	e8 f3 fe ff ff       	call   80102ed5 <lapicw>
80102fe2:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102fe5:	68 00 85 08 00       	push   $0x88500
80102fea:	68 c0 00 00 00       	push   $0xc0
80102fef:	e8 e1 fe ff ff       	call   80102ed5 <lapicw>
80102ff4:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80102ff7:	90                   	nop
80102ff8:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102ffd:	05 00 03 00 00       	add    $0x300,%eax
80103002:	8b 00                	mov    (%eax),%eax
80103004:	25 00 10 00 00       	and    $0x1000,%eax
80103009:	85 c0                	test   %eax,%eax
8010300b:	75 eb                	jne    80102ff8 <lapicinit+0xfd>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
8010300d:	6a 00                	push   $0x0
8010300f:	6a 20                	push   $0x20
80103011:	e8 bf fe ff ff       	call   80102ed5 <lapicw>
80103016:	83 c4 08             	add    $0x8,%esp
80103019:	eb 01                	jmp    8010301c <lapicinit+0x121>
    return;
8010301b:	90                   	nop
}
8010301c:	c9                   	leave  
8010301d:	c3                   	ret    

8010301e <cpunum>:

int
cpunum(void)
{
8010301e:	f3 0f 1e fb          	endbr32 
80103022:	55                   	push   %ebp
80103023:	89 e5                	mov    %esp,%ebp
80103025:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80103028:	e8 98 fe ff ff       	call   80102ec5 <readeflags>
8010302d:	25 00 02 00 00       	and    $0x200,%eax
80103032:	85 c0                	test   %eax,%eax
80103034:	74 26                	je     8010305c <cpunum+0x3e>
    static int n;
    if(n++ == 0)
80103036:	a1 40 b6 10 80       	mov    0x8010b640,%eax
8010303b:	8d 50 01             	lea    0x1(%eax),%edx
8010303e:	89 15 40 b6 10 80    	mov    %edx,0x8010b640
80103044:	85 c0                	test   %eax,%eax
80103046:	75 14                	jne    8010305c <cpunum+0x3e>
      cprintf("cpu called from %x with interrupts enabled\n",
80103048:	8b 45 04             	mov    0x4(%ebp),%eax
8010304b:	83 ec 08             	sub    $0x8,%esp
8010304e:	50                   	push   %eax
8010304f:	68 84 85 10 80       	push   $0x80108584
80103054:	e8 85 d3 ff ff       	call   801003de <cprintf>
80103059:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
8010305c:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80103061:	85 c0                	test   %eax,%eax
80103063:	74 0f                	je     80103074 <cpunum+0x56>
    return lapic[ID]>>24;
80103065:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
8010306a:	83 c0 20             	add    $0x20,%eax
8010306d:	8b 00                	mov    (%eax),%eax
8010306f:	c1 e8 18             	shr    $0x18,%eax
80103072:	eb 05                	jmp    80103079 <cpunum+0x5b>
  return 0;
80103074:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103079:	c9                   	leave  
8010307a:	c3                   	ret    

8010307b <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
8010307b:	f3 0f 1e fb          	endbr32 
8010307f:	55                   	push   %ebp
80103080:	89 e5                	mov    %esp,%ebp
  if(lapic)
80103082:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80103087:	85 c0                	test   %eax,%eax
80103089:	74 0c                	je     80103097 <lapiceoi+0x1c>
    lapicw(EOI, 0);
8010308b:	6a 00                	push   $0x0
8010308d:	6a 2c                	push   $0x2c
8010308f:	e8 41 fe ff ff       	call   80102ed5 <lapicw>
80103094:	83 c4 08             	add    $0x8,%esp
}
80103097:	90                   	nop
80103098:	c9                   	leave  
80103099:	c3                   	ret    

8010309a <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
8010309a:	f3 0f 1e fb          	endbr32 
8010309e:	55                   	push   %ebp
8010309f:	89 e5                	mov    %esp,%ebp
}
801030a1:	90                   	nop
801030a2:	5d                   	pop    %ebp
801030a3:	c3                   	ret    

801030a4 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801030a4:	f3 0f 1e fb          	endbr32 
801030a8:	55                   	push   %ebp
801030a9:	89 e5                	mov    %esp,%ebp
801030ab:	83 ec 14             	sub    $0x14,%esp
801030ae:	8b 45 08             	mov    0x8(%ebp),%eax
801030b1:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
801030b4:	6a 0f                	push   $0xf
801030b6:	6a 70                	push   $0x70
801030b8:	e8 e7 fd ff ff       	call   80102ea4 <outb>
801030bd:	83 c4 08             	add    $0x8,%esp
  outb(IO_RTC+1, 0x0A);
801030c0:	6a 0a                	push   $0xa
801030c2:	6a 71                	push   $0x71
801030c4:	e8 db fd ff ff       	call   80102ea4 <outb>
801030c9:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
801030cc:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
801030d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
801030d6:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
801030db:	8b 45 0c             	mov    0xc(%ebp),%eax
801030de:	c1 e8 04             	shr    $0x4,%eax
801030e1:	89 c2                	mov    %eax,%edx
801030e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
801030e6:	83 c0 02             	add    $0x2,%eax
801030e9:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801030ec:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801030f0:	c1 e0 18             	shl    $0x18,%eax
801030f3:	50                   	push   %eax
801030f4:	68 c4 00 00 00       	push   $0xc4
801030f9:	e8 d7 fd ff ff       	call   80102ed5 <lapicw>
801030fe:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103101:	68 00 c5 00 00       	push   $0xc500
80103106:	68 c0 00 00 00       	push   $0xc0
8010310b:	e8 c5 fd ff ff       	call   80102ed5 <lapicw>
80103110:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103113:	68 c8 00 00 00       	push   $0xc8
80103118:	e8 7d ff ff ff       	call   8010309a <microdelay>
8010311d:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80103120:	68 00 85 00 00       	push   $0x8500
80103125:	68 c0 00 00 00       	push   $0xc0
8010312a:	e8 a6 fd ff ff       	call   80102ed5 <lapicw>
8010312f:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103132:	6a 64                	push   $0x64
80103134:	e8 61 ff ff ff       	call   8010309a <microdelay>
80103139:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010313c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103143:	eb 3d                	jmp    80103182 <lapicstartap+0xde>
    lapicw(ICRHI, apicid<<24);
80103145:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103149:	c1 e0 18             	shl    $0x18,%eax
8010314c:	50                   	push   %eax
8010314d:	68 c4 00 00 00       	push   $0xc4
80103152:	e8 7e fd ff ff       	call   80102ed5 <lapicw>
80103157:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
8010315a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010315d:	c1 e8 0c             	shr    $0xc,%eax
80103160:	80 cc 06             	or     $0x6,%ah
80103163:	50                   	push   %eax
80103164:	68 c0 00 00 00       	push   $0xc0
80103169:	e8 67 fd ff ff       	call   80102ed5 <lapicw>
8010316e:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
80103171:	68 c8 00 00 00       	push   $0xc8
80103176:	e8 1f ff ff ff       	call   8010309a <microdelay>
8010317b:	83 c4 04             	add    $0x4,%esp
  for(i = 0; i < 2; i++){
8010317e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103182:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103186:	7e bd                	jle    80103145 <lapicstartap+0xa1>
  }
}
80103188:	90                   	nop
80103189:	90                   	nop
8010318a:	c9                   	leave  
8010318b:	c3                   	ret    

8010318c <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
8010318c:	f3 0f 1e fb          	endbr32 
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	83 ec 18             	sub    $0x18,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80103196:	83 ec 08             	sub    $0x8,%esp
80103199:	68 b0 85 10 80       	push   $0x801085b0
8010319e:	68 80 f8 10 80       	push   $0x8010f880
801031a3:	e8 de 1b 00 00       	call   80104d86 <initlock>
801031a8:	83 c4 10             	add    $0x10,%esp
  readsb(ROOTDEV, &sb);
801031ab:	83 ec 08             	sub    $0x8,%esp
801031ae:	8d 45 e8             	lea    -0x18(%ebp),%eax
801031b1:	50                   	push   %eax
801031b2:	6a 01                	push   $0x1
801031b4:	e8 1b e2 ff ff       	call   801013d4 <readsb>
801031b9:	83 c4 10             	add    $0x10,%esp
  log.start = sb.size - sb.nlog;
801031bc:	8b 55 e8             	mov    -0x18(%ebp),%edx
801031bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031c2:	29 c2                	sub    %eax,%edx
801031c4:	89 d0                	mov    %edx,%eax
801031c6:	a3 b4 f8 10 80       	mov    %eax,0x8010f8b4
  log.size = sb.nlog;
801031cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031ce:	a3 b8 f8 10 80       	mov    %eax,0x8010f8b8
  log.dev = ROOTDEV;
801031d3:	c7 05 c0 f8 10 80 01 	movl   $0x1,0x8010f8c0
801031da:	00 00 00 
  recover_from_log();
801031dd:	e8 bf 01 00 00       	call   801033a1 <recover_from_log>
}
801031e2:	90                   	nop
801031e3:	c9                   	leave  
801031e4:	c3                   	ret    

801031e5 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
801031e5:	f3 0f 1e fb          	endbr32 
801031e9:	55                   	push   %ebp
801031ea:	89 e5                	mov    %esp,%ebp
801031ec:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801031ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801031f6:	e9 95 00 00 00       	jmp    80103290 <install_trans+0xab>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801031fb:	8b 15 b4 f8 10 80    	mov    0x8010f8b4,%edx
80103201:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103204:	01 d0                	add    %edx,%eax
80103206:	83 c0 01             	add    $0x1,%eax
80103209:	89 c2                	mov    %eax,%edx
8010320b:	a1 c0 f8 10 80       	mov    0x8010f8c0,%eax
80103210:	83 ec 08             	sub    $0x8,%esp
80103213:	52                   	push   %edx
80103214:	50                   	push   %eax
80103215:	e8 a5 cf ff ff       	call   801001bf <bread>
8010321a:	83 c4 10             	add    $0x10,%esp
8010321d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
80103220:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103223:	83 c0 10             	add    $0x10,%eax
80103226:	8b 04 85 88 f8 10 80 	mov    -0x7fef0778(,%eax,4),%eax
8010322d:	89 c2                	mov    %eax,%edx
8010322f:	a1 c0 f8 10 80       	mov    0x8010f8c0,%eax
80103234:	83 ec 08             	sub    $0x8,%esp
80103237:	52                   	push   %edx
80103238:	50                   	push   %eax
80103239:	e8 81 cf ff ff       	call   801001bf <bread>
8010323e:	83 c4 10             	add    $0x10,%esp
80103241:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103244:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103247:	8d 50 18             	lea    0x18(%eax),%edx
8010324a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010324d:	83 c0 18             	add    $0x18,%eax
80103250:	83 ec 04             	sub    $0x4,%esp
80103253:	68 00 02 00 00       	push   $0x200
80103258:	52                   	push   %edx
80103259:	50                   	push   %eax
8010325a:	e8 90 1e 00 00       	call   801050ef <memmove>
8010325f:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103262:	83 ec 0c             	sub    $0xc,%esp
80103265:	ff 75 ec             	pushl  -0x14(%ebp)
80103268:	e8 8f cf ff ff       	call   801001fc <bwrite>
8010326d:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
80103270:	83 ec 0c             	sub    $0xc,%esp
80103273:	ff 75 f0             	pushl  -0x10(%ebp)
80103276:	e8 c4 cf ff ff       	call   8010023f <brelse>
8010327b:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
8010327e:	83 ec 0c             	sub    $0xc,%esp
80103281:	ff 75 ec             	pushl  -0x14(%ebp)
80103284:	e8 b6 cf ff ff       	call   8010023f <brelse>
80103289:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
8010328c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103290:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
80103295:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103298:	0f 8c 5d ff ff ff    	jl     801031fb <install_trans+0x16>
  }
}
8010329e:	90                   	nop
8010329f:	90                   	nop
801032a0:	c9                   	leave  
801032a1:	c3                   	ret    

801032a2 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801032a2:	f3 0f 1e fb          	endbr32 
801032a6:	55                   	push   %ebp
801032a7:	89 e5                	mov    %esp,%ebp
801032a9:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801032ac:	a1 b4 f8 10 80       	mov    0x8010f8b4,%eax
801032b1:	89 c2                	mov    %eax,%edx
801032b3:	a1 c0 f8 10 80       	mov    0x8010f8c0,%eax
801032b8:	83 ec 08             	sub    $0x8,%esp
801032bb:	52                   	push   %edx
801032bc:	50                   	push   %eax
801032bd:	e8 fd ce ff ff       	call   801001bf <bread>
801032c2:	83 c4 10             	add    $0x10,%esp
801032c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
801032c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801032cb:	83 c0 18             	add    $0x18,%eax
801032ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
801032d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032d4:	8b 00                	mov    (%eax),%eax
801032d6:	a3 c4 f8 10 80       	mov    %eax,0x8010f8c4
  for (i = 0; i < log.lh.n; i++) {
801032db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801032e2:	eb 1b                	jmp    801032ff <read_head+0x5d>
    log.lh.sector[i] = lh->sector[i];
801032e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801032ea:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
801032ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
801032f1:	83 c2 10             	add    $0x10,%edx
801032f4:	89 04 95 88 f8 10 80 	mov    %eax,-0x7fef0778(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801032fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801032ff:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
80103304:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103307:	7c db                	jl     801032e4 <read_head+0x42>
  }
  brelse(buf);
80103309:	83 ec 0c             	sub    $0xc,%esp
8010330c:	ff 75 f0             	pushl  -0x10(%ebp)
8010330f:	e8 2b cf ff ff       	call   8010023f <brelse>
80103314:	83 c4 10             	add    $0x10,%esp
}
80103317:	90                   	nop
80103318:	c9                   	leave  
80103319:	c3                   	ret    

8010331a <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010331a:	f3 0f 1e fb          	endbr32 
8010331e:	55                   	push   %ebp
8010331f:	89 e5                	mov    %esp,%ebp
80103321:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103324:	a1 b4 f8 10 80       	mov    0x8010f8b4,%eax
80103329:	89 c2                	mov    %eax,%edx
8010332b:	a1 c0 f8 10 80       	mov    0x8010f8c0,%eax
80103330:	83 ec 08             	sub    $0x8,%esp
80103333:	52                   	push   %edx
80103334:	50                   	push   %eax
80103335:	e8 85 ce ff ff       	call   801001bf <bread>
8010333a:	83 c4 10             	add    $0x10,%esp
8010333d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80103340:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103343:	83 c0 18             	add    $0x18,%eax
80103346:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103349:	8b 15 c4 f8 10 80    	mov    0x8010f8c4,%edx
8010334f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103352:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103354:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010335b:	eb 1b                	jmp    80103378 <write_head+0x5e>
    hb->sector[i] = log.lh.sector[i];
8010335d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103360:	83 c0 10             	add    $0x10,%eax
80103363:	8b 0c 85 88 f8 10 80 	mov    -0x7fef0778(,%eax,4),%ecx
8010336a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010336d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103370:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103374:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103378:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
8010337d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103380:	7c db                	jl     8010335d <write_head+0x43>
  }
  bwrite(buf);
80103382:	83 ec 0c             	sub    $0xc,%esp
80103385:	ff 75 f0             	pushl  -0x10(%ebp)
80103388:	e8 6f ce ff ff       	call   801001fc <bwrite>
8010338d:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80103390:	83 ec 0c             	sub    $0xc,%esp
80103393:	ff 75 f0             	pushl  -0x10(%ebp)
80103396:	e8 a4 ce ff ff       	call   8010023f <brelse>
8010339b:	83 c4 10             	add    $0x10,%esp
}
8010339e:	90                   	nop
8010339f:	c9                   	leave  
801033a0:	c3                   	ret    

801033a1 <recover_from_log>:

static void
recover_from_log(void)
{
801033a1:	f3 0f 1e fb          	endbr32 
801033a5:	55                   	push   %ebp
801033a6:	89 e5                	mov    %esp,%ebp
801033a8:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801033ab:	e8 f2 fe ff ff       	call   801032a2 <read_head>
  install_trans(); // if committed, copy from log to disk
801033b0:	e8 30 fe ff ff       	call   801031e5 <install_trans>
  log.lh.n = 0;
801033b5:	c7 05 c4 f8 10 80 00 	movl   $0x0,0x8010f8c4
801033bc:	00 00 00 
  write_head(); // clear the log
801033bf:	e8 56 ff ff ff       	call   8010331a <write_head>
}
801033c4:	90                   	nop
801033c5:	c9                   	leave  
801033c6:	c3                   	ret    

801033c7 <begin_trans>:

void
begin_trans(void)
{
801033c7:	f3 0f 1e fb          	endbr32 
801033cb:	55                   	push   %ebp
801033cc:	89 e5                	mov    %esp,%ebp
801033ce:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
801033d1:	83 ec 0c             	sub    $0xc,%esp
801033d4:	68 80 f8 10 80       	push   $0x8010f880
801033d9:	e8 ce 19 00 00       	call   80104dac <acquire>
801033de:	83 c4 10             	add    $0x10,%esp
  while (log.busy) {
801033e1:	eb 15                	jmp    801033f8 <begin_trans+0x31>
    sleep(&log, &log.lock);
801033e3:	83 ec 08             	sub    $0x8,%esp
801033e6:	68 80 f8 10 80       	push   $0x8010f880
801033eb:	68 80 f8 10 80       	push   $0x8010f880
801033f0:	e8 a4 16 00 00       	call   80104a99 <sleep>
801033f5:	83 c4 10             	add    $0x10,%esp
  while (log.busy) {
801033f8:	a1 bc f8 10 80       	mov    0x8010f8bc,%eax
801033fd:	85 c0                	test   %eax,%eax
801033ff:	75 e2                	jne    801033e3 <begin_trans+0x1c>
  }
  log.busy = 1;
80103401:	c7 05 bc f8 10 80 01 	movl   $0x1,0x8010f8bc
80103408:	00 00 00 
  release(&log.lock);
8010340b:	83 ec 0c             	sub    $0xc,%esp
8010340e:	68 80 f8 10 80       	push   $0x8010f880
80103413:	e8 ff 19 00 00       	call   80104e17 <release>
80103418:	83 c4 10             	add    $0x10,%esp
}
8010341b:	90                   	nop
8010341c:	c9                   	leave  
8010341d:	c3                   	ret    

8010341e <commit_trans>:

void
commit_trans(void)
{
8010341e:	f3 0f 1e fb          	endbr32 
80103422:	55                   	push   %ebp
80103423:	89 e5                	mov    %esp,%ebp
80103425:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103428:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
8010342d:	85 c0                	test   %eax,%eax
8010342f:	7e 19                	jle    8010344a <commit_trans+0x2c>
    write_head();    // Write header to disk -- the real commit
80103431:	e8 e4 fe ff ff       	call   8010331a <write_head>
    install_trans(); // Now install writes to home locations
80103436:	e8 aa fd ff ff       	call   801031e5 <install_trans>
    log.lh.n = 0; 
8010343b:	c7 05 c4 f8 10 80 00 	movl   $0x0,0x8010f8c4
80103442:	00 00 00 
    write_head();    // Erase the transaction from the log
80103445:	e8 d0 fe ff ff       	call   8010331a <write_head>
  }
  
  acquire(&log.lock);
8010344a:	83 ec 0c             	sub    $0xc,%esp
8010344d:	68 80 f8 10 80       	push   $0x8010f880
80103452:	e8 55 19 00 00       	call   80104dac <acquire>
80103457:	83 c4 10             	add    $0x10,%esp
  log.busy = 0;
8010345a:	c7 05 bc f8 10 80 00 	movl   $0x0,0x8010f8bc
80103461:	00 00 00 
  wakeup(&log);
80103464:	83 ec 0c             	sub    $0xc,%esp
80103467:	68 80 f8 10 80       	push   $0x8010f880
8010346c:	e8 1c 17 00 00       	call   80104b8d <wakeup>
80103471:	83 c4 10             	add    $0x10,%esp
  release(&log.lock);
80103474:	83 ec 0c             	sub    $0xc,%esp
80103477:	68 80 f8 10 80       	push   $0x8010f880
8010347c:	e8 96 19 00 00       	call   80104e17 <release>
80103481:	83 c4 10             	add    $0x10,%esp
}
80103484:	90                   	nop
80103485:	c9                   	leave  
80103486:	c3                   	ret    

80103487 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103487:	f3 0f 1e fb          	endbr32 
8010348b:	55                   	push   %ebp
8010348c:	89 e5                	mov    %esp,%ebp
8010348e:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103491:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
80103496:	83 f8 09             	cmp    $0x9,%eax
80103499:	7f 12                	jg     801034ad <log_write+0x26>
8010349b:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
801034a0:	8b 15 b8 f8 10 80    	mov    0x8010f8b8,%edx
801034a6:	83 ea 01             	sub    $0x1,%edx
801034a9:	39 d0                	cmp    %edx,%eax
801034ab:	7c 0d                	jl     801034ba <log_write+0x33>
    panic("too big a transaction");
801034ad:	83 ec 0c             	sub    $0xc,%esp
801034b0:	68 b4 85 10 80       	push   $0x801085b4
801034b5:	e8 dd d0 ff ff       	call   80100597 <panic>
  if (!log.busy)
801034ba:	a1 bc f8 10 80       	mov    0x8010f8bc,%eax
801034bf:	85 c0                	test   %eax,%eax
801034c1:	75 0d                	jne    801034d0 <log_write+0x49>
    panic("write outside of trans");
801034c3:	83 ec 0c             	sub    $0xc,%esp
801034c6:	68 ca 85 10 80       	push   $0x801085ca
801034cb:	e8 c7 d0 ff ff       	call   80100597 <panic>

  for (i = 0; i < log.lh.n; i++) {
801034d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034d7:	eb 1d                	jmp    801034f6 <log_write+0x6f>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
801034d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034dc:	83 c0 10             	add    $0x10,%eax
801034df:	8b 04 85 88 f8 10 80 	mov    -0x7fef0778(,%eax,4),%eax
801034e6:	89 c2                	mov    %eax,%edx
801034e8:	8b 45 08             	mov    0x8(%ebp),%eax
801034eb:	8b 40 08             	mov    0x8(%eax),%eax
801034ee:	39 c2                	cmp    %eax,%edx
801034f0:	74 10                	je     80103502 <log_write+0x7b>
  for (i = 0; i < log.lh.n; i++) {
801034f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034f6:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
801034fb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801034fe:	7c d9                	jl     801034d9 <log_write+0x52>
80103500:	eb 01                	jmp    80103503 <log_write+0x7c>
      break;
80103502:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
80103503:	8b 45 08             	mov    0x8(%ebp),%eax
80103506:	8b 40 08             	mov    0x8(%eax),%eax
80103509:	89 c2                	mov    %eax,%edx
8010350b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010350e:	83 c0 10             	add    $0x10,%eax
80103511:	89 14 85 88 f8 10 80 	mov    %edx,-0x7fef0778(,%eax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
80103518:	8b 15 b4 f8 10 80    	mov    0x8010f8b4,%edx
8010351e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103521:	01 d0                	add    %edx,%eax
80103523:	83 c0 01             	add    $0x1,%eax
80103526:	89 c2                	mov    %eax,%edx
80103528:	8b 45 08             	mov    0x8(%ebp),%eax
8010352b:	8b 40 04             	mov    0x4(%eax),%eax
8010352e:	83 ec 08             	sub    $0x8,%esp
80103531:	52                   	push   %edx
80103532:	50                   	push   %eax
80103533:	e8 87 cc ff ff       	call   801001bf <bread>
80103538:	83 c4 10             	add    $0x10,%esp
8010353b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
8010353e:	8b 45 08             	mov    0x8(%ebp),%eax
80103541:	8d 50 18             	lea    0x18(%eax),%edx
80103544:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103547:	83 c0 18             	add    $0x18,%eax
8010354a:	83 ec 04             	sub    $0x4,%esp
8010354d:	68 00 02 00 00       	push   $0x200
80103552:	52                   	push   %edx
80103553:	50                   	push   %eax
80103554:	e8 96 1b 00 00       	call   801050ef <memmove>
80103559:	83 c4 10             	add    $0x10,%esp
  bwrite(lbuf);
8010355c:	83 ec 0c             	sub    $0xc,%esp
8010355f:	ff 75 f0             	pushl  -0x10(%ebp)
80103562:	e8 95 cc ff ff       	call   801001fc <bwrite>
80103567:	83 c4 10             	add    $0x10,%esp
  brelse(lbuf);
8010356a:	83 ec 0c             	sub    $0xc,%esp
8010356d:	ff 75 f0             	pushl  -0x10(%ebp)
80103570:	e8 ca cc ff ff       	call   8010023f <brelse>
80103575:	83 c4 10             	add    $0x10,%esp
  if (i == log.lh.n)
80103578:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
8010357d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103580:	75 0d                	jne    8010358f <log_write+0x108>
    log.lh.n++;
80103582:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
80103587:	83 c0 01             	add    $0x1,%eax
8010358a:	a3 c4 f8 10 80       	mov    %eax,0x8010f8c4
  b->flags |= B_DIRTY; // XXX prevent eviction
8010358f:	8b 45 08             	mov    0x8(%ebp),%eax
80103592:	8b 00                	mov    (%eax),%eax
80103594:	83 c8 04             	or     $0x4,%eax
80103597:	89 c2                	mov    %eax,%edx
80103599:	8b 45 08             	mov    0x8(%ebp),%eax
8010359c:	89 10                	mov    %edx,(%eax)
}
8010359e:	90                   	nop
8010359f:	c9                   	leave  
801035a0:	c3                   	ret    

801035a1 <v2p>:
801035a1:	55                   	push   %ebp
801035a2:	89 e5                	mov    %esp,%ebp
801035a4:	8b 45 08             	mov    0x8(%ebp),%eax
801035a7:	05 00 00 00 80       	add    $0x80000000,%eax
801035ac:	5d                   	pop    %ebp
801035ad:	c3                   	ret    

801035ae <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801035ae:	55                   	push   %ebp
801035af:	89 e5                	mov    %esp,%ebp
801035b1:	8b 45 08             	mov    0x8(%ebp),%eax
801035b4:	05 00 00 00 80       	add    $0x80000000,%eax
801035b9:	5d                   	pop    %ebp
801035ba:	c3                   	ret    

801035bb <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801035bb:	55                   	push   %ebp
801035bc:	89 e5                	mov    %esp,%ebp
801035be:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801035c1:	8b 55 08             	mov    0x8(%ebp),%edx
801035c4:	8b 45 0c             	mov    0xc(%ebp),%eax
801035c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
801035ca:	f0 87 02             	lock xchg %eax,(%edx)
801035cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801035d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801035d3:	c9                   	leave  
801035d4:	c3                   	ret    

801035d5 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
801035d5:	f3 0f 1e fb          	endbr32 
801035d9:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801035dd:	83 e4 f0             	and    $0xfffffff0,%esp
801035e0:	ff 71 fc             	pushl  -0x4(%ecx)
801035e3:	55                   	push   %ebp
801035e4:	89 e5                	mov    %esp,%ebp
801035e6:	51                   	push   %ecx
801035e7:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801035ea:	83 ec 08             	sub    $0x8,%esp
801035ed:	68 00 00 40 80       	push   $0x80400000
801035f2:	68 fc 26 11 80       	push   $0x801126fc
801035f7:	e8 7a f5 ff ff       	call   80102b76 <kinit1>
801035fc:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
801035ff:	e8 17 46 00 00       	call   80107c1b <kvmalloc>
  mpinit();        // collect info about this machine
80103604:	e8 5f 04 00 00       	call   80103a68 <mpinit>
  lapicinit();
80103609:	e8 ed f8 ff ff       	call   80102efb <lapicinit>
  seginit();       // set up segments
8010360e:	e8 a1 3f 00 00       	call   801075b4 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103613:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103619:	0f b6 00             	movzbl (%eax),%eax
8010361c:	0f b6 c0             	movzbl %al,%eax
8010361f:	83 ec 08             	sub    $0x8,%esp
80103622:	50                   	push   %eax
80103623:	68 e1 85 10 80       	push   $0x801085e1
80103628:	e8 b1 cd ff ff       	call   801003de <cprintf>
8010362d:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
80103630:	e8 bb 06 00 00       	call   80103cf0 <picinit>
  ioapicinit();    // another interrupt controller
80103635:	e8 29 f4 ff ff       	call   80102a63 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
8010363a:	e8 05 d5 ff ff       	call   80100b44 <consoleinit>
  uartinit();      // serial port
8010363f:	e8 bc 32 00 00       	call   80106900 <uartinit>
  pinit();         // process table
80103644:	e8 b8 0b 00 00       	call   80104201 <pinit>
  tvinit();        // trap vectors
80103649:	e8 6c 2e 00 00       	call   801064ba <tvinit>
  binit();         // buffer cache
8010364e:	e8 e1 c9 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103653:	e8 51 d9 ff ff       	call   80100fa9 <fileinit>
  iinit();         // inode cache
80103658:	e8 56 e0 ff ff       	call   801016b3 <iinit>
  ideinit();       // disk
8010365d:	e8 2d f0 ff ff       	call   8010268f <ideinit>
  if(!ismp)
80103662:	a1 04 f9 10 80       	mov    0x8010f904,%eax
80103667:	85 c0                	test   %eax,%eax
80103669:	75 05                	jne    80103670 <main+0x9b>
    timerinit();   // uniprocessor timer
8010366b:	e8 a3 2d 00 00       	call   80106413 <timerinit>
  startothers();   // start other processors
80103670:	e8 87 00 00 00       	call   801036fc <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103675:	83 ec 08             	sub    $0x8,%esp
80103678:	68 00 00 00 8e       	push   $0x8e000000
8010367d:	68 00 00 40 80       	push   $0x80400000
80103682:	e8 2c f5 ff ff       	call   80102bb3 <kinit2>
80103687:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
8010368a:	e8 a0 0c 00 00       	call   8010432f <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
8010368f:	e8 1e 00 00 00       	call   801036b2 <mpmain>

80103694 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103694:	f3 0f 1e fb          	endbr32 
80103698:	55                   	push   %ebp
80103699:	89 e5                	mov    %esp,%ebp
8010369b:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
8010369e:	e8 94 45 00 00       	call   80107c37 <switchkvm>
  seginit();
801036a3:	e8 0c 3f 00 00       	call   801075b4 <seginit>
  lapicinit();
801036a8:	e8 4e f8 ff ff       	call   80102efb <lapicinit>
  mpmain();
801036ad:	e8 00 00 00 00       	call   801036b2 <mpmain>

801036b2 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801036b2:	f3 0f 1e fb          	endbr32 
801036b6:	55                   	push   %ebp
801036b7:	89 e5                	mov    %esp,%ebp
801036b9:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
801036bc:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801036c2:	0f b6 00             	movzbl (%eax),%eax
801036c5:	0f b6 c0             	movzbl %al,%eax
801036c8:	83 ec 08             	sub    $0x8,%esp
801036cb:	50                   	push   %eax
801036cc:	68 f8 85 10 80       	push   $0x801085f8
801036d1:	e8 08 cd ff ff       	call   801003de <cprintf>
801036d6:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
801036d9:	e8 56 2f 00 00       	call   80106634 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
801036de:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801036e4:	05 a8 00 00 00       	add    $0xa8,%eax
801036e9:	83 ec 08             	sub    $0x8,%esp
801036ec:	6a 01                	push   $0x1
801036ee:	50                   	push   %eax
801036ef:	e8 c7 fe ff ff       	call   801035bb <xchg>
801036f4:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
801036f7:	e8 c0 11 00 00       	call   801048bc <scheduler>

801036fc <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
801036fc:	f3 0f 1e fb          	endbr32 
80103700:	55                   	push   %ebp
80103701:	89 e5                	mov    %esp,%ebp
80103703:	83 ec 18             	sub    $0x18,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103706:	68 00 70 00 00       	push   $0x7000
8010370b:	e8 9e fe ff ff       	call   801035ae <p2v>
80103710:	83 c4 04             	add    $0x4,%esp
80103713:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103716:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010371b:	83 ec 04             	sub    $0x4,%esp
8010371e:	50                   	push   %eax
8010371f:	68 0c b5 10 80       	push   $0x8010b50c
80103724:	ff 75 f0             	pushl  -0x10(%ebp)
80103727:	e8 c3 19 00 00       	call   801050ef <memmove>
8010372c:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
8010372f:	c7 45 f4 20 f9 10 80 	movl   $0x8010f920,-0xc(%ebp)
80103736:	e9 8e 00 00 00       	jmp    801037c9 <startothers+0xcd>
    if(c == cpus+cpunum())  // We've started already.
8010373b:	e8 de f8 ff ff       	call   8010301e <cpunum>
80103740:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103746:	05 20 f9 10 80       	add    $0x8010f920,%eax
8010374b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010374e:	74 71                	je     801037c1 <startothers+0xc5>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103750:	e8 69 f5 ff ff       	call   80102cbe <kalloc>
80103755:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103758:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010375b:	83 e8 04             	sub    $0x4,%eax
8010375e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103761:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103767:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103769:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010376c:	83 e8 08             	sub    $0x8,%eax
8010376f:	c7 00 94 36 10 80    	movl   $0x80103694,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103775:	83 ec 0c             	sub    $0xc,%esp
80103778:	68 00 a0 10 80       	push   $0x8010a000
8010377d:	e8 1f fe ff ff       	call   801035a1 <v2p>
80103782:	83 c4 10             	add    $0x10,%esp
80103785:	8b 55 f0             	mov    -0x10(%ebp),%edx
80103788:	83 ea 0c             	sub    $0xc,%edx
8010378b:	89 02                	mov    %eax,(%edx)

    lapicstartap(c->id, v2p(code));
8010378d:	83 ec 0c             	sub    $0xc,%esp
80103790:	ff 75 f0             	pushl  -0x10(%ebp)
80103793:	e8 09 fe ff ff       	call   801035a1 <v2p>
80103798:	83 c4 10             	add    $0x10,%esp
8010379b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010379e:	0f b6 12             	movzbl (%edx),%edx
801037a1:	0f b6 d2             	movzbl %dl,%edx
801037a4:	83 ec 08             	sub    $0x8,%esp
801037a7:	50                   	push   %eax
801037a8:	52                   	push   %edx
801037a9:	e8 f6 f8 ff ff       	call   801030a4 <lapicstartap>
801037ae:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801037b1:	90                   	nop
801037b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037b5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801037bb:	85 c0                	test   %eax,%eax
801037bd:	74 f3                	je     801037b2 <startothers+0xb6>
801037bf:	eb 01                	jmp    801037c2 <startothers+0xc6>
      continue;
801037c1:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
801037c2:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
801037c9:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801037ce:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801037d4:	05 20 f9 10 80       	add    $0x8010f920,%eax
801037d9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801037dc:	0f 82 59 ff ff ff    	jb     8010373b <startothers+0x3f>
      ;
  }
}
801037e2:	90                   	nop
801037e3:	90                   	nop
801037e4:	c9                   	leave  
801037e5:	c3                   	ret    

801037e6 <p2v>:
801037e6:	55                   	push   %ebp
801037e7:	89 e5                	mov    %esp,%ebp
801037e9:	8b 45 08             	mov    0x8(%ebp),%eax
801037ec:	05 00 00 00 80       	add    $0x80000000,%eax
801037f1:	5d                   	pop    %ebp
801037f2:	c3                   	ret    

801037f3 <inb>:
{
801037f3:	55                   	push   %ebp
801037f4:	89 e5                	mov    %esp,%ebp
801037f6:	83 ec 14             	sub    $0x14,%esp
801037f9:	8b 45 08             	mov    0x8(%ebp),%eax
801037fc:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103800:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103804:	89 c2                	mov    %eax,%edx
80103806:	ec                   	in     (%dx),%al
80103807:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010380a:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010380e:	c9                   	leave  
8010380f:	c3                   	ret    

80103810 <outb>:
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	83 ec 08             	sub    $0x8,%esp
80103816:	8b 45 08             	mov    0x8(%ebp),%eax
80103819:	8b 55 0c             	mov    0xc(%ebp),%edx
8010381c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103820:	89 d0                	mov    %edx,%eax
80103822:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103825:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103829:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010382d:	ee                   	out    %al,(%dx)
}
8010382e:	90                   	nop
8010382f:	c9                   	leave  
80103830:	c3                   	ret    

80103831 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103831:	f3 0f 1e fb          	endbr32 
80103835:	55                   	push   %ebp
80103836:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103838:	a1 44 b6 10 80       	mov    0x8010b644,%eax
8010383d:	2d 20 f9 10 80       	sub    $0x8010f920,%eax
80103842:	c1 f8 02             	sar    $0x2,%eax
80103845:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
8010384b:	5d                   	pop    %ebp
8010384c:	c3                   	ret    

8010384d <sum>:

static uchar
sum(uchar *addr, int len)
{
8010384d:	f3 0f 1e fb          	endbr32 
80103851:	55                   	push   %ebp
80103852:	89 e5                	mov    %esp,%ebp
80103854:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103857:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
8010385e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103865:	eb 15                	jmp    8010387c <sum+0x2f>
    sum += addr[i];
80103867:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010386a:	8b 45 08             	mov    0x8(%ebp),%eax
8010386d:	01 d0                	add    %edx,%eax
8010386f:	0f b6 00             	movzbl (%eax),%eax
80103872:	0f b6 c0             	movzbl %al,%eax
80103875:	01 45 f8             	add    %eax,-0x8(%ebp)
  for(i=0; i<len; i++)
80103878:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010387c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010387f:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103882:	7c e3                	jl     80103867 <sum+0x1a>
  return sum;
80103884:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103887:	c9                   	leave  
80103888:	c3                   	ret    

80103889 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103889:	f3 0f 1e fb          	endbr32 
8010388d:	55                   	push   %ebp
8010388e:	89 e5                	mov    %esp,%ebp
80103890:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103893:	ff 75 08             	pushl  0x8(%ebp)
80103896:	e8 4b ff ff ff       	call   801037e6 <p2v>
8010389b:	83 c4 04             	add    $0x4,%esp
8010389e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
801038a1:	8b 55 0c             	mov    0xc(%ebp),%edx
801038a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038a7:	01 d0                	add    %edx,%eax
801038a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
801038ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038af:	89 45 f4             	mov    %eax,-0xc(%ebp)
801038b2:	eb 36                	jmp    801038ea <mpsearch1+0x61>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801038b4:	83 ec 04             	sub    $0x4,%esp
801038b7:	6a 04                	push   $0x4
801038b9:	68 0c 86 10 80       	push   $0x8010860c
801038be:	ff 75 f4             	pushl  -0xc(%ebp)
801038c1:	e8 cd 17 00 00       	call   80105093 <memcmp>
801038c6:	83 c4 10             	add    $0x10,%esp
801038c9:	85 c0                	test   %eax,%eax
801038cb:	75 19                	jne    801038e6 <mpsearch1+0x5d>
801038cd:	83 ec 08             	sub    $0x8,%esp
801038d0:	6a 10                	push   $0x10
801038d2:	ff 75 f4             	pushl  -0xc(%ebp)
801038d5:	e8 73 ff ff ff       	call   8010384d <sum>
801038da:	83 c4 10             	add    $0x10,%esp
801038dd:	84 c0                	test   %al,%al
801038df:	75 05                	jne    801038e6 <mpsearch1+0x5d>
      return (struct mp*)p;
801038e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038e4:	eb 11                	jmp    801038f7 <mpsearch1+0x6e>
  for(p = addr; p < e; p += sizeof(struct mp))
801038e6:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801038ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038ed:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801038f0:	72 c2                	jb     801038b4 <mpsearch1+0x2b>
  return 0;
801038f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801038f7:	c9                   	leave  
801038f8:	c3                   	ret    

801038f9 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
801038f9:	f3 0f 1e fb          	endbr32 
801038fd:	55                   	push   %ebp
801038fe:	89 e5                	mov    %esp,%ebp
80103900:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103903:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
8010390a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010390d:	83 c0 0f             	add    $0xf,%eax
80103910:	0f b6 00             	movzbl (%eax),%eax
80103913:	0f b6 c0             	movzbl %al,%eax
80103916:	c1 e0 08             	shl    $0x8,%eax
80103919:	89 c2                	mov    %eax,%edx
8010391b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010391e:	83 c0 0e             	add    $0xe,%eax
80103921:	0f b6 00             	movzbl (%eax),%eax
80103924:	0f b6 c0             	movzbl %al,%eax
80103927:	09 d0                	or     %edx,%eax
80103929:	c1 e0 04             	shl    $0x4,%eax
8010392c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010392f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103933:	74 21                	je     80103956 <mpsearch+0x5d>
    if((mp = mpsearch1(p, 1024)))
80103935:	83 ec 08             	sub    $0x8,%esp
80103938:	68 00 04 00 00       	push   $0x400
8010393d:	ff 75 f0             	pushl  -0x10(%ebp)
80103940:	e8 44 ff ff ff       	call   80103889 <mpsearch1>
80103945:	83 c4 10             	add    $0x10,%esp
80103948:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010394b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010394f:	74 51                	je     801039a2 <mpsearch+0xa9>
      return mp;
80103951:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103954:	eb 61                	jmp    801039b7 <mpsearch+0xbe>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103956:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103959:	83 c0 14             	add    $0x14,%eax
8010395c:	0f b6 00             	movzbl (%eax),%eax
8010395f:	0f b6 c0             	movzbl %al,%eax
80103962:	c1 e0 08             	shl    $0x8,%eax
80103965:	89 c2                	mov    %eax,%edx
80103967:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010396a:	83 c0 13             	add    $0x13,%eax
8010396d:	0f b6 00             	movzbl (%eax),%eax
80103970:	0f b6 c0             	movzbl %al,%eax
80103973:	09 d0                	or     %edx,%eax
80103975:	c1 e0 0a             	shl    $0xa,%eax
80103978:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
8010397b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010397e:	2d 00 04 00 00       	sub    $0x400,%eax
80103983:	83 ec 08             	sub    $0x8,%esp
80103986:	68 00 04 00 00       	push   $0x400
8010398b:	50                   	push   %eax
8010398c:	e8 f8 fe ff ff       	call   80103889 <mpsearch1>
80103991:	83 c4 10             	add    $0x10,%esp
80103994:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103997:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010399b:	74 05                	je     801039a2 <mpsearch+0xa9>
      return mp;
8010399d:	8b 45 ec             	mov    -0x14(%ebp),%eax
801039a0:	eb 15                	jmp    801039b7 <mpsearch+0xbe>
  }
  return mpsearch1(0xF0000, 0x10000);
801039a2:	83 ec 08             	sub    $0x8,%esp
801039a5:	68 00 00 01 00       	push   $0x10000
801039aa:	68 00 00 0f 00       	push   $0xf0000
801039af:	e8 d5 fe ff ff       	call   80103889 <mpsearch1>
801039b4:	83 c4 10             	add    $0x10,%esp
}
801039b7:	c9                   	leave  
801039b8:	c3                   	ret    

801039b9 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
801039b9:	f3 0f 1e fb          	endbr32 
801039bd:	55                   	push   %ebp
801039be:	89 e5                	mov    %esp,%ebp
801039c0:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801039c3:	e8 31 ff ff ff       	call   801038f9 <mpsearch>
801039c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801039cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801039cf:	74 0a                	je     801039db <mpconfig+0x22>
801039d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039d4:	8b 40 04             	mov    0x4(%eax),%eax
801039d7:	85 c0                	test   %eax,%eax
801039d9:	75 0a                	jne    801039e5 <mpconfig+0x2c>
    return 0;
801039db:	b8 00 00 00 00       	mov    $0x0,%eax
801039e0:	e9 81 00 00 00       	jmp    80103a66 <mpconfig+0xad>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
801039e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039e8:	8b 40 04             	mov    0x4(%eax),%eax
801039eb:	83 ec 0c             	sub    $0xc,%esp
801039ee:	50                   	push   %eax
801039ef:	e8 f2 fd ff ff       	call   801037e6 <p2v>
801039f4:	83 c4 10             	add    $0x10,%esp
801039f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801039fa:	83 ec 04             	sub    $0x4,%esp
801039fd:	6a 04                	push   $0x4
801039ff:	68 11 86 10 80       	push   $0x80108611
80103a04:	ff 75 f0             	pushl  -0x10(%ebp)
80103a07:	e8 87 16 00 00       	call   80105093 <memcmp>
80103a0c:	83 c4 10             	add    $0x10,%esp
80103a0f:	85 c0                	test   %eax,%eax
80103a11:	74 07                	je     80103a1a <mpconfig+0x61>
    return 0;
80103a13:	b8 00 00 00 00       	mov    $0x0,%eax
80103a18:	eb 4c                	jmp    80103a66 <mpconfig+0xad>
  if(conf->version != 1 && conf->version != 4)
80103a1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a1d:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103a21:	3c 01                	cmp    $0x1,%al
80103a23:	74 12                	je     80103a37 <mpconfig+0x7e>
80103a25:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a28:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103a2c:	3c 04                	cmp    $0x4,%al
80103a2e:	74 07                	je     80103a37 <mpconfig+0x7e>
    return 0;
80103a30:	b8 00 00 00 00       	mov    $0x0,%eax
80103a35:	eb 2f                	jmp    80103a66 <mpconfig+0xad>
  if(sum((uchar*)conf, conf->length) != 0)
80103a37:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a3a:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103a3e:	0f b7 c0             	movzwl %ax,%eax
80103a41:	83 ec 08             	sub    $0x8,%esp
80103a44:	50                   	push   %eax
80103a45:	ff 75 f0             	pushl  -0x10(%ebp)
80103a48:	e8 00 fe ff ff       	call   8010384d <sum>
80103a4d:	83 c4 10             	add    $0x10,%esp
80103a50:	84 c0                	test   %al,%al
80103a52:	74 07                	je     80103a5b <mpconfig+0xa2>
    return 0;
80103a54:	b8 00 00 00 00       	mov    $0x0,%eax
80103a59:	eb 0b                	jmp    80103a66 <mpconfig+0xad>
  *pmp = mp;
80103a5b:	8b 45 08             	mov    0x8(%ebp),%eax
80103a5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103a61:	89 10                	mov    %edx,(%eax)
  return conf;
80103a63:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103a66:	c9                   	leave  
80103a67:	c3                   	ret    

80103a68 <mpinit>:

void
mpinit(void)
{
80103a68:	f3 0f 1e fb          	endbr32 
80103a6c:	55                   	push   %ebp
80103a6d:	89 e5                	mov    %esp,%ebp
80103a6f:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103a72:	c7 05 44 b6 10 80 20 	movl   $0x8010f920,0x8010b644
80103a79:	f9 10 80 
  if((conf = mpconfig(&mp)) == 0)
80103a7c:	83 ec 0c             	sub    $0xc,%esp
80103a7f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103a82:	50                   	push   %eax
80103a83:	e8 31 ff ff ff       	call   801039b9 <mpconfig>
80103a88:	83 c4 10             	add    $0x10,%esp
80103a8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103a8e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103a92:	0f 84 ba 01 00 00    	je     80103c52 <mpinit+0x1ea>
    return;
  ismp = 1;
80103a98:	c7 05 04 f9 10 80 01 	movl   $0x1,0x8010f904
80103a9f:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103aa2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103aa5:	8b 40 24             	mov    0x24(%eax),%eax
80103aa8:	a3 7c f8 10 80       	mov    %eax,0x8010f87c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103aad:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ab0:	83 c0 2c             	add    $0x2c,%eax
80103ab3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103ab6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ab9:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103abd:	0f b7 d0             	movzwl %ax,%edx
80103ac0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ac3:	01 d0                	add    %edx,%eax
80103ac5:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103ac8:	e9 16 01 00 00       	jmp    80103be3 <mpinit+0x17b>
    switch(*p){
80103acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ad0:	0f b6 00             	movzbl (%eax),%eax
80103ad3:	0f b6 c0             	movzbl %al,%eax
80103ad6:	83 f8 04             	cmp    $0x4,%eax
80103ad9:	0f 8f e0 00 00 00    	jg     80103bbf <mpinit+0x157>
80103adf:	83 f8 03             	cmp    $0x3,%eax
80103ae2:	0f 8d d1 00 00 00    	jge    80103bb9 <mpinit+0x151>
80103ae8:	83 f8 02             	cmp    $0x2,%eax
80103aeb:	0f 84 b0 00 00 00    	je     80103ba1 <mpinit+0x139>
80103af1:	83 f8 02             	cmp    $0x2,%eax
80103af4:	0f 8f c5 00 00 00    	jg     80103bbf <mpinit+0x157>
80103afa:	85 c0                	test   %eax,%eax
80103afc:	74 0e                	je     80103b0c <mpinit+0xa4>
80103afe:	83 f8 01             	cmp    $0x1,%eax
80103b01:	0f 84 b2 00 00 00    	je     80103bb9 <mpinit+0x151>
80103b07:	e9 b3 00 00 00       	jmp    80103bbf <mpinit+0x157>
    case MPPROC:
      proc = (struct mpproc*)p;
80103b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b0f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(ncpu != proc->apicid){
80103b12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103b15:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103b19:	0f b6 d0             	movzbl %al,%edx
80103b1c:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80103b21:	39 c2                	cmp    %eax,%edx
80103b23:	74 2b                	je     80103b50 <mpinit+0xe8>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103b25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103b28:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103b2c:	0f b6 d0             	movzbl %al,%edx
80103b2f:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80103b34:	83 ec 04             	sub    $0x4,%esp
80103b37:	52                   	push   %edx
80103b38:	50                   	push   %eax
80103b39:	68 16 86 10 80       	push   $0x80108616
80103b3e:	e8 9b c8 ff ff       	call   801003de <cprintf>
80103b43:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103b46:	c7 05 04 f9 10 80 00 	movl   $0x0,0x8010f904
80103b4d:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103b50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103b53:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103b57:	0f b6 c0             	movzbl %al,%eax
80103b5a:	83 e0 02             	and    $0x2,%eax
80103b5d:	85 c0                	test   %eax,%eax
80103b5f:	74 15                	je     80103b76 <mpinit+0x10e>
        bcpu = &cpus[ncpu];
80103b61:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80103b66:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103b6c:	05 20 f9 10 80       	add    $0x8010f920,%eax
80103b71:	a3 44 b6 10 80       	mov    %eax,0x8010b644
      cpus[ncpu].id = ncpu;
80103b76:	8b 15 00 ff 10 80    	mov    0x8010ff00,%edx
80103b7c:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80103b81:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103b87:	05 20 f9 10 80       	add    $0x8010f920,%eax
80103b8c:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103b8e:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80103b93:	83 c0 01             	add    $0x1,%eax
80103b96:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
      p += sizeof(struct mpproc);
80103b9b:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103b9f:	eb 42                	jmp    80103be3 <mpinit+0x17b>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103ba1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ba4:	89 45 e8             	mov    %eax,-0x18(%ebp)
      ioapicid = ioapic->apicno;
80103ba7:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103baa:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103bae:	a2 00 f9 10 80       	mov    %al,0x8010f900
      p += sizeof(struct mpioapic);
80103bb3:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103bb7:	eb 2a                	jmp    80103be3 <mpinit+0x17b>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103bb9:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103bbd:	eb 24                	jmp    80103be3 <mpinit+0x17b>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bc2:	0f b6 00             	movzbl (%eax),%eax
80103bc5:	0f b6 c0             	movzbl %al,%eax
80103bc8:	83 ec 08             	sub    $0x8,%esp
80103bcb:	50                   	push   %eax
80103bcc:	68 34 86 10 80       	push   $0x80108634
80103bd1:	e8 08 c8 ff ff       	call   801003de <cprintf>
80103bd6:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103bd9:	c7 05 04 f9 10 80 00 	movl   $0x0,0x8010f904
80103be0:	00 00 00 
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103be3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103be6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103be9:	0f 82 de fe ff ff    	jb     80103acd <mpinit+0x65>
    }
  }
  if(!ismp){
80103bef:	a1 04 f9 10 80       	mov    0x8010f904,%eax
80103bf4:	85 c0                	test   %eax,%eax
80103bf6:	75 1d                	jne    80103c15 <mpinit+0x1ad>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103bf8:	c7 05 00 ff 10 80 01 	movl   $0x1,0x8010ff00
80103bff:	00 00 00 
    lapic = 0;
80103c02:	c7 05 7c f8 10 80 00 	movl   $0x0,0x8010f87c
80103c09:	00 00 00 
    ioapicid = 0;
80103c0c:	c6 05 00 f9 10 80 00 	movb   $0x0,0x8010f900
    return;
80103c13:	eb 3e                	jmp    80103c53 <mpinit+0x1eb>
  }

  if(mp->imcrp){
80103c15:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103c18:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103c1c:	84 c0                	test   %al,%al
80103c1e:	74 33                	je     80103c53 <mpinit+0x1eb>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103c20:	83 ec 08             	sub    $0x8,%esp
80103c23:	6a 70                	push   $0x70
80103c25:	6a 22                	push   $0x22
80103c27:	e8 e4 fb ff ff       	call   80103810 <outb>
80103c2c:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103c2f:	83 ec 0c             	sub    $0xc,%esp
80103c32:	6a 23                	push   $0x23
80103c34:	e8 ba fb ff ff       	call   801037f3 <inb>
80103c39:	83 c4 10             	add    $0x10,%esp
80103c3c:	83 c8 01             	or     $0x1,%eax
80103c3f:	0f b6 c0             	movzbl %al,%eax
80103c42:	83 ec 08             	sub    $0x8,%esp
80103c45:	50                   	push   %eax
80103c46:	6a 23                	push   $0x23
80103c48:	e8 c3 fb ff ff       	call   80103810 <outb>
80103c4d:	83 c4 10             	add    $0x10,%esp
80103c50:	eb 01                	jmp    80103c53 <mpinit+0x1eb>
    return;
80103c52:	90                   	nop
  }
}
80103c53:	c9                   	leave  
80103c54:	c3                   	ret    

80103c55 <outb>:
{
80103c55:	55                   	push   %ebp
80103c56:	89 e5                	mov    %esp,%ebp
80103c58:	83 ec 08             	sub    $0x8,%esp
80103c5b:	8b 45 08             	mov    0x8(%ebp),%eax
80103c5e:	8b 55 0c             	mov    0xc(%ebp),%edx
80103c61:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103c65:	89 d0                	mov    %edx,%eax
80103c67:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103c6a:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103c6e:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103c72:	ee                   	out    %al,(%dx)
}
80103c73:	90                   	nop
80103c74:	c9                   	leave  
80103c75:	c3                   	ret    

80103c76 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103c76:	f3 0f 1e fb          	endbr32 
80103c7a:	55                   	push   %ebp
80103c7b:	89 e5                	mov    %esp,%ebp
80103c7d:	83 ec 04             	sub    $0x4,%esp
80103c80:	8b 45 08             	mov    0x8(%ebp),%eax
80103c83:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103c87:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103c8b:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103c91:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103c95:	0f b6 c0             	movzbl %al,%eax
80103c98:	50                   	push   %eax
80103c99:	6a 21                	push   $0x21
80103c9b:	e8 b5 ff ff ff       	call   80103c55 <outb>
80103ca0:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103ca3:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ca7:	66 c1 e8 08          	shr    $0x8,%ax
80103cab:	0f b6 c0             	movzbl %al,%eax
80103cae:	50                   	push   %eax
80103caf:	68 a1 00 00 00       	push   $0xa1
80103cb4:	e8 9c ff ff ff       	call   80103c55 <outb>
80103cb9:	83 c4 08             	add    $0x8,%esp
}
80103cbc:	90                   	nop
80103cbd:	c9                   	leave  
80103cbe:	c3                   	ret    

80103cbf <picenable>:

void
picenable(int irq)
{
80103cbf:	f3 0f 1e fb          	endbr32 
80103cc3:	55                   	push   %ebp
80103cc4:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103cc6:	8b 45 08             	mov    0x8(%ebp),%eax
80103cc9:	ba 01 00 00 00       	mov    $0x1,%edx
80103cce:	89 c1                	mov    %eax,%ecx
80103cd0:	d3 e2                	shl    %cl,%edx
80103cd2:	89 d0                	mov    %edx,%eax
80103cd4:	f7 d0                	not    %eax
80103cd6:	89 c2                	mov    %eax,%edx
80103cd8:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103cdf:	21 d0                	and    %edx,%eax
80103ce1:	0f b7 c0             	movzwl %ax,%eax
80103ce4:	50                   	push   %eax
80103ce5:	e8 8c ff ff ff       	call   80103c76 <picsetmask>
80103cea:	83 c4 04             	add    $0x4,%esp
}
80103ced:	90                   	nop
80103cee:	c9                   	leave  
80103cef:	c3                   	ret    

80103cf0 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103cf0:	f3 0f 1e fb          	endbr32 
80103cf4:	55                   	push   %ebp
80103cf5:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103cf7:	68 ff 00 00 00       	push   $0xff
80103cfc:	6a 21                	push   $0x21
80103cfe:	e8 52 ff ff ff       	call   80103c55 <outb>
80103d03:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103d06:	68 ff 00 00 00       	push   $0xff
80103d0b:	68 a1 00 00 00       	push   $0xa1
80103d10:	e8 40 ff ff ff       	call   80103c55 <outb>
80103d15:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103d18:	6a 11                	push   $0x11
80103d1a:	6a 20                	push   $0x20
80103d1c:	e8 34 ff ff ff       	call   80103c55 <outb>
80103d21:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103d24:	6a 20                	push   $0x20
80103d26:	6a 21                	push   $0x21
80103d28:	e8 28 ff ff ff       	call   80103c55 <outb>
80103d2d:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103d30:	6a 04                	push   $0x4
80103d32:	6a 21                	push   $0x21
80103d34:	e8 1c ff ff ff       	call   80103c55 <outb>
80103d39:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103d3c:	6a 03                	push   $0x3
80103d3e:	6a 21                	push   $0x21
80103d40:	e8 10 ff ff ff       	call   80103c55 <outb>
80103d45:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103d48:	6a 11                	push   $0x11
80103d4a:	68 a0 00 00 00       	push   $0xa0
80103d4f:	e8 01 ff ff ff       	call   80103c55 <outb>
80103d54:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103d57:	6a 28                	push   $0x28
80103d59:	68 a1 00 00 00       	push   $0xa1
80103d5e:	e8 f2 fe ff ff       	call   80103c55 <outb>
80103d63:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103d66:	6a 02                	push   $0x2
80103d68:	68 a1 00 00 00       	push   $0xa1
80103d6d:	e8 e3 fe ff ff       	call   80103c55 <outb>
80103d72:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103d75:	6a 03                	push   $0x3
80103d77:	68 a1 00 00 00       	push   $0xa1
80103d7c:	e8 d4 fe ff ff       	call   80103c55 <outb>
80103d81:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103d84:	6a 68                	push   $0x68
80103d86:	6a 20                	push   $0x20
80103d88:	e8 c8 fe ff ff       	call   80103c55 <outb>
80103d8d:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103d90:	6a 0a                	push   $0xa
80103d92:	6a 20                	push   $0x20
80103d94:	e8 bc fe ff ff       	call   80103c55 <outb>
80103d99:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103d9c:	6a 68                	push   $0x68
80103d9e:	68 a0 00 00 00       	push   $0xa0
80103da3:	e8 ad fe ff ff       	call   80103c55 <outb>
80103da8:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103dab:	6a 0a                	push   $0xa
80103dad:	68 a0 00 00 00       	push   $0xa0
80103db2:	e8 9e fe ff ff       	call   80103c55 <outb>
80103db7:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103dba:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103dc1:	66 83 f8 ff          	cmp    $0xffff,%ax
80103dc5:	74 13                	je     80103dda <picinit+0xea>
    picsetmask(irqmask);
80103dc7:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103dce:	0f b7 c0             	movzwl %ax,%eax
80103dd1:	50                   	push   %eax
80103dd2:	e8 9f fe ff ff       	call   80103c76 <picsetmask>
80103dd7:	83 c4 04             	add    $0x4,%esp
}
80103dda:	90                   	nop
80103ddb:	c9                   	leave  
80103ddc:	c3                   	ret    

80103ddd <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103ddd:	f3 0f 1e fb          	endbr32 
80103de1:	55                   	push   %ebp
80103de2:	89 e5                	mov    %esp,%ebp
80103de4:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103de7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103dee:	8b 45 0c             	mov    0xc(%ebp),%eax
80103df1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103df7:	8b 45 0c             	mov    0xc(%ebp),%eax
80103dfa:	8b 10                	mov    (%eax),%edx
80103dfc:	8b 45 08             	mov    0x8(%ebp),%eax
80103dff:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103e01:	e8 c5 d1 ff ff       	call   80100fcb <filealloc>
80103e06:	8b 55 08             	mov    0x8(%ebp),%edx
80103e09:	89 02                	mov    %eax,(%edx)
80103e0b:	8b 45 08             	mov    0x8(%ebp),%eax
80103e0e:	8b 00                	mov    (%eax),%eax
80103e10:	85 c0                	test   %eax,%eax
80103e12:	0f 84 c8 00 00 00    	je     80103ee0 <pipealloc+0x103>
80103e18:	e8 ae d1 ff ff       	call   80100fcb <filealloc>
80103e1d:	8b 55 0c             	mov    0xc(%ebp),%edx
80103e20:	89 02                	mov    %eax,(%edx)
80103e22:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e25:	8b 00                	mov    (%eax),%eax
80103e27:	85 c0                	test   %eax,%eax
80103e29:	0f 84 b1 00 00 00    	je     80103ee0 <pipealloc+0x103>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103e2f:	e8 8a ee ff ff       	call   80102cbe <kalloc>
80103e34:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103e37:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103e3b:	0f 84 a2 00 00 00    	je     80103ee3 <pipealloc+0x106>
    goto bad;
  p->readopen = 1;
80103e41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e44:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103e4b:	00 00 00 
  p->writeopen = 1;
80103e4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e51:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103e58:	00 00 00 
  p->nwrite = 0;
80103e5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e5e:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103e65:	00 00 00 
  p->nread = 0;
80103e68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e6b:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103e72:	00 00 00 
  initlock(&p->lock, "pipe");
80103e75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e78:	83 ec 08             	sub    $0x8,%esp
80103e7b:	68 54 86 10 80       	push   $0x80108654
80103e80:	50                   	push   %eax
80103e81:	e8 00 0f 00 00       	call   80104d86 <initlock>
80103e86:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103e89:	8b 45 08             	mov    0x8(%ebp),%eax
80103e8c:	8b 00                	mov    (%eax),%eax
80103e8e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103e94:	8b 45 08             	mov    0x8(%ebp),%eax
80103e97:	8b 00                	mov    (%eax),%eax
80103e99:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103e9d:	8b 45 08             	mov    0x8(%ebp),%eax
80103ea0:	8b 00                	mov    (%eax),%eax
80103ea2:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103ea6:	8b 45 08             	mov    0x8(%ebp),%eax
80103ea9:	8b 00                	mov    (%eax),%eax
80103eab:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103eae:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103eb1:	8b 45 0c             	mov    0xc(%ebp),%eax
80103eb4:	8b 00                	mov    (%eax),%eax
80103eb6:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103ebc:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ebf:	8b 00                	mov    (%eax),%eax
80103ec1:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ec8:	8b 00                	mov    (%eax),%eax
80103eca:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103ece:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ed1:	8b 00                	mov    (%eax),%eax
80103ed3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103ed6:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103ed9:	b8 00 00 00 00       	mov    $0x0,%eax
80103ede:	eb 51                	jmp    80103f31 <pipealloc+0x154>
    goto bad;
80103ee0:	90                   	nop
80103ee1:	eb 01                	jmp    80103ee4 <pipealloc+0x107>
    goto bad;
80103ee3:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
80103ee4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103ee8:	74 0e                	je     80103ef8 <pipealloc+0x11b>
    kfree((char*)p);
80103eea:	83 ec 0c             	sub    $0xc,%esp
80103eed:	ff 75 f4             	pushl  -0xc(%ebp)
80103ef0:	e8 28 ed ff ff       	call   80102c1d <kfree>
80103ef5:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80103ef8:	8b 45 08             	mov    0x8(%ebp),%eax
80103efb:	8b 00                	mov    (%eax),%eax
80103efd:	85 c0                	test   %eax,%eax
80103eff:	74 11                	je     80103f12 <pipealloc+0x135>
    fileclose(*f0);
80103f01:	8b 45 08             	mov    0x8(%ebp),%eax
80103f04:	8b 00                	mov    (%eax),%eax
80103f06:	83 ec 0c             	sub    $0xc,%esp
80103f09:	50                   	push   %eax
80103f0a:	e8 82 d1 ff ff       	call   80101091 <fileclose>
80103f0f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103f12:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f15:	8b 00                	mov    (%eax),%eax
80103f17:	85 c0                	test   %eax,%eax
80103f19:	74 11                	je     80103f2c <pipealloc+0x14f>
    fileclose(*f1);
80103f1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f1e:	8b 00                	mov    (%eax),%eax
80103f20:	83 ec 0c             	sub    $0xc,%esp
80103f23:	50                   	push   %eax
80103f24:	e8 68 d1 ff ff       	call   80101091 <fileclose>
80103f29:	83 c4 10             	add    $0x10,%esp
  return -1;
80103f2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103f31:	c9                   	leave  
80103f32:	c3                   	ret    

80103f33 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103f33:	f3 0f 1e fb          	endbr32 
80103f37:	55                   	push   %ebp
80103f38:	89 e5                	mov    %esp,%ebp
80103f3a:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
80103f3d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f40:	83 ec 0c             	sub    $0xc,%esp
80103f43:	50                   	push   %eax
80103f44:	e8 63 0e 00 00       	call   80104dac <acquire>
80103f49:	83 c4 10             	add    $0x10,%esp
  if(writable){
80103f4c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80103f50:	74 23                	je     80103f75 <pipeclose+0x42>
    p->writeopen = 0;
80103f52:	8b 45 08             	mov    0x8(%ebp),%eax
80103f55:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80103f5c:	00 00 00 
    wakeup(&p->nread);
80103f5f:	8b 45 08             	mov    0x8(%ebp),%eax
80103f62:	05 34 02 00 00       	add    $0x234,%eax
80103f67:	83 ec 0c             	sub    $0xc,%esp
80103f6a:	50                   	push   %eax
80103f6b:	e8 1d 0c 00 00       	call   80104b8d <wakeup>
80103f70:	83 c4 10             	add    $0x10,%esp
80103f73:	eb 21                	jmp    80103f96 <pipeclose+0x63>
  } else {
    p->readopen = 0;
80103f75:	8b 45 08             	mov    0x8(%ebp),%eax
80103f78:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80103f7f:	00 00 00 
    wakeup(&p->nwrite);
80103f82:	8b 45 08             	mov    0x8(%ebp),%eax
80103f85:	05 38 02 00 00       	add    $0x238,%eax
80103f8a:	83 ec 0c             	sub    $0xc,%esp
80103f8d:	50                   	push   %eax
80103f8e:	e8 fa 0b 00 00       	call   80104b8d <wakeup>
80103f93:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103f96:	8b 45 08             	mov    0x8(%ebp),%eax
80103f99:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103f9f:	85 c0                	test   %eax,%eax
80103fa1:	75 2c                	jne    80103fcf <pipeclose+0x9c>
80103fa3:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa6:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103fac:	85 c0                	test   %eax,%eax
80103fae:	75 1f                	jne    80103fcf <pipeclose+0x9c>
    release(&p->lock);
80103fb0:	8b 45 08             	mov    0x8(%ebp),%eax
80103fb3:	83 ec 0c             	sub    $0xc,%esp
80103fb6:	50                   	push   %eax
80103fb7:	e8 5b 0e 00 00       	call   80104e17 <release>
80103fbc:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80103fbf:	83 ec 0c             	sub    $0xc,%esp
80103fc2:	ff 75 08             	pushl  0x8(%ebp)
80103fc5:	e8 53 ec ff ff       	call   80102c1d <kfree>
80103fca:	83 c4 10             	add    $0x10,%esp
80103fcd:	eb 10                	jmp    80103fdf <pipeclose+0xac>
  } else
    release(&p->lock);
80103fcf:	8b 45 08             	mov    0x8(%ebp),%eax
80103fd2:	83 ec 0c             	sub    $0xc,%esp
80103fd5:	50                   	push   %eax
80103fd6:	e8 3c 0e 00 00       	call   80104e17 <release>
80103fdb:	83 c4 10             	add    $0x10,%esp
}
80103fde:	90                   	nop
80103fdf:	90                   	nop
80103fe0:	c9                   	leave  
80103fe1:	c3                   	ret    

80103fe2 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103fe2:	f3 0f 1e fb          	endbr32 
80103fe6:	55                   	push   %ebp
80103fe7:	89 e5                	mov    %esp,%ebp
80103fe9:	53                   	push   %ebx
80103fea:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80103fed:	8b 45 08             	mov    0x8(%ebp),%eax
80103ff0:	83 ec 0c             	sub    $0xc,%esp
80103ff3:	50                   	push   %eax
80103ff4:	e8 b3 0d 00 00       	call   80104dac <acquire>
80103ff9:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80103ffc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104003:	e9 ae 00 00 00       	jmp    801040b6 <pipewrite+0xd4>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
80104008:	8b 45 08             	mov    0x8(%ebp),%eax
8010400b:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104011:	85 c0                	test   %eax,%eax
80104013:	74 0d                	je     80104022 <pipewrite+0x40>
80104015:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010401b:	8b 40 24             	mov    0x24(%eax),%eax
8010401e:	85 c0                	test   %eax,%eax
80104020:	74 19                	je     8010403b <pipewrite+0x59>
        release(&p->lock);
80104022:	8b 45 08             	mov    0x8(%ebp),%eax
80104025:	83 ec 0c             	sub    $0xc,%esp
80104028:	50                   	push   %eax
80104029:	e8 e9 0d 00 00       	call   80104e17 <release>
8010402e:	83 c4 10             	add    $0x10,%esp
        return -1;
80104031:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104036:	e9 a9 00 00 00       	jmp    801040e4 <pipewrite+0x102>
      }
      wakeup(&p->nread);
8010403b:	8b 45 08             	mov    0x8(%ebp),%eax
8010403e:	05 34 02 00 00       	add    $0x234,%eax
80104043:	83 ec 0c             	sub    $0xc,%esp
80104046:	50                   	push   %eax
80104047:	e8 41 0b 00 00       	call   80104b8d <wakeup>
8010404c:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010404f:	8b 45 08             	mov    0x8(%ebp),%eax
80104052:	8b 55 08             	mov    0x8(%ebp),%edx
80104055:	81 c2 38 02 00 00    	add    $0x238,%edx
8010405b:	83 ec 08             	sub    $0x8,%esp
8010405e:	50                   	push   %eax
8010405f:	52                   	push   %edx
80104060:	e8 34 0a 00 00       	call   80104a99 <sleep>
80104065:	83 c4 10             	add    $0x10,%esp
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104068:	8b 45 08             	mov    0x8(%ebp),%eax
8010406b:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104071:	8b 45 08             	mov    0x8(%ebp),%eax
80104074:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010407a:	05 00 02 00 00       	add    $0x200,%eax
8010407f:	39 c2                	cmp    %eax,%edx
80104081:	74 85                	je     80104008 <pipewrite+0x26>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104083:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104086:	8b 45 0c             	mov    0xc(%ebp),%eax
80104089:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010408c:	8b 45 08             	mov    0x8(%ebp),%eax
8010408f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104095:	8d 48 01             	lea    0x1(%eax),%ecx
80104098:	8b 55 08             	mov    0x8(%ebp),%edx
8010409b:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
801040a1:	25 ff 01 00 00       	and    $0x1ff,%eax
801040a6:	89 c1                	mov    %eax,%ecx
801040a8:	0f b6 13             	movzbl (%ebx),%edx
801040ab:	8b 45 08             	mov    0x8(%ebp),%eax
801040ae:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
  for(i = 0; i < n; i++){
801040b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801040b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040b9:	3b 45 10             	cmp    0x10(%ebp),%eax
801040bc:	7c aa                	jl     80104068 <pipewrite+0x86>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801040be:	8b 45 08             	mov    0x8(%ebp),%eax
801040c1:	05 34 02 00 00       	add    $0x234,%eax
801040c6:	83 ec 0c             	sub    $0xc,%esp
801040c9:	50                   	push   %eax
801040ca:	e8 be 0a 00 00       	call   80104b8d <wakeup>
801040cf:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801040d2:	8b 45 08             	mov    0x8(%ebp),%eax
801040d5:	83 ec 0c             	sub    $0xc,%esp
801040d8:	50                   	push   %eax
801040d9:	e8 39 0d 00 00       	call   80104e17 <release>
801040de:	83 c4 10             	add    $0x10,%esp
  return n;
801040e1:	8b 45 10             	mov    0x10(%ebp),%eax
}
801040e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040e7:	c9                   	leave  
801040e8:	c3                   	ret    

801040e9 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801040e9:	f3 0f 1e fb          	endbr32 
801040ed:	55                   	push   %ebp
801040ee:	89 e5                	mov    %esp,%ebp
801040f0:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801040f3:	8b 45 08             	mov    0x8(%ebp),%eax
801040f6:	83 ec 0c             	sub    $0xc,%esp
801040f9:	50                   	push   %eax
801040fa:	e8 ad 0c 00 00       	call   80104dac <acquire>
801040ff:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104102:	eb 3f                	jmp    80104143 <piperead+0x5a>
    if(proc->killed){
80104104:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010410a:	8b 40 24             	mov    0x24(%eax),%eax
8010410d:	85 c0                	test   %eax,%eax
8010410f:	74 19                	je     8010412a <piperead+0x41>
      release(&p->lock);
80104111:	8b 45 08             	mov    0x8(%ebp),%eax
80104114:	83 ec 0c             	sub    $0xc,%esp
80104117:	50                   	push   %eax
80104118:	e8 fa 0c 00 00       	call   80104e17 <release>
8010411d:	83 c4 10             	add    $0x10,%esp
      return -1;
80104120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104125:	e9 be 00 00 00       	jmp    801041e8 <piperead+0xff>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010412a:	8b 45 08             	mov    0x8(%ebp),%eax
8010412d:	8b 55 08             	mov    0x8(%ebp),%edx
80104130:	81 c2 34 02 00 00    	add    $0x234,%edx
80104136:	83 ec 08             	sub    $0x8,%esp
80104139:	50                   	push   %eax
8010413a:	52                   	push   %edx
8010413b:	e8 59 09 00 00       	call   80104a99 <sleep>
80104140:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104143:	8b 45 08             	mov    0x8(%ebp),%eax
80104146:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010414c:	8b 45 08             	mov    0x8(%ebp),%eax
8010414f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104155:	39 c2                	cmp    %eax,%edx
80104157:	75 0d                	jne    80104166 <piperead+0x7d>
80104159:	8b 45 08             	mov    0x8(%ebp),%eax
8010415c:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104162:	85 c0                	test   %eax,%eax
80104164:	75 9e                	jne    80104104 <piperead+0x1b>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104166:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010416d:	eb 48                	jmp    801041b7 <piperead+0xce>
    if(p->nread == p->nwrite)
8010416f:	8b 45 08             	mov    0x8(%ebp),%eax
80104172:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104178:	8b 45 08             	mov    0x8(%ebp),%eax
8010417b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104181:	39 c2                	cmp    %eax,%edx
80104183:	74 3c                	je     801041c1 <piperead+0xd8>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104185:	8b 45 08             	mov    0x8(%ebp),%eax
80104188:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010418e:	8d 48 01             	lea    0x1(%eax),%ecx
80104191:	8b 55 08             	mov    0x8(%ebp),%edx
80104194:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
8010419a:	25 ff 01 00 00       	and    $0x1ff,%eax
8010419f:	89 c1                	mov    %eax,%ecx
801041a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041a4:	8b 45 0c             	mov    0xc(%ebp),%eax
801041a7:	01 c2                	add    %eax,%edx
801041a9:	8b 45 08             	mov    0x8(%ebp),%eax
801041ac:	0f b6 44 08 34       	movzbl 0x34(%eax,%ecx,1),%eax
801041b1:	88 02                	mov    %al,(%edx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801041b3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801041b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041ba:	3b 45 10             	cmp    0x10(%ebp),%eax
801041bd:	7c b0                	jl     8010416f <piperead+0x86>
801041bf:	eb 01                	jmp    801041c2 <piperead+0xd9>
      break;
801041c1:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801041c2:	8b 45 08             	mov    0x8(%ebp),%eax
801041c5:	05 38 02 00 00       	add    $0x238,%eax
801041ca:	83 ec 0c             	sub    $0xc,%esp
801041cd:	50                   	push   %eax
801041ce:	e8 ba 09 00 00       	call   80104b8d <wakeup>
801041d3:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801041d6:	8b 45 08             	mov    0x8(%ebp),%eax
801041d9:	83 ec 0c             	sub    $0xc,%esp
801041dc:	50                   	push   %eax
801041dd:	e8 35 0c 00 00       	call   80104e17 <release>
801041e2:	83 c4 10             	add    $0x10,%esp
  return i;
801041e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801041e8:	c9                   	leave  
801041e9:	c3                   	ret    

801041ea <readeflags>:
{
801041ea:	55                   	push   %ebp
801041eb:	89 e5                	mov    %esp,%ebp
801041ed:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801041f0:	9c                   	pushf  
801041f1:	58                   	pop    %eax
801041f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801041f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801041f8:	c9                   	leave  
801041f9:	c3                   	ret    

801041fa <sti>:
{
801041fa:	55                   	push   %ebp
801041fb:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801041fd:	fb                   	sti    
}
801041fe:	90                   	nop
801041ff:	5d                   	pop    %ebp
80104200:	c3                   	ret    

80104201 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104201:	f3 0f 1e fb          	endbr32 
80104205:	55                   	push   %ebp
80104206:	89 e5                	mov    %esp,%ebp
80104208:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
8010420b:	83 ec 08             	sub    $0x8,%esp
8010420e:	68 59 86 10 80       	push   $0x80108659
80104213:	68 20 ff 10 80       	push   $0x8010ff20
80104218:	e8 69 0b 00 00       	call   80104d86 <initlock>
8010421d:	83 c4 10             	add    $0x10,%esp
}
80104220:	90                   	nop
80104221:	c9                   	leave  
80104222:	c3                   	ret    

80104223 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104223:	f3 0f 1e fb          	endbr32 
80104227:	55                   	push   %ebp
80104228:	89 e5                	mov    %esp,%ebp
8010422a:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010422d:	83 ec 0c             	sub    $0xc,%esp
80104230:	68 20 ff 10 80       	push   $0x8010ff20
80104235:	e8 72 0b 00 00       	call   80104dac <acquire>
8010423a:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010423d:	c7 45 f4 54 ff 10 80 	movl   $0x8010ff54,-0xc(%ebp)
80104244:	eb 0e                	jmp    80104254 <allocproc+0x31>
    if(p->state == UNUSED)
80104246:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104249:	8b 40 0c             	mov    0xc(%eax),%eax
8010424c:	85 c0                	test   %eax,%eax
8010424e:	74 27                	je     80104277 <allocproc+0x54>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104250:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104254:	81 7d f4 54 1e 11 80 	cmpl   $0x80111e54,-0xc(%ebp)
8010425b:	72 e9                	jb     80104246 <allocproc+0x23>
      goto found;
  release(&ptable.lock);
8010425d:	83 ec 0c             	sub    $0xc,%esp
80104260:	68 20 ff 10 80       	push   $0x8010ff20
80104265:	e8 ad 0b 00 00       	call   80104e17 <release>
8010426a:	83 c4 10             	add    $0x10,%esp
  return 0;
8010426d:	b8 00 00 00 00       	mov    $0x0,%eax
80104272:	e9 b6 00 00 00       	jmp    8010432d <allocproc+0x10a>
      goto found;
80104277:	90                   	nop
80104278:	f3 0f 1e fb          	endbr32 

found:
  p->state = EMBRYO;
8010427c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010427f:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
80104286:	a1 04 b0 10 80       	mov    0x8010b004,%eax
8010428b:	8d 50 01             	lea    0x1(%eax),%edx
8010428e:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80104294:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104297:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
8010429a:	83 ec 0c             	sub    $0xc,%esp
8010429d:	68 20 ff 10 80       	push   $0x8010ff20
801042a2:	e8 70 0b 00 00       	call   80104e17 <release>
801042a7:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801042aa:	e8 0f ea ff ff       	call   80102cbe <kalloc>
801042af:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042b2:	89 42 08             	mov    %eax,0x8(%edx)
801042b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042b8:	8b 40 08             	mov    0x8(%eax),%eax
801042bb:	85 c0                	test   %eax,%eax
801042bd:	75 11                	jne    801042d0 <allocproc+0xad>
    p->state = UNUSED;
801042bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042c2:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
801042c9:	b8 00 00 00 00       	mov    $0x0,%eax
801042ce:	eb 5d                	jmp    8010432d <allocproc+0x10a>
  }
  sp = p->kstack + KSTACKSIZE;
801042d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042d3:	8b 40 08             	mov    0x8(%eax),%eax
801042d6:	05 00 10 00 00       	add    $0x1000,%eax
801042db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801042de:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801042e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042e5:	8b 55 f0             	mov    -0x10(%ebp),%edx
801042e8:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801042eb:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801042ef:	ba 74 64 10 80       	mov    $0x80106474,%edx
801042f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801042f7:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801042f9:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801042fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104300:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104303:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104306:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104309:	8b 40 1c             	mov    0x1c(%eax),%eax
8010430c:	83 ec 04             	sub    $0x4,%esp
8010430f:	6a 14                	push   $0x14
80104311:	6a 00                	push   $0x0
80104313:	50                   	push   %eax
80104314:	e8 0f 0d 00 00       	call   80105028 <memset>
80104319:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010431c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010431f:	8b 40 1c             	mov    0x1c(%eax),%eax
80104322:	ba 64 4a 10 80       	mov    $0x80104a64,%edx
80104327:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
8010432a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010432d:	c9                   	leave  
8010432e:	c3                   	ret    

8010432f <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
8010432f:	f3 0f 1e fb          	endbr32 
80104333:	55                   	push   %ebp
80104334:	89 e5                	mov    %esp,%ebp
80104336:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
80104339:	e8 e5 fe ff ff       	call   80104223 <allocproc>
8010433e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
80104341:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104344:	a3 48 b6 10 80       	mov    %eax,0x8010b648
  if((p->pgdir = setupkvm()) == 0)
80104349:	e8 17 38 00 00       	call   80107b65 <setupkvm>
8010434e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104351:	89 42 04             	mov    %eax,0x4(%edx)
80104354:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104357:	8b 40 04             	mov    0x4(%eax),%eax
8010435a:	85 c0                	test   %eax,%eax
8010435c:	75 0d                	jne    8010436b <userinit+0x3c>
    panic("userinit: out of memory?");
8010435e:	83 ec 0c             	sub    $0xc,%esp
80104361:	68 60 86 10 80       	push   $0x80108660
80104366:	e8 2c c2 ff ff       	call   80100597 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
8010436b:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104370:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104373:	8b 40 04             	mov    0x4(%eax),%eax
80104376:	83 ec 04             	sub    $0x4,%esp
80104379:	52                   	push   %edx
8010437a:	68 e0 b4 10 80       	push   $0x8010b4e0
8010437f:	50                   	push   %eax
80104380:	e8 4b 3a 00 00       	call   80107dd0 <inituvm>
80104385:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80104388:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010438b:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104391:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104394:	8b 40 18             	mov    0x18(%eax),%eax
80104397:	83 ec 04             	sub    $0x4,%esp
8010439a:	6a 4c                	push   $0x4c
8010439c:	6a 00                	push   $0x0
8010439e:	50                   	push   %eax
8010439f:	e8 84 0c 00 00       	call   80105028 <memset>
801043a4:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801043a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043aa:	8b 40 18             	mov    0x18(%eax),%eax
801043ad:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801043b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043b6:	8b 40 18             	mov    0x18(%eax),%eax
801043b9:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801043bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043c2:	8b 50 18             	mov    0x18(%eax),%edx
801043c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043c8:	8b 40 18             	mov    0x18(%eax),%eax
801043cb:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801043cf:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801043d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043d6:	8b 50 18             	mov    0x18(%eax),%edx
801043d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043dc:	8b 40 18             	mov    0x18(%eax),%eax
801043df:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801043e3:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801043e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043ea:	8b 40 18             	mov    0x18(%eax),%eax
801043ed:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801043f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043f7:	8b 40 18             	mov    0x18(%eax),%eax
801043fa:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104401:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104404:	8b 40 18             	mov    0x18(%eax),%eax
80104407:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010440e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104411:	83 c0 6c             	add    $0x6c,%eax
80104414:	83 ec 04             	sub    $0x4,%esp
80104417:	6a 10                	push   $0x10
80104419:	68 79 86 10 80       	push   $0x80108679
8010441e:	50                   	push   %eax
8010441f:	e8 1f 0e 00 00       	call   80105243 <safestrcpy>
80104424:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
80104427:	83 ec 0c             	sub    $0xc,%esp
8010442a:	68 82 86 10 80       	push   $0x80108682
8010442f:	e8 49 e1 ff ff       	call   8010257d <namei>
80104434:	83 c4 10             	add    $0x10,%esp
80104437:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010443a:	89 42 68             	mov    %eax,0x68(%edx)

  p->state = RUNNABLE;
8010443d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104440:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
80104447:	90                   	nop
80104448:	c9                   	leave  
80104449:	c3                   	ret    

8010444a <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
8010444a:	f3 0f 1e fb          	endbr32 
8010444e:	55                   	push   %ebp
8010444f:	89 e5                	mov    %esp,%ebp
80104451:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
80104454:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010445a:	8b 00                	mov    (%eax),%eax
8010445c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
8010445f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104463:	7e 31                	jle    80104496 <growproc+0x4c>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104465:	8b 55 08             	mov    0x8(%ebp),%edx
80104468:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010446b:	01 c2                	add    %eax,%edx
8010446d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104473:	8b 40 04             	mov    0x4(%eax),%eax
80104476:	83 ec 04             	sub    $0x4,%esp
80104479:	52                   	push   %edx
8010447a:	ff 75 f4             	pushl  -0xc(%ebp)
8010447d:	50                   	push   %eax
8010447e:	e8 a2 3a 00 00       	call   80107f25 <allocuvm>
80104483:	83 c4 10             	add    $0x10,%esp
80104486:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104489:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010448d:	75 3e                	jne    801044cd <growproc+0x83>
      return -1;
8010448f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104494:	eb 59                	jmp    801044ef <growproc+0xa5>
  } else if(n < 0){
80104496:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010449a:	79 31                	jns    801044cd <growproc+0x83>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
8010449c:	8b 55 08             	mov    0x8(%ebp),%edx
8010449f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a2:	01 c2                	add    %eax,%edx
801044a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044aa:	8b 40 04             	mov    0x4(%eax),%eax
801044ad:	83 ec 04             	sub    $0x4,%esp
801044b0:	52                   	push   %edx
801044b1:	ff 75 f4             	pushl  -0xc(%ebp)
801044b4:	50                   	push   %eax
801044b5:	e8 36 3b 00 00       	call   80107ff0 <deallocuvm>
801044ba:	83 c4 10             	add    $0x10,%esp
801044bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801044c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801044c4:	75 07                	jne    801044cd <growproc+0x83>
      return -1;
801044c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044cb:	eb 22                	jmp    801044ef <growproc+0xa5>
  }
  proc->sz = sz;
801044cd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044d6:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801044d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044de:	83 ec 0c             	sub    $0xc,%esp
801044e1:	50                   	push   %eax
801044e2:	e8 71 37 00 00       	call   80107c58 <switchuvm>
801044e7:	83 c4 10             	add    $0x10,%esp
  return 0;
801044ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
801044ef:	c9                   	leave  
801044f0:	c3                   	ret    

801044f1 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801044f1:	f3 0f 1e fb          	endbr32 
801044f5:	55                   	push   %ebp
801044f6:	89 e5                	mov    %esp,%ebp
801044f8:	57                   	push   %edi
801044f9:	56                   	push   %esi
801044fa:	53                   	push   %ebx
801044fb:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
801044fe:	e8 20 fd ff ff       	call   80104223 <allocproc>
80104503:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104506:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010450a:	75 0a                	jne    80104516 <fork+0x25>
    return -1;
8010450c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104511:	e9 44 01 00 00       	jmp    8010465a <fork+0x169>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104516:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010451c:	8b 10                	mov    (%eax),%edx
8010451e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104524:	8b 40 04             	mov    0x4(%eax),%eax
80104527:	83 ec 08             	sub    $0x8,%esp
8010452a:	52                   	push   %edx
8010452b:	50                   	push   %eax
8010452c:	e8 69 3c 00 00       	call   8010819a <copyuvm>
80104531:	83 c4 10             	add    $0x10,%esp
80104534:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104537:	89 42 04             	mov    %eax,0x4(%edx)
8010453a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010453d:	8b 40 04             	mov    0x4(%eax),%eax
80104540:	85 c0                	test   %eax,%eax
80104542:	75 30                	jne    80104574 <fork+0x83>
    kfree(np->kstack);
80104544:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104547:	8b 40 08             	mov    0x8(%eax),%eax
8010454a:	83 ec 0c             	sub    $0xc,%esp
8010454d:	50                   	push   %eax
8010454e:	e8 ca e6 ff ff       	call   80102c1d <kfree>
80104553:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80104556:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104559:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104560:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104563:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
8010456a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010456f:	e9 e6 00 00 00       	jmp    8010465a <fork+0x169>
  }
  np->sz = proc->sz;
80104574:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010457a:	8b 10                	mov    (%eax),%edx
8010457c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010457f:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104581:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104588:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010458b:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
8010458e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104594:	8b 48 18             	mov    0x18(%eax),%ecx
80104597:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010459a:	8b 40 18             	mov    0x18(%eax),%eax
8010459d:	89 c2                	mov    %eax,%edx
8010459f:	89 cb                	mov    %ecx,%ebx
801045a1:	b8 13 00 00 00       	mov    $0x13,%eax
801045a6:	89 d7                	mov    %edx,%edi
801045a8:	89 de                	mov    %ebx,%esi
801045aa:	89 c1                	mov    %eax,%ecx
801045ac:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801045ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801045b1:	8b 40 18             	mov    0x18(%eax),%eax
801045b4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
801045bb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801045c2:	eb 41                	jmp    80104605 <fork+0x114>
    if(proc->ofile[i])
801045c4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801045cd:	83 c2 08             	add    $0x8,%edx
801045d0:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801045d4:	85 c0                	test   %eax,%eax
801045d6:	74 29                	je     80104601 <fork+0x110>
      np->ofile[i] = filedup(proc->ofile[i]);
801045d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045de:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801045e1:	83 c2 08             	add    $0x8,%edx
801045e4:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801045e8:	83 ec 0c             	sub    $0xc,%esp
801045eb:	50                   	push   %eax
801045ec:	e8 4b ca ff ff       	call   8010103c <filedup>
801045f1:	83 c4 10             	add    $0x10,%esp
801045f4:	8b 55 e0             	mov    -0x20(%ebp),%edx
801045f7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801045fa:	83 c1 08             	add    $0x8,%ecx
801045fd:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  for(i = 0; i < NOFILE; i++)
80104601:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104605:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104609:	7e b9                	jle    801045c4 <fork+0xd3>
  np->cwd = idup(proc->cwd);
8010460b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104611:	8b 40 68             	mov    0x68(%eax),%eax
80104614:	83 ec 0c             	sub    $0xc,%esp
80104617:	50                   	push   %eax
80104618:	e8 3f d3 ff ff       	call   8010195c <idup>
8010461d:	83 c4 10             	add    $0x10,%esp
80104620:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104623:	89 42 68             	mov    %eax,0x68(%edx)
 
  pid = np->pid;
80104626:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104629:	8b 40 10             	mov    0x10(%eax),%eax
8010462c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  np->state = RUNNABLE;
8010462f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104632:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104639:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010463f:	8d 50 6c             	lea    0x6c(%eax),%edx
80104642:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104645:	83 c0 6c             	add    $0x6c,%eax
80104648:	83 ec 04             	sub    $0x4,%esp
8010464b:	6a 10                	push   $0x10
8010464d:	52                   	push   %edx
8010464e:	50                   	push   %eax
8010464f:	e8 ef 0b 00 00       	call   80105243 <safestrcpy>
80104654:	83 c4 10             	add    $0x10,%esp
  return pid;
80104657:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
8010465a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010465d:	5b                   	pop    %ebx
8010465e:	5e                   	pop    %esi
8010465f:	5f                   	pop    %edi
80104660:	5d                   	pop    %ebp
80104661:	c3                   	ret    

80104662 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104662:	f3 0f 1e fb          	endbr32 
80104666:	55                   	push   %ebp
80104667:	89 e5                	mov    %esp,%ebp
80104669:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
8010466c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104673:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80104678:	39 c2                	cmp    %eax,%edx
8010467a:	75 0d                	jne    80104689 <exit+0x27>
    panic("init exiting");
8010467c:	83 ec 0c             	sub    $0xc,%esp
8010467f:	68 84 86 10 80       	push   $0x80108684
80104684:	e8 0e bf ff ff       	call   80100597 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104689:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104690:	eb 48                	jmp    801046da <exit+0x78>
    if(proc->ofile[fd]){
80104692:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104698:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010469b:	83 c2 08             	add    $0x8,%edx
8010469e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046a2:	85 c0                	test   %eax,%eax
801046a4:	74 30                	je     801046d6 <exit+0x74>
      fileclose(proc->ofile[fd]);
801046a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046ac:	8b 55 f0             	mov    -0x10(%ebp),%edx
801046af:	83 c2 08             	add    $0x8,%edx
801046b2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801046b6:	83 ec 0c             	sub    $0xc,%esp
801046b9:	50                   	push   %eax
801046ba:	e8 d2 c9 ff ff       	call   80101091 <fileclose>
801046bf:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
801046c2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801046cb:	83 c2 08             	add    $0x8,%edx
801046ce:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801046d5:	00 
  for(fd = 0; fd < NOFILE; fd++){
801046d6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801046da:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
801046de:	7e b2                	jle    80104692 <exit+0x30>
    }
  }

  iput(proc->cwd);
801046e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046e6:	8b 40 68             	mov    0x68(%eax),%eax
801046e9:	83 ec 0c             	sub    $0xc,%esp
801046ec:	50                   	push   %eax
801046ed:	e8 7a d4 ff ff       	call   80101b6c <iput>
801046f2:	83 c4 10             	add    $0x10,%esp
  proc->cwd = 0;
801046f5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046fb:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104702:	83 ec 0c             	sub    $0xc,%esp
80104705:	68 20 ff 10 80       	push   $0x8010ff20
8010470a:	e8 9d 06 00 00       	call   80104dac <acquire>
8010470f:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104712:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104718:	8b 40 14             	mov    0x14(%eax),%eax
8010471b:	83 ec 0c             	sub    $0xc,%esp
8010471e:	50                   	push   %eax
8010471f:	e8 25 04 00 00       	call   80104b49 <wakeup1>
80104724:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104727:	c7 45 f4 54 ff 10 80 	movl   $0x8010ff54,-0xc(%ebp)
8010472e:	eb 3c                	jmp    8010476c <exit+0x10a>
    if(p->parent == proc){
80104730:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104733:	8b 50 14             	mov    0x14(%eax),%edx
80104736:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010473c:	39 c2                	cmp    %eax,%edx
8010473e:	75 28                	jne    80104768 <exit+0x106>
      p->parent = initproc;
80104740:	8b 15 48 b6 10 80    	mov    0x8010b648,%edx
80104746:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104749:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
8010474c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010474f:	8b 40 0c             	mov    0xc(%eax),%eax
80104752:	83 f8 05             	cmp    $0x5,%eax
80104755:	75 11                	jne    80104768 <exit+0x106>
        wakeup1(initproc);
80104757:	a1 48 b6 10 80       	mov    0x8010b648,%eax
8010475c:	83 ec 0c             	sub    $0xc,%esp
8010475f:	50                   	push   %eax
80104760:	e8 e4 03 00 00       	call   80104b49 <wakeup1>
80104765:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104768:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
8010476c:	81 7d f4 54 1e 11 80 	cmpl   $0x80111e54,-0xc(%ebp)
80104773:	72 bb                	jb     80104730 <exit+0xce>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104775:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010477b:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104782:	e8 de 01 00 00       	call   80104965 <sched>
  panic("zombie exit");
80104787:	83 ec 0c             	sub    $0xc,%esp
8010478a:	68 91 86 10 80       	push   $0x80108691
8010478f:	e8 03 be ff ff       	call   80100597 <panic>

80104794 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104794:	f3 0f 1e fb          	endbr32 
80104798:	55                   	push   %ebp
80104799:	89 e5                	mov    %esp,%ebp
8010479b:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
8010479e:	83 ec 0c             	sub    $0xc,%esp
801047a1:	68 20 ff 10 80       	push   $0x8010ff20
801047a6:	e8 01 06 00 00       	call   80104dac <acquire>
801047ab:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
801047ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047b5:	c7 45 f4 54 ff 10 80 	movl   $0x8010ff54,-0xc(%ebp)
801047bc:	e9 a6 00 00 00       	jmp    80104867 <wait+0xd3>
      if(p->parent != proc)
801047c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047c4:	8b 50 14             	mov    0x14(%eax),%edx
801047c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047cd:	39 c2                	cmp    %eax,%edx
801047cf:	0f 85 8d 00 00 00    	jne    80104862 <wait+0xce>
        continue;
      havekids = 1;
801047d5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
801047dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047df:	8b 40 0c             	mov    0xc(%eax),%eax
801047e2:	83 f8 05             	cmp    $0x5,%eax
801047e5:	75 7c                	jne    80104863 <wait+0xcf>
        // Found one.
        pid = p->pid;
801047e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047ea:	8b 40 10             	mov    0x10(%eax),%eax
801047ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
801047f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047f3:	8b 40 08             	mov    0x8(%eax),%eax
801047f6:	83 ec 0c             	sub    $0xc,%esp
801047f9:	50                   	push   %eax
801047fa:	e8 1e e4 ff ff       	call   80102c1d <kfree>
801047ff:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104802:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104805:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
8010480c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010480f:	8b 40 04             	mov    0x4(%eax),%eax
80104812:	83 ec 0c             	sub    $0xc,%esp
80104815:	50                   	push   %eax
80104816:	e8 96 38 00 00       	call   801080b1 <freevm>
8010481b:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
8010481e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104821:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104828:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010482b:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104832:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104835:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
8010483c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010483f:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104843:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104846:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
8010484d:	83 ec 0c             	sub    $0xc,%esp
80104850:	68 20 ff 10 80       	push   $0x8010ff20
80104855:	e8 bd 05 00 00       	call   80104e17 <release>
8010485a:	83 c4 10             	add    $0x10,%esp
        return pid;
8010485d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104860:	eb 58                	jmp    801048ba <wait+0x126>
        continue;
80104862:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104863:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104867:	81 7d f4 54 1e 11 80 	cmpl   $0x80111e54,-0xc(%ebp)
8010486e:	0f 82 4d ff ff ff    	jb     801047c1 <wait+0x2d>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104874:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104878:	74 0d                	je     80104887 <wait+0xf3>
8010487a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104880:	8b 40 24             	mov    0x24(%eax),%eax
80104883:	85 c0                	test   %eax,%eax
80104885:	74 17                	je     8010489e <wait+0x10a>
      release(&ptable.lock);
80104887:	83 ec 0c             	sub    $0xc,%esp
8010488a:	68 20 ff 10 80       	push   $0x8010ff20
8010488f:	e8 83 05 00 00       	call   80104e17 <release>
80104894:	83 c4 10             	add    $0x10,%esp
      return -1;
80104897:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010489c:	eb 1c                	jmp    801048ba <wait+0x126>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
8010489e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048a4:	83 ec 08             	sub    $0x8,%esp
801048a7:	68 20 ff 10 80       	push   $0x8010ff20
801048ac:	50                   	push   %eax
801048ad:	e8 e7 01 00 00       	call   80104a99 <sleep>
801048b2:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801048b5:	e9 f4 fe ff ff       	jmp    801047ae <wait+0x1a>
  }
}
801048ba:	c9                   	leave  
801048bb:	c3                   	ret    

801048bc <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801048bc:	f3 0f 1e fb          	endbr32 
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
801048c6:	e8 2f f9 ff ff       	call   801041fa <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801048cb:	83 ec 0c             	sub    $0xc,%esp
801048ce:	68 20 ff 10 80       	push   $0x8010ff20
801048d3:	e8 d4 04 00 00       	call   80104dac <acquire>
801048d8:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048db:	c7 45 f4 54 ff 10 80 	movl   $0x8010ff54,-0xc(%ebp)
801048e2:	eb 63                	jmp    80104947 <scheduler+0x8b>
      if(p->state != RUNNABLE)
801048e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e7:	8b 40 0c             	mov    0xc(%eax),%eax
801048ea:	83 f8 03             	cmp    $0x3,%eax
801048ed:	75 53                	jne    80104942 <scheduler+0x86>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
801048ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048f2:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
801048f8:	83 ec 0c             	sub    $0xc,%esp
801048fb:	ff 75 f4             	pushl  -0xc(%ebp)
801048fe:	e8 55 33 00 00       	call   80107c58 <switchuvm>
80104903:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80104906:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104909:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
80104910:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104916:	8b 40 1c             	mov    0x1c(%eax),%eax
80104919:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104920:	83 c2 04             	add    $0x4,%edx
80104923:	83 ec 08             	sub    $0x8,%esp
80104926:	50                   	push   %eax
80104927:	52                   	push   %edx
80104928:	e8 8f 09 00 00       	call   801052bc <swtch>
8010492d:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104930:	e8 02 33 00 00       	call   80107c37 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104935:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
8010493c:	00 00 00 00 
80104940:	eb 01                	jmp    80104943 <scheduler+0x87>
        continue;
80104942:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104943:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104947:	81 7d f4 54 1e 11 80 	cmpl   $0x80111e54,-0xc(%ebp)
8010494e:	72 94                	jb     801048e4 <scheduler+0x28>
    }
    release(&ptable.lock);
80104950:	83 ec 0c             	sub    $0xc,%esp
80104953:	68 20 ff 10 80       	push   $0x8010ff20
80104958:	e8 ba 04 00 00       	call   80104e17 <release>
8010495d:	83 c4 10             	add    $0x10,%esp
    sti();
80104960:	e9 61 ff ff ff       	jmp    801048c6 <scheduler+0xa>

80104965 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104965:	f3 0f 1e fb          	endbr32 
80104969:	55                   	push   %ebp
8010496a:	89 e5                	mov    %esp,%ebp
8010496c:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
8010496f:	83 ec 0c             	sub    $0xc,%esp
80104972:	68 20 ff 10 80       	push   $0x8010ff20
80104977:	e8 70 05 00 00       	call   80104eec <holding>
8010497c:	83 c4 10             	add    $0x10,%esp
8010497f:	85 c0                	test   %eax,%eax
80104981:	75 0d                	jne    80104990 <sched+0x2b>
    panic("sched ptable.lock");
80104983:	83 ec 0c             	sub    $0xc,%esp
80104986:	68 9d 86 10 80       	push   $0x8010869d
8010498b:	e8 07 bc ff ff       	call   80100597 <panic>
  if(cpu->ncli != 1)
80104990:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104996:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010499c:	83 f8 01             	cmp    $0x1,%eax
8010499f:	74 0d                	je     801049ae <sched+0x49>
    panic("sched locks");
801049a1:	83 ec 0c             	sub    $0xc,%esp
801049a4:	68 af 86 10 80       	push   $0x801086af
801049a9:	e8 e9 bb ff ff       	call   80100597 <panic>
  if(proc->state == RUNNING)
801049ae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049b4:	8b 40 0c             	mov    0xc(%eax),%eax
801049b7:	83 f8 04             	cmp    $0x4,%eax
801049ba:	75 0d                	jne    801049c9 <sched+0x64>
    panic("sched running");
801049bc:	83 ec 0c             	sub    $0xc,%esp
801049bf:	68 bb 86 10 80       	push   $0x801086bb
801049c4:	e8 ce bb ff ff       	call   80100597 <panic>
  if(readeflags()&FL_IF)
801049c9:	e8 1c f8 ff ff       	call   801041ea <readeflags>
801049ce:	25 00 02 00 00       	and    $0x200,%eax
801049d3:	85 c0                	test   %eax,%eax
801049d5:	74 0d                	je     801049e4 <sched+0x7f>
    panic("sched interruptible");
801049d7:	83 ec 0c             	sub    $0xc,%esp
801049da:	68 c9 86 10 80       	push   $0x801086c9
801049df:	e8 b3 bb ff ff       	call   80100597 <panic>
  intena = cpu->intena;
801049e4:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801049ea:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801049f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
801049f3:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801049f9:	8b 40 04             	mov    0x4(%eax),%eax
801049fc:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104a03:	83 c2 1c             	add    $0x1c,%edx
80104a06:	83 ec 08             	sub    $0x8,%esp
80104a09:	50                   	push   %eax
80104a0a:	52                   	push   %edx
80104a0b:	e8 ac 08 00 00       	call   801052bc <swtch>
80104a10:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104a13:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104a19:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a1c:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104a22:	90                   	nop
80104a23:	c9                   	leave  
80104a24:	c3                   	ret    

80104a25 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104a25:	f3 0f 1e fb          	endbr32 
80104a29:	55                   	push   %ebp
80104a2a:	89 e5                	mov    %esp,%ebp
80104a2c:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104a2f:	83 ec 0c             	sub    $0xc,%esp
80104a32:	68 20 ff 10 80       	push   $0x8010ff20
80104a37:	e8 70 03 00 00       	call   80104dac <acquire>
80104a3c:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104a3f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a45:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104a4c:	e8 14 ff ff ff       	call   80104965 <sched>
  release(&ptable.lock);
80104a51:	83 ec 0c             	sub    $0xc,%esp
80104a54:	68 20 ff 10 80       	push   $0x8010ff20
80104a59:	e8 b9 03 00 00       	call   80104e17 <release>
80104a5e:	83 c4 10             	add    $0x10,%esp
}
80104a61:	90                   	nop
80104a62:	c9                   	leave  
80104a63:	c3                   	ret    

80104a64 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104a64:	f3 0f 1e fb          	endbr32 
80104a68:	55                   	push   %ebp
80104a69:	89 e5                	mov    %esp,%ebp
80104a6b:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104a6e:	83 ec 0c             	sub    $0xc,%esp
80104a71:	68 20 ff 10 80       	push   $0x8010ff20
80104a76:	e8 9c 03 00 00       	call   80104e17 <release>
80104a7b:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104a7e:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104a83:	85 c0                	test   %eax,%eax
80104a85:	74 0f                	je     80104a96 <forkret+0x32>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104a87:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
80104a8e:	00 00 00 
    initlog();
80104a91:	e8 f6 e6 ff ff       	call   8010318c <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104a96:	90                   	nop
80104a97:	c9                   	leave  
80104a98:	c3                   	ret    

80104a99 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104a99:	f3 0f 1e fb          	endbr32 
80104a9d:	55                   	push   %ebp
80104a9e:	89 e5                	mov    %esp,%ebp
80104aa0:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104aa3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aa9:	85 c0                	test   %eax,%eax
80104aab:	75 0d                	jne    80104aba <sleep+0x21>
    panic("sleep");
80104aad:	83 ec 0c             	sub    $0xc,%esp
80104ab0:	68 dd 86 10 80       	push   $0x801086dd
80104ab5:	e8 dd ba ff ff       	call   80100597 <panic>

  if(lk == 0)
80104aba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104abe:	75 0d                	jne    80104acd <sleep+0x34>
    panic("sleep without lk");
80104ac0:	83 ec 0c             	sub    $0xc,%esp
80104ac3:	68 e3 86 10 80       	push   $0x801086e3
80104ac8:	e8 ca ba ff ff       	call   80100597 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104acd:	81 7d 0c 20 ff 10 80 	cmpl   $0x8010ff20,0xc(%ebp)
80104ad4:	74 1e                	je     80104af4 <sleep+0x5b>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104ad6:	83 ec 0c             	sub    $0xc,%esp
80104ad9:	68 20 ff 10 80       	push   $0x8010ff20
80104ade:	e8 c9 02 00 00       	call   80104dac <acquire>
80104ae3:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104ae6:	83 ec 0c             	sub    $0xc,%esp
80104ae9:	ff 75 0c             	pushl  0xc(%ebp)
80104aec:	e8 26 03 00 00       	call   80104e17 <release>
80104af1:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104af4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104afa:	8b 55 08             	mov    0x8(%ebp),%edx
80104afd:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104b00:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b06:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104b0d:	e8 53 fe ff ff       	call   80104965 <sched>

  // Tidy up.
  proc->chan = 0;
80104b12:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b18:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104b1f:	81 7d 0c 20 ff 10 80 	cmpl   $0x8010ff20,0xc(%ebp)
80104b26:	74 1e                	je     80104b46 <sleep+0xad>
    release(&ptable.lock);
80104b28:	83 ec 0c             	sub    $0xc,%esp
80104b2b:	68 20 ff 10 80       	push   $0x8010ff20
80104b30:	e8 e2 02 00 00       	call   80104e17 <release>
80104b35:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104b38:	83 ec 0c             	sub    $0xc,%esp
80104b3b:	ff 75 0c             	pushl  0xc(%ebp)
80104b3e:	e8 69 02 00 00       	call   80104dac <acquire>
80104b43:	83 c4 10             	add    $0x10,%esp
  }
}
80104b46:	90                   	nop
80104b47:	c9                   	leave  
80104b48:	c3                   	ret    

80104b49 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104b49:	f3 0f 1e fb          	endbr32 
80104b4d:	55                   	push   %ebp
80104b4e:	89 e5                	mov    %esp,%ebp
80104b50:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b53:	c7 45 fc 54 ff 10 80 	movl   $0x8010ff54,-0x4(%ebp)
80104b5a:	eb 24                	jmp    80104b80 <wakeup1+0x37>
    if(p->state == SLEEPING && p->chan == chan)
80104b5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104b5f:	8b 40 0c             	mov    0xc(%eax),%eax
80104b62:	83 f8 02             	cmp    $0x2,%eax
80104b65:	75 15                	jne    80104b7c <wakeup1+0x33>
80104b67:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104b6a:	8b 40 20             	mov    0x20(%eax),%eax
80104b6d:	39 45 08             	cmp    %eax,0x8(%ebp)
80104b70:	75 0a                	jne    80104b7c <wakeup1+0x33>
      p->state = RUNNABLE;
80104b72:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104b75:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b7c:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104b80:	81 7d fc 54 1e 11 80 	cmpl   $0x80111e54,-0x4(%ebp)
80104b87:	72 d3                	jb     80104b5c <wakeup1+0x13>
}
80104b89:	90                   	nop
80104b8a:	90                   	nop
80104b8b:	c9                   	leave  
80104b8c:	c3                   	ret    

80104b8d <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104b8d:	f3 0f 1e fb          	endbr32 
80104b91:	55                   	push   %ebp
80104b92:	89 e5                	mov    %esp,%ebp
80104b94:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104b97:	83 ec 0c             	sub    $0xc,%esp
80104b9a:	68 20 ff 10 80       	push   $0x8010ff20
80104b9f:	e8 08 02 00 00       	call   80104dac <acquire>
80104ba4:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104ba7:	83 ec 0c             	sub    $0xc,%esp
80104baa:	ff 75 08             	pushl  0x8(%ebp)
80104bad:	e8 97 ff ff ff       	call   80104b49 <wakeup1>
80104bb2:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104bb5:	83 ec 0c             	sub    $0xc,%esp
80104bb8:	68 20 ff 10 80       	push   $0x8010ff20
80104bbd:	e8 55 02 00 00       	call   80104e17 <release>
80104bc2:	83 c4 10             	add    $0x10,%esp
}
80104bc5:	90                   	nop
80104bc6:	c9                   	leave  
80104bc7:	c3                   	ret    

80104bc8 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104bc8:	f3 0f 1e fb          	endbr32 
80104bcc:	55                   	push   %ebp
80104bcd:	89 e5                	mov    %esp,%ebp
80104bcf:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104bd2:	83 ec 0c             	sub    $0xc,%esp
80104bd5:	68 20 ff 10 80       	push   $0x8010ff20
80104bda:	e8 cd 01 00 00       	call   80104dac <acquire>
80104bdf:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104be2:	c7 45 f4 54 ff 10 80 	movl   $0x8010ff54,-0xc(%ebp)
80104be9:	eb 45                	jmp    80104c30 <kill+0x68>
    if(p->pid == pid){
80104beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bee:	8b 40 10             	mov    0x10(%eax),%eax
80104bf1:	39 45 08             	cmp    %eax,0x8(%ebp)
80104bf4:	75 36                	jne    80104c2c <kill+0x64>
      p->killed = 1;
80104bf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bf9:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104c00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c03:	8b 40 0c             	mov    0xc(%eax),%eax
80104c06:	83 f8 02             	cmp    $0x2,%eax
80104c09:	75 0a                	jne    80104c15 <kill+0x4d>
        p->state = RUNNABLE;
80104c0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c0e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104c15:	83 ec 0c             	sub    $0xc,%esp
80104c18:	68 20 ff 10 80       	push   $0x8010ff20
80104c1d:	e8 f5 01 00 00       	call   80104e17 <release>
80104c22:	83 c4 10             	add    $0x10,%esp
      return 0;
80104c25:	b8 00 00 00 00       	mov    $0x0,%eax
80104c2a:	eb 22                	jmp    80104c4e <kill+0x86>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c2c:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104c30:	81 7d f4 54 1e 11 80 	cmpl   $0x80111e54,-0xc(%ebp)
80104c37:	72 b2                	jb     80104beb <kill+0x23>
    }
  }
  release(&ptable.lock);
80104c39:	83 ec 0c             	sub    $0xc,%esp
80104c3c:	68 20 ff 10 80       	push   $0x8010ff20
80104c41:	e8 d1 01 00 00       	call   80104e17 <release>
80104c46:	83 c4 10             	add    $0x10,%esp
  return -1;
80104c49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c4e:	c9                   	leave  
80104c4f:	c3                   	ret    

80104c50 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104c50:	f3 0f 1e fb          	endbr32 
80104c54:	55                   	push   %ebp
80104c55:	89 e5                	mov    %esp,%ebp
80104c57:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c5a:	c7 45 f0 54 ff 10 80 	movl   $0x8010ff54,-0x10(%ebp)
80104c61:	e9 d7 00 00 00       	jmp    80104d3d <procdump+0xed>
    if(p->state == UNUSED)
80104c66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c69:	8b 40 0c             	mov    0xc(%eax),%eax
80104c6c:	85 c0                	test   %eax,%eax
80104c6e:	0f 84 c4 00 00 00    	je     80104d38 <procdump+0xe8>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104c74:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c77:	8b 40 0c             	mov    0xc(%eax),%eax
80104c7a:	83 f8 05             	cmp    $0x5,%eax
80104c7d:	77 23                	ja     80104ca2 <procdump+0x52>
80104c7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c82:	8b 40 0c             	mov    0xc(%eax),%eax
80104c85:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104c8c:	85 c0                	test   %eax,%eax
80104c8e:	74 12                	je     80104ca2 <procdump+0x52>
      state = states[p->state];
80104c90:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c93:	8b 40 0c             	mov    0xc(%eax),%eax
80104c96:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104c9d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104ca0:	eb 07                	jmp    80104ca9 <procdump+0x59>
    else
      state = "???";
80104ca2:	c7 45 ec f4 86 10 80 	movl   $0x801086f4,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104ca9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104cac:	8d 50 6c             	lea    0x6c(%eax),%edx
80104caf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104cb2:	8b 40 10             	mov    0x10(%eax),%eax
80104cb5:	52                   	push   %edx
80104cb6:	ff 75 ec             	pushl  -0x14(%ebp)
80104cb9:	50                   	push   %eax
80104cba:	68 f8 86 10 80       	push   $0x801086f8
80104cbf:	e8 1a b7 ff ff       	call   801003de <cprintf>
80104cc4:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104cc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104cca:	8b 40 0c             	mov    0xc(%eax),%eax
80104ccd:	83 f8 02             	cmp    $0x2,%eax
80104cd0:	75 54                	jne    80104d26 <procdump+0xd6>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104cd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104cd5:	8b 40 1c             	mov    0x1c(%eax),%eax
80104cd8:	8b 40 0c             	mov    0xc(%eax),%eax
80104cdb:	83 c0 08             	add    $0x8,%eax
80104cde:	89 c2                	mov    %eax,%edx
80104ce0:	83 ec 08             	sub    $0x8,%esp
80104ce3:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104ce6:	50                   	push   %eax
80104ce7:	52                   	push   %edx
80104ce8:	e8 80 01 00 00       	call   80104e6d <getcallerpcs>
80104ced:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104cf0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104cf7:	eb 1c                	jmp    80104d15 <procdump+0xc5>
        cprintf(" %p", pc[i]);
80104cf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cfc:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104d00:	83 ec 08             	sub    $0x8,%esp
80104d03:	50                   	push   %eax
80104d04:	68 01 87 10 80       	push   $0x80108701
80104d09:	e8 d0 b6 ff ff       	call   801003de <cprintf>
80104d0e:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104d11:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104d15:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104d19:	7f 0b                	jg     80104d26 <procdump+0xd6>
80104d1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d1e:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104d22:	85 c0                	test   %eax,%eax
80104d24:	75 d3                	jne    80104cf9 <procdump+0xa9>
    }
    cprintf("\n");
80104d26:	83 ec 0c             	sub    $0xc,%esp
80104d29:	68 05 87 10 80       	push   $0x80108705
80104d2e:	e8 ab b6 ff ff       	call   801003de <cprintf>
80104d33:	83 c4 10             	add    $0x10,%esp
80104d36:	eb 01                	jmp    80104d39 <procdump+0xe9>
      continue;
80104d38:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d39:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104d3d:	81 7d f0 54 1e 11 80 	cmpl   $0x80111e54,-0x10(%ebp)
80104d44:	0f 82 1c ff ff ff    	jb     80104c66 <procdump+0x16>
  }
}
80104d4a:	90                   	nop
80104d4b:	90                   	nop
80104d4c:	c9                   	leave  
80104d4d:	c3                   	ret    

80104d4e <readeflags>:
{
80104d4e:	55                   	push   %ebp
80104d4f:	89 e5                	mov    %esp,%ebp
80104d51:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104d54:	9c                   	pushf  
80104d55:	58                   	pop    %eax
80104d56:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104d59:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104d5c:	c9                   	leave  
80104d5d:	c3                   	ret    

80104d5e <cli>:
{
80104d5e:	55                   	push   %ebp
80104d5f:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104d61:	fa                   	cli    
}
80104d62:	90                   	nop
80104d63:	5d                   	pop    %ebp
80104d64:	c3                   	ret    

80104d65 <sti>:
{
80104d65:	55                   	push   %ebp
80104d66:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104d68:	fb                   	sti    
}
80104d69:	90                   	nop
80104d6a:	5d                   	pop    %ebp
80104d6b:	c3                   	ret    

80104d6c <xchg>:
{
80104d6c:	55                   	push   %ebp
80104d6d:	89 e5                	mov    %esp,%ebp
80104d6f:	83 ec 10             	sub    $0x10,%esp
  asm volatile("lock; xchgl %0, %1" :
80104d72:	8b 55 08             	mov    0x8(%ebp),%edx
80104d75:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d78:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104d7b:	f0 87 02             	lock xchg %eax,(%edx)
80104d7e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return result;
80104d81:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104d84:	c9                   	leave  
80104d85:	c3                   	ret    

80104d86 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104d86:	f3 0f 1e fb          	endbr32 
80104d8a:	55                   	push   %ebp
80104d8b:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104d8d:	8b 45 08             	mov    0x8(%ebp),%eax
80104d90:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d93:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104d96:	8b 45 08             	mov    0x8(%ebp),%eax
80104d99:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104d9f:	8b 45 08             	mov    0x8(%ebp),%eax
80104da2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104da9:	90                   	nop
80104daa:	5d                   	pop    %ebp
80104dab:	c3                   	ret    

80104dac <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104dac:	f3 0f 1e fb          	endbr32 
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104db6:	e8 5f 01 00 00       	call   80104f1a <pushcli>
  if(holding(lk))
80104dbb:	8b 45 08             	mov    0x8(%ebp),%eax
80104dbe:	83 ec 0c             	sub    $0xc,%esp
80104dc1:	50                   	push   %eax
80104dc2:	e8 25 01 00 00       	call   80104eec <holding>
80104dc7:	83 c4 10             	add    $0x10,%esp
80104dca:	85 c0                	test   %eax,%eax
80104dcc:	74 0d                	je     80104ddb <acquire+0x2f>
    panic("acquire");
80104dce:	83 ec 0c             	sub    $0xc,%esp
80104dd1:	68 31 87 10 80       	push   $0x80108731
80104dd6:	e8 bc b7 ff ff       	call   80100597 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104ddb:	90                   	nop
80104ddc:	8b 45 08             	mov    0x8(%ebp),%eax
80104ddf:	83 ec 08             	sub    $0x8,%esp
80104de2:	6a 01                	push   $0x1
80104de4:	50                   	push   %eax
80104de5:	e8 82 ff ff ff       	call   80104d6c <xchg>
80104dea:	83 c4 10             	add    $0x10,%esp
80104ded:	85 c0                	test   %eax,%eax
80104def:	75 eb                	jne    80104ddc <acquire+0x30>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104df1:	8b 45 08             	mov    0x8(%ebp),%eax
80104df4:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104dfb:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104dfe:	8b 45 08             	mov    0x8(%ebp),%eax
80104e01:	83 c0 0c             	add    $0xc,%eax
80104e04:	83 ec 08             	sub    $0x8,%esp
80104e07:	50                   	push   %eax
80104e08:	8d 45 08             	lea    0x8(%ebp),%eax
80104e0b:	50                   	push   %eax
80104e0c:	e8 5c 00 00 00       	call   80104e6d <getcallerpcs>
80104e11:	83 c4 10             	add    $0x10,%esp
}
80104e14:	90                   	nop
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    

80104e17 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104e17:	f3 0f 1e fb          	endbr32 
80104e1b:	55                   	push   %ebp
80104e1c:	89 e5                	mov    %esp,%ebp
80104e1e:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80104e21:	83 ec 0c             	sub    $0xc,%esp
80104e24:	ff 75 08             	pushl  0x8(%ebp)
80104e27:	e8 c0 00 00 00       	call   80104eec <holding>
80104e2c:	83 c4 10             	add    $0x10,%esp
80104e2f:	85 c0                	test   %eax,%eax
80104e31:	75 0d                	jne    80104e40 <release+0x29>
    panic("release");
80104e33:	83 ec 0c             	sub    $0xc,%esp
80104e36:	68 39 87 10 80       	push   $0x80108739
80104e3b:	e8 57 b7 ff ff       	call   80100597 <panic>

  lk->pcs[0] = 0;
80104e40:	8b 45 08             	mov    0x8(%ebp),%eax
80104e43:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104e4a:	8b 45 08             	mov    0x8(%ebp),%eax
80104e4d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104e54:	8b 45 08             	mov    0x8(%ebp),%eax
80104e57:	83 ec 08             	sub    $0x8,%esp
80104e5a:	6a 00                	push   $0x0
80104e5c:	50                   	push   %eax
80104e5d:	e8 0a ff ff ff       	call   80104d6c <xchg>
80104e62:	83 c4 10             	add    $0x10,%esp

  popcli();
80104e65:	e8 f9 00 00 00       	call   80104f63 <popcli>
}
80104e6a:	90                   	nop
80104e6b:	c9                   	leave  
80104e6c:	c3                   	ret    

80104e6d <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104e6d:	f3 0f 1e fb          	endbr32 
80104e71:	55                   	push   %ebp
80104e72:	89 e5                	mov    %esp,%ebp
80104e74:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80104e77:	8b 45 08             	mov    0x8(%ebp),%eax
80104e7a:	83 e8 08             	sub    $0x8,%eax
80104e7d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104e80:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80104e87:	eb 38                	jmp    80104ec1 <getcallerpcs+0x54>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104e89:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80104e8d:	74 53                	je     80104ee2 <getcallerpcs+0x75>
80104e8f:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80104e96:	76 4a                	jbe    80104ee2 <getcallerpcs+0x75>
80104e98:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80104e9c:	74 44                	je     80104ee2 <getcallerpcs+0x75>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104e9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104ea1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104ea8:	8b 45 0c             	mov    0xc(%ebp),%eax
80104eab:	01 c2                	add    %eax,%edx
80104ead:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104eb0:	8b 40 04             	mov    0x4(%eax),%eax
80104eb3:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80104eb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104eb8:	8b 00                	mov    (%eax),%eax
80104eba:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104ebd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104ec1:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104ec5:	7e c2                	jle    80104e89 <getcallerpcs+0x1c>
  }
  for(; i < 10; i++)
80104ec7:	eb 19                	jmp    80104ee2 <getcallerpcs+0x75>
    pcs[i] = 0;
80104ec9:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104ecc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104ed3:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ed6:	01 d0                	add    %edx,%eax
80104ed8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ede:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104ee2:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104ee6:	7e e1                	jle    80104ec9 <getcallerpcs+0x5c>
}
80104ee8:	90                   	nop
80104ee9:	90                   	nop
80104eea:	c9                   	leave  
80104eeb:	c3                   	ret    

80104eec <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104eec:	f3 0f 1e fb          	endbr32 
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80104ef3:	8b 45 08             	mov    0x8(%ebp),%eax
80104ef6:	8b 00                	mov    (%eax),%eax
80104ef8:	85 c0                	test   %eax,%eax
80104efa:	74 17                	je     80104f13 <holding+0x27>
80104efc:	8b 45 08             	mov    0x8(%ebp),%eax
80104eff:	8b 50 08             	mov    0x8(%eax),%edx
80104f02:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f08:	39 c2                	cmp    %eax,%edx
80104f0a:	75 07                	jne    80104f13 <holding+0x27>
80104f0c:	b8 01 00 00 00       	mov    $0x1,%eax
80104f11:	eb 05                	jmp    80104f18 <holding+0x2c>
80104f13:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104f18:	5d                   	pop    %ebp
80104f19:	c3                   	ret    

80104f1a <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104f1a:	f3 0f 1e fb          	endbr32 
80104f1e:	55                   	push   %ebp
80104f1f:	89 e5                	mov    %esp,%ebp
80104f21:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80104f24:	e8 25 fe ff ff       	call   80104d4e <readeflags>
80104f29:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80104f2c:	e8 2d fe ff ff       	call   80104d5e <cli>
  if(cpu->ncli++ == 0)
80104f31:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104f38:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104f3e:	8d 48 01             	lea    0x1(%eax),%ecx
80104f41:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
80104f47:	85 c0                	test   %eax,%eax
80104f49:	75 15                	jne    80104f60 <pushcli+0x46>
    cpu->intena = eflags & FL_IF;
80104f4b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f51:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104f54:	81 e2 00 02 00 00    	and    $0x200,%edx
80104f5a:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104f60:	90                   	nop
80104f61:	c9                   	leave  
80104f62:	c3                   	ret    

80104f63 <popcli>:

void
popcli(void)
{
80104f63:	f3 0f 1e fb          	endbr32 
80104f67:	55                   	push   %ebp
80104f68:	89 e5                	mov    %esp,%ebp
80104f6a:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
80104f6d:	e8 dc fd ff ff       	call   80104d4e <readeflags>
80104f72:	25 00 02 00 00       	and    $0x200,%eax
80104f77:	85 c0                	test   %eax,%eax
80104f79:	74 0d                	je     80104f88 <popcli+0x25>
    panic("popcli - interruptible");
80104f7b:	83 ec 0c             	sub    $0xc,%esp
80104f7e:	68 41 87 10 80       	push   $0x80108741
80104f83:	e8 0f b6 ff ff       	call   80100597 <panic>
  if(--cpu->ncli < 0)
80104f88:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104f8e:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104f94:	83 ea 01             	sub    $0x1,%edx
80104f97:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80104f9d:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104fa3:	85 c0                	test   %eax,%eax
80104fa5:	79 0d                	jns    80104fb4 <popcli+0x51>
    panic("popcli");
80104fa7:	83 ec 0c             	sub    $0xc,%esp
80104faa:	68 58 87 10 80       	push   $0x80108758
80104faf:	e8 e3 b5 ff ff       	call   80100597 <panic>
  if(cpu->ncli == 0 && cpu->intena)
80104fb4:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104fba:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104fc0:	85 c0                	test   %eax,%eax
80104fc2:	75 15                	jne    80104fd9 <popcli+0x76>
80104fc4:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104fca:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104fd0:	85 c0                	test   %eax,%eax
80104fd2:	74 05                	je     80104fd9 <popcli+0x76>
    sti();
80104fd4:	e8 8c fd ff ff       	call   80104d65 <sti>
}
80104fd9:	90                   	nop
80104fda:	c9                   	leave  
80104fdb:	c3                   	ret    

80104fdc <stosb>:
{
80104fdc:	55                   	push   %ebp
80104fdd:	89 e5                	mov    %esp,%ebp
80104fdf:	57                   	push   %edi
80104fe0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80104fe1:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104fe4:	8b 55 10             	mov    0x10(%ebp),%edx
80104fe7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fea:	89 cb                	mov    %ecx,%ebx
80104fec:	89 df                	mov    %ebx,%edi
80104fee:	89 d1                	mov    %edx,%ecx
80104ff0:	fc                   	cld    
80104ff1:	f3 aa                	rep stos %al,%es:(%edi)
80104ff3:	89 ca                	mov    %ecx,%edx
80104ff5:	89 fb                	mov    %edi,%ebx
80104ff7:	89 5d 08             	mov    %ebx,0x8(%ebp)
80104ffa:	89 55 10             	mov    %edx,0x10(%ebp)
}
80104ffd:	90                   	nop
80104ffe:	5b                   	pop    %ebx
80104fff:	5f                   	pop    %edi
80105000:	5d                   	pop    %ebp
80105001:	c3                   	ret    

80105002 <stosl>:
{
80105002:	55                   	push   %ebp
80105003:	89 e5                	mov    %esp,%ebp
80105005:	57                   	push   %edi
80105006:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80105007:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010500a:	8b 55 10             	mov    0x10(%ebp),%edx
8010500d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105010:	89 cb                	mov    %ecx,%ebx
80105012:	89 df                	mov    %ebx,%edi
80105014:	89 d1                	mov    %edx,%ecx
80105016:	fc                   	cld    
80105017:	f3 ab                	rep stos %eax,%es:(%edi)
80105019:	89 ca                	mov    %ecx,%edx
8010501b:	89 fb                	mov    %edi,%ebx
8010501d:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105020:	89 55 10             	mov    %edx,0x10(%ebp)
}
80105023:	90                   	nop
80105024:	5b                   	pop    %ebx
80105025:	5f                   	pop    %edi
80105026:	5d                   	pop    %ebp
80105027:	c3                   	ret    

80105028 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105028:	f3 0f 1e fb          	endbr32 
8010502c:	55                   	push   %ebp
8010502d:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
8010502f:	8b 45 08             	mov    0x8(%ebp),%eax
80105032:	83 e0 03             	and    $0x3,%eax
80105035:	85 c0                	test   %eax,%eax
80105037:	75 43                	jne    8010507c <memset+0x54>
80105039:	8b 45 10             	mov    0x10(%ebp),%eax
8010503c:	83 e0 03             	and    $0x3,%eax
8010503f:	85 c0                	test   %eax,%eax
80105041:	75 39                	jne    8010507c <memset+0x54>
    c &= 0xFF;
80105043:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010504a:	8b 45 10             	mov    0x10(%ebp),%eax
8010504d:	c1 e8 02             	shr    $0x2,%eax
80105050:	89 c1                	mov    %eax,%ecx
80105052:	8b 45 0c             	mov    0xc(%ebp),%eax
80105055:	c1 e0 18             	shl    $0x18,%eax
80105058:	89 c2                	mov    %eax,%edx
8010505a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010505d:	c1 e0 10             	shl    $0x10,%eax
80105060:	09 c2                	or     %eax,%edx
80105062:	8b 45 0c             	mov    0xc(%ebp),%eax
80105065:	c1 e0 08             	shl    $0x8,%eax
80105068:	09 d0                	or     %edx,%eax
8010506a:	0b 45 0c             	or     0xc(%ebp),%eax
8010506d:	51                   	push   %ecx
8010506e:	50                   	push   %eax
8010506f:	ff 75 08             	pushl  0x8(%ebp)
80105072:	e8 8b ff ff ff       	call   80105002 <stosl>
80105077:	83 c4 0c             	add    $0xc,%esp
8010507a:	eb 12                	jmp    8010508e <memset+0x66>
  } else
    stosb(dst, c, n);
8010507c:	8b 45 10             	mov    0x10(%ebp),%eax
8010507f:	50                   	push   %eax
80105080:	ff 75 0c             	pushl  0xc(%ebp)
80105083:	ff 75 08             	pushl  0x8(%ebp)
80105086:	e8 51 ff ff ff       	call   80104fdc <stosb>
8010508b:	83 c4 0c             	add    $0xc,%esp
  return dst;
8010508e:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105091:	c9                   	leave  
80105092:	c3                   	ret    

80105093 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105093:	f3 0f 1e fb          	endbr32 
80105097:	55                   	push   %ebp
80105098:	89 e5                	mov    %esp,%ebp
8010509a:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
8010509d:	8b 45 08             	mov    0x8(%ebp),%eax
801050a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801050a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801050a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801050a9:	eb 30                	jmp    801050db <memcmp+0x48>
    if(*s1 != *s2)
801050ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
801050ae:	0f b6 10             	movzbl (%eax),%edx
801050b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
801050b4:	0f b6 00             	movzbl (%eax),%eax
801050b7:	38 c2                	cmp    %al,%dl
801050b9:	74 18                	je     801050d3 <memcmp+0x40>
      return *s1 - *s2;
801050bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
801050be:	0f b6 00             	movzbl (%eax),%eax
801050c1:	0f b6 d0             	movzbl %al,%edx
801050c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
801050c7:	0f b6 00             	movzbl (%eax),%eax
801050ca:	0f b6 c0             	movzbl %al,%eax
801050cd:	29 c2                	sub    %eax,%edx
801050cf:	89 d0                	mov    %edx,%eax
801050d1:	eb 1a                	jmp    801050ed <memcmp+0x5a>
    s1++, s2++;
801050d3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801050d7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  while(n-- > 0){
801050db:	8b 45 10             	mov    0x10(%ebp),%eax
801050de:	8d 50 ff             	lea    -0x1(%eax),%edx
801050e1:	89 55 10             	mov    %edx,0x10(%ebp)
801050e4:	85 c0                	test   %eax,%eax
801050e6:	75 c3                	jne    801050ab <memcmp+0x18>
  }

  return 0;
801050e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
801050ed:	c9                   	leave  
801050ee:	c3                   	ret    

801050ef <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801050ef:	f3 0f 1e fb          	endbr32 
801050f3:	55                   	push   %ebp
801050f4:	89 e5                	mov    %esp,%ebp
801050f6:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
801050f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801050fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
801050ff:	8b 45 08             	mov    0x8(%ebp),%eax
80105102:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80105105:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105108:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010510b:	73 54                	jae    80105161 <memmove+0x72>
8010510d:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105110:	8b 45 10             	mov    0x10(%ebp),%eax
80105113:	01 d0                	add    %edx,%eax
80105115:	39 45 f8             	cmp    %eax,-0x8(%ebp)
80105118:	73 47                	jae    80105161 <memmove+0x72>
    s += n;
8010511a:	8b 45 10             	mov    0x10(%ebp),%eax
8010511d:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105120:	8b 45 10             	mov    0x10(%ebp),%eax
80105123:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80105126:	eb 13                	jmp    8010513b <memmove+0x4c>
      *--d = *--s;
80105128:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
8010512c:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105130:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105133:	0f b6 10             	movzbl (%eax),%edx
80105136:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105139:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
8010513b:	8b 45 10             	mov    0x10(%ebp),%eax
8010513e:	8d 50 ff             	lea    -0x1(%eax),%edx
80105141:	89 55 10             	mov    %edx,0x10(%ebp)
80105144:	85 c0                	test   %eax,%eax
80105146:	75 e0                	jne    80105128 <memmove+0x39>
  if(s < d && s + n > d){
80105148:	eb 24                	jmp    8010516e <memmove+0x7f>
  } else
    while(n-- > 0)
      *d++ = *s++;
8010514a:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010514d:	8d 42 01             	lea    0x1(%edx),%eax
80105150:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105153:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105156:	8d 48 01             	lea    0x1(%eax),%ecx
80105159:	89 4d f8             	mov    %ecx,-0x8(%ebp)
8010515c:	0f b6 12             	movzbl (%edx),%edx
8010515f:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80105161:	8b 45 10             	mov    0x10(%ebp),%eax
80105164:	8d 50 ff             	lea    -0x1(%eax),%edx
80105167:	89 55 10             	mov    %edx,0x10(%ebp)
8010516a:	85 c0                	test   %eax,%eax
8010516c:	75 dc                	jne    8010514a <memmove+0x5b>

  return dst;
8010516e:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105171:	c9                   	leave  
80105172:	c3                   	ret    

80105173 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105173:	f3 0f 1e fb          	endbr32 
80105177:	55                   	push   %ebp
80105178:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
8010517a:	ff 75 10             	pushl  0x10(%ebp)
8010517d:	ff 75 0c             	pushl  0xc(%ebp)
80105180:	ff 75 08             	pushl  0x8(%ebp)
80105183:	e8 67 ff ff ff       	call   801050ef <memmove>
80105188:	83 c4 0c             	add    $0xc,%esp
}
8010518b:	c9                   	leave  
8010518c:	c3                   	ret    

8010518d <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
8010518d:	f3 0f 1e fb          	endbr32 
80105191:	55                   	push   %ebp
80105192:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80105194:	eb 0c                	jmp    801051a2 <strncmp+0x15>
    n--, p++, q++;
80105196:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010519a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
8010519e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(n > 0 && *p && *p == *q)
801051a2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801051a6:	74 1a                	je     801051c2 <strncmp+0x35>
801051a8:	8b 45 08             	mov    0x8(%ebp),%eax
801051ab:	0f b6 00             	movzbl (%eax),%eax
801051ae:	84 c0                	test   %al,%al
801051b0:	74 10                	je     801051c2 <strncmp+0x35>
801051b2:	8b 45 08             	mov    0x8(%ebp),%eax
801051b5:	0f b6 10             	movzbl (%eax),%edx
801051b8:	8b 45 0c             	mov    0xc(%ebp),%eax
801051bb:	0f b6 00             	movzbl (%eax),%eax
801051be:	38 c2                	cmp    %al,%dl
801051c0:	74 d4                	je     80105196 <strncmp+0x9>
  if(n == 0)
801051c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801051c6:	75 07                	jne    801051cf <strncmp+0x42>
    return 0;
801051c8:	b8 00 00 00 00       	mov    $0x0,%eax
801051cd:	eb 16                	jmp    801051e5 <strncmp+0x58>
  return (uchar)*p - (uchar)*q;
801051cf:	8b 45 08             	mov    0x8(%ebp),%eax
801051d2:	0f b6 00             	movzbl (%eax),%eax
801051d5:	0f b6 d0             	movzbl %al,%edx
801051d8:	8b 45 0c             	mov    0xc(%ebp),%eax
801051db:	0f b6 00             	movzbl (%eax),%eax
801051de:	0f b6 c0             	movzbl %al,%eax
801051e1:	29 c2                	sub    %eax,%edx
801051e3:	89 d0                	mov    %edx,%eax
}
801051e5:	5d                   	pop    %ebp
801051e6:	c3                   	ret    

801051e7 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801051e7:	f3 0f 1e fb          	endbr32 
801051eb:	55                   	push   %ebp
801051ec:	89 e5                	mov    %esp,%ebp
801051ee:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801051f1:	8b 45 08             	mov    0x8(%ebp),%eax
801051f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
801051f7:	90                   	nop
801051f8:	8b 45 10             	mov    0x10(%ebp),%eax
801051fb:	8d 50 ff             	lea    -0x1(%eax),%edx
801051fe:	89 55 10             	mov    %edx,0x10(%ebp)
80105201:	85 c0                	test   %eax,%eax
80105203:	7e 2c                	jle    80105231 <strncpy+0x4a>
80105205:	8b 55 0c             	mov    0xc(%ebp),%edx
80105208:	8d 42 01             	lea    0x1(%edx),%eax
8010520b:	89 45 0c             	mov    %eax,0xc(%ebp)
8010520e:	8b 45 08             	mov    0x8(%ebp),%eax
80105211:	8d 48 01             	lea    0x1(%eax),%ecx
80105214:	89 4d 08             	mov    %ecx,0x8(%ebp)
80105217:	0f b6 12             	movzbl (%edx),%edx
8010521a:	88 10                	mov    %dl,(%eax)
8010521c:	0f b6 00             	movzbl (%eax),%eax
8010521f:	84 c0                	test   %al,%al
80105221:	75 d5                	jne    801051f8 <strncpy+0x11>
    ;
  while(n-- > 0)
80105223:	eb 0c                	jmp    80105231 <strncpy+0x4a>
    *s++ = 0;
80105225:	8b 45 08             	mov    0x8(%ebp),%eax
80105228:	8d 50 01             	lea    0x1(%eax),%edx
8010522b:	89 55 08             	mov    %edx,0x8(%ebp)
8010522e:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
80105231:	8b 45 10             	mov    0x10(%ebp),%eax
80105234:	8d 50 ff             	lea    -0x1(%eax),%edx
80105237:	89 55 10             	mov    %edx,0x10(%ebp)
8010523a:	85 c0                	test   %eax,%eax
8010523c:	7f e7                	jg     80105225 <strncpy+0x3e>
  return os;
8010523e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105241:	c9                   	leave  
80105242:	c3                   	ret    

80105243 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105243:	f3 0f 1e fb          	endbr32 
80105247:	55                   	push   %ebp
80105248:	89 e5                	mov    %esp,%ebp
8010524a:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
8010524d:	8b 45 08             	mov    0x8(%ebp),%eax
80105250:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80105253:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105257:	7f 05                	jg     8010525e <safestrcpy+0x1b>
    return os;
80105259:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010525c:	eb 31                	jmp    8010528f <safestrcpy+0x4c>
  while(--n > 0 && (*s++ = *t++) != 0)
8010525e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105262:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105266:	7e 1e                	jle    80105286 <safestrcpy+0x43>
80105268:	8b 55 0c             	mov    0xc(%ebp),%edx
8010526b:	8d 42 01             	lea    0x1(%edx),%eax
8010526e:	89 45 0c             	mov    %eax,0xc(%ebp)
80105271:	8b 45 08             	mov    0x8(%ebp),%eax
80105274:	8d 48 01             	lea    0x1(%eax),%ecx
80105277:	89 4d 08             	mov    %ecx,0x8(%ebp)
8010527a:	0f b6 12             	movzbl (%edx),%edx
8010527d:	88 10                	mov    %dl,(%eax)
8010527f:	0f b6 00             	movzbl (%eax),%eax
80105282:	84 c0                	test   %al,%al
80105284:	75 d8                	jne    8010525e <safestrcpy+0x1b>
    ;
  *s = 0;
80105286:	8b 45 08             	mov    0x8(%ebp),%eax
80105289:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010528c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010528f:	c9                   	leave  
80105290:	c3                   	ret    

80105291 <strlen>:

int
strlen(const char *s)
{
80105291:	f3 0f 1e fb          	endbr32 
80105295:	55                   	push   %ebp
80105296:	89 e5                	mov    %esp,%ebp
80105298:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
8010529b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801052a2:	eb 04                	jmp    801052a8 <strlen+0x17>
801052a4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801052a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
801052ab:	8b 45 08             	mov    0x8(%ebp),%eax
801052ae:	01 d0                	add    %edx,%eax
801052b0:	0f b6 00             	movzbl (%eax),%eax
801052b3:	84 c0                	test   %al,%al
801052b5:	75 ed                	jne    801052a4 <strlen+0x13>
    ;
  return n;
801052b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801052ba:	c9                   	leave  
801052bb:	c3                   	ret    

801052bc <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801052bc:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801052c0:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801052c4:	55                   	push   %ebp
  pushl %ebx
801052c5:	53                   	push   %ebx
  pushl %esi
801052c6:	56                   	push   %esi
  pushl %edi
801052c7:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801052c8:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801052ca:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
801052cc:	5f                   	pop    %edi
  popl %esi
801052cd:	5e                   	pop    %esi
  popl %ebx
801052ce:	5b                   	pop    %ebx
  popl %ebp
801052cf:	5d                   	pop    %ebp
  ret
801052d0:	c3                   	ret    

801052d1 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801052d1:	f3 0f 1e fb          	endbr32 
801052d5:	55                   	push   %ebp
801052d6:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801052d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052de:	8b 00                	mov    (%eax),%eax
801052e0:	39 45 08             	cmp    %eax,0x8(%ebp)
801052e3:	73 12                	jae    801052f7 <fetchint+0x26>
801052e5:	8b 45 08             	mov    0x8(%ebp),%eax
801052e8:	8d 50 04             	lea    0x4(%eax),%edx
801052eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052f1:	8b 00                	mov    (%eax),%eax
801052f3:	39 c2                	cmp    %eax,%edx
801052f5:	76 07                	jbe    801052fe <fetchint+0x2d>
    return -1;
801052f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052fc:	eb 0f                	jmp    8010530d <fetchint+0x3c>
  *ip = *(int*)(addr);
801052fe:	8b 45 08             	mov    0x8(%ebp),%eax
80105301:	8b 10                	mov    (%eax),%edx
80105303:	8b 45 0c             	mov    0xc(%ebp),%eax
80105306:	89 10                	mov    %edx,(%eax)
  return 0;
80105308:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010530d:	5d                   	pop    %ebp
8010530e:	c3                   	ret    

8010530f <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010530f:	f3 0f 1e fb          	endbr32 
80105313:	55                   	push   %ebp
80105314:	89 e5                	mov    %esp,%ebp
80105316:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105319:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010531f:	8b 00                	mov    (%eax),%eax
80105321:	39 45 08             	cmp    %eax,0x8(%ebp)
80105324:	72 07                	jb     8010532d <fetchstr+0x1e>
    return -1;
80105326:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010532b:	eb 46                	jmp    80105373 <fetchstr+0x64>
  *pp = (char*)addr;
8010532d:	8b 55 08             	mov    0x8(%ebp),%edx
80105330:	8b 45 0c             	mov    0xc(%ebp),%eax
80105333:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80105335:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010533b:	8b 00                	mov    (%eax),%eax
8010533d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80105340:	8b 45 0c             	mov    0xc(%ebp),%eax
80105343:	8b 00                	mov    (%eax),%eax
80105345:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105348:	eb 1c                	jmp    80105366 <fetchstr+0x57>
    if(*s == 0)
8010534a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010534d:	0f b6 00             	movzbl (%eax),%eax
80105350:	84 c0                	test   %al,%al
80105352:	75 0e                	jne    80105362 <fetchstr+0x53>
      return s - *pp;
80105354:	8b 45 0c             	mov    0xc(%ebp),%eax
80105357:	8b 00                	mov    (%eax),%eax
80105359:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010535c:	29 c2                	sub    %eax,%edx
8010535e:	89 d0                	mov    %edx,%eax
80105360:	eb 11                	jmp    80105373 <fetchstr+0x64>
  for(s = *pp; s < ep; s++)
80105362:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105366:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105369:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010536c:	72 dc                	jb     8010534a <fetchstr+0x3b>
  return -1;
8010536e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105373:	c9                   	leave  
80105374:	c3                   	ret    

80105375 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105375:	f3 0f 1e fb          	endbr32 
80105379:	55                   	push   %ebp
8010537a:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010537c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105382:	8b 40 18             	mov    0x18(%eax),%eax
80105385:	8b 40 44             	mov    0x44(%eax),%eax
80105388:	8b 55 08             	mov    0x8(%ebp),%edx
8010538b:	c1 e2 02             	shl    $0x2,%edx
8010538e:	01 d0                	add    %edx,%eax
80105390:	83 c0 04             	add    $0x4,%eax
80105393:	ff 75 0c             	pushl  0xc(%ebp)
80105396:	50                   	push   %eax
80105397:	e8 35 ff ff ff       	call   801052d1 <fetchint>
8010539c:	83 c4 08             	add    $0x8,%esp
}
8010539f:	c9                   	leave  
801053a0:	c3                   	ret    

801053a1 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801053a1:	f3 0f 1e fb          	endbr32 
801053a5:	55                   	push   %ebp
801053a6:	89 e5                	mov    %esp,%ebp
801053a8:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
801053ab:	8d 45 fc             	lea    -0x4(%ebp),%eax
801053ae:	50                   	push   %eax
801053af:	ff 75 08             	pushl  0x8(%ebp)
801053b2:	e8 be ff ff ff       	call   80105375 <argint>
801053b7:	83 c4 08             	add    $0x8,%esp
801053ba:	85 c0                	test   %eax,%eax
801053bc:	79 07                	jns    801053c5 <argptr+0x24>
    return -1;
801053be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053c3:	eb 3b                	jmp    80105400 <argptr+0x5f>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801053c5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053cb:	8b 00                	mov    (%eax),%eax
801053cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
801053d0:	39 d0                	cmp    %edx,%eax
801053d2:	76 16                	jbe    801053ea <argptr+0x49>
801053d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053d7:	89 c2                	mov    %eax,%edx
801053d9:	8b 45 10             	mov    0x10(%ebp),%eax
801053dc:	01 c2                	add    %eax,%edx
801053de:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053e4:	8b 00                	mov    (%eax),%eax
801053e6:	39 c2                	cmp    %eax,%edx
801053e8:	76 07                	jbe    801053f1 <argptr+0x50>
    return -1;
801053ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ef:	eb 0f                	jmp    80105400 <argptr+0x5f>
  *pp = (char*)i;
801053f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053f4:	89 c2                	mov    %eax,%edx
801053f6:	8b 45 0c             	mov    0xc(%ebp),%eax
801053f9:	89 10                	mov    %edx,(%eax)
  return 0;
801053fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105400:	c9                   	leave  
80105401:	c3                   	ret    

80105402 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105402:	f3 0f 1e fb          	endbr32 
80105406:	55                   	push   %ebp
80105407:	89 e5                	mov    %esp,%ebp
80105409:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010540c:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010540f:	50                   	push   %eax
80105410:	ff 75 08             	pushl  0x8(%ebp)
80105413:	e8 5d ff ff ff       	call   80105375 <argint>
80105418:	83 c4 08             	add    $0x8,%esp
8010541b:	85 c0                	test   %eax,%eax
8010541d:	79 07                	jns    80105426 <argstr+0x24>
    return -1;
8010541f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105424:	eb 0f                	jmp    80105435 <argstr+0x33>
  return fetchstr(addr, pp);
80105426:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105429:	ff 75 0c             	pushl  0xc(%ebp)
8010542c:	50                   	push   %eax
8010542d:	e8 dd fe ff ff       	call   8010530f <fetchstr>
80105432:	83 c4 08             	add    $0x8,%esp
}
80105435:	c9                   	leave  
80105436:	c3                   	ret    

80105437 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80105437:	f3 0f 1e fb          	endbr32 
8010543b:	55                   	push   %ebp
8010543c:	89 e5                	mov    %esp,%ebp
8010543e:	83 ec 18             	sub    $0x18,%esp
  int num;

  num = proc->tf->eax;
80105441:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105447:	8b 40 18             	mov    0x18(%eax),%eax
8010544a:	8b 40 1c             	mov    0x1c(%eax),%eax
8010544d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105450:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105454:	7e 32                	jle    80105488 <syscall+0x51>
80105456:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105459:	83 f8 15             	cmp    $0x15,%eax
8010545c:	77 2a                	ja     80105488 <syscall+0x51>
8010545e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105461:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105468:	85 c0                	test   %eax,%eax
8010546a:	74 1c                	je     80105488 <syscall+0x51>
    proc->tf->eax = syscalls[num]();
8010546c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010546f:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105476:	ff d0                	call   *%eax
80105478:	89 c2                	mov    %eax,%edx
8010547a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105480:	8b 40 18             	mov    0x18(%eax),%eax
80105483:	89 50 1c             	mov    %edx,0x1c(%eax)
80105486:	eb 35                	jmp    801054bd <syscall+0x86>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
80105488:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010548e:	8d 50 6c             	lea    0x6c(%eax),%edx
80105491:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("%d %s: unknown sys call %d\n",
80105497:	8b 40 10             	mov    0x10(%eax),%eax
8010549a:	ff 75 f4             	pushl  -0xc(%ebp)
8010549d:	52                   	push   %edx
8010549e:	50                   	push   %eax
8010549f:	68 5f 87 10 80       	push   $0x8010875f
801054a4:	e8 35 af ff ff       	call   801003de <cprintf>
801054a9:	83 c4 10             	add    $0x10,%esp
    proc->tf->eax = -1;
801054ac:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054b2:	8b 40 18             	mov    0x18(%eax),%eax
801054b5:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801054bc:	90                   	nop
801054bd:	90                   	nop
801054be:	c9                   	leave  
801054bf:	c3                   	ret    

801054c0 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
801054c0:	f3 0f 1e fb          	endbr32 
801054c4:	55                   	push   %ebp
801054c5:	89 e5                	mov    %esp,%ebp
801054c7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801054ca:	83 ec 08             	sub    $0x8,%esp
801054cd:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054d0:	50                   	push   %eax
801054d1:	ff 75 08             	pushl  0x8(%ebp)
801054d4:	e8 9c fe ff ff       	call   80105375 <argint>
801054d9:	83 c4 10             	add    $0x10,%esp
801054dc:	85 c0                	test   %eax,%eax
801054de:	79 07                	jns    801054e7 <argfd+0x27>
    return -1;
801054e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054e5:	eb 50                	jmp    80105537 <argfd+0x77>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801054e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054ea:	85 c0                	test   %eax,%eax
801054ec:	78 21                	js     8010550f <argfd+0x4f>
801054ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054f1:	83 f8 0f             	cmp    $0xf,%eax
801054f4:	7f 19                	jg     8010550f <argfd+0x4f>
801054f6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054fc:	8b 55 f0             	mov    -0x10(%ebp),%edx
801054ff:	83 c2 08             	add    $0x8,%edx
80105502:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105506:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105509:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010550d:	75 07                	jne    80105516 <argfd+0x56>
    return -1;
8010550f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105514:	eb 21                	jmp    80105537 <argfd+0x77>
  if(pfd)
80105516:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010551a:	74 08                	je     80105524 <argfd+0x64>
    *pfd = fd;
8010551c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010551f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105522:	89 10                	mov    %edx,(%eax)
  if(pf)
80105524:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105528:	74 08                	je     80105532 <argfd+0x72>
    *pf = f;
8010552a:	8b 45 10             	mov    0x10(%ebp),%eax
8010552d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105530:	89 10                	mov    %edx,(%eax)
  return 0;
80105532:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105537:	c9                   	leave  
80105538:	c3                   	ret    

80105539 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105539:	f3 0f 1e fb          	endbr32 
8010553d:	55                   	push   %ebp
8010553e:	89 e5                	mov    %esp,%ebp
80105540:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105543:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010554a:	eb 30                	jmp    8010557c <fdalloc+0x43>
    if(proc->ofile[fd] == 0){
8010554c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105552:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105555:	83 c2 08             	add    $0x8,%edx
80105558:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010555c:	85 c0                	test   %eax,%eax
8010555e:	75 18                	jne    80105578 <fdalloc+0x3f>
      proc->ofile[fd] = f;
80105560:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105566:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105569:	8d 4a 08             	lea    0x8(%edx),%ecx
8010556c:	8b 55 08             	mov    0x8(%ebp),%edx
8010556f:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105573:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105576:	eb 0f                	jmp    80105587 <fdalloc+0x4e>
  for(fd = 0; fd < NOFILE; fd++){
80105578:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010557c:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105580:	7e ca                	jle    8010554c <fdalloc+0x13>
    }
  }
  return -1;
80105582:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105587:	c9                   	leave  
80105588:	c3                   	ret    

80105589 <sys_dup>:

int
sys_dup(void)
{
80105589:	f3 0f 1e fb          	endbr32 
8010558d:	55                   	push   %ebp
8010558e:	89 e5                	mov    %esp,%ebp
80105590:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
80105593:	83 ec 04             	sub    $0x4,%esp
80105596:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105599:	50                   	push   %eax
8010559a:	6a 00                	push   $0x0
8010559c:	6a 00                	push   $0x0
8010559e:	e8 1d ff ff ff       	call   801054c0 <argfd>
801055a3:	83 c4 10             	add    $0x10,%esp
801055a6:	85 c0                	test   %eax,%eax
801055a8:	79 07                	jns    801055b1 <sys_dup+0x28>
    return -1;
801055aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055af:	eb 31                	jmp    801055e2 <sys_dup+0x59>
  if((fd=fdalloc(f)) < 0)
801055b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055b4:	83 ec 0c             	sub    $0xc,%esp
801055b7:	50                   	push   %eax
801055b8:	e8 7c ff ff ff       	call   80105539 <fdalloc>
801055bd:	83 c4 10             	add    $0x10,%esp
801055c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801055c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801055c7:	79 07                	jns    801055d0 <sys_dup+0x47>
    return -1;
801055c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055ce:	eb 12                	jmp    801055e2 <sys_dup+0x59>
  filedup(f);
801055d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055d3:	83 ec 0c             	sub    $0xc,%esp
801055d6:	50                   	push   %eax
801055d7:	e8 60 ba ff ff       	call   8010103c <filedup>
801055dc:	83 c4 10             	add    $0x10,%esp
  return fd;
801055df:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801055e2:	c9                   	leave  
801055e3:	c3                   	ret    

801055e4 <sys_read>:

int
sys_read(void)
{
801055e4:	f3 0f 1e fb          	endbr32 
801055e8:	55                   	push   %ebp
801055e9:	89 e5                	mov    %esp,%ebp
801055eb:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801055ee:	83 ec 04             	sub    $0x4,%esp
801055f1:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055f4:	50                   	push   %eax
801055f5:	6a 00                	push   $0x0
801055f7:	6a 00                	push   $0x0
801055f9:	e8 c2 fe ff ff       	call   801054c0 <argfd>
801055fe:	83 c4 10             	add    $0x10,%esp
80105601:	85 c0                	test   %eax,%eax
80105603:	78 2e                	js     80105633 <sys_read+0x4f>
80105605:	83 ec 08             	sub    $0x8,%esp
80105608:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010560b:	50                   	push   %eax
8010560c:	6a 02                	push   $0x2
8010560e:	e8 62 fd ff ff       	call   80105375 <argint>
80105613:	83 c4 10             	add    $0x10,%esp
80105616:	85 c0                	test   %eax,%eax
80105618:	78 19                	js     80105633 <sys_read+0x4f>
8010561a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010561d:	83 ec 04             	sub    $0x4,%esp
80105620:	50                   	push   %eax
80105621:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105624:	50                   	push   %eax
80105625:	6a 01                	push   $0x1
80105627:	e8 75 fd ff ff       	call   801053a1 <argptr>
8010562c:	83 c4 10             	add    $0x10,%esp
8010562f:	85 c0                	test   %eax,%eax
80105631:	79 07                	jns    8010563a <sys_read+0x56>
    return -1;
80105633:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105638:	eb 17                	jmp    80105651 <sys_read+0x6d>
  return fileread(f, p, n);
8010563a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010563d:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105640:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105643:	83 ec 04             	sub    $0x4,%esp
80105646:	51                   	push   %ecx
80105647:	52                   	push   %edx
80105648:	50                   	push   %eax
80105649:	e8 8a bb ff ff       	call   801011d8 <fileread>
8010564e:	83 c4 10             	add    $0x10,%esp
}
80105651:	c9                   	leave  
80105652:	c3                   	ret    

80105653 <sys_write>:

int
sys_write(void)
{
80105653:	f3 0f 1e fb          	endbr32 
80105657:	55                   	push   %ebp
80105658:	89 e5                	mov    %esp,%ebp
8010565a:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010565d:	83 ec 04             	sub    $0x4,%esp
80105660:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105663:	50                   	push   %eax
80105664:	6a 00                	push   $0x0
80105666:	6a 00                	push   $0x0
80105668:	e8 53 fe ff ff       	call   801054c0 <argfd>
8010566d:	83 c4 10             	add    $0x10,%esp
80105670:	85 c0                	test   %eax,%eax
80105672:	78 2e                	js     801056a2 <sys_write+0x4f>
80105674:	83 ec 08             	sub    $0x8,%esp
80105677:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010567a:	50                   	push   %eax
8010567b:	6a 02                	push   $0x2
8010567d:	e8 f3 fc ff ff       	call   80105375 <argint>
80105682:	83 c4 10             	add    $0x10,%esp
80105685:	85 c0                	test   %eax,%eax
80105687:	78 19                	js     801056a2 <sys_write+0x4f>
80105689:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010568c:	83 ec 04             	sub    $0x4,%esp
8010568f:	50                   	push   %eax
80105690:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105693:	50                   	push   %eax
80105694:	6a 01                	push   $0x1
80105696:	e8 06 fd ff ff       	call   801053a1 <argptr>
8010569b:	83 c4 10             	add    $0x10,%esp
8010569e:	85 c0                	test   %eax,%eax
801056a0:	79 07                	jns    801056a9 <sys_write+0x56>
    return -1;
801056a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056a7:	eb 17                	jmp    801056c0 <sys_write+0x6d>
  return filewrite(f, p, n);
801056a9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801056ac:	8b 55 ec             	mov    -0x14(%ebp),%edx
801056af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056b2:	83 ec 04             	sub    $0x4,%esp
801056b5:	51                   	push   %ecx
801056b6:	52                   	push   %edx
801056b7:	50                   	push   %eax
801056b8:	e8 d7 bb ff ff       	call   80101294 <filewrite>
801056bd:	83 c4 10             	add    $0x10,%esp
}
801056c0:	c9                   	leave  
801056c1:	c3                   	ret    

801056c2 <sys_close>:

int
sys_close(void)
{
801056c2:	f3 0f 1e fb          	endbr32 
801056c6:	55                   	push   %ebp
801056c7:	89 e5                	mov    %esp,%ebp
801056c9:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
801056cc:	83 ec 04             	sub    $0x4,%esp
801056cf:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056d2:	50                   	push   %eax
801056d3:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056d6:	50                   	push   %eax
801056d7:	6a 00                	push   $0x0
801056d9:	e8 e2 fd ff ff       	call   801054c0 <argfd>
801056de:	83 c4 10             	add    $0x10,%esp
801056e1:	85 c0                	test   %eax,%eax
801056e3:	79 07                	jns    801056ec <sys_close+0x2a>
    return -1;
801056e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ea:	eb 28                	jmp    80105714 <sys_close+0x52>
  proc->ofile[fd] = 0;
801056ec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056f5:	83 c2 08             	add    $0x8,%edx
801056f8:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801056ff:	00 
  fileclose(f);
80105700:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105703:	83 ec 0c             	sub    $0xc,%esp
80105706:	50                   	push   %eax
80105707:	e8 85 b9 ff ff       	call   80101091 <fileclose>
8010570c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010570f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105714:	c9                   	leave  
80105715:	c3                   	ret    

80105716 <sys_fstat>:

int
sys_fstat(void)
{
80105716:	f3 0f 1e fb          	endbr32 
8010571a:	55                   	push   %ebp
8010571b:	89 e5                	mov    %esp,%ebp
8010571d:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105720:	83 ec 04             	sub    $0x4,%esp
80105723:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105726:	50                   	push   %eax
80105727:	6a 00                	push   $0x0
80105729:	6a 00                	push   $0x0
8010572b:	e8 90 fd ff ff       	call   801054c0 <argfd>
80105730:	83 c4 10             	add    $0x10,%esp
80105733:	85 c0                	test   %eax,%eax
80105735:	78 17                	js     8010574e <sys_fstat+0x38>
80105737:	83 ec 04             	sub    $0x4,%esp
8010573a:	6a 14                	push   $0x14
8010573c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010573f:	50                   	push   %eax
80105740:	6a 01                	push   $0x1
80105742:	e8 5a fc ff ff       	call   801053a1 <argptr>
80105747:	83 c4 10             	add    $0x10,%esp
8010574a:	85 c0                	test   %eax,%eax
8010574c:	79 07                	jns    80105755 <sys_fstat+0x3f>
    return -1;
8010574e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105753:	eb 13                	jmp    80105768 <sys_fstat+0x52>
  return filestat(f, st);
80105755:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105758:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010575b:	83 ec 08             	sub    $0x8,%esp
8010575e:	52                   	push   %edx
8010575f:	50                   	push   %eax
80105760:	e8 18 ba ff ff       	call   8010117d <filestat>
80105765:	83 c4 10             	add    $0x10,%esp
}
80105768:	c9                   	leave  
80105769:	c3                   	ret    

8010576a <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
8010576a:	f3 0f 1e fb          	endbr32 
8010576e:	55                   	push   %ebp
8010576f:	89 e5                	mov    %esp,%ebp
80105771:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105774:	83 ec 08             	sub    $0x8,%esp
80105777:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010577a:	50                   	push   %eax
8010577b:	6a 00                	push   $0x0
8010577d:	e8 80 fc ff ff       	call   80105402 <argstr>
80105782:	83 c4 10             	add    $0x10,%esp
80105785:	85 c0                	test   %eax,%eax
80105787:	78 15                	js     8010579e <sys_link+0x34>
80105789:	83 ec 08             	sub    $0x8,%esp
8010578c:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010578f:	50                   	push   %eax
80105790:	6a 01                	push   $0x1
80105792:	e8 6b fc ff ff       	call   80105402 <argstr>
80105797:	83 c4 10             	add    $0x10,%esp
8010579a:	85 c0                	test   %eax,%eax
8010579c:	79 0a                	jns    801057a8 <sys_link+0x3e>
    return -1;
8010579e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057a3:	e9 63 01 00 00       	jmp    8010590b <sys_link+0x1a1>
  if((ip = namei(old)) == 0)
801057a8:	8b 45 d8             	mov    -0x28(%ebp),%eax
801057ab:	83 ec 0c             	sub    $0xc,%esp
801057ae:	50                   	push   %eax
801057af:	e8 c9 cd ff ff       	call   8010257d <namei>
801057b4:	83 c4 10             	add    $0x10,%esp
801057b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801057ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801057be:	75 0a                	jne    801057ca <sys_link+0x60>
    return -1;
801057c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057c5:	e9 41 01 00 00       	jmp    8010590b <sys_link+0x1a1>

  begin_trans();
801057ca:	e8 f8 db ff ff       	call   801033c7 <begin_trans>

  ilock(ip);
801057cf:	83 ec 0c             	sub    $0xc,%esp
801057d2:	ff 75 f4             	pushl  -0xc(%ebp)
801057d5:	e8 c0 c1 ff ff       	call   8010199a <ilock>
801057da:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
801057dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057e0:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801057e4:	66 83 f8 01          	cmp    $0x1,%ax
801057e8:	75 1d                	jne    80105807 <sys_link+0x9d>
    iunlockput(ip);
801057ea:	83 ec 0c             	sub    $0xc,%esp
801057ed:	ff 75 f4             	pushl  -0xc(%ebp)
801057f0:	e8 6b c4 ff ff       	call   80101c60 <iunlockput>
801057f5:	83 c4 10             	add    $0x10,%esp
    commit_trans();
801057f8:	e8 21 dc ff ff       	call   8010341e <commit_trans>
    return -1;
801057fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105802:	e9 04 01 00 00       	jmp    8010590b <sys_link+0x1a1>
  }

  ip->nlink++;
80105807:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010580a:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010580e:	83 c0 01             	add    $0x1,%eax
80105811:	89 c2                	mov    %eax,%edx
80105813:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105816:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
8010581a:	83 ec 0c             	sub    $0xc,%esp
8010581d:	ff 75 f4             	pushl  -0xc(%ebp)
80105820:	e8 95 bf ff ff       	call   801017ba <iupdate>
80105825:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105828:	83 ec 0c             	sub    $0xc,%esp
8010582b:	ff 75 f4             	pushl  -0xc(%ebp)
8010582e:	e8 c3 c2 ff ff       	call   80101af6 <iunlock>
80105833:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105836:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105839:	83 ec 08             	sub    $0x8,%esp
8010583c:	8d 55 e2             	lea    -0x1e(%ebp),%edx
8010583f:	52                   	push   %edx
80105840:	50                   	push   %eax
80105841:	e8 57 cd ff ff       	call   8010259d <nameiparent>
80105846:	83 c4 10             	add    $0x10,%esp
80105849:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010584c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105850:	74 71                	je     801058c3 <sys_link+0x159>
    goto bad;
  ilock(dp);
80105852:	83 ec 0c             	sub    $0xc,%esp
80105855:	ff 75 f0             	pushl  -0x10(%ebp)
80105858:	e8 3d c1 ff ff       	call   8010199a <ilock>
8010585d:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105860:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105863:	8b 10                	mov    (%eax),%edx
80105865:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105868:	8b 00                	mov    (%eax),%eax
8010586a:	39 c2                	cmp    %eax,%edx
8010586c:	75 1d                	jne    8010588b <sys_link+0x121>
8010586e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105871:	8b 40 04             	mov    0x4(%eax),%eax
80105874:	83 ec 04             	sub    $0x4,%esp
80105877:	50                   	push   %eax
80105878:	8d 45 e2             	lea    -0x1e(%ebp),%eax
8010587b:	50                   	push   %eax
8010587c:	ff 75 f0             	pushl  -0x10(%ebp)
8010587f:	e8 55 ca ff ff       	call   801022d9 <dirlink>
80105884:	83 c4 10             	add    $0x10,%esp
80105887:	85 c0                	test   %eax,%eax
80105889:	79 10                	jns    8010589b <sys_link+0x131>
    iunlockput(dp);
8010588b:	83 ec 0c             	sub    $0xc,%esp
8010588e:	ff 75 f0             	pushl  -0x10(%ebp)
80105891:	e8 ca c3 ff ff       	call   80101c60 <iunlockput>
80105896:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105899:	eb 29                	jmp    801058c4 <sys_link+0x15a>
  }
  iunlockput(dp);
8010589b:	83 ec 0c             	sub    $0xc,%esp
8010589e:	ff 75 f0             	pushl  -0x10(%ebp)
801058a1:	e8 ba c3 ff ff       	call   80101c60 <iunlockput>
801058a6:	83 c4 10             	add    $0x10,%esp
  iput(ip);
801058a9:	83 ec 0c             	sub    $0xc,%esp
801058ac:	ff 75 f4             	pushl  -0xc(%ebp)
801058af:	e8 b8 c2 ff ff       	call   80101b6c <iput>
801058b4:	83 c4 10             	add    $0x10,%esp

  commit_trans();
801058b7:	e8 62 db ff ff       	call   8010341e <commit_trans>

  return 0;
801058bc:	b8 00 00 00 00       	mov    $0x0,%eax
801058c1:	eb 48                	jmp    8010590b <sys_link+0x1a1>
    goto bad;
801058c3:	90                   	nop

bad:
  ilock(ip);
801058c4:	83 ec 0c             	sub    $0xc,%esp
801058c7:	ff 75 f4             	pushl  -0xc(%ebp)
801058ca:	e8 cb c0 ff ff       	call   8010199a <ilock>
801058cf:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
801058d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058d5:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801058d9:	83 e8 01             	sub    $0x1,%eax
801058dc:	89 c2                	mov    %eax,%edx
801058de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058e1:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801058e5:	83 ec 0c             	sub    $0xc,%esp
801058e8:	ff 75 f4             	pushl  -0xc(%ebp)
801058eb:	e8 ca be ff ff       	call   801017ba <iupdate>
801058f0:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
801058f3:	83 ec 0c             	sub    $0xc,%esp
801058f6:	ff 75 f4             	pushl  -0xc(%ebp)
801058f9:	e8 62 c3 ff ff       	call   80101c60 <iunlockput>
801058fe:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105901:	e8 18 db ff ff       	call   8010341e <commit_trans>
  return -1;
80105906:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010590b:	c9                   	leave  
8010590c:	c3                   	ret    

8010590d <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
8010590d:	f3 0f 1e fb          	endbr32 
80105911:	55                   	push   %ebp
80105912:	89 e5                	mov    %esp,%ebp
80105914:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105917:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
8010591e:	eb 40                	jmp    80105960 <isdirempty+0x53>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105920:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105923:	6a 10                	push   $0x10
80105925:	50                   	push   %eax
80105926:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105929:	50                   	push   %eax
8010592a:	ff 75 08             	pushl  0x8(%ebp)
8010592d:	e8 e7 c5 ff ff       	call   80101f19 <readi>
80105932:	83 c4 10             	add    $0x10,%esp
80105935:	83 f8 10             	cmp    $0x10,%eax
80105938:	74 0d                	je     80105947 <isdirempty+0x3a>
      panic("isdirempty: readi");
8010593a:	83 ec 0c             	sub    $0xc,%esp
8010593d:	68 7b 87 10 80       	push   $0x8010877b
80105942:	e8 50 ac ff ff       	call   80100597 <panic>
    if(de.inum != 0)
80105947:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
8010594b:	66 85 c0             	test   %ax,%ax
8010594e:	74 07                	je     80105957 <isdirempty+0x4a>
      return 0;
80105950:	b8 00 00 00 00       	mov    $0x0,%eax
80105955:	eb 1b                	jmp    80105972 <isdirempty+0x65>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105957:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010595a:	83 c0 10             	add    $0x10,%eax
8010595d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105960:	8b 45 08             	mov    0x8(%ebp),%eax
80105963:	8b 50 18             	mov    0x18(%eax),%edx
80105966:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105969:	39 c2                	cmp    %eax,%edx
8010596b:	77 b3                	ja     80105920 <isdirempty+0x13>
  }
  return 1;
8010596d:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105972:	c9                   	leave  
80105973:	c3                   	ret    

80105974 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105974:	f3 0f 1e fb          	endbr32 
80105978:	55                   	push   %ebp
80105979:	89 e5                	mov    %esp,%ebp
8010597b:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
8010597e:	83 ec 08             	sub    $0x8,%esp
80105981:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105984:	50                   	push   %eax
80105985:	6a 00                	push   $0x0
80105987:	e8 76 fa ff ff       	call   80105402 <argstr>
8010598c:	83 c4 10             	add    $0x10,%esp
8010598f:	85 c0                	test   %eax,%eax
80105991:	79 0a                	jns    8010599d <sys_unlink+0x29>
    return -1;
80105993:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105998:	e9 ba 01 00 00       	jmp    80105b57 <sys_unlink+0x1e3>
  if((dp = nameiparent(path, name)) == 0)
8010599d:	8b 45 cc             	mov    -0x34(%ebp),%eax
801059a0:	83 ec 08             	sub    $0x8,%esp
801059a3:	8d 55 d2             	lea    -0x2e(%ebp),%edx
801059a6:	52                   	push   %edx
801059a7:	50                   	push   %eax
801059a8:	e8 f0 cb ff ff       	call   8010259d <nameiparent>
801059ad:	83 c4 10             	add    $0x10,%esp
801059b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801059b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801059b7:	75 0a                	jne    801059c3 <sys_unlink+0x4f>
    return -1;
801059b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059be:	e9 94 01 00 00       	jmp    80105b57 <sys_unlink+0x1e3>

  begin_trans();
801059c3:	e8 ff d9 ff ff       	call   801033c7 <begin_trans>

  ilock(dp);
801059c8:	83 ec 0c             	sub    $0xc,%esp
801059cb:	ff 75 f4             	pushl  -0xc(%ebp)
801059ce:	e8 c7 bf ff ff       	call   8010199a <ilock>
801059d3:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801059d6:	83 ec 08             	sub    $0x8,%esp
801059d9:	68 8d 87 10 80       	push   $0x8010878d
801059de:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801059e1:	50                   	push   %eax
801059e2:	e8 15 c8 ff ff       	call   801021fc <namecmp>
801059e7:	83 c4 10             	add    $0x10,%esp
801059ea:	85 c0                	test   %eax,%eax
801059ec:	0f 84 49 01 00 00    	je     80105b3b <sys_unlink+0x1c7>
801059f2:	83 ec 08             	sub    $0x8,%esp
801059f5:	68 8f 87 10 80       	push   $0x8010878f
801059fa:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801059fd:	50                   	push   %eax
801059fe:	e8 f9 c7 ff ff       	call   801021fc <namecmp>
80105a03:	83 c4 10             	add    $0x10,%esp
80105a06:	85 c0                	test   %eax,%eax
80105a08:	0f 84 2d 01 00 00    	je     80105b3b <sys_unlink+0x1c7>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105a0e:	83 ec 04             	sub    $0x4,%esp
80105a11:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105a14:	50                   	push   %eax
80105a15:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105a18:	50                   	push   %eax
80105a19:	ff 75 f4             	pushl  -0xc(%ebp)
80105a1c:	e8 fa c7 ff ff       	call   8010221b <dirlookup>
80105a21:	83 c4 10             	add    $0x10,%esp
80105a24:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105a27:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105a2b:	0f 84 0d 01 00 00    	je     80105b3e <sys_unlink+0x1ca>
    goto bad;
  ilock(ip);
80105a31:	83 ec 0c             	sub    $0xc,%esp
80105a34:	ff 75 f0             	pushl  -0x10(%ebp)
80105a37:	e8 5e bf ff ff       	call   8010199a <ilock>
80105a3c:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a42:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a46:	66 85 c0             	test   %ax,%ax
80105a49:	7f 0d                	jg     80105a58 <sys_unlink+0xe4>
    panic("unlink: nlink < 1");
80105a4b:	83 ec 0c             	sub    $0xc,%esp
80105a4e:	68 92 87 10 80       	push   $0x80108792
80105a53:	e8 3f ab ff ff       	call   80100597 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105a58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a5b:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105a5f:	66 83 f8 01          	cmp    $0x1,%ax
80105a63:	75 25                	jne    80105a8a <sys_unlink+0x116>
80105a65:	83 ec 0c             	sub    $0xc,%esp
80105a68:	ff 75 f0             	pushl  -0x10(%ebp)
80105a6b:	e8 9d fe ff ff       	call   8010590d <isdirempty>
80105a70:	83 c4 10             	add    $0x10,%esp
80105a73:	85 c0                	test   %eax,%eax
80105a75:	75 13                	jne    80105a8a <sys_unlink+0x116>
    iunlockput(ip);
80105a77:	83 ec 0c             	sub    $0xc,%esp
80105a7a:	ff 75 f0             	pushl  -0x10(%ebp)
80105a7d:	e8 de c1 ff ff       	call   80101c60 <iunlockput>
80105a82:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105a85:	e9 b5 00 00 00       	jmp    80105b3f <sys_unlink+0x1cb>
  }

  memset(&de, 0, sizeof(de));
80105a8a:	83 ec 04             	sub    $0x4,%esp
80105a8d:	6a 10                	push   $0x10
80105a8f:	6a 00                	push   $0x0
80105a91:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105a94:	50                   	push   %eax
80105a95:	e8 8e f5 ff ff       	call   80105028 <memset>
80105a9a:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105a9d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105aa0:	6a 10                	push   $0x10
80105aa2:	50                   	push   %eax
80105aa3:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105aa6:	50                   	push   %eax
80105aa7:	ff 75 f4             	pushl  -0xc(%ebp)
80105aaa:	e8 c3 c5 ff ff       	call   80102072 <writei>
80105aaf:	83 c4 10             	add    $0x10,%esp
80105ab2:	83 f8 10             	cmp    $0x10,%eax
80105ab5:	74 0d                	je     80105ac4 <sys_unlink+0x150>
    panic("unlink: writei");
80105ab7:	83 ec 0c             	sub    $0xc,%esp
80105aba:	68 a4 87 10 80       	push   $0x801087a4
80105abf:	e8 d3 aa ff ff       	call   80100597 <panic>
  if(ip->type == T_DIR){
80105ac4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ac7:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105acb:	66 83 f8 01          	cmp    $0x1,%ax
80105acf:	75 21                	jne    80105af2 <sys_unlink+0x17e>
    dp->nlink--;
80105ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ad4:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105ad8:	83 e8 01             	sub    $0x1,%eax
80105adb:	89 c2                	mov    %eax,%edx
80105add:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae0:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105ae4:	83 ec 0c             	sub    $0xc,%esp
80105ae7:	ff 75 f4             	pushl  -0xc(%ebp)
80105aea:	e8 cb bc ff ff       	call   801017ba <iupdate>
80105aef:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105af2:	83 ec 0c             	sub    $0xc,%esp
80105af5:	ff 75 f4             	pushl  -0xc(%ebp)
80105af8:	e8 63 c1 ff ff       	call   80101c60 <iunlockput>
80105afd:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105b00:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b03:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105b07:	83 e8 01             	sub    $0x1,%eax
80105b0a:	89 c2                	mov    %eax,%edx
80105b0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b0f:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105b13:	83 ec 0c             	sub    $0xc,%esp
80105b16:	ff 75 f0             	pushl  -0x10(%ebp)
80105b19:	e8 9c bc ff ff       	call   801017ba <iupdate>
80105b1e:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105b21:	83 ec 0c             	sub    $0xc,%esp
80105b24:	ff 75 f0             	pushl  -0x10(%ebp)
80105b27:	e8 34 c1 ff ff       	call   80101c60 <iunlockput>
80105b2c:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105b2f:	e8 ea d8 ff ff       	call   8010341e <commit_trans>

  return 0;
80105b34:	b8 00 00 00 00       	mov    $0x0,%eax
80105b39:	eb 1c                	jmp    80105b57 <sys_unlink+0x1e3>
    goto bad;
80105b3b:	90                   	nop
80105b3c:	eb 01                	jmp    80105b3f <sys_unlink+0x1cb>
    goto bad;
80105b3e:	90                   	nop

bad:
  iunlockput(dp);
80105b3f:	83 ec 0c             	sub    $0xc,%esp
80105b42:	ff 75 f4             	pushl  -0xc(%ebp)
80105b45:	e8 16 c1 ff ff       	call   80101c60 <iunlockput>
80105b4a:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105b4d:	e8 cc d8 ff ff       	call   8010341e <commit_trans>
  return -1;
80105b52:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b57:	c9                   	leave  
80105b58:	c3                   	ret    

80105b59 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105b59:	f3 0f 1e fb          	endbr32 
80105b5d:	55                   	push   %ebp
80105b5e:	89 e5                	mov    %esp,%ebp
80105b60:	83 ec 38             	sub    $0x38,%esp
80105b63:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105b66:	8b 55 10             	mov    0x10(%ebp),%edx
80105b69:	8b 45 14             	mov    0x14(%ebp),%eax
80105b6c:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105b70:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105b74:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105b78:	83 ec 08             	sub    $0x8,%esp
80105b7b:	8d 45 de             	lea    -0x22(%ebp),%eax
80105b7e:	50                   	push   %eax
80105b7f:	ff 75 08             	pushl  0x8(%ebp)
80105b82:	e8 16 ca ff ff       	call   8010259d <nameiparent>
80105b87:	83 c4 10             	add    $0x10,%esp
80105b8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b8d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b91:	75 0a                	jne    80105b9d <create+0x44>
    return 0;
80105b93:	b8 00 00 00 00       	mov    $0x0,%eax
80105b98:	e9 90 01 00 00       	jmp    80105d2d <create+0x1d4>
  ilock(dp);
80105b9d:	83 ec 0c             	sub    $0xc,%esp
80105ba0:	ff 75 f4             	pushl  -0xc(%ebp)
80105ba3:	e8 f2 bd ff ff       	call   8010199a <ilock>
80105ba8:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105bab:	83 ec 04             	sub    $0x4,%esp
80105bae:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105bb1:	50                   	push   %eax
80105bb2:	8d 45 de             	lea    -0x22(%ebp),%eax
80105bb5:	50                   	push   %eax
80105bb6:	ff 75 f4             	pushl  -0xc(%ebp)
80105bb9:	e8 5d c6 ff ff       	call   8010221b <dirlookup>
80105bbe:	83 c4 10             	add    $0x10,%esp
80105bc1:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105bc4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105bc8:	74 50                	je     80105c1a <create+0xc1>
    iunlockput(dp);
80105bca:	83 ec 0c             	sub    $0xc,%esp
80105bcd:	ff 75 f4             	pushl  -0xc(%ebp)
80105bd0:	e8 8b c0 ff ff       	call   80101c60 <iunlockput>
80105bd5:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105bd8:	83 ec 0c             	sub    $0xc,%esp
80105bdb:	ff 75 f0             	pushl  -0x10(%ebp)
80105bde:	e8 b7 bd ff ff       	call   8010199a <ilock>
80105be3:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105be6:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105beb:	75 15                	jne    80105c02 <create+0xa9>
80105bed:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bf0:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105bf4:	66 83 f8 02          	cmp    $0x2,%ax
80105bf8:	75 08                	jne    80105c02 <create+0xa9>
      return ip;
80105bfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bfd:	e9 2b 01 00 00       	jmp    80105d2d <create+0x1d4>
    iunlockput(ip);
80105c02:	83 ec 0c             	sub    $0xc,%esp
80105c05:	ff 75 f0             	pushl  -0x10(%ebp)
80105c08:	e8 53 c0 ff ff       	call   80101c60 <iunlockput>
80105c0d:	83 c4 10             	add    $0x10,%esp
    return 0;
80105c10:	b8 00 00 00 00       	mov    $0x0,%eax
80105c15:	e9 13 01 00 00       	jmp    80105d2d <create+0x1d4>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105c1a:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c21:	8b 00                	mov    (%eax),%eax
80105c23:	83 ec 08             	sub    $0x8,%esp
80105c26:	52                   	push   %edx
80105c27:	50                   	push   %eax
80105c28:	e8 a8 ba ff ff       	call   801016d5 <ialloc>
80105c2d:	83 c4 10             	add    $0x10,%esp
80105c30:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c33:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c37:	75 0d                	jne    80105c46 <create+0xed>
    panic("create: ialloc");
80105c39:	83 ec 0c             	sub    $0xc,%esp
80105c3c:	68 b3 87 10 80       	push   $0x801087b3
80105c41:	e8 51 a9 ff ff       	call   80100597 <panic>

  ilock(ip);
80105c46:	83 ec 0c             	sub    $0xc,%esp
80105c49:	ff 75 f0             	pushl  -0x10(%ebp)
80105c4c:	e8 49 bd ff ff       	call   8010199a <ilock>
80105c51:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105c54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c57:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105c5b:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105c5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c62:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105c66:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105c6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c6d:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105c73:	83 ec 0c             	sub    $0xc,%esp
80105c76:	ff 75 f0             	pushl  -0x10(%ebp)
80105c79:	e8 3c bb ff ff       	call   801017ba <iupdate>
80105c7e:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105c81:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105c86:	75 6a                	jne    80105cf2 <create+0x199>
    dp->nlink++;  // for ".."
80105c88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c8b:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c8f:	83 c0 01             	add    $0x1,%eax
80105c92:	89 c2                	mov    %eax,%edx
80105c94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c97:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105c9b:	83 ec 0c             	sub    $0xc,%esp
80105c9e:	ff 75 f4             	pushl  -0xc(%ebp)
80105ca1:	e8 14 bb ff ff       	call   801017ba <iupdate>
80105ca6:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105ca9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cac:	8b 40 04             	mov    0x4(%eax),%eax
80105caf:	83 ec 04             	sub    $0x4,%esp
80105cb2:	50                   	push   %eax
80105cb3:	68 8d 87 10 80       	push   $0x8010878d
80105cb8:	ff 75 f0             	pushl  -0x10(%ebp)
80105cbb:	e8 19 c6 ff ff       	call   801022d9 <dirlink>
80105cc0:	83 c4 10             	add    $0x10,%esp
80105cc3:	85 c0                	test   %eax,%eax
80105cc5:	78 1e                	js     80105ce5 <create+0x18c>
80105cc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cca:	8b 40 04             	mov    0x4(%eax),%eax
80105ccd:	83 ec 04             	sub    $0x4,%esp
80105cd0:	50                   	push   %eax
80105cd1:	68 8f 87 10 80       	push   $0x8010878f
80105cd6:	ff 75 f0             	pushl  -0x10(%ebp)
80105cd9:	e8 fb c5 ff ff       	call   801022d9 <dirlink>
80105cde:	83 c4 10             	add    $0x10,%esp
80105ce1:	85 c0                	test   %eax,%eax
80105ce3:	79 0d                	jns    80105cf2 <create+0x199>
      panic("create dots");
80105ce5:	83 ec 0c             	sub    $0xc,%esp
80105ce8:	68 c2 87 10 80       	push   $0x801087c2
80105ced:	e8 a5 a8 ff ff       	call   80100597 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105cf2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cf5:	8b 40 04             	mov    0x4(%eax),%eax
80105cf8:	83 ec 04             	sub    $0x4,%esp
80105cfb:	50                   	push   %eax
80105cfc:	8d 45 de             	lea    -0x22(%ebp),%eax
80105cff:	50                   	push   %eax
80105d00:	ff 75 f4             	pushl  -0xc(%ebp)
80105d03:	e8 d1 c5 ff ff       	call   801022d9 <dirlink>
80105d08:	83 c4 10             	add    $0x10,%esp
80105d0b:	85 c0                	test   %eax,%eax
80105d0d:	79 0d                	jns    80105d1c <create+0x1c3>
    panic("create: dirlink");
80105d0f:	83 ec 0c             	sub    $0xc,%esp
80105d12:	68 ce 87 10 80       	push   $0x801087ce
80105d17:	e8 7b a8 ff ff       	call   80100597 <panic>

  iunlockput(dp);
80105d1c:	83 ec 0c             	sub    $0xc,%esp
80105d1f:	ff 75 f4             	pushl  -0xc(%ebp)
80105d22:	e8 39 bf ff ff       	call   80101c60 <iunlockput>
80105d27:	83 c4 10             	add    $0x10,%esp

  return ip;
80105d2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105d2d:	c9                   	leave  
80105d2e:	c3                   	ret    

80105d2f <sys_open>:

int
sys_open(void)
{
80105d2f:	f3 0f 1e fb          	endbr32 
80105d33:	55                   	push   %ebp
80105d34:	89 e5                	mov    %esp,%ebp
80105d36:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d39:	83 ec 08             	sub    $0x8,%esp
80105d3c:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105d3f:	50                   	push   %eax
80105d40:	6a 00                	push   $0x0
80105d42:	e8 bb f6 ff ff       	call   80105402 <argstr>
80105d47:	83 c4 10             	add    $0x10,%esp
80105d4a:	85 c0                	test   %eax,%eax
80105d4c:	78 15                	js     80105d63 <sys_open+0x34>
80105d4e:	83 ec 08             	sub    $0x8,%esp
80105d51:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d54:	50                   	push   %eax
80105d55:	6a 01                	push   $0x1
80105d57:	e8 19 f6 ff ff       	call   80105375 <argint>
80105d5c:	83 c4 10             	add    $0x10,%esp
80105d5f:	85 c0                	test   %eax,%eax
80105d61:	79 0a                	jns    80105d6d <sys_open+0x3e>
    return -1;
80105d63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d68:	e9 4d 01 00 00       	jmp    80105eba <sys_open+0x18b>
  if(omode & O_CREATE){
80105d6d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105d70:	25 00 02 00 00       	and    $0x200,%eax
80105d75:	85 c0                	test   %eax,%eax
80105d77:	74 2f                	je     80105da8 <sys_open+0x79>
    begin_trans();
80105d79:	e8 49 d6 ff ff       	call   801033c7 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105d7e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105d81:	6a 00                	push   $0x0
80105d83:	6a 00                	push   $0x0
80105d85:	6a 02                	push   $0x2
80105d87:	50                   	push   %eax
80105d88:	e8 cc fd ff ff       	call   80105b59 <create>
80105d8d:	83 c4 10             	add    $0x10,%esp
80105d90:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105d93:	e8 86 d6 ff ff       	call   8010341e <commit_trans>
    if(ip == 0)
80105d98:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d9c:	75 66                	jne    80105e04 <sys_open+0xd5>
      return -1;
80105d9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105da3:	e9 12 01 00 00       	jmp    80105eba <sys_open+0x18b>
  } else {
    if((ip = namei(path)) == 0)
80105da8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105dab:	83 ec 0c             	sub    $0xc,%esp
80105dae:	50                   	push   %eax
80105daf:	e8 c9 c7 ff ff       	call   8010257d <namei>
80105db4:	83 c4 10             	add    $0x10,%esp
80105db7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105dba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105dbe:	75 0a                	jne    80105dca <sys_open+0x9b>
      return -1;
80105dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dc5:	e9 f0 00 00 00       	jmp    80105eba <sys_open+0x18b>
    ilock(ip);
80105dca:	83 ec 0c             	sub    $0xc,%esp
80105dcd:	ff 75 f4             	pushl  -0xc(%ebp)
80105dd0:	e8 c5 bb ff ff       	call   8010199a <ilock>
80105dd5:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80105dd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ddb:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105ddf:	66 83 f8 01          	cmp    $0x1,%ax
80105de3:	75 1f                	jne    80105e04 <sys_open+0xd5>
80105de5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105de8:	85 c0                	test   %eax,%eax
80105dea:	74 18                	je     80105e04 <sys_open+0xd5>
      iunlockput(ip);
80105dec:	83 ec 0c             	sub    $0xc,%esp
80105def:	ff 75 f4             	pushl  -0xc(%ebp)
80105df2:	e8 69 be ff ff       	call   80101c60 <iunlockput>
80105df7:	83 c4 10             	add    $0x10,%esp
      return -1;
80105dfa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dff:	e9 b6 00 00 00       	jmp    80105eba <sys_open+0x18b>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e04:	e8 c2 b1 ff ff       	call   80100fcb <filealloc>
80105e09:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e0c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e10:	74 17                	je     80105e29 <sys_open+0xfa>
80105e12:	83 ec 0c             	sub    $0xc,%esp
80105e15:	ff 75 f0             	pushl  -0x10(%ebp)
80105e18:	e8 1c f7 ff ff       	call   80105539 <fdalloc>
80105e1d:	83 c4 10             	add    $0x10,%esp
80105e20:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105e23:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105e27:	79 29                	jns    80105e52 <sys_open+0x123>
    if(f)
80105e29:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e2d:	74 0e                	je     80105e3d <sys_open+0x10e>
      fileclose(f);
80105e2f:	83 ec 0c             	sub    $0xc,%esp
80105e32:	ff 75 f0             	pushl  -0x10(%ebp)
80105e35:	e8 57 b2 ff ff       	call   80101091 <fileclose>
80105e3a:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105e3d:	83 ec 0c             	sub    $0xc,%esp
80105e40:	ff 75 f4             	pushl  -0xc(%ebp)
80105e43:	e8 18 be ff ff       	call   80101c60 <iunlockput>
80105e48:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e50:	eb 68                	jmp    80105eba <sys_open+0x18b>
  }
  iunlock(ip);
80105e52:	83 ec 0c             	sub    $0xc,%esp
80105e55:	ff 75 f4             	pushl  -0xc(%ebp)
80105e58:	e8 99 bc ff ff       	call   80101af6 <iunlock>
80105e5d:	83 c4 10             	add    $0x10,%esp

  f->type = FD_INODE;
80105e60:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e63:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105e69:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e6f:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105e72:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e75:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105e7c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e7f:	83 e0 01             	and    $0x1,%eax
80105e82:	85 c0                	test   %eax,%eax
80105e84:	0f 94 c0             	sete   %al
80105e87:	89 c2                	mov    %eax,%edx
80105e89:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e8c:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e92:	83 e0 01             	and    $0x1,%eax
80105e95:	85 c0                	test   %eax,%eax
80105e97:	75 0a                	jne    80105ea3 <sys_open+0x174>
80105e99:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e9c:	83 e0 02             	and    $0x2,%eax
80105e9f:	85 c0                	test   %eax,%eax
80105ea1:	74 07                	je     80105eaa <sys_open+0x17b>
80105ea3:	b8 01 00 00 00       	mov    $0x1,%eax
80105ea8:	eb 05                	jmp    80105eaf <sys_open+0x180>
80105eaa:	b8 00 00 00 00       	mov    $0x0,%eax
80105eaf:	89 c2                	mov    %eax,%edx
80105eb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eb4:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105eb7:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105eba:	c9                   	leave  
80105ebb:	c3                   	ret    

80105ebc <sys_mkdir>:

int
sys_mkdir(void)
{
80105ebc:	f3 0f 1e fb          	endbr32 
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80105ec6:	e8 fc d4 ff ff       	call   801033c7 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105ecb:	83 ec 08             	sub    $0x8,%esp
80105ece:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ed1:	50                   	push   %eax
80105ed2:	6a 00                	push   $0x0
80105ed4:	e8 29 f5 ff ff       	call   80105402 <argstr>
80105ed9:	83 c4 10             	add    $0x10,%esp
80105edc:	85 c0                	test   %eax,%eax
80105ede:	78 1b                	js     80105efb <sys_mkdir+0x3f>
80105ee0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ee3:	6a 00                	push   $0x0
80105ee5:	6a 00                	push   $0x0
80105ee7:	6a 01                	push   $0x1
80105ee9:	50                   	push   %eax
80105eea:	e8 6a fc ff ff       	call   80105b59 <create>
80105eef:	83 c4 10             	add    $0x10,%esp
80105ef2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ef5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ef9:	75 0c                	jne    80105f07 <sys_mkdir+0x4b>
    commit_trans();
80105efb:	e8 1e d5 ff ff       	call   8010341e <commit_trans>
    return -1;
80105f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f05:	eb 18                	jmp    80105f1f <sys_mkdir+0x63>
  }
  iunlockput(ip);
80105f07:	83 ec 0c             	sub    $0xc,%esp
80105f0a:	ff 75 f4             	pushl  -0xc(%ebp)
80105f0d:	e8 4e bd ff ff       	call   80101c60 <iunlockput>
80105f12:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105f15:	e8 04 d5 ff ff       	call   8010341e <commit_trans>
  return 0;
80105f1a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105f1f:	c9                   	leave  
80105f20:	c3                   	ret    

80105f21 <sys_mknod>:

int
sys_mknod(void)
{
80105f21:	f3 0f 1e fb          	endbr32 
80105f25:	55                   	push   %ebp
80105f26:	89 e5                	mov    %esp,%ebp
80105f28:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80105f2b:	e8 97 d4 ff ff       	call   801033c7 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80105f30:	83 ec 08             	sub    $0x8,%esp
80105f33:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f36:	50                   	push   %eax
80105f37:	6a 00                	push   $0x0
80105f39:	e8 c4 f4 ff ff       	call   80105402 <argstr>
80105f3e:	83 c4 10             	add    $0x10,%esp
80105f41:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f44:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f48:	78 4f                	js     80105f99 <sys_mknod+0x78>
     argint(1, &major) < 0 ||
80105f4a:	83 ec 08             	sub    $0x8,%esp
80105f4d:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f50:	50                   	push   %eax
80105f51:	6a 01                	push   $0x1
80105f53:	e8 1d f4 ff ff       	call   80105375 <argint>
80105f58:	83 c4 10             	add    $0x10,%esp
  if((len=argstr(0, &path)) < 0 ||
80105f5b:	85 c0                	test   %eax,%eax
80105f5d:	78 3a                	js     80105f99 <sys_mknod+0x78>
     argint(2, &minor) < 0 ||
80105f5f:	83 ec 08             	sub    $0x8,%esp
80105f62:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f65:	50                   	push   %eax
80105f66:	6a 02                	push   $0x2
80105f68:	e8 08 f4 ff ff       	call   80105375 <argint>
80105f6d:	83 c4 10             	add    $0x10,%esp
     argint(1, &major) < 0 ||
80105f70:	85 c0                	test   %eax,%eax
80105f72:	78 25                	js     80105f99 <sys_mknod+0x78>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f77:	0f bf c8             	movswl %ax,%ecx
80105f7a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f7d:	0f bf d0             	movswl %ax,%edx
80105f80:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105f83:	51                   	push   %ecx
80105f84:	52                   	push   %edx
80105f85:	6a 03                	push   $0x3
80105f87:	50                   	push   %eax
80105f88:	e8 cc fb ff ff       	call   80105b59 <create>
80105f8d:	83 c4 10             	add    $0x10,%esp
80105f90:	89 45 f0             	mov    %eax,-0x10(%ebp)
     argint(2, &minor) < 0 ||
80105f93:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f97:	75 0c                	jne    80105fa5 <sys_mknod+0x84>
    commit_trans();
80105f99:	e8 80 d4 ff ff       	call   8010341e <commit_trans>
    return -1;
80105f9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fa3:	eb 18                	jmp    80105fbd <sys_mknod+0x9c>
  }
  iunlockput(ip);
80105fa5:	83 ec 0c             	sub    $0xc,%esp
80105fa8:	ff 75 f0             	pushl  -0x10(%ebp)
80105fab:	e8 b0 bc ff ff       	call   80101c60 <iunlockput>
80105fb0:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105fb3:	e8 66 d4 ff ff       	call   8010341e <commit_trans>
  return 0;
80105fb8:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105fbd:	c9                   	leave  
80105fbe:	c3                   	ret    

80105fbf <sys_chdir>:

int
sys_chdir(void)
{
80105fbf:	f3 0f 1e fb          	endbr32 
80105fc3:	55                   	push   %ebp
80105fc4:	89 e5                	mov    %esp,%ebp
80105fc6:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105fc9:	83 ec 08             	sub    $0x8,%esp
80105fcc:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105fcf:	50                   	push   %eax
80105fd0:	6a 00                	push   $0x0
80105fd2:	e8 2b f4 ff ff       	call   80105402 <argstr>
80105fd7:	83 c4 10             	add    $0x10,%esp
80105fda:	85 c0                	test   %eax,%eax
80105fdc:	78 18                	js     80105ff6 <sys_chdir+0x37>
80105fde:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fe1:	83 ec 0c             	sub    $0xc,%esp
80105fe4:	50                   	push   %eax
80105fe5:	e8 93 c5 ff ff       	call   8010257d <namei>
80105fea:	83 c4 10             	add    $0x10,%esp
80105fed:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ff0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ff4:	75 07                	jne    80105ffd <sys_chdir+0x3e>
    return -1;
80105ff6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ffb:	eb 64                	jmp    80106061 <sys_chdir+0xa2>
  ilock(ip);
80105ffd:	83 ec 0c             	sub    $0xc,%esp
80106000:	ff 75 f4             	pushl  -0xc(%ebp)
80106003:	e8 92 b9 ff ff       	call   8010199a <ilock>
80106008:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
8010600b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010600e:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106012:	66 83 f8 01          	cmp    $0x1,%ax
80106016:	74 15                	je     8010602d <sys_chdir+0x6e>
    iunlockput(ip);
80106018:	83 ec 0c             	sub    $0xc,%esp
8010601b:	ff 75 f4             	pushl  -0xc(%ebp)
8010601e:	e8 3d bc ff ff       	call   80101c60 <iunlockput>
80106023:	83 c4 10             	add    $0x10,%esp
    return -1;
80106026:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010602b:	eb 34                	jmp    80106061 <sys_chdir+0xa2>
  }
  iunlock(ip);
8010602d:	83 ec 0c             	sub    $0xc,%esp
80106030:	ff 75 f4             	pushl  -0xc(%ebp)
80106033:	e8 be ba ff ff       	call   80101af6 <iunlock>
80106038:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
8010603b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106041:	8b 40 68             	mov    0x68(%eax),%eax
80106044:	83 ec 0c             	sub    $0xc,%esp
80106047:	50                   	push   %eax
80106048:	e8 1f bb ff ff       	call   80101b6c <iput>
8010604d:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
80106050:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106056:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106059:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
8010605c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106061:	c9                   	leave  
80106062:	c3                   	ret    

80106063 <sys_exec>:

int
sys_exec(void)
{
80106063:	f3 0f 1e fb          	endbr32 
80106067:	55                   	push   %ebp
80106068:	89 e5                	mov    %esp,%ebp
8010606a:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106070:	83 ec 08             	sub    $0x8,%esp
80106073:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106076:	50                   	push   %eax
80106077:	6a 00                	push   $0x0
80106079:	e8 84 f3 ff ff       	call   80105402 <argstr>
8010607e:	83 c4 10             	add    $0x10,%esp
80106081:	85 c0                	test   %eax,%eax
80106083:	78 18                	js     8010609d <sys_exec+0x3a>
80106085:	83 ec 08             	sub    $0x8,%esp
80106088:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
8010608e:	50                   	push   %eax
8010608f:	6a 01                	push   $0x1
80106091:	e8 df f2 ff ff       	call   80105375 <argint>
80106096:	83 c4 10             	add    $0x10,%esp
80106099:	85 c0                	test   %eax,%eax
8010609b:	79 0a                	jns    801060a7 <sys_exec+0x44>
    return -1;
8010609d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060a2:	e9 c6 00 00 00       	jmp    8010616d <sys_exec+0x10a>
  }
  memset(argv, 0, sizeof(argv));
801060a7:	83 ec 04             	sub    $0x4,%esp
801060aa:	68 80 00 00 00       	push   $0x80
801060af:	6a 00                	push   $0x0
801060b1:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801060b7:	50                   	push   %eax
801060b8:	e8 6b ef ff ff       	call   80105028 <memset>
801060bd:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
801060c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801060c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060ca:	83 f8 1f             	cmp    $0x1f,%eax
801060cd:	76 0a                	jbe    801060d9 <sys_exec+0x76>
      return -1;
801060cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060d4:	e9 94 00 00 00       	jmp    8010616d <sys_exec+0x10a>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801060d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060dc:	c1 e0 02             	shl    $0x2,%eax
801060df:	89 c2                	mov    %eax,%edx
801060e1:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801060e7:	01 c2                	add    %eax,%edx
801060e9:	83 ec 08             	sub    $0x8,%esp
801060ec:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801060f2:	50                   	push   %eax
801060f3:	52                   	push   %edx
801060f4:	e8 d8 f1 ff ff       	call   801052d1 <fetchint>
801060f9:	83 c4 10             	add    $0x10,%esp
801060fc:	85 c0                	test   %eax,%eax
801060fe:	79 07                	jns    80106107 <sys_exec+0xa4>
      return -1;
80106100:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106105:	eb 66                	jmp    8010616d <sys_exec+0x10a>
    if(uarg == 0){
80106107:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010610d:	85 c0                	test   %eax,%eax
8010610f:	75 27                	jne    80106138 <sys_exec+0xd5>
      argv[i] = 0;
80106111:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106114:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
8010611b:	00 00 00 00 
      break;
8010611f:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106120:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106123:	83 ec 08             	sub    $0x8,%esp
80106126:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010612c:	52                   	push   %edx
8010612d:	50                   	push   %eax
8010612e:	e8 82 aa ff ff       	call   80100bb5 <exec>
80106133:	83 c4 10             	add    $0x10,%esp
80106136:	eb 35                	jmp    8010616d <sys_exec+0x10a>
    if(fetchstr(uarg, &argv[i]) < 0)
80106138:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010613e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106141:	c1 e2 02             	shl    $0x2,%edx
80106144:	01 c2                	add    %eax,%edx
80106146:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010614c:	83 ec 08             	sub    $0x8,%esp
8010614f:	52                   	push   %edx
80106150:	50                   	push   %eax
80106151:	e8 b9 f1 ff ff       	call   8010530f <fetchstr>
80106156:	83 c4 10             	add    $0x10,%esp
80106159:	85 c0                	test   %eax,%eax
8010615b:	79 07                	jns    80106164 <sys_exec+0x101>
      return -1;
8010615d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106162:	eb 09                	jmp    8010616d <sys_exec+0x10a>
  for(i=0;; i++){
80106164:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(i >= NELEM(argv))
80106168:	e9 5a ff ff ff       	jmp    801060c7 <sys_exec+0x64>
}
8010616d:	c9                   	leave  
8010616e:	c3                   	ret    

8010616f <sys_pipe>:

int
sys_pipe(void)
{
8010616f:	f3 0f 1e fb          	endbr32 
80106173:	55                   	push   %ebp
80106174:	89 e5                	mov    %esp,%ebp
80106176:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106179:	83 ec 04             	sub    $0x4,%esp
8010617c:	6a 08                	push   $0x8
8010617e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106181:	50                   	push   %eax
80106182:	6a 00                	push   $0x0
80106184:	e8 18 f2 ff ff       	call   801053a1 <argptr>
80106189:	83 c4 10             	add    $0x10,%esp
8010618c:	85 c0                	test   %eax,%eax
8010618e:	79 0a                	jns    8010619a <sys_pipe+0x2b>
    return -1;
80106190:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106195:	e9 af 00 00 00       	jmp    80106249 <sys_pipe+0xda>
  if(pipealloc(&rf, &wf) < 0)
8010619a:	83 ec 08             	sub    $0x8,%esp
8010619d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801061a0:	50                   	push   %eax
801061a1:	8d 45 e8             	lea    -0x18(%ebp),%eax
801061a4:	50                   	push   %eax
801061a5:	e8 33 dc ff ff       	call   80103ddd <pipealloc>
801061aa:	83 c4 10             	add    $0x10,%esp
801061ad:	85 c0                	test   %eax,%eax
801061af:	79 0a                	jns    801061bb <sys_pipe+0x4c>
    return -1;
801061b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061b6:	e9 8e 00 00 00       	jmp    80106249 <sys_pipe+0xda>
  fd0 = -1;
801061bb:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
801061c5:	83 ec 0c             	sub    $0xc,%esp
801061c8:	50                   	push   %eax
801061c9:	e8 6b f3 ff ff       	call   80105539 <fdalloc>
801061ce:	83 c4 10             	add    $0x10,%esp
801061d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061d8:	78 18                	js     801061f2 <sys_pipe+0x83>
801061da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801061dd:	83 ec 0c             	sub    $0xc,%esp
801061e0:	50                   	push   %eax
801061e1:	e8 53 f3 ff ff       	call   80105539 <fdalloc>
801061e6:	83 c4 10             	add    $0x10,%esp
801061e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
801061ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801061f0:	79 3f                	jns    80106231 <sys_pipe+0xc2>
    if(fd0 >= 0)
801061f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061f6:	78 14                	js     8010620c <sys_pipe+0x9d>
      proc->ofile[fd0] = 0;
801061f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106201:	83 c2 08             	add    $0x8,%edx
80106204:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010620b:	00 
    fileclose(rf);
8010620c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010620f:	83 ec 0c             	sub    $0xc,%esp
80106212:	50                   	push   %eax
80106213:	e8 79 ae ff ff       	call   80101091 <fileclose>
80106218:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
8010621b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010621e:	83 ec 0c             	sub    $0xc,%esp
80106221:	50                   	push   %eax
80106222:	e8 6a ae ff ff       	call   80101091 <fileclose>
80106227:	83 c4 10             	add    $0x10,%esp
    return -1;
8010622a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010622f:	eb 18                	jmp    80106249 <sys_pipe+0xda>
  }
  fd[0] = fd0;
80106231:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106234:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106237:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106239:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010623c:	8d 50 04             	lea    0x4(%eax),%edx
8010623f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106242:	89 02                	mov    %eax,(%edx)
  return 0;
80106244:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106249:	c9                   	leave  
8010624a:	c3                   	ret    

8010624b <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
8010624b:	f3 0f 1e fb          	endbr32 
8010624f:	55                   	push   %ebp
80106250:	89 e5                	mov    %esp,%ebp
80106252:	83 ec 08             	sub    $0x8,%esp
  return fork();
80106255:	e8 97 e2 ff ff       	call   801044f1 <fork>
}
8010625a:	c9                   	leave  
8010625b:	c3                   	ret    

8010625c <sys_exit>:

int
sys_exit(void)
{
8010625c:	f3 0f 1e fb          	endbr32 
80106260:	55                   	push   %ebp
80106261:	89 e5                	mov    %esp,%ebp
80106263:	83 ec 08             	sub    $0x8,%esp
  exit();
80106266:	e8 f7 e3 ff ff       	call   80104662 <exit>
  return 0;  // not reached
8010626b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106270:	c9                   	leave  
80106271:	c3                   	ret    

80106272 <sys_wait>:

int
sys_wait(void)
{
80106272:	f3 0f 1e fb          	endbr32 
80106276:	55                   	push   %ebp
80106277:	89 e5                	mov    %esp,%ebp
80106279:	83 ec 08             	sub    $0x8,%esp
  return wait();
8010627c:	e8 13 e5 ff ff       	call   80104794 <wait>
}
80106281:	c9                   	leave  
80106282:	c3                   	ret    

80106283 <sys_kill>:

int
sys_kill(void)
{
80106283:	f3 0f 1e fb          	endbr32 
80106287:	55                   	push   %ebp
80106288:	89 e5                	mov    %esp,%ebp
8010628a:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010628d:	83 ec 08             	sub    $0x8,%esp
80106290:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106293:	50                   	push   %eax
80106294:	6a 00                	push   $0x0
80106296:	e8 da f0 ff ff       	call   80105375 <argint>
8010629b:	83 c4 10             	add    $0x10,%esp
8010629e:	85 c0                	test   %eax,%eax
801062a0:	79 07                	jns    801062a9 <sys_kill+0x26>
    return -1;
801062a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062a7:	eb 0f                	jmp    801062b8 <sys_kill+0x35>
  return kill(pid);
801062a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062ac:	83 ec 0c             	sub    $0xc,%esp
801062af:	50                   	push   %eax
801062b0:	e8 13 e9 ff ff       	call   80104bc8 <kill>
801062b5:	83 c4 10             	add    $0x10,%esp
}
801062b8:	c9                   	leave  
801062b9:	c3                   	ret    

801062ba <sys_getpid>:

int
sys_getpid(void)
{
801062ba:	f3 0f 1e fb          	endbr32 
801062be:	55                   	push   %ebp
801062bf:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801062c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062c7:	8b 40 10             	mov    0x10(%eax),%eax
}
801062ca:	5d                   	pop    %ebp
801062cb:	c3                   	ret    

801062cc <sys_sbrk>:

int
sys_sbrk(void)
{
801062cc:	f3 0f 1e fb          	endbr32 
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801062d6:	83 ec 08             	sub    $0x8,%esp
801062d9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062dc:	50                   	push   %eax
801062dd:	6a 00                	push   $0x0
801062df:	e8 91 f0 ff ff       	call   80105375 <argint>
801062e4:	83 c4 10             	add    $0x10,%esp
801062e7:	85 c0                	test   %eax,%eax
801062e9:	79 07                	jns    801062f2 <sys_sbrk+0x26>
    return -1;
801062eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062f0:	eb 28                	jmp    8010631a <sys_sbrk+0x4e>
  addr = proc->sz;
801062f2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062f8:	8b 00                	mov    (%eax),%eax
801062fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
801062fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106300:	83 ec 0c             	sub    $0xc,%esp
80106303:	50                   	push   %eax
80106304:	e8 41 e1 ff ff       	call   8010444a <growproc>
80106309:	83 c4 10             	add    $0x10,%esp
8010630c:	85 c0                	test   %eax,%eax
8010630e:	79 07                	jns    80106317 <sys_sbrk+0x4b>
    return -1;
80106310:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106315:	eb 03                	jmp    8010631a <sys_sbrk+0x4e>
  return addr;
80106317:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010631a:	c9                   	leave  
8010631b:	c3                   	ret    

8010631c <sys_sleep>:

int
sys_sleep(void)
{
8010631c:	f3 0f 1e fb          	endbr32 
80106320:	55                   	push   %ebp
80106321:	89 e5                	mov    %esp,%ebp
80106323:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106326:	83 ec 08             	sub    $0x8,%esp
80106329:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010632c:	50                   	push   %eax
8010632d:	6a 00                	push   $0x0
8010632f:	e8 41 f0 ff ff       	call   80105375 <argint>
80106334:	83 c4 10             	add    $0x10,%esp
80106337:	85 c0                	test   %eax,%eax
80106339:	79 07                	jns    80106342 <sys_sleep+0x26>
    return -1;
8010633b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106340:	eb 77                	jmp    801063b9 <sys_sleep+0x9d>
  acquire(&tickslock);
80106342:	83 ec 0c             	sub    $0xc,%esp
80106345:	68 60 1e 11 80       	push   $0x80111e60
8010634a:	e8 5d ea ff ff       	call   80104dac <acquire>
8010634f:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106352:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80106357:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
8010635a:	eb 39                	jmp    80106395 <sys_sleep+0x79>
    if(proc->killed){
8010635c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106362:	8b 40 24             	mov    0x24(%eax),%eax
80106365:	85 c0                	test   %eax,%eax
80106367:	74 17                	je     80106380 <sys_sleep+0x64>
      release(&tickslock);
80106369:	83 ec 0c             	sub    $0xc,%esp
8010636c:	68 60 1e 11 80       	push   $0x80111e60
80106371:	e8 a1 ea ff ff       	call   80104e17 <release>
80106376:	83 c4 10             	add    $0x10,%esp
      return -1;
80106379:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010637e:	eb 39                	jmp    801063b9 <sys_sleep+0x9d>
    }
    sleep(&ticks, &tickslock);
80106380:	83 ec 08             	sub    $0x8,%esp
80106383:	68 60 1e 11 80       	push   $0x80111e60
80106388:	68 a0 26 11 80       	push   $0x801126a0
8010638d:	e8 07 e7 ff ff       	call   80104a99 <sleep>
80106392:	83 c4 10             	add    $0x10,%esp
  while(ticks - ticks0 < n){
80106395:	a1 a0 26 11 80       	mov    0x801126a0,%eax
8010639a:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010639d:	8b 55 f0             	mov    -0x10(%ebp),%edx
801063a0:	39 d0                	cmp    %edx,%eax
801063a2:	72 b8                	jb     8010635c <sys_sleep+0x40>
  }
  release(&tickslock);
801063a4:	83 ec 0c             	sub    $0xc,%esp
801063a7:	68 60 1e 11 80       	push   $0x80111e60
801063ac:	e8 66 ea ff ff       	call   80104e17 <release>
801063b1:	83 c4 10             	add    $0x10,%esp
  return 0;
801063b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801063b9:	c9                   	leave  
801063ba:	c3                   	ret    

801063bb <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801063bb:	f3 0f 1e fb          	endbr32 
801063bf:	55                   	push   %ebp
801063c0:	89 e5                	mov    %esp,%ebp
801063c2:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
801063c5:	83 ec 0c             	sub    $0xc,%esp
801063c8:	68 60 1e 11 80       	push   $0x80111e60
801063cd:	e8 da e9 ff ff       	call   80104dac <acquire>
801063d2:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
801063d5:	a1 a0 26 11 80       	mov    0x801126a0,%eax
801063da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801063dd:	83 ec 0c             	sub    $0xc,%esp
801063e0:	68 60 1e 11 80       	push   $0x80111e60
801063e5:	e8 2d ea ff ff       	call   80104e17 <release>
801063ea:	83 c4 10             	add    $0x10,%esp
  return xticks;
801063ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801063f0:	c9                   	leave  
801063f1:	c3                   	ret    

801063f2 <outb>:
{
801063f2:	55                   	push   %ebp
801063f3:	89 e5                	mov    %esp,%ebp
801063f5:	83 ec 08             	sub    $0x8,%esp
801063f8:	8b 45 08             	mov    0x8(%ebp),%eax
801063fb:	8b 55 0c             	mov    0xc(%ebp),%edx
801063fe:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80106402:	89 d0                	mov    %edx,%eax
80106404:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106407:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010640b:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010640f:	ee                   	out    %al,(%dx)
}
80106410:	90                   	nop
80106411:	c9                   	leave  
80106412:	c3                   	ret    

80106413 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80106413:	f3 0f 1e fb          	endbr32 
80106417:	55                   	push   %ebp
80106418:	89 e5                	mov    %esp,%ebp
8010641a:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
8010641d:	6a 34                	push   $0x34
8010641f:	6a 43                	push   $0x43
80106421:	e8 cc ff ff ff       	call   801063f2 <outb>
80106426:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106429:	68 9c 00 00 00       	push   $0x9c
8010642e:	6a 40                	push   $0x40
80106430:	e8 bd ff ff ff       	call   801063f2 <outb>
80106435:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106438:	6a 2e                	push   $0x2e
8010643a:	6a 40                	push   $0x40
8010643c:	e8 b1 ff ff ff       	call   801063f2 <outb>
80106441:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
80106444:	83 ec 0c             	sub    $0xc,%esp
80106447:	6a 00                	push   $0x0
80106449:	e8 71 d8 ff ff       	call   80103cbf <picenable>
8010644e:	83 c4 10             	add    $0x10,%esp
}
80106451:	90                   	nop
80106452:	c9                   	leave  
80106453:	c3                   	ret    

80106454 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106454:	1e                   	push   %ds
  pushl %es
80106455:	06                   	push   %es
  pushl %fs
80106456:	0f a0                	push   %fs
  pushl %gs
80106458:	0f a8                	push   %gs
  pushal
8010645a:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
8010645b:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010645f:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106461:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80106463:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80106467:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106469:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
8010646b:	54                   	push   %esp
  call trap
8010646c:	e8 df 01 00 00       	call   80106650 <trap>
  addl $4, %esp
80106471:	83 c4 04             	add    $0x4,%esp

80106474 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106474:	61                   	popa   
  popl %gs
80106475:	0f a9                	pop    %gs
  popl %fs
80106477:	0f a1                	pop    %fs
  popl %es
80106479:	07                   	pop    %es
  popl %ds
8010647a:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010647b:	83 c4 08             	add    $0x8,%esp
  iret
8010647e:	cf                   	iret   

8010647f <lidt>:
{
8010647f:	55                   	push   %ebp
80106480:	89 e5                	mov    %esp,%ebp
80106482:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80106485:	8b 45 0c             	mov    0xc(%ebp),%eax
80106488:	83 e8 01             	sub    $0x1,%eax
8010648b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010648f:	8b 45 08             	mov    0x8(%ebp),%eax
80106492:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106496:	8b 45 08             	mov    0x8(%ebp),%eax
80106499:	c1 e8 10             	shr    $0x10,%eax
8010649c:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801064a0:	8d 45 fa             	lea    -0x6(%ebp),%eax
801064a3:	0f 01 18             	lidtl  (%eax)
}
801064a6:	90                   	nop
801064a7:	c9                   	leave  
801064a8:	c3                   	ret    

801064a9 <rcr2>:

static inline uint
rcr2(void)
{
801064a9:	55                   	push   %ebp
801064aa:	89 e5                	mov    %esp,%ebp
801064ac:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801064af:	0f 20 d0             	mov    %cr2,%eax
801064b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801064b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801064b8:	c9                   	leave  
801064b9:	c3                   	ret    

801064ba <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801064ba:	f3 0f 1e fb          	endbr32 
801064be:	55                   	push   %ebp
801064bf:	89 e5                	mov    %esp,%ebp
801064c1:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
801064c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801064cb:	e9 c3 00 00 00       	jmp    80106593 <tvinit+0xd9>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801064d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064d3:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
801064da:	89 c2                	mov    %eax,%edx
801064dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064df:	66 89 14 c5 a0 1e 11 	mov    %dx,-0x7feee160(,%eax,8)
801064e6:	80 
801064e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064ea:	66 c7 04 c5 a2 1e 11 	movw   $0x8,-0x7feee15e(,%eax,8)
801064f1:	80 08 00 
801064f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064f7:	0f b6 14 c5 a4 1e 11 	movzbl -0x7feee15c(,%eax,8),%edx
801064fe:	80 
801064ff:	83 e2 e0             	and    $0xffffffe0,%edx
80106502:	88 14 c5 a4 1e 11 80 	mov    %dl,-0x7feee15c(,%eax,8)
80106509:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010650c:	0f b6 14 c5 a4 1e 11 	movzbl -0x7feee15c(,%eax,8),%edx
80106513:	80 
80106514:	83 e2 1f             	and    $0x1f,%edx
80106517:	88 14 c5 a4 1e 11 80 	mov    %dl,-0x7feee15c(,%eax,8)
8010651e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106521:	0f b6 14 c5 a5 1e 11 	movzbl -0x7feee15b(,%eax,8),%edx
80106528:	80 
80106529:	83 e2 f0             	and    $0xfffffff0,%edx
8010652c:	83 ca 0e             	or     $0xe,%edx
8010652f:	88 14 c5 a5 1e 11 80 	mov    %dl,-0x7feee15b(,%eax,8)
80106536:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106539:	0f b6 14 c5 a5 1e 11 	movzbl -0x7feee15b(,%eax,8),%edx
80106540:	80 
80106541:	83 e2 ef             	and    $0xffffffef,%edx
80106544:	88 14 c5 a5 1e 11 80 	mov    %dl,-0x7feee15b(,%eax,8)
8010654b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010654e:	0f b6 14 c5 a5 1e 11 	movzbl -0x7feee15b(,%eax,8),%edx
80106555:	80 
80106556:	83 e2 9f             	and    $0xffffff9f,%edx
80106559:	88 14 c5 a5 1e 11 80 	mov    %dl,-0x7feee15b(,%eax,8)
80106560:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106563:	0f b6 14 c5 a5 1e 11 	movzbl -0x7feee15b(,%eax,8),%edx
8010656a:	80 
8010656b:	83 ca 80             	or     $0xffffff80,%edx
8010656e:	88 14 c5 a5 1e 11 80 	mov    %dl,-0x7feee15b(,%eax,8)
80106575:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106578:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
8010657f:	c1 e8 10             	shr    $0x10,%eax
80106582:	89 c2                	mov    %eax,%edx
80106584:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106587:	66 89 14 c5 a6 1e 11 	mov    %dx,-0x7feee15a(,%eax,8)
8010658e:	80 
  for(i = 0; i < 256; i++)
8010658f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106593:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
8010659a:	0f 8e 30 ff ff ff    	jle    801064d0 <tvinit+0x16>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065a0:	a1 98 b1 10 80       	mov    0x8010b198,%eax
801065a5:	66 a3 a0 20 11 80    	mov    %ax,0x801120a0
801065ab:	66 c7 05 a2 20 11 80 	movw   $0x8,0x801120a2
801065b2:	08 00 
801065b4:	0f b6 05 a4 20 11 80 	movzbl 0x801120a4,%eax
801065bb:	83 e0 e0             	and    $0xffffffe0,%eax
801065be:	a2 a4 20 11 80       	mov    %al,0x801120a4
801065c3:	0f b6 05 a4 20 11 80 	movzbl 0x801120a4,%eax
801065ca:	83 e0 1f             	and    $0x1f,%eax
801065cd:	a2 a4 20 11 80       	mov    %al,0x801120a4
801065d2:	0f b6 05 a5 20 11 80 	movzbl 0x801120a5,%eax
801065d9:	83 c8 0f             	or     $0xf,%eax
801065dc:	a2 a5 20 11 80       	mov    %al,0x801120a5
801065e1:	0f b6 05 a5 20 11 80 	movzbl 0x801120a5,%eax
801065e8:	83 e0 ef             	and    $0xffffffef,%eax
801065eb:	a2 a5 20 11 80       	mov    %al,0x801120a5
801065f0:	0f b6 05 a5 20 11 80 	movzbl 0x801120a5,%eax
801065f7:	83 c8 60             	or     $0x60,%eax
801065fa:	a2 a5 20 11 80       	mov    %al,0x801120a5
801065ff:	0f b6 05 a5 20 11 80 	movzbl 0x801120a5,%eax
80106606:	83 c8 80             	or     $0xffffff80,%eax
80106609:	a2 a5 20 11 80       	mov    %al,0x801120a5
8010660e:	a1 98 b1 10 80       	mov    0x8010b198,%eax
80106613:	c1 e8 10             	shr    $0x10,%eax
80106616:	66 a3 a6 20 11 80    	mov    %ax,0x801120a6
  
  initlock(&tickslock, "time");
8010661c:	83 ec 08             	sub    $0x8,%esp
8010661f:	68 e0 87 10 80       	push   $0x801087e0
80106624:	68 60 1e 11 80       	push   $0x80111e60
80106629:	e8 58 e7 ff ff       	call   80104d86 <initlock>
8010662e:	83 c4 10             	add    $0x10,%esp
}
80106631:	90                   	nop
80106632:	c9                   	leave  
80106633:	c3                   	ret    

80106634 <idtinit>:

void
idtinit(void)
{
80106634:	f3 0f 1e fb          	endbr32 
80106638:	55                   	push   %ebp
80106639:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
8010663b:	68 00 08 00 00       	push   $0x800
80106640:	68 a0 1e 11 80       	push   $0x80111ea0
80106645:	e8 35 fe ff ff       	call   8010647f <lidt>
8010664a:	83 c4 08             	add    $0x8,%esp
}
8010664d:	90                   	nop
8010664e:	c9                   	leave  
8010664f:	c3                   	ret    

80106650 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106650:	f3 0f 1e fb          	endbr32 
80106654:	55                   	push   %ebp
80106655:	89 e5                	mov    %esp,%ebp
80106657:	57                   	push   %edi
80106658:	56                   	push   %esi
80106659:	53                   	push   %ebx
8010665a:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
8010665d:	8b 45 08             	mov    0x8(%ebp),%eax
80106660:	8b 40 30             	mov    0x30(%eax),%eax
80106663:	83 f8 40             	cmp    $0x40,%eax
80106666:	75 3e                	jne    801066a6 <trap+0x56>
    if(proc->killed)
80106668:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010666e:	8b 40 24             	mov    0x24(%eax),%eax
80106671:	85 c0                	test   %eax,%eax
80106673:	74 05                	je     8010667a <trap+0x2a>
      exit();
80106675:	e8 e8 df ff ff       	call   80104662 <exit>
    proc->tf = tf;
8010667a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106680:	8b 55 08             	mov    0x8(%ebp),%edx
80106683:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106686:	e8 ac ed ff ff       	call   80105437 <syscall>
    if(proc->killed)
8010668b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106691:	8b 40 24             	mov    0x24(%eax),%eax
80106694:	85 c0                	test   %eax,%eax
80106696:	0f 84 1d 02 00 00    	je     801068b9 <trap+0x269>
      exit();
8010669c:	e8 c1 df ff ff       	call   80104662 <exit>
    return;
801066a1:	e9 13 02 00 00       	jmp    801068b9 <trap+0x269>
  }

  switch(tf->trapno){
801066a6:	8b 45 08             	mov    0x8(%ebp),%eax
801066a9:	8b 40 30             	mov    0x30(%eax),%eax
801066ac:	83 e8 20             	sub    $0x20,%eax
801066af:	83 f8 1f             	cmp    $0x1f,%eax
801066b2:	0f 87 c1 00 00 00    	ja     80106779 <trap+0x129>
801066b8:	8b 04 85 88 88 10 80 	mov    -0x7fef7778(,%eax,4),%eax
801066bf:	3e ff e0             	notrack jmp *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
801066c2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801066c8:	0f b6 00             	movzbl (%eax),%eax
801066cb:	84 c0                	test   %al,%al
801066cd:	75 3d                	jne    8010670c <trap+0xbc>
      acquire(&tickslock);
801066cf:	83 ec 0c             	sub    $0xc,%esp
801066d2:	68 60 1e 11 80       	push   $0x80111e60
801066d7:	e8 d0 e6 ff ff       	call   80104dac <acquire>
801066dc:	83 c4 10             	add    $0x10,%esp
      ticks++;
801066df:	a1 a0 26 11 80       	mov    0x801126a0,%eax
801066e4:	83 c0 01             	add    $0x1,%eax
801066e7:	a3 a0 26 11 80       	mov    %eax,0x801126a0
      wakeup(&ticks);
801066ec:	83 ec 0c             	sub    $0xc,%esp
801066ef:	68 a0 26 11 80       	push   $0x801126a0
801066f4:	e8 94 e4 ff ff       	call   80104b8d <wakeup>
801066f9:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
801066fc:	83 ec 0c             	sub    $0xc,%esp
801066ff:	68 60 1e 11 80       	push   $0x80111e60
80106704:	e8 0e e7 ff ff       	call   80104e17 <release>
80106709:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
8010670c:	e8 6a c9 ff ff       	call   8010307b <lapiceoi>
    break;
80106711:	e9 1d 01 00 00       	jmp    80106833 <trap+0x1e3>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106716:	e8 4c c1 ff ff       	call   80102867 <ideintr>
    lapiceoi();
8010671b:	e8 5b c9 ff ff       	call   8010307b <lapiceoi>
    break;
80106720:	e9 0e 01 00 00       	jmp    80106833 <trap+0x1e3>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106725:	e8 5d c7 ff ff       	call   80102e87 <kbdintr>
    lapiceoi();
8010672a:	e8 4c c9 ff ff       	call   8010307b <lapiceoi>
    break;
8010672f:	e9 ff 00 00 00       	jmp    80106833 <trap+0x1e3>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106734:	e8 6f 03 00 00       	call   80106aa8 <uartintr>
    lapiceoi();
80106739:	e8 3d c9 ff ff       	call   8010307b <lapiceoi>
    break;
8010673e:	e9 f0 00 00 00       	jmp    80106833 <trap+0x1e3>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106743:	8b 45 08             	mov    0x8(%ebp),%eax
80106746:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106749:	8b 45 08             	mov    0x8(%ebp),%eax
8010674c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106750:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
80106753:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106759:	0f b6 00             	movzbl (%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010675c:	0f b6 c0             	movzbl %al,%eax
8010675f:	51                   	push   %ecx
80106760:	52                   	push   %edx
80106761:	50                   	push   %eax
80106762:	68 e8 87 10 80       	push   $0x801087e8
80106767:	e8 72 9c ff ff       	call   801003de <cprintf>
8010676c:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010676f:	e8 07 c9 ff ff       	call   8010307b <lapiceoi>
    break;
80106774:	e9 ba 00 00 00       	jmp    80106833 <trap+0x1e3>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106779:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010677f:	85 c0                	test   %eax,%eax
80106781:	74 11                	je     80106794 <trap+0x144>
80106783:	8b 45 08             	mov    0x8(%ebp),%eax
80106786:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
8010678a:	0f b7 c0             	movzwl %ax,%eax
8010678d:	83 e0 03             	and    $0x3,%eax
80106790:	85 c0                	test   %eax,%eax
80106792:	75 3f                	jne    801067d3 <trap+0x183>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106794:	e8 10 fd ff ff       	call   801064a9 <rcr2>
80106799:	8b 55 08             	mov    0x8(%ebp),%edx
8010679c:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
8010679f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801067a6:	0f b6 12             	movzbl (%edx),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801067a9:	0f b6 ca             	movzbl %dl,%ecx
801067ac:	8b 55 08             	mov    0x8(%ebp),%edx
801067af:	8b 52 30             	mov    0x30(%edx),%edx
801067b2:	83 ec 0c             	sub    $0xc,%esp
801067b5:	50                   	push   %eax
801067b6:	53                   	push   %ebx
801067b7:	51                   	push   %ecx
801067b8:	52                   	push   %edx
801067b9:	68 0c 88 10 80       	push   $0x8010880c
801067be:	e8 1b 9c ff ff       	call   801003de <cprintf>
801067c3:	83 c4 20             	add    $0x20,%esp
      panic("trap");
801067c6:	83 ec 0c             	sub    $0xc,%esp
801067c9:	68 3e 88 10 80       	push   $0x8010883e
801067ce:	e8 c4 9d ff ff       	call   80100597 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067d3:	e8 d1 fc ff ff       	call   801064a9 <rcr2>
801067d8:	89 c2                	mov    %eax,%edx
801067da:	8b 45 08             	mov    0x8(%ebp),%eax
801067dd:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801067e0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801067e6:	0f b6 00             	movzbl (%eax),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067e9:	0f b6 f0             	movzbl %al,%esi
801067ec:	8b 45 08             	mov    0x8(%ebp),%eax
801067ef:	8b 58 34             	mov    0x34(%eax),%ebx
801067f2:	8b 45 08             	mov    0x8(%ebp),%eax
801067f5:	8b 48 30             	mov    0x30(%eax),%ecx
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801067f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801067fe:	83 c0 6c             	add    $0x6c,%eax
80106801:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106804:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010680a:	8b 40 10             	mov    0x10(%eax),%eax
8010680d:	52                   	push   %edx
8010680e:	57                   	push   %edi
8010680f:	56                   	push   %esi
80106810:	53                   	push   %ebx
80106811:	51                   	push   %ecx
80106812:	ff 75 e4             	pushl  -0x1c(%ebp)
80106815:	50                   	push   %eax
80106816:	68 44 88 10 80       	push   $0x80108844
8010681b:	e8 be 9b ff ff       	call   801003de <cprintf>
80106820:	83 c4 20             	add    $0x20,%esp
            rcr2());
    proc->killed = 1;
80106823:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106829:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106830:	eb 01                	jmp    80106833 <trap+0x1e3>
    break;
80106832:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106833:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106839:	85 c0                	test   %eax,%eax
8010683b:	74 24                	je     80106861 <trap+0x211>
8010683d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106843:	8b 40 24             	mov    0x24(%eax),%eax
80106846:	85 c0                	test   %eax,%eax
80106848:	74 17                	je     80106861 <trap+0x211>
8010684a:	8b 45 08             	mov    0x8(%ebp),%eax
8010684d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106851:	0f b7 c0             	movzwl %ax,%eax
80106854:	83 e0 03             	and    $0x3,%eax
80106857:	83 f8 03             	cmp    $0x3,%eax
8010685a:	75 05                	jne    80106861 <trap+0x211>
    exit();
8010685c:	e8 01 de ff ff       	call   80104662 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106861:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106867:	85 c0                	test   %eax,%eax
80106869:	74 1e                	je     80106889 <trap+0x239>
8010686b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106871:	8b 40 0c             	mov    0xc(%eax),%eax
80106874:	83 f8 04             	cmp    $0x4,%eax
80106877:	75 10                	jne    80106889 <trap+0x239>
80106879:	8b 45 08             	mov    0x8(%ebp),%eax
8010687c:	8b 40 30             	mov    0x30(%eax),%eax
8010687f:	83 f8 20             	cmp    $0x20,%eax
80106882:	75 05                	jne    80106889 <trap+0x239>
    yield();
80106884:	e8 9c e1 ff ff       	call   80104a25 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106889:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010688f:	85 c0                	test   %eax,%eax
80106891:	74 27                	je     801068ba <trap+0x26a>
80106893:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106899:	8b 40 24             	mov    0x24(%eax),%eax
8010689c:	85 c0                	test   %eax,%eax
8010689e:	74 1a                	je     801068ba <trap+0x26a>
801068a0:	8b 45 08             	mov    0x8(%ebp),%eax
801068a3:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801068a7:	0f b7 c0             	movzwl %ax,%eax
801068aa:	83 e0 03             	and    $0x3,%eax
801068ad:	83 f8 03             	cmp    $0x3,%eax
801068b0:	75 08                	jne    801068ba <trap+0x26a>
    exit();
801068b2:	e8 ab dd ff ff       	call   80104662 <exit>
801068b7:	eb 01                	jmp    801068ba <trap+0x26a>
    return;
801068b9:	90                   	nop
}
801068ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068bd:	5b                   	pop    %ebx
801068be:	5e                   	pop    %esi
801068bf:	5f                   	pop    %edi
801068c0:	5d                   	pop    %ebp
801068c1:	c3                   	ret    

801068c2 <inb>:
{
801068c2:	55                   	push   %ebp
801068c3:	89 e5                	mov    %esp,%ebp
801068c5:	83 ec 14             	sub    $0x14,%esp
801068c8:	8b 45 08             	mov    0x8(%ebp),%eax
801068cb:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068cf:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801068d3:	89 c2                	mov    %eax,%edx
801068d5:	ec                   	in     (%dx),%al
801068d6:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801068d9:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801068dd:	c9                   	leave  
801068de:	c3                   	ret    

801068df <outb>:
{
801068df:	55                   	push   %ebp
801068e0:	89 e5                	mov    %esp,%ebp
801068e2:	83 ec 08             	sub    $0x8,%esp
801068e5:	8b 45 08             	mov    0x8(%ebp),%eax
801068e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801068eb:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801068ef:	89 d0                	mov    %edx,%eax
801068f1:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801068f4:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801068f8:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801068fc:	ee                   	out    %al,(%dx)
}
801068fd:	90                   	nop
801068fe:	c9                   	leave  
801068ff:	c3                   	ret    

80106900 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106900:	f3 0f 1e fb          	endbr32 
80106904:	55                   	push   %ebp
80106905:	89 e5                	mov    %esp,%ebp
80106907:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
8010690a:	6a 00                	push   $0x0
8010690c:	68 fa 03 00 00       	push   $0x3fa
80106911:	e8 c9 ff ff ff       	call   801068df <outb>
80106916:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106919:	68 80 00 00 00       	push   $0x80
8010691e:	68 fb 03 00 00       	push   $0x3fb
80106923:	e8 b7 ff ff ff       	call   801068df <outb>
80106928:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
8010692b:	6a 0c                	push   $0xc
8010692d:	68 f8 03 00 00       	push   $0x3f8
80106932:	e8 a8 ff ff ff       	call   801068df <outb>
80106937:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
8010693a:	6a 00                	push   $0x0
8010693c:	68 f9 03 00 00       	push   $0x3f9
80106941:	e8 99 ff ff ff       	call   801068df <outb>
80106946:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106949:	6a 03                	push   $0x3
8010694b:	68 fb 03 00 00       	push   $0x3fb
80106950:	e8 8a ff ff ff       	call   801068df <outb>
80106955:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106958:	6a 00                	push   $0x0
8010695a:	68 fc 03 00 00       	push   $0x3fc
8010695f:	e8 7b ff ff ff       	call   801068df <outb>
80106964:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106967:	6a 01                	push   $0x1
80106969:	68 f9 03 00 00       	push   $0x3f9
8010696e:	e8 6c ff ff ff       	call   801068df <outb>
80106973:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106976:	68 fd 03 00 00       	push   $0x3fd
8010697b:	e8 42 ff ff ff       	call   801068c2 <inb>
80106980:	83 c4 04             	add    $0x4,%esp
80106983:	3c ff                	cmp    $0xff,%al
80106985:	74 6e                	je     801069f5 <uartinit+0xf5>
    return;
  uart = 1;
80106987:	c7 05 4c b6 10 80 01 	movl   $0x1,0x8010b64c
8010698e:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106991:	68 fa 03 00 00       	push   $0x3fa
80106996:	e8 27 ff ff ff       	call   801068c2 <inb>
8010699b:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
8010699e:	68 f8 03 00 00       	push   $0x3f8
801069a3:	e8 1a ff ff ff       	call   801068c2 <inb>
801069a8:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
801069ab:	83 ec 0c             	sub    $0xc,%esp
801069ae:	6a 04                	push   $0x4
801069b0:	e8 0a d3 ff ff       	call   80103cbf <picenable>
801069b5:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
801069b8:	83 ec 08             	sub    $0x8,%esp
801069bb:	6a 00                	push   $0x0
801069bd:	6a 04                	push   $0x4
801069bf:	e8 59 c1 ff ff       	call   80102b1d <ioapicenable>
801069c4:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801069c7:	c7 45 f4 08 89 10 80 	movl   $0x80108908,-0xc(%ebp)
801069ce:	eb 19                	jmp    801069e9 <uartinit+0xe9>
    uartputc(*p);
801069d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069d3:	0f b6 00             	movzbl (%eax),%eax
801069d6:	0f be c0             	movsbl %al,%eax
801069d9:	83 ec 0c             	sub    $0xc,%esp
801069dc:	50                   	push   %eax
801069dd:	e8 16 00 00 00       	call   801069f8 <uartputc>
801069e2:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801069e5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801069e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069ec:	0f b6 00             	movzbl (%eax),%eax
801069ef:	84 c0                	test   %al,%al
801069f1:	75 dd                	jne    801069d0 <uartinit+0xd0>
801069f3:	eb 01                	jmp    801069f6 <uartinit+0xf6>
    return;
801069f5:	90                   	nop
}
801069f6:	c9                   	leave  
801069f7:	c3                   	ret    

801069f8 <uartputc>:

void
uartputc(int c)
{
801069f8:	f3 0f 1e fb          	endbr32 
801069fc:	55                   	push   %ebp
801069fd:	89 e5                	mov    %esp,%ebp
801069ff:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106a02:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106a07:	85 c0                	test   %eax,%eax
80106a09:	74 53                	je     80106a5e <uartputc+0x66>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106a0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106a12:	eb 11                	jmp    80106a25 <uartputc+0x2d>
    microdelay(10);
80106a14:	83 ec 0c             	sub    $0xc,%esp
80106a17:	6a 0a                	push   $0xa
80106a19:	e8 7c c6 ff ff       	call   8010309a <microdelay>
80106a1e:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106a21:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106a25:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106a29:	7f 1a                	jg     80106a45 <uartputc+0x4d>
80106a2b:	83 ec 0c             	sub    $0xc,%esp
80106a2e:	68 fd 03 00 00       	push   $0x3fd
80106a33:	e8 8a fe ff ff       	call   801068c2 <inb>
80106a38:	83 c4 10             	add    $0x10,%esp
80106a3b:	0f b6 c0             	movzbl %al,%eax
80106a3e:	83 e0 20             	and    $0x20,%eax
80106a41:	85 c0                	test   %eax,%eax
80106a43:	74 cf                	je     80106a14 <uartputc+0x1c>
  outb(COM1+0, c);
80106a45:	8b 45 08             	mov    0x8(%ebp),%eax
80106a48:	0f b6 c0             	movzbl %al,%eax
80106a4b:	83 ec 08             	sub    $0x8,%esp
80106a4e:	50                   	push   %eax
80106a4f:	68 f8 03 00 00       	push   $0x3f8
80106a54:	e8 86 fe ff ff       	call   801068df <outb>
80106a59:	83 c4 10             	add    $0x10,%esp
80106a5c:	eb 01                	jmp    80106a5f <uartputc+0x67>
    return;
80106a5e:	90                   	nop
}
80106a5f:	c9                   	leave  
80106a60:	c3                   	ret    

80106a61 <uartgetc>:

static int
uartgetc(void)
{
80106a61:	f3 0f 1e fb          	endbr32 
80106a65:	55                   	push   %ebp
80106a66:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106a68:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106a6d:	85 c0                	test   %eax,%eax
80106a6f:	75 07                	jne    80106a78 <uartgetc+0x17>
    return -1;
80106a71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a76:	eb 2e                	jmp    80106aa6 <uartgetc+0x45>
  if(!(inb(COM1+5) & 0x01))
80106a78:	68 fd 03 00 00       	push   $0x3fd
80106a7d:	e8 40 fe ff ff       	call   801068c2 <inb>
80106a82:	83 c4 04             	add    $0x4,%esp
80106a85:	0f b6 c0             	movzbl %al,%eax
80106a88:	83 e0 01             	and    $0x1,%eax
80106a8b:	85 c0                	test   %eax,%eax
80106a8d:	75 07                	jne    80106a96 <uartgetc+0x35>
    return -1;
80106a8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a94:	eb 10                	jmp    80106aa6 <uartgetc+0x45>
  return inb(COM1+0);
80106a96:	68 f8 03 00 00       	push   $0x3f8
80106a9b:	e8 22 fe ff ff       	call   801068c2 <inb>
80106aa0:	83 c4 04             	add    $0x4,%esp
80106aa3:	0f b6 c0             	movzbl %al,%eax
}
80106aa6:	c9                   	leave  
80106aa7:	c3                   	ret    

80106aa8 <uartintr>:

void
uartintr(void)
{
80106aa8:	f3 0f 1e fb          	endbr32 
80106aac:	55                   	push   %ebp
80106aad:	89 e5                	mov    %esp,%ebp
80106aaf:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106ab2:	83 ec 0c             	sub    $0xc,%esp
80106ab5:	68 61 6a 10 80       	push   $0x80106a61
80106aba:	e8 63 9d ff ff       	call   80100822 <consoleintr>
80106abf:	83 c4 10             	add    $0x10,%esp
}
80106ac2:	90                   	nop
80106ac3:	c9                   	leave  
80106ac4:	c3                   	ret    

80106ac5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106ac5:	6a 00                	push   $0x0
  pushl $0
80106ac7:	6a 00                	push   $0x0
  jmp alltraps
80106ac9:	e9 86 f9 ff ff       	jmp    80106454 <alltraps>

80106ace <vector1>:
.globl vector1
vector1:
  pushl $0
80106ace:	6a 00                	push   $0x0
  pushl $1
80106ad0:	6a 01                	push   $0x1
  jmp alltraps
80106ad2:	e9 7d f9 ff ff       	jmp    80106454 <alltraps>

80106ad7 <vector2>:
.globl vector2
vector2:
  pushl $0
80106ad7:	6a 00                	push   $0x0
  pushl $2
80106ad9:	6a 02                	push   $0x2
  jmp alltraps
80106adb:	e9 74 f9 ff ff       	jmp    80106454 <alltraps>

80106ae0 <vector3>:
.globl vector3
vector3:
  pushl $0
80106ae0:	6a 00                	push   $0x0
  pushl $3
80106ae2:	6a 03                	push   $0x3
  jmp alltraps
80106ae4:	e9 6b f9 ff ff       	jmp    80106454 <alltraps>

80106ae9 <vector4>:
.globl vector4
vector4:
  pushl $0
80106ae9:	6a 00                	push   $0x0
  pushl $4
80106aeb:	6a 04                	push   $0x4
  jmp alltraps
80106aed:	e9 62 f9 ff ff       	jmp    80106454 <alltraps>

80106af2 <vector5>:
.globl vector5
vector5:
  pushl $0
80106af2:	6a 00                	push   $0x0
  pushl $5
80106af4:	6a 05                	push   $0x5
  jmp alltraps
80106af6:	e9 59 f9 ff ff       	jmp    80106454 <alltraps>

80106afb <vector6>:
.globl vector6
vector6:
  pushl $0
80106afb:	6a 00                	push   $0x0
  pushl $6
80106afd:	6a 06                	push   $0x6
  jmp alltraps
80106aff:	e9 50 f9 ff ff       	jmp    80106454 <alltraps>

80106b04 <vector7>:
.globl vector7
vector7:
  pushl $0
80106b04:	6a 00                	push   $0x0
  pushl $7
80106b06:	6a 07                	push   $0x7
  jmp alltraps
80106b08:	e9 47 f9 ff ff       	jmp    80106454 <alltraps>

80106b0d <vector8>:
.globl vector8
vector8:
  pushl $8
80106b0d:	6a 08                	push   $0x8
  jmp alltraps
80106b0f:	e9 40 f9 ff ff       	jmp    80106454 <alltraps>

80106b14 <vector9>:
.globl vector9
vector9:
  pushl $0
80106b14:	6a 00                	push   $0x0
  pushl $9
80106b16:	6a 09                	push   $0x9
  jmp alltraps
80106b18:	e9 37 f9 ff ff       	jmp    80106454 <alltraps>

80106b1d <vector10>:
.globl vector10
vector10:
  pushl $10
80106b1d:	6a 0a                	push   $0xa
  jmp alltraps
80106b1f:	e9 30 f9 ff ff       	jmp    80106454 <alltraps>

80106b24 <vector11>:
.globl vector11
vector11:
  pushl $11
80106b24:	6a 0b                	push   $0xb
  jmp alltraps
80106b26:	e9 29 f9 ff ff       	jmp    80106454 <alltraps>

80106b2b <vector12>:
.globl vector12
vector12:
  pushl $12
80106b2b:	6a 0c                	push   $0xc
  jmp alltraps
80106b2d:	e9 22 f9 ff ff       	jmp    80106454 <alltraps>

80106b32 <vector13>:
.globl vector13
vector13:
  pushl $13
80106b32:	6a 0d                	push   $0xd
  jmp alltraps
80106b34:	e9 1b f9 ff ff       	jmp    80106454 <alltraps>

80106b39 <vector14>:
.globl vector14
vector14:
  pushl $14
80106b39:	6a 0e                	push   $0xe
  jmp alltraps
80106b3b:	e9 14 f9 ff ff       	jmp    80106454 <alltraps>

80106b40 <vector15>:
.globl vector15
vector15:
  pushl $0
80106b40:	6a 00                	push   $0x0
  pushl $15
80106b42:	6a 0f                	push   $0xf
  jmp alltraps
80106b44:	e9 0b f9 ff ff       	jmp    80106454 <alltraps>

80106b49 <vector16>:
.globl vector16
vector16:
  pushl $0
80106b49:	6a 00                	push   $0x0
  pushl $16
80106b4b:	6a 10                	push   $0x10
  jmp alltraps
80106b4d:	e9 02 f9 ff ff       	jmp    80106454 <alltraps>

80106b52 <vector17>:
.globl vector17
vector17:
  pushl $17
80106b52:	6a 11                	push   $0x11
  jmp alltraps
80106b54:	e9 fb f8 ff ff       	jmp    80106454 <alltraps>

80106b59 <vector18>:
.globl vector18
vector18:
  pushl $0
80106b59:	6a 00                	push   $0x0
  pushl $18
80106b5b:	6a 12                	push   $0x12
  jmp alltraps
80106b5d:	e9 f2 f8 ff ff       	jmp    80106454 <alltraps>

80106b62 <vector19>:
.globl vector19
vector19:
  pushl $0
80106b62:	6a 00                	push   $0x0
  pushl $19
80106b64:	6a 13                	push   $0x13
  jmp alltraps
80106b66:	e9 e9 f8 ff ff       	jmp    80106454 <alltraps>

80106b6b <vector20>:
.globl vector20
vector20:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $20
80106b6d:	6a 14                	push   $0x14
  jmp alltraps
80106b6f:	e9 e0 f8 ff ff       	jmp    80106454 <alltraps>

80106b74 <vector21>:
.globl vector21
vector21:
  pushl $0
80106b74:	6a 00                	push   $0x0
  pushl $21
80106b76:	6a 15                	push   $0x15
  jmp alltraps
80106b78:	e9 d7 f8 ff ff       	jmp    80106454 <alltraps>

80106b7d <vector22>:
.globl vector22
vector22:
  pushl $0
80106b7d:	6a 00                	push   $0x0
  pushl $22
80106b7f:	6a 16                	push   $0x16
  jmp alltraps
80106b81:	e9 ce f8 ff ff       	jmp    80106454 <alltraps>

80106b86 <vector23>:
.globl vector23
vector23:
  pushl $0
80106b86:	6a 00                	push   $0x0
  pushl $23
80106b88:	6a 17                	push   $0x17
  jmp alltraps
80106b8a:	e9 c5 f8 ff ff       	jmp    80106454 <alltraps>

80106b8f <vector24>:
.globl vector24
vector24:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $24
80106b91:	6a 18                	push   $0x18
  jmp alltraps
80106b93:	e9 bc f8 ff ff       	jmp    80106454 <alltraps>

80106b98 <vector25>:
.globl vector25
vector25:
  pushl $0
80106b98:	6a 00                	push   $0x0
  pushl $25
80106b9a:	6a 19                	push   $0x19
  jmp alltraps
80106b9c:	e9 b3 f8 ff ff       	jmp    80106454 <alltraps>

80106ba1 <vector26>:
.globl vector26
vector26:
  pushl $0
80106ba1:	6a 00                	push   $0x0
  pushl $26
80106ba3:	6a 1a                	push   $0x1a
  jmp alltraps
80106ba5:	e9 aa f8 ff ff       	jmp    80106454 <alltraps>

80106baa <vector27>:
.globl vector27
vector27:
  pushl $0
80106baa:	6a 00                	push   $0x0
  pushl $27
80106bac:	6a 1b                	push   $0x1b
  jmp alltraps
80106bae:	e9 a1 f8 ff ff       	jmp    80106454 <alltraps>

80106bb3 <vector28>:
.globl vector28
vector28:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $28
80106bb5:	6a 1c                	push   $0x1c
  jmp alltraps
80106bb7:	e9 98 f8 ff ff       	jmp    80106454 <alltraps>

80106bbc <vector29>:
.globl vector29
vector29:
  pushl $0
80106bbc:	6a 00                	push   $0x0
  pushl $29
80106bbe:	6a 1d                	push   $0x1d
  jmp alltraps
80106bc0:	e9 8f f8 ff ff       	jmp    80106454 <alltraps>

80106bc5 <vector30>:
.globl vector30
vector30:
  pushl $0
80106bc5:	6a 00                	push   $0x0
  pushl $30
80106bc7:	6a 1e                	push   $0x1e
  jmp alltraps
80106bc9:	e9 86 f8 ff ff       	jmp    80106454 <alltraps>

80106bce <vector31>:
.globl vector31
vector31:
  pushl $0
80106bce:	6a 00                	push   $0x0
  pushl $31
80106bd0:	6a 1f                	push   $0x1f
  jmp alltraps
80106bd2:	e9 7d f8 ff ff       	jmp    80106454 <alltraps>

80106bd7 <vector32>:
.globl vector32
vector32:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $32
80106bd9:	6a 20                	push   $0x20
  jmp alltraps
80106bdb:	e9 74 f8 ff ff       	jmp    80106454 <alltraps>

80106be0 <vector33>:
.globl vector33
vector33:
  pushl $0
80106be0:	6a 00                	push   $0x0
  pushl $33
80106be2:	6a 21                	push   $0x21
  jmp alltraps
80106be4:	e9 6b f8 ff ff       	jmp    80106454 <alltraps>

80106be9 <vector34>:
.globl vector34
vector34:
  pushl $0
80106be9:	6a 00                	push   $0x0
  pushl $34
80106beb:	6a 22                	push   $0x22
  jmp alltraps
80106bed:	e9 62 f8 ff ff       	jmp    80106454 <alltraps>

80106bf2 <vector35>:
.globl vector35
vector35:
  pushl $0
80106bf2:	6a 00                	push   $0x0
  pushl $35
80106bf4:	6a 23                	push   $0x23
  jmp alltraps
80106bf6:	e9 59 f8 ff ff       	jmp    80106454 <alltraps>

80106bfb <vector36>:
.globl vector36
vector36:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $36
80106bfd:	6a 24                	push   $0x24
  jmp alltraps
80106bff:	e9 50 f8 ff ff       	jmp    80106454 <alltraps>

80106c04 <vector37>:
.globl vector37
vector37:
  pushl $0
80106c04:	6a 00                	push   $0x0
  pushl $37
80106c06:	6a 25                	push   $0x25
  jmp alltraps
80106c08:	e9 47 f8 ff ff       	jmp    80106454 <alltraps>

80106c0d <vector38>:
.globl vector38
vector38:
  pushl $0
80106c0d:	6a 00                	push   $0x0
  pushl $38
80106c0f:	6a 26                	push   $0x26
  jmp alltraps
80106c11:	e9 3e f8 ff ff       	jmp    80106454 <alltraps>

80106c16 <vector39>:
.globl vector39
vector39:
  pushl $0
80106c16:	6a 00                	push   $0x0
  pushl $39
80106c18:	6a 27                	push   $0x27
  jmp alltraps
80106c1a:	e9 35 f8 ff ff       	jmp    80106454 <alltraps>

80106c1f <vector40>:
.globl vector40
vector40:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $40
80106c21:	6a 28                	push   $0x28
  jmp alltraps
80106c23:	e9 2c f8 ff ff       	jmp    80106454 <alltraps>

80106c28 <vector41>:
.globl vector41
vector41:
  pushl $0
80106c28:	6a 00                	push   $0x0
  pushl $41
80106c2a:	6a 29                	push   $0x29
  jmp alltraps
80106c2c:	e9 23 f8 ff ff       	jmp    80106454 <alltraps>

80106c31 <vector42>:
.globl vector42
vector42:
  pushl $0
80106c31:	6a 00                	push   $0x0
  pushl $42
80106c33:	6a 2a                	push   $0x2a
  jmp alltraps
80106c35:	e9 1a f8 ff ff       	jmp    80106454 <alltraps>

80106c3a <vector43>:
.globl vector43
vector43:
  pushl $0
80106c3a:	6a 00                	push   $0x0
  pushl $43
80106c3c:	6a 2b                	push   $0x2b
  jmp alltraps
80106c3e:	e9 11 f8 ff ff       	jmp    80106454 <alltraps>

80106c43 <vector44>:
.globl vector44
vector44:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $44
80106c45:	6a 2c                	push   $0x2c
  jmp alltraps
80106c47:	e9 08 f8 ff ff       	jmp    80106454 <alltraps>

80106c4c <vector45>:
.globl vector45
vector45:
  pushl $0
80106c4c:	6a 00                	push   $0x0
  pushl $45
80106c4e:	6a 2d                	push   $0x2d
  jmp alltraps
80106c50:	e9 ff f7 ff ff       	jmp    80106454 <alltraps>

80106c55 <vector46>:
.globl vector46
vector46:
  pushl $0
80106c55:	6a 00                	push   $0x0
  pushl $46
80106c57:	6a 2e                	push   $0x2e
  jmp alltraps
80106c59:	e9 f6 f7 ff ff       	jmp    80106454 <alltraps>

80106c5e <vector47>:
.globl vector47
vector47:
  pushl $0
80106c5e:	6a 00                	push   $0x0
  pushl $47
80106c60:	6a 2f                	push   $0x2f
  jmp alltraps
80106c62:	e9 ed f7 ff ff       	jmp    80106454 <alltraps>

80106c67 <vector48>:
.globl vector48
vector48:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $48
80106c69:	6a 30                	push   $0x30
  jmp alltraps
80106c6b:	e9 e4 f7 ff ff       	jmp    80106454 <alltraps>

80106c70 <vector49>:
.globl vector49
vector49:
  pushl $0
80106c70:	6a 00                	push   $0x0
  pushl $49
80106c72:	6a 31                	push   $0x31
  jmp alltraps
80106c74:	e9 db f7 ff ff       	jmp    80106454 <alltraps>

80106c79 <vector50>:
.globl vector50
vector50:
  pushl $0
80106c79:	6a 00                	push   $0x0
  pushl $50
80106c7b:	6a 32                	push   $0x32
  jmp alltraps
80106c7d:	e9 d2 f7 ff ff       	jmp    80106454 <alltraps>

80106c82 <vector51>:
.globl vector51
vector51:
  pushl $0
80106c82:	6a 00                	push   $0x0
  pushl $51
80106c84:	6a 33                	push   $0x33
  jmp alltraps
80106c86:	e9 c9 f7 ff ff       	jmp    80106454 <alltraps>

80106c8b <vector52>:
.globl vector52
vector52:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $52
80106c8d:	6a 34                	push   $0x34
  jmp alltraps
80106c8f:	e9 c0 f7 ff ff       	jmp    80106454 <alltraps>

80106c94 <vector53>:
.globl vector53
vector53:
  pushl $0
80106c94:	6a 00                	push   $0x0
  pushl $53
80106c96:	6a 35                	push   $0x35
  jmp alltraps
80106c98:	e9 b7 f7 ff ff       	jmp    80106454 <alltraps>

80106c9d <vector54>:
.globl vector54
vector54:
  pushl $0
80106c9d:	6a 00                	push   $0x0
  pushl $54
80106c9f:	6a 36                	push   $0x36
  jmp alltraps
80106ca1:	e9 ae f7 ff ff       	jmp    80106454 <alltraps>

80106ca6 <vector55>:
.globl vector55
vector55:
  pushl $0
80106ca6:	6a 00                	push   $0x0
  pushl $55
80106ca8:	6a 37                	push   $0x37
  jmp alltraps
80106caa:	e9 a5 f7 ff ff       	jmp    80106454 <alltraps>

80106caf <vector56>:
.globl vector56
vector56:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $56
80106cb1:	6a 38                	push   $0x38
  jmp alltraps
80106cb3:	e9 9c f7 ff ff       	jmp    80106454 <alltraps>

80106cb8 <vector57>:
.globl vector57
vector57:
  pushl $0
80106cb8:	6a 00                	push   $0x0
  pushl $57
80106cba:	6a 39                	push   $0x39
  jmp alltraps
80106cbc:	e9 93 f7 ff ff       	jmp    80106454 <alltraps>

80106cc1 <vector58>:
.globl vector58
vector58:
  pushl $0
80106cc1:	6a 00                	push   $0x0
  pushl $58
80106cc3:	6a 3a                	push   $0x3a
  jmp alltraps
80106cc5:	e9 8a f7 ff ff       	jmp    80106454 <alltraps>

80106cca <vector59>:
.globl vector59
vector59:
  pushl $0
80106cca:	6a 00                	push   $0x0
  pushl $59
80106ccc:	6a 3b                	push   $0x3b
  jmp alltraps
80106cce:	e9 81 f7 ff ff       	jmp    80106454 <alltraps>

80106cd3 <vector60>:
.globl vector60
vector60:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $60
80106cd5:	6a 3c                	push   $0x3c
  jmp alltraps
80106cd7:	e9 78 f7 ff ff       	jmp    80106454 <alltraps>

80106cdc <vector61>:
.globl vector61
vector61:
  pushl $0
80106cdc:	6a 00                	push   $0x0
  pushl $61
80106cde:	6a 3d                	push   $0x3d
  jmp alltraps
80106ce0:	e9 6f f7 ff ff       	jmp    80106454 <alltraps>

80106ce5 <vector62>:
.globl vector62
vector62:
  pushl $0
80106ce5:	6a 00                	push   $0x0
  pushl $62
80106ce7:	6a 3e                	push   $0x3e
  jmp alltraps
80106ce9:	e9 66 f7 ff ff       	jmp    80106454 <alltraps>

80106cee <vector63>:
.globl vector63
vector63:
  pushl $0
80106cee:	6a 00                	push   $0x0
  pushl $63
80106cf0:	6a 3f                	push   $0x3f
  jmp alltraps
80106cf2:	e9 5d f7 ff ff       	jmp    80106454 <alltraps>

80106cf7 <vector64>:
.globl vector64
vector64:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $64
80106cf9:	6a 40                	push   $0x40
  jmp alltraps
80106cfb:	e9 54 f7 ff ff       	jmp    80106454 <alltraps>

80106d00 <vector65>:
.globl vector65
vector65:
  pushl $0
80106d00:	6a 00                	push   $0x0
  pushl $65
80106d02:	6a 41                	push   $0x41
  jmp alltraps
80106d04:	e9 4b f7 ff ff       	jmp    80106454 <alltraps>

80106d09 <vector66>:
.globl vector66
vector66:
  pushl $0
80106d09:	6a 00                	push   $0x0
  pushl $66
80106d0b:	6a 42                	push   $0x42
  jmp alltraps
80106d0d:	e9 42 f7 ff ff       	jmp    80106454 <alltraps>

80106d12 <vector67>:
.globl vector67
vector67:
  pushl $0
80106d12:	6a 00                	push   $0x0
  pushl $67
80106d14:	6a 43                	push   $0x43
  jmp alltraps
80106d16:	e9 39 f7 ff ff       	jmp    80106454 <alltraps>

80106d1b <vector68>:
.globl vector68
vector68:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $68
80106d1d:	6a 44                	push   $0x44
  jmp alltraps
80106d1f:	e9 30 f7 ff ff       	jmp    80106454 <alltraps>

80106d24 <vector69>:
.globl vector69
vector69:
  pushl $0
80106d24:	6a 00                	push   $0x0
  pushl $69
80106d26:	6a 45                	push   $0x45
  jmp alltraps
80106d28:	e9 27 f7 ff ff       	jmp    80106454 <alltraps>

80106d2d <vector70>:
.globl vector70
vector70:
  pushl $0
80106d2d:	6a 00                	push   $0x0
  pushl $70
80106d2f:	6a 46                	push   $0x46
  jmp alltraps
80106d31:	e9 1e f7 ff ff       	jmp    80106454 <alltraps>

80106d36 <vector71>:
.globl vector71
vector71:
  pushl $0
80106d36:	6a 00                	push   $0x0
  pushl $71
80106d38:	6a 47                	push   $0x47
  jmp alltraps
80106d3a:	e9 15 f7 ff ff       	jmp    80106454 <alltraps>

80106d3f <vector72>:
.globl vector72
vector72:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $72
80106d41:	6a 48                	push   $0x48
  jmp alltraps
80106d43:	e9 0c f7 ff ff       	jmp    80106454 <alltraps>

80106d48 <vector73>:
.globl vector73
vector73:
  pushl $0
80106d48:	6a 00                	push   $0x0
  pushl $73
80106d4a:	6a 49                	push   $0x49
  jmp alltraps
80106d4c:	e9 03 f7 ff ff       	jmp    80106454 <alltraps>

80106d51 <vector74>:
.globl vector74
vector74:
  pushl $0
80106d51:	6a 00                	push   $0x0
  pushl $74
80106d53:	6a 4a                	push   $0x4a
  jmp alltraps
80106d55:	e9 fa f6 ff ff       	jmp    80106454 <alltraps>

80106d5a <vector75>:
.globl vector75
vector75:
  pushl $0
80106d5a:	6a 00                	push   $0x0
  pushl $75
80106d5c:	6a 4b                	push   $0x4b
  jmp alltraps
80106d5e:	e9 f1 f6 ff ff       	jmp    80106454 <alltraps>

80106d63 <vector76>:
.globl vector76
vector76:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $76
80106d65:	6a 4c                	push   $0x4c
  jmp alltraps
80106d67:	e9 e8 f6 ff ff       	jmp    80106454 <alltraps>

80106d6c <vector77>:
.globl vector77
vector77:
  pushl $0
80106d6c:	6a 00                	push   $0x0
  pushl $77
80106d6e:	6a 4d                	push   $0x4d
  jmp alltraps
80106d70:	e9 df f6 ff ff       	jmp    80106454 <alltraps>

80106d75 <vector78>:
.globl vector78
vector78:
  pushl $0
80106d75:	6a 00                	push   $0x0
  pushl $78
80106d77:	6a 4e                	push   $0x4e
  jmp alltraps
80106d79:	e9 d6 f6 ff ff       	jmp    80106454 <alltraps>

80106d7e <vector79>:
.globl vector79
vector79:
  pushl $0
80106d7e:	6a 00                	push   $0x0
  pushl $79
80106d80:	6a 4f                	push   $0x4f
  jmp alltraps
80106d82:	e9 cd f6 ff ff       	jmp    80106454 <alltraps>

80106d87 <vector80>:
.globl vector80
vector80:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $80
80106d89:	6a 50                	push   $0x50
  jmp alltraps
80106d8b:	e9 c4 f6 ff ff       	jmp    80106454 <alltraps>

80106d90 <vector81>:
.globl vector81
vector81:
  pushl $0
80106d90:	6a 00                	push   $0x0
  pushl $81
80106d92:	6a 51                	push   $0x51
  jmp alltraps
80106d94:	e9 bb f6 ff ff       	jmp    80106454 <alltraps>

80106d99 <vector82>:
.globl vector82
vector82:
  pushl $0
80106d99:	6a 00                	push   $0x0
  pushl $82
80106d9b:	6a 52                	push   $0x52
  jmp alltraps
80106d9d:	e9 b2 f6 ff ff       	jmp    80106454 <alltraps>

80106da2 <vector83>:
.globl vector83
vector83:
  pushl $0
80106da2:	6a 00                	push   $0x0
  pushl $83
80106da4:	6a 53                	push   $0x53
  jmp alltraps
80106da6:	e9 a9 f6 ff ff       	jmp    80106454 <alltraps>

80106dab <vector84>:
.globl vector84
vector84:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $84
80106dad:	6a 54                	push   $0x54
  jmp alltraps
80106daf:	e9 a0 f6 ff ff       	jmp    80106454 <alltraps>

80106db4 <vector85>:
.globl vector85
vector85:
  pushl $0
80106db4:	6a 00                	push   $0x0
  pushl $85
80106db6:	6a 55                	push   $0x55
  jmp alltraps
80106db8:	e9 97 f6 ff ff       	jmp    80106454 <alltraps>

80106dbd <vector86>:
.globl vector86
vector86:
  pushl $0
80106dbd:	6a 00                	push   $0x0
  pushl $86
80106dbf:	6a 56                	push   $0x56
  jmp alltraps
80106dc1:	e9 8e f6 ff ff       	jmp    80106454 <alltraps>

80106dc6 <vector87>:
.globl vector87
vector87:
  pushl $0
80106dc6:	6a 00                	push   $0x0
  pushl $87
80106dc8:	6a 57                	push   $0x57
  jmp alltraps
80106dca:	e9 85 f6 ff ff       	jmp    80106454 <alltraps>

80106dcf <vector88>:
.globl vector88
vector88:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $88
80106dd1:	6a 58                	push   $0x58
  jmp alltraps
80106dd3:	e9 7c f6 ff ff       	jmp    80106454 <alltraps>

80106dd8 <vector89>:
.globl vector89
vector89:
  pushl $0
80106dd8:	6a 00                	push   $0x0
  pushl $89
80106dda:	6a 59                	push   $0x59
  jmp alltraps
80106ddc:	e9 73 f6 ff ff       	jmp    80106454 <alltraps>

80106de1 <vector90>:
.globl vector90
vector90:
  pushl $0
80106de1:	6a 00                	push   $0x0
  pushl $90
80106de3:	6a 5a                	push   $0x5a
  jmp alltraps
80106de5:	e9 6a f6 ff ff       	jmp    80106454 <alltraps>

80106dea <vector91>:
.globl vector91
vector91:
  pushl $0
80106dea:	6a 00                	push   $0x0
  pushl $91
80106dec:	6a 5b                	push   $0x5b
  jmp alltraps
80106dee:	e9 61 f6 ff ff       	jmp    80106454 <alltraps>

80106df3 <vector92>:
.globl vector92
vector92:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $92
80106df5:	6a 5c                	push   $0x5c
  jmp alltraps
80106df7:	e9 58 f6 ff ff       	jmp    80106454 <alltraps>

80106dfc <vector93>:
.globl vector93
vector93:
  pushl $0
80106dfc:	6a 00                	push   $0x0
  pushl $93
80106dfe:	6a 5d                	push   $0x5d
  jmp alltraps
80106e00:	e9 4f f6 ff ff       	jmp    80106454 <alltraps>

80106e05 <vector94>:
.globl vector94
vector94:
  pushl $0
80106e05:	6a 00                	push   $0x0
  pushl $94
80106e07:	6a 5e                	push   $0x5e
  jmp alltraps
80106e09:	e9 46 f6 ff ff       	jmp    80106454 <alltraps>

80106e0e <vector95>:
.globl vector95
vector95:
  pushl $0
80106e0e:	6a 00                	push   $0x0
  pushl $95
80106e10:	6a 5f                	push   $0x5f
  jmp alltraps
80106e12:	e9 3d f6 ff ff       	jmp    80106454 <alltraps>

80106e17 <vector96>:
.globl vector96
vector96:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $96
80106e19:	6a 60                	push   $0x60
  jmp alltraps
80106e1b:	e9 34 f6 ff ff       	jmp    80106454 <alltraps>

80106e20 <vector97>:
.globl vector97
vector97:
  pushl $0
80106e20:	6a 00                	push   $0x0
  pushl $97
80106e22:	6a 61                	push   $0x61
  jmp alltraps
80106e24:	e9 2b f6 ff ff       	jmp    80106454 <alltraps>

80106e29 <vector98>:
.globl vector98
vector98:
  pushl $0
80106e29:	6a 00                	push   $0x0
  pushl $98
80106e2b:	6a 62                	push   $0x62
  jmp alltraps
80106e2d:	e9 22 f6 ff ff       	jmp    80106454 <alltraps>

80106e32 <vector99>:
.globl vector99
vector99:
  pushl $0
80106e32:	6a 00                	push   $0x0
  pushl $99
80106e34:	6a 63                	push   $0x63
  jmp alltraps
80106e36:	e9 19 f6 ff ff       	jmp    80106454 <alltraps>

80106e3b <vector100>:
.globl vector100
vector100:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $100
80106e3d:	6a 64                	push   $0x64
  jmp alltraps
80106e3f:	e9 10 f6 ff ff       	jmp    80106454 <alltraps>

80106e44 <vector101>:
.globl vector101
vector101:
  pushl $0
80106e44:	6a 00                	push   $0x0
  pushl $101
80106e46:	6a 65                	push   $0x65
  jmp alltraps
80106e48:	e9 07 f6 ff ff       	jmp    80106454 <alltraps>

80106e4d <vector102>:
.globl vector102
vector102:
  pushl $0
80106e4d:	6a 00                	push   $0x0
  pushl $102
80106e4f:	6a 66                	push   $0x66
  jmp alltraps
80106e51:	e9 fe f5 ff ff       	jmp    80106454 <alltraps>

80106e56 <vector103>:
.globl vector103
vector103:
  pushl $0
80106e56:	6a 00                	push   $0x0
  pushl $103
80106e58:	6a 67                	push   $0x67
  jmp alltraps
80106e5a:	e9 f5 f5 ff ff       	jmp    80106454 <alltraps>

80106e5f <vector104>:
.globl vector104
vector104:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $104
80106e61:	6a 68                	push   $0x68
  jmp alltraps
80106e63:	e9 ec f5 ff ff       	jmp    80106454 <alltraps>

80106e68 <vector105>:
.globl vector105
vector105:
  pushl $0
80106e68:	6a 00                	push   $0x0
  pushl $105
80106e6a:	6a 69                	push   $0x69
  jmp alltraps
80106e6c:	e9 e3 f5 ff ff       	jmp    80106454 <alltraps>

80106e71 <vector106>:
.globl vector106
vector106:
  pushl $0
80106e71:	6a 00                	push   $0x0
  pushl $106
80106e73:	6a 6a                	push   $0x6a
  jmp alltraps
80106e75:	e9 da f5 ff ff       	jmp    80106454 <alltraps>

80106e7a <vector107>:
.globl vector107
vector107:
  pushl $0
80106e7a:	6a 00                	push   $0x0
  pushl $107
80106e7c:	6a 6b                	push   $0x6b
  jmp alltraps
80106e7e:	e9 d1 f5 ff ff       	jmp    80106454 <alltraps>

80106e83 <vector108>:
.globl vector108
vector108:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $108
80106e85:	6a 6c                	push   $0x6c
  jmp alltraps
80106e87:	e9 c8 f5 ff ff       	jmp    80106454 <alltraps>

80106e8c <vector109>:
.globl vector109
vector109:
  pushl $0
80106e8c:	6a 00                	push   $0x0
  pushl $109
80106e8e:	6a 6d                	push   $0x6d
  jmp alltraps
80106e90:	e9 bf f5 ff ff       	jmp    80106454 <alltraps>

80106e95 <vector110>:
.globl vector110
vector110:
  pushl $0
80106e95:	6a 00                	push   $0x0
  pushl $110
80106e97:	6a 6e                	push   $0x6e
  jmp alltraps
80106e99:	e9 b6 f5 ff ff       	jmp    80106454 <alltraps>

80106e9e <vector111>:
.globl vector111
vector111:
  pushl $0
80106e9e:	6a 00                	push   $0x0
  pushl $111
80106ea0:	6a 6f                	push   $0x6f
  jmp alltraps
80106ea2:	e9 ad f5 ff ff       	jmp    80106454 <alltraps>

80106ea7 <vector112>:
.globl vector112
vector112:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $112
80106ea9:	6a 70                	push   $0x70
  jmp alltraps
80106eab:	e9 a4 f5 ff ff       	jmp    80106454 <alltraps>

80106eb0 <vector113>:
.globl vector113
vector113:
  pushl $0
80106eb0:	6a 00                	push   $0x0
  pushl $113
80106eb2:	6a 71                	push   $0x71
  jmp alltraps
80106eb4:	e9 9b f5 ff ff       	jmp    80106454 <alltraps>

80106eb9 <vector114>:
.globl vector114
vector114:
  pushl $0
80106eb9:	6a 00                	push   $0x0
  pushl $114
80106ebb:	6a 72                	push   $0x72
  jmp alltraps
80106ebd:	e9 92 f5 ff ff       	jmp    80106454 <alltraps>

80106ec2 <vector115>:
.globl vector115
vector115:
  pushl $0
80106ec2:	6a 00                	push   $0x0
  pushl $115
80106ec4:	6a 73                	push   $0x73
  jmp alltraps
80106ec6:	e9 89 f5 ff ff       	jmp    80106454 <alltraps>

80106ecb <vector116>:
.globl vector116
vector116:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $116
80106ecd:	6a 74                	push   $0x74
  jmp alltraps
80106ecf:	e9 80 f5 ff ff       	jmp    80106454 <alltraps>

80106ed4 <vector117>:
.globl vector117
vector117:
  pushl $0
80106ed4:	6a 00                	push   $0x0
  pushl $117
80106ed6:	6a 75                	push   $0x75
  jmp alltraps
80106ed8:	e9 77 f5 ff ff       	jmp    80106454 <alltraps>

80106edd <vector118>:
.globl vector118
vector118:
  pushl $0
80106edd:	6a 00                	push   $0x0
  pushl $118
80106edf:	6a 76                	push   $0x76
  jmp alltraps
80106ee1:	e9 6e f5 ff ff       	jmp    80106454 <alltraps>

80106ee6 <vector119>:
.globl vector119
vector119:
  pushl $0
80106ee6:	6a 00                	push   $0x0
  pushl $119
80106ee8:	6a 77                	push   $0x77
  jmp alltraps
80106eea:	e9 65 f5 ff ff       	jmp    80106454 <alltraps>

80106eef <vector120>:
.globl vector120
vector120:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $120
80106ef1:	6a 78                	push   $0x78
  jmp alltraps
80106ef3:	e9 5c f5 ff ff       	jmp    80106454 <alltraps>

80106ef8 <vector121>:
.globl vector121
vector121:
  pushl $0
80106ef8:	6a 00                	push   $0x0
  pushl $121
80106efa:	6a 79                	push   $0x79
  jmp alltraps
80106efc:	e9 53 f5 ff ff       	jmp    80106454 <alltraps>

80106f01 <vector122>:
.globl vector122
vector122:
  pushl $0
80106f01:	6a 00                	push   $0x0
  pushl $122
80106f03:	6a 7a                	push   $0x7a
  jmp alltraps
80106f05:	e9 4a f5 ff ff       	jmp    80106454 <alltraps>

80106f0a <vector123>:
.globl vector123
vector123:
  pushl $0
80106f0a:	6a 00                	push   $0x0
  pushl $123
80106f0c:	6a 7b                	push   $0x7b
  jmp alltraps
80106f0e:	e9 41 f5 ff ff       	jmp    80106454 <alltraps>

80106f13 <vector124>:
.globl vector124
vector124:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $124
80106f15:	6a 7c                	push   $0x7c
  jmp alltraps
80106f17:	e9 38 f5 ff ff       	jmp    80106454 <alltraps>

80106f1c <vector125>:
.globl vector125
vector125:
  pushl $0
80106f1c:	6a 00                	push   $0x0
  pushl $125
80106f1e:	6a 7d                	push   $0x7d
  jmp alltraps
80106f20:	e9 2f f5 ff ff       	jmp    80106454 <alltraps>

80106f25 <vector126>:
.globl vector126
vector126:
  pushl $0
80106f25:	6a 00                	push   $0x0
  pushl $126
80106f27:	6a 7e                	push   $0x7e
  jmp alltraps
80106f29:	e9 26 f5 ff ff       	jmp    80106454 <alltraps>

80106f2e <vector127>:
.globl vector127
vector127:
  pushl $0
80106f2e:	6a 00                	push   $0x0
  pushl $127
80106f30:	6a 7f                	push   $0x7f
  jmp alltraps
80106f32:	e9 1d f5 ff ff       	jmp    80106454 <alltraps>

80106f37 <vector128>:
.globl vector128
vector128:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $128
80106f39:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106f3e:	e9 11 f5 ff ff       	jmp    80106454 <alltraps>

80106f43 <vector129>:
.globl vector129
vector129:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $129
80106f45:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106f4a:	e9 05 f5 ff ff       	jmp    80106454 <alltraps>

80106f4f <vector130>:
.globl vector130
vector130:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $130
80106f51:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106f56:	e9 f9 f4 ff ff       	jmp    80106454 <alltraps>

80106f5b <vector131>:
.globl vector131
vector131:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $131
80106f5d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106f62:	e9 ed f4 ff ff       	jmp    80106454 <alltraps>

80106f67 <vector132>:
.globl vector132
vector132:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $132
80106f69:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106f6e:	e9 e1 f4 ff ff       	jmp    80106454 <alltraps>

80106f73 <vector133>:
.globl vector133
vector133:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $133
80106f75:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106f7a:	e9 d5 f4 ff ff       	jmp    80106454 <alltraps>

80106f7f <vector134>:
.globl vector134
vector134:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $134
80106f81:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106f86:	e9 c9 f4 ff ff       	jmp    80106454 <alltraps>

80106f8b <vector135>:
.globl vector135
vector135:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $135
80106f8d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106f92:	e9 bd f4 ff ff       	jmp    80106454 <alltraps>

80106f97 <vector136>:
.globl vector136
vector136:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $136
80106f99:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106f9e:	e9 b1 f4 ff ff       	jmp    80106454 <alltraps>

80106fa3 <vector137>:
.globl vector137
vector137:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $137
80106fa5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106faa:	e9 a5 f4 ff ff       	jmp    80106454 <alltraps>

80106faf <vector138>:
.globl vector138
vector138:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $138
80106fb1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106fb6:	e9 99 f4 ff ff       	jmp    80106454 <alltraps>

80106fbb <vector139>:
.globl vector139
vector139:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $139
80106fbd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106fc2:	e9 8d f4 ff ff       	jmp    80106454 <alltraps>

80106fc7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $140
80106fc9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106fce:	e9 81 f4 ff ff       	jmp    80106454 <alltraps>

80106fd3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $141
80106fd5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106fda:	e9 75 f4 ff ff       	jmp    80106454 <alltraps>

80106fdf <vector142>:
.globl vector142
vector142:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $142
80106fe1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106fe6:	e9 69 f4 ff ff       	jmp    80106454 <alltraps>

80106feb <vector143>:
.globl vector143
vector143:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $143
80106fed:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106ff2:	e9 5d f4 ff ff       	jmp    80106454 <alltraps>

80106ff7 <vector144>:
.globl vector144
vector144:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $144
80106ff9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106ffe:	e9 51 f4 ff ff       	jmp    80106454 <alltraps>

80107003 <vector145>:
.globl vector145
vector145:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $145
80107005:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010700a:	e9 45 f4 ff ff       	jmp    80106454 <alltraps>

8010700f <vector146>:
.globl vector146
vector146:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $146
80107011:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107016:	e9 39 f4 ff ff       	jmp    80106454 <alltraps>

8010701b <vector147>:
.globl vector147
vector147:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $147
8010701d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107022:	e9 2d f4 ff ff       	jmp    80106454 <alltraps>

80107027 <vector148>:
.globl vector148
vector148:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $148
80107029:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010702e:	e9 21 f4 ff ff       	jmp    80106454 <alltraps>

80107033 <vector149>:
.globl vector149
vector149:
  pushl $0
80107033:	6a 00                	push   $0x0
  pushl $149
80107035:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010703a:	e9 15 f4 ff ff       	jmp    80106454 <alltraps>

8010703f <vector150>:
.globl vector150
vector150:
  pushl $0
8010703f:	6a 00                	push   $0x0
  pushl $150
80107041:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107046:	e9 09 f4 ff ff       	jmp    80106454 <alltraps>

8010704b <vector151>:
.globl vector151
vector151:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $151
8010704d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107052:	e9 fd f3 ff ff       	jmp    80106454 <alltraps>

80107057 <vector152>:
.globl vector152
vector152:
  pushl $0
80107057:	6a 00                	push   $0x0
  pushl $152
80107059:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010705e:	e9 f1 f3 ff ff       	jmp    80106454 <alltraps>

80107063 <vector153>:
.globl vector153
vector153:
  pushl $0
80107063:	6a 00                	push   $0x0
  pushl $153
80107065:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010706a:	e9 e5 f3 ff ff       	jmp    80106454 <alltraps>

8010706f <vector154>:
.globl vector154
vector154:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $154
80107071:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107076:	e9 d9 f3 ff ff       	jmp    80106454 <alltraps>

8010707b <vector155>:
.globl vector155
vector155:
  pushl $0
8010707b:	6a 00                	push   $0x0
  pushl $155
8010707d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107082:	e9 cd f3 ff ff       	jmp    80106454 <alltraps>

80107087 <vector156>:
.globl vector156
vector156:
  pushl $0
80107087:	6a 00                	push   $0x0
  pushl $156
80107089:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010708e:	e9 c1 f3 ff ff       	jmp    80106454 <alltraps>

80107093 <vector157>:
.globl vector157
vector157:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $157
80107095:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010709a:	e9 b5 f3 ff ff       	jmp    80106454 <alltraps>

8010709f <vector158>:
.globl vector158
vector158:
  pushl $0
8010709f:	6a 00                	push   $0x0
  pushl $158
801070a1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801070a6:	e9 a9 f3 ff ff       	jmp    80106454 <alltraps>

801070ab <vector159>:
.globl vector159
vector159:
  pushl $0
801070ab:	6a 00                	push   $0x0
  pushl $159
801070ad:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801070b2:	e9 9d f3 ff ff       	jmp    80106454 <alltraps>

801070b7 <vector160>:
.globl vector160
vector160:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $160
801070b9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801070be:	e9 91 f3 ff ff       	jmp    80106454 <alltraps>

801070c3 <vector161>:
.globl vector161
vector161:
  pushl $0
801070c3:	6a 00                	push   $0x0
  pushl $161
801070c5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801070ca:	e9 85 f3 ff ff       	jmp    80106454 <alltraps>

801070cf <vector162>:
.globl vector162
vector162:
  pushl $0
801070cf:	6a 00                	push   $0x0
  pushl $162
801070d1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801070d6:	e9 79 f3 ff ff       	jmp    80106454 <alltraps>

801070db <vector163>:
.globl vector163
vector163:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $163
801070dd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801070e2:	e9 6d f3 ff ff       	jmp    80106454 <alltraps>

801070e7 <vector164>:
.globl vector164
vector164:
  pushl $0
801070e7:	6a 00                	push   $0x0
  pushl $164
801070e9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801070ee:	e9 61 f3 ff ff       	jmp    80106454 <alltraps>

801070f3 <vector165>:
.globl vector165
vector165:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $165
801070f5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801070fa:	e9 55 f3 ff ff       	jmp    80106454 <alltraps>

801070ff <vector166>:
.globl vector166
vector166:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $166
80107101:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107106:	e9 49 f3 ff ff       	jmp    80106454 <alltraps>

8010710b <vector167>:
.globl vector167
vector167:
  pushl $0
8010710b:	6a 00                	push   $0x0
  pushl $167
8010710d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107112:	e9 3d f3 ff ff       	jmp    80106454 <alltraps>

80107117 <vector168>:
.globl vector168
vector168:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $168
80107119:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010711e:	e9 31 f3 ff ff       	jmp    80106454 <alltraps>

80107123 <vector169>:
.globl vector169
vector169:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $169
80107125:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010712a:	e9 25 f3 ff ff       	jmp    80106454 <alltraps>

8010712f <vector170>:
.globl vector170
vector170:
  pushl $0
8010712f:	6a 00                	push   $0x0
  pushl $170
80107131:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107136:	e9 19 f3 ff ff       	jmp    80106454 <alltraps>

8010713b <vector171>:
.globl vector171
vector171:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $171
8010713d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107142:	e9 0d f3 ff ff       	jmp    80106454 <alltraps>

80107147 <vector172>:
.globl vector172
vector172:
  pushl $0
80107147:	6a 00                	push   $0x0
  pushl $172
80107149:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010714e:	e9 01 f3 ff ff       	jmp    80106454 <alltraps>

80107153 <vector173>:
.globl vector173
vector173:
  pushl $0
80107153:	6a 00                	push   $0x0
  pushl $173
80107155:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010715a:	e9 f5 f2 ff ff       	jmp    80106454 <alltraps>

8010715f <vector174>:
.globl vector174
vector174:
  pushl $0
8010715f:	6a 00                	push   $0x0
  pushl $174
80107161:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107166:	e9 e9 f2 ff ff       	jmp    80106454 <alltraps>

8010716b <vector175>:
.globl vector175
vector175:
  pushl $0
8010716b:	6a 00                	push   $0x0
  pushl $175
8010716d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107172:	e9 dd f2 ff ff       	jmp    80106454 <alltraps>

80107177 <vector176>:
.globl vector176
vector176:
  pushl $0
80107177:	6a 00                	push   $0x0
  pushl $176
80107179:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010717e:	e9 d1 f2 ff ff       	jmp    80106454 <alltraps>

80107183 <vector177>:
.globl vector177
vector177:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $177
80107185:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010718a:	e9 c5 f2 ff ff       	jmp    80106454 <alltraps>

8010718f <vector178>:
.globl vector178
vector178:
  pushl $0
8010718f:	6a 00                	push   $0x0
  pushl $178
80107191:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107196:	e9 b9 f2 ff ff       	jmp    80106454 <alltraps>

8010719b <vector179>:
.globl vector179
vector179:
  pushl $0
8010719b:	6a 00                	push   $0x0
  pushl $179
8010719d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801071a2:	e9 ad f2 ff ff       	jmp    80106454 <alltraps>

801071a7 <vector180>:
.globl vector180
vector180:
  pushl $0
801071a7:	6a 00                	push   $0x0
  pushl $180
801071a9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801071ae:	e9 a1 f2 ff ff       	jmp    80106454 <alltraps>

801071b3 <vector181>:
.globl vector181
vector181:
  pushl $0
801071b3:	6a 00                	push   $0x0
  pushl $181
801071b5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801071ba:	e9 95 f2 ff ff       	jmp    80106454 <alltraps>

801071bf <vector182>:
.globl vector182
vector182:
  pushl $0
801071bf:	6a 00                	push   $0x0
  pushl $182
801071c1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801071c6:	e9 89 f2 ff ff       	jmp    80106454 <alltraps>

801071cb <vector183>:
.globl vector183
vector183:
  pushl $0
801071cb:	6a 00                	push   $0x0
  pushl $183
801071cd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801071d2:	e9 7d f2 ff ff       	jmp    80106454 <alltraps>

801071d7 <vector184>:
.globl vector184
vector184:
  pushl $0
801071d7:	6a 00                	push   $0x0
  pushl $184
801071d9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801071de:	e9 71 f2 ff ff       	jmp    80106454 <alltraps>

801071e3 <vector185>:
.globl vector185
vector185:
  pushl $0
801071e3:	6a 00                	push   $0x0
  pushl $185
801071e5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801071ea:	e9 65 f2 ff ff       	jmp    80106454 <alltraps>

801071ef <vector186>:
.globl vector186
vector186:
  pushl $0
801071ef:	6a 00                	push   $0x0
  pushl $186
801071f1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801071f6:	e9 59 f2 ff ff       	jmp    80106454 <alltraps>

801071fb <vector187>:
.globl vector187
vector187:
  pushl $0
801071fb:	6a 00                	push   $0x0
  pushl $187
801071fd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107202:	e9 4d f2 ff ff       	jmp    80106454 <alltraps>

80107207 <vector188>:
.globl vector188
vector188:
  pushl $0
80107207:	6a 00                	push   $0x0
  pushl $188
80107209:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010720e:	e9 41 f2 ff ff       	jmp    80106454 <alltraps>

80107213 <vector189>:
.globl vector189
vector189:
  pushl $0
80107213:	6a 00                	push   $0x0
  pushl $189
80107215:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010721a:	e9 35 f2 ff ff       	jmp    80106454 <alltraps>

8010721f <vector190>:
.globl vector190
vector190:
  pushl $0
8010721f:	6a 00                	push   $0x0
  pushl $190
80107221:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107226:	e9 29 f2 ff ff       	jmp    80106454 <alltraps>

8010722b <vector191>:
.globl vector191
vector191:
  pushl $0
8010722b:	6a 00                	push   $0x0
  pushl $191
8010722d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107232:	e9 1d f2 ff ff       	jmp    80106454 <alltraps>

80107237 <vector192>:
.globl vector192
vector192:
  pushl $0
80107237:	6a 00                	push   $0x0
  pushl $192
80107239:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010723e:	e9 11 f2 ff ff       	jmp    80106454 <alltraps>

80107243 <vector193>:
.globl vector193
vector193:
  pushl $0
80107243:	6a 00                	push   $0x0
  pushl $193
80107245:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010724a:	e9 05 f2 ff ff       	jmp    80106454 <alltraps>

8010724f <vector194>:
.globl vector194
vector194:
  pushl $0
8010724f:	6a 00                	push   $0x0
  pushl $194
80107251:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107256:	e9 f9 f1 ff ff       	jmp    80106454 <alltraps>

8010725b <vector195>:
.globl vector195
vector195:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $195
8010725d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107262:	e9 ed f1 ff ff       	jmp    80106454 <alltraps>

80107267 <vector196>:
.globl vector196
vector196:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $196
80107269:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010726e:	e9 e1 f1 ff ff       	jmp    80106454 <alltraps>

80107273 <vector197>:
.globl vector197
vector197:
  pushl $0
80107273:	6a 00                	push   $0x0
  pushl $197
80107275:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010727a:	e9 d5 f1 ff ff       	jmp    80106454 <alltraps>

8010727f <vector198>:
.globl vector198
vector198:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $198
80107281:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107286:	e9 c9 f1 ff ff       	jmp    80106454 <alltraps>

8010728b <vector199>:
.globl vector199
vector199:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $199
8010728d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107292:	e9 bd f1 ff ff       	jmp    80106454 <alltraps>

80107297 <vector200>:
.globl vector200
vector200:
  pushl $0
80107297:	6a 00                	push   $0x0
  pushl $200
80107299:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010729e:	e9 b1 f1 ff ff       	jmp    80106454 <alltraps>

801072a3 <vector201>:
.globl vector201
vector201:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $201
801072a5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801072aa:	e9 a5 f1 ff ff       	jmp    80106454 <alltraps>

801072af <vector202>:
.globl vector202
vector202:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $202
801072b1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801072b6:	e9 99 f1 ff ff       	jmp    80106454 <alltraps>

801072bb <vector203>:
.globl vector203
vector203:
  pushl $0
801072bb:	6a 00                	push   $0x0
  pushl $203
801072bd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801072c2:	e9 8d f1 ff ff       	jmp    80106454 <alltraps>

801072c7 <vector204>:
.globl vector204
vector204:
  pushl $0
801072c7:	6a 00                	push   $0x0
  pushl $204
801072c9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801072ce:	e9 81 f1 ff ff       	jmp    80106454 <alltraps>

801072d3 <vector205>:
.globl vector205
vector205:
  pushl $0
801072d3:	6a 00                	push   $0x0
  pushl $205
801072d5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801072da:	e9 75 f1 ff ff       	jmp    80106454 <alltraps>

801072df <vector206>:
.globl vector206
vector206:
  pushl $0
801072df:	6a 00                	push   $0x0
  pushl $206
801072e1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801072e6:	e9 69 f1 ff ff       	jmp    80106454 <alltraps>

801072eb <vector207>:
.globl vector207
vector207:
  pushl $0
801072eb:	6a 00                	push   $0x0
  pushl $207
801072ed:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801072f2:	e9 5d f1 ff ff       	jmp    80106454 <alltraps>

801072f7 <vector208>:
.globl vector208
vector208:
  pushl $0
801072f7:	6a 00                	push   $0x0
  pushl $208
801072f9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801072fe:	e9 51 f1 ff ff       	jmp    80106454 <alltraps>

80107303 <vector209>:
.globl vector209
vector209:
  pushl $0
80107303:	6a 00                	push   $0x0
  pushl $209
80107305:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010730a:	e9 45 f1 ff ff       	jmp    80106454 <alltraps>

8010730f <vector210>:
.globl vector210
vector210:
  pushl $0
8010730f:	6a 00                	push   $0x0
  pushl $210
80107311:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107316:	e9 39 f1 ff ff       	jmp    80106454 <alltraps>

8010731b <vector211>:
.globl vector211
vector211:
  pushl $0
8010731b:	6a 00                	push   $0x0
  pushl $211
8010731d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107322:	e9 2d f1 ff ff       	jmp    80106454 <alltraps>

80107327 <vector212>:
.globl vector212
vector212:
  pushl $0
80107327:	6a 00                	push   $0x0
  pushl $212
80107329:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010732e:	e9 21 f1 ff ff       	jmp    80106454 <alltraps>

80107333 <vector213>:
.globl vector213
vector213:
  pushl $0
80107333:	6a 00                	push   $0x0
  pushl $213
80107335:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010733a:	e9 15 f1 ff ff       	jmp    80106454 <alltraps>

8010733f <vector214>:
.globl vector214
vector214:
  pushl $0
8010733f:	6a 00                	push   $0x0
  pushl $214
80107341:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107346:	e9 09 f1 ff ff       	jmp    80106454 <alltraps>

8010734b <vector215>:
.globl vector215
vector215:
  pushl $0
8010734b:	6a 00                	push   $0x0
  pushl $215
8010734d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107352:	e9 fd f0 ff ff       	jmp    80106454 <alltraps>

80107357 <vector216>:
.globl vector216
vector216:
  pushl $0
80107357:	6a 00                	push   $0x0
  pushl $216
80107359:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010735e:	e9 f1 f0 ff ff       	jmp    80106454 <alltraps>

80107363 <vector217>:
.globl vector217
vector217:
  pushl $0
80107363:	6a 00                	push   $0x0
  pushl $217
80107365:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010736a:	e9 e5 f0 ff ff       	jmp    80106454 <alltraps>

8010736f <vector218>:
.globl vector218
vector218:
  pushl $0
8010736f:	6a 00                	push   $0x0
  pushl $218
80107371:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107376:	e9 d9 f0 ff ff       	jmp    80106454 <alltraps>

8010737b <vector219>:
.globl vector219
vector219:
  pushl $0
8010737b:	6a 00                	push   $0x0
  pushl $219
8010737d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107382:	e9 cd f0 ff ff       	jmp    80106454 <alltraps>

80107387 <vector220>:
.globl vector220
vector220:
  pushl $0
80107387:	6a 00                	push   $0x0
  pushl $220
80107389:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010738e:	e9 c1 f0 ff ff       	jmp    80106454 <alltraps>

80107393 <vector221>:
.globl vector221
vector221:
  pushl $0
80107393:	6a 00                	push   $0x0
  pushl $221
80107395:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010739a:	e9 b5 f0 ff ff       	jmp    80106454 <alltraps>

8010739f <vector222>:
.globl vector222
vector222:
  pushl $0
8010739f:	6a 00                	push   $0x0
  pushl $222
801073a1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801073a6:	e9 a9 f0 ff ff       	jmp    80106454 <alltraps>

801073ab <vector223>:
.globl vector223
vector223:
  pushl $0
801073ab:	6a 00                	push   $0x0
  pushl $223
801073ad:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801073b2:	e9 9d f0 ff ff       	jmp    80106454 <alltraps>

801073b7 <vector224>:
.globl vector224
vector224:
  pushl $0
801073b7:	6a 00                	push   $0x0
  pushl $224
801073b9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801073be:	e9 91 f0 ff ff       	jmp    80106454 <alltraps>

801073c3 <vector225>:
.globl vector225
vector225:
  pushl $0
801073c3:	6a 00                	push   $0x0
  pushl $225
801073c5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801073ca:	e9 85 f0 ff ff       	jmp    80106454 <alltraps>

801073cf <vector226>:
.globl vector226
vector226:
  pushl $0
801073cf:	6a 00                	push   $0x0
  pushl $226
801073d1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801073d6:	e9 79 f0 ff ff       	jmp    80106454 <alltraps>

801073db <vector227>:
.globl vector227
vector227:
  pushl $0
801073db:	6a 00                	push   $0x0
  pushl $227
801073dd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801073e2:	e9 6d f0 ff ff       	jmp    80106454 <alltraps>

801073e7 <vector228>:
.globl vector228
vector228:
  pushl $0
801073e7:	6a 00                	push   $0x0
  pushl $228
801073e9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801073ee:	e9 61 f0 ff ff       	jmp    80106454 <alltraps>

801073f3 <vector229>:
.globl vector229
vector229:
  pushl $0
801073f3:	6a 00                	push   $0x0
  pushl $229
801073f5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801073fa:	e9 55 f0 ff ff       	jmp    80106454 <alltraps>

801073ff <vector230>:
.globl vector230
vector230:
  pushl $0
801073ff:	6a 00                	push   $0x0
  pushl $230
80107401:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107406:	e9 49 f0 ff ff       	jmp    80106454 <alltraps>

8010740b <vector231>:
.globl vector231
vector231:
  pushl $0
8010740b:	6a 00                	push   $0x0
  pushl $231
8010740d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107412:	e9 3d f0 ff ff       	jmp    80106454 <alltraps>

80107417 <vector232>:
.globl vector232
vector232:
  pushl $0
80107417:	6a 00                	push   $0x0
  pushl $232
80107419:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010741e:	e9 31 f0 ff ff       	jmp    80106454 <alltraps>

80107423 <vector233>:
.globl vector233
vector233:
  pushl $0
80107423:	6a 00                	push   $0x0
  pushl $233
80107425:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010742a:	e9 25 f0 ff ff       	jmp    80106454 <alltraps>

8010742f <vector234>:
.globl vector234
vector234:
  pushl $0
8010742f:	6a 00                	push   $0x0
  pushl $234
80107431:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107436:	e9 19 f0 ff ff       	jmp    80106454 <alltraps>

8010743b <vector235>:
.globl vector235
vector235:
  pushl $0
8010743b:	6a 00                	push   $0x0
  pushl $235
8010743d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107442:	e9 0d f0 ff ff       	jmp    80106454 <alltraps>

80107447 <vector236>:
.globl vector236
vector236:
  pushl $0
80107447:	6a 00                	push   $0x0
  pushl $236
80107449:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010744e:	e9 01 f0 ff ff       	jmp    80106454 <alltraps>

80107453 <vector237>:
.globl vector237
vector237:
  pushl $0
80107453:	6a 00                	push   $0x0
  pushl $237
80107455:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010745a:	e9 f5 ef ff ff       	jmp    80106454 <alltraps>

8010745f <vector238>:
.globl vector238
vector238:
  pushl $0
8010745f:	6a 00                	push   $0x0
  pushl $238
80107461:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107466:	e9 e9 ef ff ff       	jmp    80106454 <alltraps>

8010746b <vector239>:
.globl vector239
vector239:
  pushl $0
8010746b:	6a 00                	push   $0x0
  pushl $239
8010746d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107472:	e9 dd ef ff ff       	jmp    80106454 <alltraps>

80107477 <vector240>:
.globl vector240
vector240:
  pushl $0
80107477:	6a 00                	push   $0x0
  pushl $240
80107479:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010747e:	e9 d1 ef ff ff       	jmp    80106454 <alltraps>

80107483 <vector241>:
.globl vector241
vector241:
  pushl $0
80107483:	6a 00                	push   $0x0
  pushl $241
80107485:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010748a:	e9 c5 ef ff ff       	jmp    80106454 <alltraps>

8010748f <vector242>:
.globl vector242
vector242:
  pushl $0
8010748f:	6a 00                	push   $0x0
  pushl $242
80107491:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107496:	e9 b9 ef ff ff       	jmp    80106454 <alltraps>

8010749b <vector243>:
.globl vector243
vector243:
  pushl $0
8010749b:	6a 00                	push   $0x0
  pushl $243
8010749d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801074a2:	e9 ad ef ff ff       	jmp    80106454 <alltraps>

801074a7 <vector244>:
.globl vector244
vector244:
  pushl $0
801074a7:	6a 00                	push   $0x0
  pushl $244
801074a9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801074ae:	e9 a1 ef ff ff       	jmp    80106454 <alltraps>

801074b3 <vector245>:
.globl vector245
vector245:
  pushl $0
801074b3:	6a 00                	push   $0x0
  pushl $245
801074b5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801074ba:	e9 95 ef ff ff       	jmp    80106454 <alltraps>

801074bf <vector246>:
.globl vector246
vector246:
  pushl $0
801074bf:	6a 00                	push   $0x0
  pushl $246
801074c1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801074c6:	e9 89 ef ff ff       	jmp    80106454 <alltraps>

801074cb <vector247>:
.globl vector247
vector247:
  pushl $0
801074cb:	6a 00                	push   $0x0
  pushl $247
801074cd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801074d2:	e9 7d ef ff ff       	jmp    80106454 <alltraps>

801074d7 <vector248>:
.globl vector248
vector248:
  pushl $0
801074d7:	6a 00                	push   $0x0
  pushl $248
801074d9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801074de:	e9 71 ef ff ff       	jmp    80106454 <alltraps>

801074e3 <vector249>:
.globl vector249
vector249:
  pushl $0
801074e3:	6a 00                	push   $0x0
  pushl $249
801074e5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801074ea:	e9 65 ef ff ff       	jmp    80106454 <alltraps>

801074ef <vector250>:
.globl vector250
vector250:
  pushl $0
801074ef:	6a 00                	push   $0x0
  pushl $250
801074f1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801074f6:	e9 59 ef ff ff       	jmp    80106454 <alltraps>

801074fb <vector251>:
.globl vector251
vector251:
  pushl $0
801074fb:	6a 00                	push   $0x0
  pushl $251
801074fd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107502:	e9 4d ef ff ff       	jmp    80106454 <alltraps>

80107507 <vector252>:
.globl vector252
vector252:
  pushl $0
80107507:	6a 00                	push   $0x0
  pushl $252
80107509:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010750e:	e9 41 ef ff ff       	jmp    80106454 <alltraps>

80107513 <vector253>:
.globl vector253
vector253:
  pushl $0
80107513:	6a 00                	push   $0x0
  pushl $253
80107515:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010751a:	e9 35 ef ff ff       	jmp    80106454 <alltraps>

8010751f <vector254>:
.globl vector254
vector254:
  pushl $0
8010751f:	6a 00                	push   $0x0
  pushl $254
80107521:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107526:	e9 29 ef ff ff       	jmp    80106454 <alltraps>

8010752b <vector255>:
.globl vector255
vector255:
  pushl $0
8010752b:	6a 00                	push   $0x0
  pushl $255
8010752d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107532:	e9 1d ef ff ff       	jmp    80106454 <alltraps>

80107537 <lgdt>:
{
80107537:	55                   	push   %ebp
80107538:	89 e5                	mov    %esp,%ebp
8010753a:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
8010753d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107540:	83 e8 01             	sub    $0x1,%eax
80107543:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107547:	8b 45 08             	mov    0x8(%ebp),%eax
8010754a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010754e:	8b 45 08             	mov    0x8(%ebp),%eax
80107551:	c1 e8 10             	shr    $0x10,%eax
80107554:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107558:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010755b:	0f 01 10             	lgdtl  (%eax)
}
8010755e:	90                   	nop
8010755f:	c9                   	leave  
80107560:	c3                   	ret    

80107561 <ltr>:
{
80107561:	55                   	push   %ebp
80107562:	89 e5                	mov    %esp,%ebp
80107564:	83 ec 04             	sub    $0x4,%esp
80107567:	8b 45 08             	mov    0x8(%ebp),%eax
8010756a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
8010756e:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107572:	0f 00 d8             	ltr    %ax
}
80107575:	90                   	nop
80107576:	c9                   	leave  
80107577:	c3                   	ret    

80107578 <loadgs>:
{
80107578:	55                   	push   %ebp
80107579:	89 e5                	mov    %esp,%ebp
8010757b:	83 ec 04             	sub    $0x4,%esp
8010757e:	8b 45 08             	mov    0x8(%ebp),%eax
80107581:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107585:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107589:	8e e8                	mov    %eax,%gs
}
8010758b:	90                   	nop
8010758c:	c9                   	leave  
8010758d:	c3                   	ret    

8010758e <lcr3>:

static inline void
lcr3(uint val) 
{
8010758e:	55                   	push   %ebp
8010758f:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107591:	8b 45 08             	mov    0x8(%ebp),%eax
80107594:	0f 22 d8             	mov    %eax,%cr3
}
80107597:	90                   	nop
80107598:	5d                   	pop    %ebp
80107599:	c3                   	ret    

8010759a <v2p>:
static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
8010759a:	55                   	push   %ebp
8010759b:	89 e5                	mov    %esp,%ebp
8010759d:	8b 45 08             	mov    0x8(%ebp),%eax
801075a0:	05 00 00 00 80       	add    $0x80000000,%eax
801075a5:	5d                   	pop    %ebp
801075a6:	c3                   	ret    

801075a7 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801075a7:	55                   	push   %ebp
801075a8:	89 e5                	mov    %esp,%ebp
801075aa:	8b 45 08             	mov    0x8(%ebp),%eax
801075ad:	05 00 00 00 80       	add    $0x80000000,%eax
801075b2:	5d                   	pop    %ebp
801075b3:	c3                   	ret    

801075b4 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801075b4:	f3 0f 1e fb          	endbr32 
801075b8:	55                   	push   %ebp
801075b9:	89 e5                	mov    %esp,%ebp
801075bb:	53                   	push   %ebx
801075bc:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801075bf:	e8 5a ba ff ff       	call   8010301e <cpunum>
801075c4:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801075ca:	05 20 f9 10 80       	add    $0x8010f920,%eax
801075cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801075d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075d5:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801075db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075de:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801075e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075e7:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801075eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075ee:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801075f2:	83 e2 f0             	and    $0xfffffff0,%edx
801075f5:	83 ca 0a             	or     $0xa,%edx
801075f8:	88 50 7d             	mov    %dl,0x7d(%eax)
801075fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075fe:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107602:	83 ca 10             	or     $0x10,%edx
80107605:	88 50 7d             	mov    %dl,0x7d(%eax)
80107608:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010760b:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010760f:	83 e2 9f             	and    $0xffffff9f,%edx
80107612:	88 50 7d             	mov    %dl,0x7d(%eax)
80107615:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107618:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010761c:	83 ca 80             	or     $0xffffff80,%edx
8010761f:	88 50 7d             	mov    %dl,0x7d(%eax)
80107622:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107625:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107629:	83 ca 0f             	or     $0xf,%edx
8010762c:	88 50 7e             	mov    %dl,0x7e(%eax)
8010762f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107632:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107636:	83 e2 ef             	and    $0xffffffef,%edx
80107639:	88 50 7e             	mov    %dl,0x7e(%eax)
8010763c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010763f:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107643:	83 e2 df             	and    $0xffffffdf,%edx
80107646:	88 50 7e             	mov    %dl,0x7e(%eax)
80107649:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010764c:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107650:	83 ca 40             	or     $0x40,%edx
80107653:	88 50 7e             	mov    %dl,0x7e(%eax)
80107656:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107659:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010765d:	83 ca 80             	or     $0xffffff80,%edx
80107660:	88 50 7e             	mov    %dl,0x7e(%eax)
80107663:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107666:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010766a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010766d:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107674:	ff ff 
80107676:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107679:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107680:	00 00 
80107682:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107685:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
8010768c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010768f:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107696:	83 e2 f0             	and    $0xfffffff0,%edx
80107699:	83 ca 02             	or     $0x2,%edx
8010769c:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a5:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801076ac:	83 ca 10             	or     $0x10,%edx
801076af:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076b8:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801076bf:	83 e2 9f             	and    $0xffffff9f,%edx
801076c2:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076cb:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801076d2:	83 ca 80             	or     $0xffffff80,%edx
801076d5:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801076db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076de:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076e5:	83 ca 0f             	or     $0xf,%edx
801076e8:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801076ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076f1:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801076f8:	83 e2 ef             	and    $0xffffffef,%edx
801076fb:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107701:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107704:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010770b:	83 e2 df             	and    $0xffffffdf,%edx
8010770e:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107714:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107717:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010771e:	83 ca 40             	or     $0x40,%edx
80107721:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107727:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010772a:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107731:	83 ca 80             	or     $0xffffff80,%edx
80107734:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010773a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010773d:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107744:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107747:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
8010774e:	ff ff 
80107750:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107753:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
8010775a:	00 00 
8010775c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010775f:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107766:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107769:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107770:	83 e2 f0             	and    $0xfffffff0,%edx
80107773:	83 ca 0a             	or     $0xa,%edx
80107776:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010777c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010777f:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107786:	83 ca 10             	or     $0x10,%edx
80107789:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010778f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107792:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107799:	83 ca 60             	or     $0x60,%edx
8010779c:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801077a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077a5:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801077ac:	83 ca 80             	or     $0xffffff80,%edx
801077af:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801077b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077b8:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077bf:	83 ca 0f             	or     $0xf,%edx
801077c2:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077cb:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077d2:	83 e2 ef             	and    $0xffffffef,%edx
801077d5:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077de:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077e5:	83 e2 df             	and    $0xffffffdf,%edx
801077e8:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801077ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077f1:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801077f8:	83 ca 40             	or     $0x40,%edx
801077fb:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107801:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107804:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010780b:	83 ca 80             	or     $0xffffff80,%edx
8010780e:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107814:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107817:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010781e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107821:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107828:	ff ff 
8010782a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010782d:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107834:	00 00 
80107836:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107839:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107840:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107843:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010784a:	83 e2 f0             	and    $0xfffffff0,%edx
8010784d:	83 ca 02             	or     $0x2,%edx
80107850:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107856:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107859:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107860:	83 ca 10             	or     $0x10,%edx
80107863:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107869:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010786c:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107873:	83 ca 60             	or     $0x60,%edx
80107876:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010787c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010787f:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107886:	83 ca 80             	or     $0xffffff80,%edx
80107889:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010788f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107892:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107899:	83 ca 0f             	or     $0xf,%edx
8010789c:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a5:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078ac:	83 e2 ef             	and    $0xffffffef,%edx
801078af:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b8:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078bf:	83 e2 df             	and    $0xffffffdf,%edx
801078c2:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078cb:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078d2:	83 ca 40             	or     $0x40,%edx
801078d5:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078de:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801078e5:	83 ca 80             	or     $0xffffff80,%edx
801078e8:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801078ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f1:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801078f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078fb:	05 b4 00 00 00       	add    $0xb4,%eax
80107900:	89 c3                	mov    %eax,%ebx
80107902:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107905:	05 b4 00 00 00       	add    $0xb4,%eax
8010790a:	c1 e8 10             	shr    $0x10,%eax
8010790d:	89 c2                	mov    %eax,%edx
8010790f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107912:	05 b4 00 00 00       	add    $0xb4,%eax
80107917:	c1 e8 18             	shr    $0x18,%eax
8010791a:	89 c1                	mov    %eax,%ecx
8010791c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010791f:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107926:	00 00 
80107928:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010792b:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107932:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107935:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
8010793b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793e:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107945:	83 e2 f0             	and    $0xfffffff0,%edx
80107948:	83 ca 02             	or     $0x2,%edx
8010794b:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107951:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107954:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010795b:	83 ca 10             	or     $0x10,%edx
8010795e:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107964:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107967:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010796e:	83 e2 9f             	and    $0xffffff9f,%edx
80107971:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107977:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010797a:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107981:	83 ca 80             	or     $0xffffff80,%edx
80107984:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010798a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010798d:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107994:	83 e2 f0             	and    $0xfffffff0,%edx
80107997:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010799d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a0:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079a7:	83 e2 ef             	and    $0xffffffef,%edx
801079aa:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b3:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079ba:	83 e2 df             	and    $0xffffffdf,%edx
801079bd:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c6:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079cd:	83 ca 40             	or     $0x40,%edx
801079d0:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079d9:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801079e0:	83 ca 80             	or     $0xffffff80,%edx
801079e3:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801079e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ec:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
801079f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f5:	83 c0 70             	add    $0x70,%eax
801079f8:	83 ec 08             	sub    $0x8,%esp
801079fb:	6a 38                	push   $0x38
801079fd:	50                   	push   %eax
801079fe:	e8 34 fb ff ff       	call   80107537 <lgdt>
80107a03:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107a06:	83 ec 0c             	sub    $0xc,%esp
80107a09:	6a 18                	push   $0x18
80107a0b:	e8 68 fb ff ff       	call   80107578 <loadgs>
80107a10:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80107a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a16:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107a1c:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107a23:	00 00 00 00 
}
80107a27:	90                   	nop
80107a28:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107a2b:	c9                   	leave  
80107a2c:	c3                   	ret    

80107a2d <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107a2d:	f3 0f 1e fb          	endbr32 
80107a31:	55                   	push   %ebp
80107a32:	89 e5                	mov    %esp,%ebp
80107a34:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107a37:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a3a:	c1 e8 16             	shr    $0x16,%eax
80107a3d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107a44:	8b 45 08             	mov    0x8(%ebp),%eax
80107a47:	01 d0                	add    %edx,%eax
80107a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107a4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a4f:	8b 00                	mov    (%eax),%eax
80107a51:	83 e0 01             	and    $0x1,%eax
80107a54:	85 c0                	test   %eax,%eax
80107a56:	74 18                	je     80107a70 <walkpgdir+0x43>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107a58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a5b:	8b 00                	mov    (%eax),%eax
80107a5d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107a62:	50                   	push   %eax
80107a63:	e8 3f fb ff ff       	call   801075a7 <p2v>
80107a68:	83 c4 04             	add    $0x4,%esp
80107a6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107a6e:	eb 48                	jmp    80107ab8 <walkpgdir+0x8b>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107a70:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107a74:	74 0e                	je     80107a84 <walkpgdir+0x57>
80107a76:	e8 43 b2 ff ff       	call   80102cbe <kalloc>
80107a7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107a7e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107a82:	75 07                	jne    80107a8b <walkpgdir+0x5e>
      return 0;
80107a84:	b8 00 00 00 00       	mov    $0x0,%eax
80107a89:	eb 44                	jmp    80107acf <walkpgdir+0xa2>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107a8b:	83 ec 04             	sub    $0x4,%esp
80107a8e:	68 00 10 00 00       	push   $0x1000
80107a93:	6a 00                	push   $0x0
80107a95:	ff 75 f4             	pushl  -0xc(%ebp)
80107a98:	e8 8b d5 ff ff       	call   80105028 <memset>
80107a9d:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107aa0:	83 ec 0c             	sub    $0xc,%esp
80107aa3:	ff 75 f4             	pushl  -0xc(%ebp)
80107aa6:	e8 ef fa ff ff       	call   8010759a <v2p>
80107aab:	83 c4 10             	add    $0x10,%esp
80107aae:	83 c8 07             	or     $0x7,%eax
80107ab1:	89 c2                	mov    %eax,%edx
80107ab3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ab6:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107ab8:	8b 45 0c             	mov    0xc(%ebp),%eax
80107abb:	c1 e8 0c             	shr    $0xc,%eax
80107abe:	25 ff 03 00 00       	and    $0x3ff,%eax
80107ac3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107acd:	01 d0                	add    %edx,%eax
}
80107acf:	c9                   	leave  
80107ad0:	c3                   	ret    

80107ad1 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107ad1:	f3 0f 1e fb          	endbr32 
80107ad5:	55                   	push   %ebp
80107ad6:	89 e5                	mov    %esp,%ebp
80107ad8:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107adb:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ade:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ae3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107ae6:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ae9:	8b 45 10             	mov    0x10(%ebp),%eax
80107aec:	01 d0                	add    %edx,%eax
80107aee:	83 e8 01             	sub    $0x1,%eax
80107af1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107af6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107af9:	83 ec 04             	sub    $0x4,%esp
80107afc:	6a 01                	push   $0x1
80107afe:	ff 75 f4             	pushl  -0xc(%ebp)
80107b01:	ff 75 08             	pushl  0x8(%ebp)
80107b04:	e8 24 ff ff ff       	call   80107a2d <walkpgdir>
80107b09:	83 c4 10             	add    $0x10,%esp
80107b0c:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107b0f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107b13:	75 07                	jne    80107b1c <mappages+0x4b>
      return -1;
80107b15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107b1a:	eb 47                	jmp    80107b63 <mappages+0x92>
    if(*pte & PTE_P)
80107b1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107b1f:	8b 00                	mov    (%eax),%eax
80107b21:	83 e0 01             	and    $0x1,%eax
80107b24:	85 c0                	test   %eax,%eax
80107b26:	74 0d                	je     80107b35 <mappages+0x64>
      panic("remap");
80107b28:	83 ec 0c             	sub    $0xc,%esp
80107b2b:	68 10 89 10 80       	push   $0x80108910
80107b30:	e8 62 8a ff ff       	call   80100597 <panic>
    *pte = pa | perm | PTE_P;
80107b35:	8b 45 18             	mov    0x18(%ebp),%eax
80107b38:	0b 45 14             	or     0x14(%ebp),%eax
80107b3b:	83 c8 01             	or     $0x1,%eax
80107b3e:	89 c2                	mov    %eax,%edx
80107b40:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107b43:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107b45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b48:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107b4b:	74 10                	je     80107b5d <mappages+0x8c>
      break;
    a += PGSIZE;
80107b4d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107b54:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107b5b:	eb 9c                	jmp    80107af9 <mappages+0x28>
      break;
80107b5d:	90                   	nop
  }
  return 0;
80107b5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107b63:	c9                   	leave  
80107b64:	c3                   	ret    

80107b65 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107b65:	f3 0f 1e fb          	endbr32 
80107b69:	55                   	push   %ebp
80107b6a:	89 e5                	mov    %esp,%ebp
80107b6c:	53                   	push   %ebx
80107b6d:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107b70:	e8 49 b1 ff ff       	call   80102cbe <kalloc>
80107b75:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107b78:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107b7c:	75 0a                	jne    80107b88 <setupkvm+0x23>
    return 0;
80107b7e:	b8 00 00 00 00       	mov    $0x0,%eax
80107b83:	e9 8e 00 00 00       	jmp    80107c16 <setupkvm+0xb1>
  memset(pgdir, 0, PGSIZE);
80107b88:	83 ec 04             	sub    $0x4,%esp
80107b8b:	68 00 10 00 00       	push   $0x1000
80107b90:	6a 00                	push   $0x0
80107b92:	ff 75 f0             	pushl  -0x10(%ebp)
80107b95:	e8 8e d4 ff ff       	call   80105028 <memset>
80107b9a:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107b9d:	83 ec 0c             	sub    $0xc,%esp
80107ba0:	68 00 00 00 0e       	push   $0xe000000
80107ba5:	e8 fd f9 ff ff       	call   801075a7 <p2v>
80107baa:	83 c4 10             	add    $0x10,%esp
80107bad:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107bb2:	76 0d                	jbe    80107bc1 <setupkvm+0x5c>
    panic("PHYSTOP too high");
80107bb4:	83 ec 0c             	sub    $0xc,%esp
80107bb7:	68 16 89 10 80       	push   $0x80108916
80107bbc:	e8 d6 89 ff ff       	call   80100597 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107bc1:	c7 45 f4 a0 b4 10 80 	movl   $0x8010b4a0,-0xc(%ebp)
80107bc8:	eb 40                	jmp    80107c0a <setupkvm+0xa5>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107bca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bcd:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80107bd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd3:	8b 50 04             	mov    0x4(%eax),%edx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd9:	8b 58 08             	mov    0x8(%eax),%ebx
80107bdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bdf:	8b 40 04             	mov    0x4(%eax),%eax
80107be2:	29 c3                	sub    %eax,%ebx
80107be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107be7:	8b 00                	mov    (%eax),%eax
80107be9:	83 ec 0c             	sub    $0xc,%esp
80107bec:	51                   	push   %ecx
80107bed:	52                   	push   %edx
80107bee:	53                   	push   %ebx
80107bef:	50                   	push   %eax
80107bf0:	ff 75 f0             	pushl  -0x10(%ebp)
80107bf3:	e8 d9 fe ff ff       	call   80107ad1 <mappages>
80107bf8:	83 c4 20             	add    $0x20,%esp
80107bfb:	85 c0                	test   %eax,%eax
80107bfd:	79 07                	jns    80107c06 <setupkvm+0xa1>
      return 0;
80107bff:	b8 00 00 00 00       	mov    $0x0,%eax
80107c04:	eb 10                	jmp    80107c16 <setupkvm+0xb1>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107c06:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107c0a:	81 7d f4 e0 b4 10 80 	cmpl   $0x8010b4e0,-0xc(%ebp)
80107c11:	72 b7                	jb     80107bca <setupkvm+0x65>
  return pgdir;
80107c13:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107c16:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107c19:	c9                   	leave  
80107c1a:	c3                   	ret    

80107c1b <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107c1b:	f3 0f 1e fb          	endbr32 
80107c1f:	55                   	push   %ebp
80107c20:	89 e5                	mov    %esp,%ebp
80107c22:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107c25:	e8 3b ff ff ff       	call   80107b65 <setupkvm>
80107c2a:	a3 f8 26 11 80       	mov    %eax,0x801126f8
  switchkvm();
80107c2f:	e8 03 00 00 00       	call   80107c37 <switchkvm>
}
80107c34:	90                   	nop
80107c35:	c9                   	leave  
80107c36:	c3                   	ret    

80107c37 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107c37:	f3 0f 1e fb          	endbr32 
80107c3b:	55                   	push   %ebp
80107c3c:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107c3e:	a1 f8 26 11 80       	mov    0x801126f8,%eax
80107c43:	50                   	push   %eax
80107c44:	e8 51 f9 ff ff       	call   8010759a <v2p>
80107c49:	83 c4 04             	add    $0x4,%esp
80107c4c:	50                   	push   %eax
80107c4d:	e8 3c f9 ff ff       	call   8010758e <lcr3>
80107c52:	83 c4 04             	add    $0x4,%esp
}
80107c55:	90                   	nop
80107c56:	c9                   	leave  
80107c57:	c3                   	ret    

80107c58 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107c58:	f3 0f 1e fb          	endbr32 
80107c5c:	55                   	push   %ebp
80107c5d:	89 e5                	mov    %esp,%ebp
80107c5f:	56                   	push   %esi
80107c60:	53                   	push   %ebx
  pushcli();
80107c61:	e8 b4 d2 ff ff       	call   80104f1a <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107c66:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107c6c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c73:	83 c2 08             	add    $0x8,%edx
80107c76:	89 d6                	mov    %edx,%esi
80107c78:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c7f:	83 c2 08             	add    $0x8,%edx
80107c82:	c1 ea 10             	shr    $0x10,%edx
80107c85:	89 d3                	mov    %edx,%ebx
80107c87:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107c8e:	83 c2 08             	add    $0x8,%edx
80107c91:	c1 ea 18             	shr    $0x18,%edx
80107c94:	89 d1                	mov    %edx,%ecx
80107c96:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107c9d:	67 00 
80107c9f:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107ca6:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107cac:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107cb3:	83 e2 f0             	and    $0xfffffff0,%edx
80107cb6:	83 ca 09             	or     $0x9,%edx
80107cb9:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107cbf:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107cc6:	83 ca 10             	or     $0x10,%edx
80107cc9:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ccf:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107cd6:	83 e2 9f             	and    $0xffffff9f,%edx
80107cd9:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107cdf:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107ce6:	83 ca 80             	or     $0xffffff80,%edx
80107ce9:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107cef:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107cf6:	83 e2 f0             	and    $0xfffffff0,%edx
80107cf9:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107cff:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107d06:	83 e2 ef             	and    $0xffffffef,%edx
80107d09:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d0f:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107d16:	83 e2 df             	and    $0xffffffdf,%edx
80107d19:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d1f:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107d26:	83 ca 40             	or     $0x40,%edx
80107d29:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d2f:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107d36:	83 e2 7f             	and    $0x7f,%edx
80107d39:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d3f:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107d45:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d4b:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107d52:	83 e2 ef             	and    $0xffffffef,%edx
80107d55:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107d5b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d61:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107d67:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107d6d:	8b 40 08             	mov    0x8(%eax),%eax
80107d70:	89 c2                	mov    %eax,%edx
80107d72:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d78:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107d7e:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107d81:	83 ec 0c             	sub    $0xc,%esp
80107d84:	6a 30                	push   $0x30
80107d86:	e8 d6 f7 ff ff       	call   80107561 <ltr>
80107d8b:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80107d8e:	8b 45 08             	mov    0x8(%ebp),%eax
80107d91:	8b 40 04             	mov    0x4(%eax),%eax
80107d94:	85 c0                	test   %eax,%eax
80107d96:	75 0d                	jne    80107da5 <switchuvm+0x14d>
    panic("switchuvm: no pgdir");
80107d98:	83 ec 0c             	sub    $0xc,%esp
80107d9b:	68 27 89 10 80       	push   $0x80108927
80107da0:	e8 f2 87 ff ff       	call   80100597 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107da5:	8b 45 08             	mov    0x8(%ebp),%eax
80107da8:	8b 40 04             	mov    0x4(%eax),%eax
80107dab:	83 ec 0c             	sub    $0xc,%esp
80107dae:	50                   	push   %eax
80107daf:	e8 e6 f7 ff ff       	call   8010759a <v2p>
80107db4:	83 c4 10             	add    $0x10,%esp
80107db7:	83 ec 0c             	sub    $0xc,%esp
80107dba:	50                   	push   %eax
80107dbb:	e8 ce f7 ff ff       	call   8010758e <lcr3>
80107dc0:	83 c4 10             	add    $0x10,%esp
  popcli();
80107dc3:	e8 9b d1 ff ff       	call   80104f63 <popcli>
}
80107dc8:	90                   	nop
80107dc9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107dcc:	5b                   	pop    %ebx
80107dcd:	5e                   	pop    %esi
80107dce:	5d                   	pop    %ebp
80107dcf:	c3                   	ret    

80107dd0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107dd0:	f3 0f 1e fb          	endbr32 
80107dd4:	55                   	push   %ebp
80107dd5:	89 e5                	mov    %esp,%ebp
80107dd7:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107dda:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107de1:	76 0d                	jbe    80107df0 <inituvm+0x20>
    panic("inituvm: more than a page");
80107de3:	83 ec 0c             	sub    $0xc,%esp
80107de6:	68 3b 89 10 80       	push   $0x8010893b
80107deb:	e8 a7 87 ff ff       	call   80100597 <panic>
  mem = kalloc();
80107df0:	e8 c9 ae ff ff       	call   80102cbe <kalloc>
80107df5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107df8:	83 ec 04             	sub    $0x4,%esp
80107dfb:	68 00 10 00 00       	push   $0x1000
80107e00:	6a 00                	push   $0x0
80107e02:	ff 75 f4             	pushl  -0xc(%ebp)
80107e05:	e8 1e d2 ff ff       	call   80105028 <memset>
80107e0a:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107e0d:	83 ec 0c             	sub    $0xc,%esp
80107e10:	ff 75 f4             	pushl  -0xc(%ebp)
80107e13:	e8 82 f7 ff ff       	call   8010759a <v2p>
80107e18:	83 c4 10             	add    $0x10,%esp
80107e1b:	83 ec 0c             	sub    $0xc,%esp
80107e1e:	6a 06                	push   $0x6
80107e20:	50                   	push   %eax
80107e21:	68 00 10 00 00       	push   $0x1000
80107e26:	6a 00                	push   $0x0
80107e28:	ff 75 08             	pushl  0x8(%ebp)
80107e2b:	e8 a1 fc ff ff       	call   80107ad1 <mappages>
80107e30:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80107e33:	83 ec 04             	sub    $0x4,%esp
80107e36:	ff 75 10             	pushl  0x10(%ebp)
80107e39:	ff 75 0c             	pushl  0xc(%ebp)
80107e3c:	ff 75 f4             	pushl  -0xc(%ebp)
80107e3f:	e8 ab d2 ff ff       	call   801050ef <memmove>
80107e44:	83 c4 10             	add    $0x10,%esp
}
80107e47:	90                   	nop
80107e48:	c9                   	leave  
80107e49:	c3                   	ret    

80107e4a <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107e4a:	f3 0f 1e fb          	endbr32 
80107e4e:	55                   	push   %ebp
80107e4f:	89 e5                	mov    %esp,%ebp
80107e51:	53                   	push   %ebx
80107e52:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107e55:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e58:	25 ff 0f 00 00       	and    $0xfff,%eax
80107e5d:	85 c0                	test   %eax,%eax
80107e5f:	74 0d                	je     80107e6e <loaduvm+0x24>
    panic("loaduvm: addr must be page aligned");
80107e61:	83 ec 0c             	sub    $0xc,%esp
80107e64:	68 58 89 10 80       	push   $0x80108958
80107e69:	e8 29 87 ff ff       	call   80100597 <panic>
  for(i = 0; i < sz; i += PGSIZE){
80107e6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107e75:	e9 95 00 00 00       	jmp    80107f0f <loaduvm+0xc5>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107e7a:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e80:	01 d0                	add    %edx,%eax
80107e82:	83 ec 04             	sub    $0x4,%esp
80107e85:	6a 00                	push   $0x0
80107e87:	50                   	push   %eax
80107e88:	ff 75 08             	pushl  0x8(%ebp)
80107e8b:	e8 9d fb ff ff       	call   80107a2d <walkpgdir>
80107e90:	83 c4 10             	add    $0x10,%esp
80107e93:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107e96:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107e9a:	75 0d                	jne    80107ea9 <loaduvm+0x5f>
      panic("loaduvm: address should exist");
80107e9c:	83 ec 0c             	sub    $0xc,%esp
80107e9f:	68 7b 89 10 80       	push   $0x8010897b
80107ea4:	e8 ee 86 ff ff       	call   80100597 <panic>
    pa = PTE_ADDR(*pte);
80107ea9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107eac:	8b 00                	mov    (%eax),%eax
80107eae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107eb3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80107eb6:	8b 45 18             	mov    0x18(%ebp),%eax
80107eb9:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107ebc:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107ec1:	77 0b                	ja     80107ece <loaduvm+0x84>
      n = sz - i;
80107ec3:	8b 45 18             	mov    0x18(%ebp),%eax
80107ec6:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107ec9:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107ecc:	eb 07                	jmp    80107ed5 <loaduvm+0x8b>
    else
      n = PGSIZE;
80107ece:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80107ed5:	8b 55 14             	mov    0x14(%ebp),%edx
80107ed8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107edb:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107ede:	83 ec 0c             	sub    $0xc,%esp
80107ee1:	ff 75 e8             	pushl  -0x18(%ebp)
80107ee4:	e8 be f6 ff ff       	call   801075a7 <p2v>
80107ee9:	83 c4 10             	add    $0x10,%esp
80107eec:	ff 75 f0             	pushl  -0x10(%ebp)
80107eef:	53                   	push   %ebx
80107ef0:	50                   	push   %eax
80107ef1:	ff 75 10             	pushl  0x10(%ebp)
80107ef4:	e8 20 a0 ff ff       	call   80101f19 <readi>
80107ef9:	83 c4 10             	add    $0x10,%esp
80107efc:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80107eff:	74 07                	je     80107f08 <loaduvm+0xbe>
      return -1;
80107f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107f06:	eb 18                	jmp    80107f20 <loaduvm+0xd6>
  for(i = 0; i < sz; i += PGSIZE){
80107f08:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107f0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f12:	3b 45 18             	cmp    0x18(%ebp),%eax
80107f15:	0f 82 5f ff ff ff    	jb     80107e7a <loaduvm+0x30>
  }
  return 0;
80107f1b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107f20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107f23:	c9                   	leave  
80107f24:	c3                   	ret    

80107f25 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107f25:	f3 0f 1e fb          	endbr32 
80107f29:	55                   	push   %ebp
80107f2a:	89 e5                	mov    %esp,%ebp
80107f2c:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80107f2f:	8b 45 10             	mov    0x10(%ebp),%eax
80107f32:	85 c0                	test   %eax,%eax
80107f34:	79 0a                	jns    80107f40 <allocuvm+0x1b>
    return 0;
80107f36:	b8 00 00 00 00       	mov    $0x0,%eax
80107f3b:	e9 ae 00 00 00       	jmp    80107fee <allocuvm+0xc9>
  if(newsz < oldsz)
80107f40:	8b 45 10             	mov    0x10(%ebp),%eax
80107f43:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107f46:	73 08                	jae    80107f50 <allocuvm+0x2b>
    return oldsz;
80107f48:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f4b:	e9 9e 00 00 00       	jmp    80107fee <allocuvm+0xc9>

  a = PGROUNDUP(oldsz);
80107f50:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f53:	05 ff 0f 00 00       	add    $0xfff,%eax
80107f58:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80107f60:	eb 7d                	jmp    80107fdf <allocuvm+0xba>
    mem = kalloc();
80107f62:	e8 57 ad ff ff       	call   80102cbe <kalloc>
80107f67:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80107f6a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f6e:	75 2b                	jne    80107f9b <allocuvm+0x76>
      cprintf("allocuvm out of memory\n");
80107f70:	83 ec 0c             	sub    $0xc,%esp
80107f73:	68 99 89 10 80       	push   $0x80108999
80107f78:	e8 61 84 ff ff       	call   801003de <cprintf>
80107f7d:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80107f80:	83 ec 04             	sub    $0x4,%esp
80107f83:	ff 75 0c             	pushl  0xc(%ebp)
80107f86:	ff 75 10             	pushl  0x10(%ebp)
80107f89:	ff 75 08             	pushl  0x8(%ebp)
80107f8c:	e8 5f 00 00 00       	call   80107ff0 <deallocuvm>
80107f91:	83 c4 10             	add    $0x10,%esp
      return 0;
80107f94:	b8 00 00 00 00       	mov    $0x0,%eax
80107f99:	eb 53                	jmp    80107fee <allocuvm+0xc9>
    }
    memset(mem, 0, PGSIZE);
80107f9b:	83 ec 04             	sub    $0x4,%esp
80107f9e:	68 00 10 00 00       	push   $0x1000
80107fa3:	6a 00                	push   $0x0
80107fa5:	ff 75 f0             	pushl  -0x10(%ebp)
80107fa8:	e8 7b d0 ff ff       	call   80105028 <memset>
80107fad:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107fb0:	83 ec 0c             	sub    $0xc,%esp
80107fb3:	ff 75 f0             	pushl  -0x10(%ebp)
80107fb6:	e8 df f5 ff ff       	call   8010759a <v2p>
80107fbb:	83 c4 10             	add    $0x10,%esp
80107fbe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107fc1:	83 ec 0c             	sub    $0xc,%esp
80107fc4:	6a 06                	push   $0x6
80107fc6:	50                   	push   %eax
80107fc7:	68 00 10 00 00       	push   $0x1000
80107fcc:	52                   	push   %edx
80107fcd:	ff 75 08             	pushl  0x8(%ebp)
80107fd0:	e8 fc fa ff ff       	call   80107ad1 <mappages>
80107fd5:	83 c4 20             	add    $0x20,%esp
  for(; a < newsz; a += PGSIZE){
80107fd8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107fdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fe2:	3b 45 10             	cmp    0x10(%ebp),%eax
80107fe5:	0f 82 77 ff ff ff    	jb     80107f62 <allocuvm+0x3d>
  }
  return newsz;
80107feb:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107fee:	c9                   	leave  
80107fef:	c3                   	ret    

80107ff0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107ff0:	f3 0f 1e fb          	endbr32 
80107ff4:	55                   	push   %ebp
80107ff5:	89 e5                	mov    %esp,%ebp
80107ff7:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107ffa:	8b 45 10             	mov    0x10(%ebp),%eax
80107ffd:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108000:	72 08                	jb     8010800a <deallocuvm+0x1a>
    return oldsz;
80108002:	8b 45 0c             	mov    0xc(%ebp),%eax
80108005:	e9 a5 00 00 00       	jmp    801080af <deallocuvm+0xbf>

  a = PGROUNDUP(newsz);
8010800a:	8b 45 10             	mov    0x10(%ebp),%eax
8010800d:	05 ff 0f 00 00       	add    $0xfff,%eax
80108012:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108017:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010801a:	e9 81 00 00 00       	jmp    801080a0 <deallocuvm+0xb0>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010801f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108022:	83 ec 04             	sub    $0x4,%esp
80108025:	6a 00                	push   $0x0
80108027:	50                   	push   %eax
80108028:	ff 75 08             	pushl  0x8(%ebp)
8010802b:	e8 fd f9 ff ff       	call   80107a2d <walkpgdir>
80108030:	83 c4 10             	add    $0x10,%esp
80108033:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80108036:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010803a:	75 09                	jne    80108045 <deallocuvm+0x55>
      a += (NPTENTRIES - 1) * PGSIZE;
8010803c:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80108043:	eb 54                	jmp    80108099 <deallocuvm+0xa9>
    else if((*pte & PTE_P) != 0){
80108045:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108048:	8b 00                	mov    (%eax),%eax
8010804a:	83 e0 01             	and    $0x1,%eax
8010804d:	85 c0                	test   %eax,%eax
8010804f:	74 48                	je     80108099 <deallocuvm+0xa9>
      pa = PTE_ADDR(*pte);
80108051:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108054:	8b 00                	mov    (%eax),%eax
80108056:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010805b:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
8010805e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108062:	75 0d                	jne    80108071 <deallocuvm+0x81>
        panic("kfree");
80108064:	83 ec 0c             	sub    $0xc,%esp
80108067:	68 b1 89 10 80       	push   $0x801089b1
8010806c:	e8 26 85 ff ff       	call   80100597 <panic>
      char *v = p2v(pa);
80108071:	83 ec 0c             	sub    $0xc,%esp
80108074:	ff 75 ec             	pushl  -0x14(%ebp)
80108077:	e8 2b f5 ff ff       	call   801075a7 <p2v>
8010807c:	83 c4 10             	add    $0x10,%esp
8010807f:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80108082:	83 ec 0c             	sub    $0xc,%esp
80108085:	ff 75 e8             	pushl  -0x18(%ebp)
80108088:	e8 90 ab ff ff       	call   80102c1d <kfree>
8010808d:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80108090:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108093:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80108099:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801080a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080a3:	3b 45 0c             	cmp    0xc(%ebp),%eax
801080a6:	0f 82 73 ff ff ff    	jb     8010801f <deallocuvm+0x2f>
    }
  }
  return newsz;
801080ac:	8b 45 10             	mov    0x10(%ebp),%eax
}
801080af:	c9                   	leave  
801080b0:	c3                   	ret    

801080b1 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801080b1:	f3 0f 1e fb          	endbr32 
801080b5:	55                   	push   %ebp
801080b6:	89 e5                	mov    %esp,%ebp
801080b8:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
801080bb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801080bf:	75 0d                	jne    801080ce <freevm+0x1d>
    panic("freevm: no pgdir");
801080c1:	83 ec 0c             	sub    $0xc,%esp
801080c4:	68 b7 89 10 80       	push   $0x801089b7
801080c9:	e8 c9 84 ff ff       	call   80100597 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
801080ce:	83 ec 04             	sub    $0x4,%esp
801080d1:	6a 00                	push   $0x0
801080d3:	68 00 00 00 80       	push   $0x80000000
801080d8:	ff 75 08             	pushl  0x8(%ebp)
801080db:	e8 10 ff ff ff       	call   80107ff0 <deallocuvm>
801080e0:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801080e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801080ea:	eb 4f                	jmp    8010813b <freevm+0x8a>
    if(pgdir[i] & PTE_P){
801080ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801080f6:	8b 45 08             	mov    0x8(%ebp),%eax
801080f9:	01 d0                	add    %edx,%eax
801080fb:	8b 00                	mov    (%eax),%eax
801080fd:	83 e0 01             	and    $0x1,%eax
80108100:	85 c0                	test   %eax,%eax
80108102:	74 33                	je     80108137 <freevm+0x86>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80108104:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108107:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010810e:	8b 45 08             	mov    0x8(%ebp),%eax
80108111:	01 d0                	add    %edx,%eax
80108113:	8b 00                	mov    (%eax),%eax
80108115:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010811a:	83 ec 0c             	sub    $0xc,%esp
8010811d:	50                   	push   %eax
8010811e:	e8 84 f4 ff ff       	call   801075a7 <p2v>
80108123:	83 c4 10             	add    $0x10,%esp
80108126:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80108129:	83 ec 0c             	sub    $0xc,%esp
8010812c:	ff 75 f0             	pushl  -0x10(%ebp)
8010812f:	e8 e9 aa ff ff       	call   80102c1d <kfree>
80108134:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108137:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010813b:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108142:	76 a8                	jbe    801080ec <freevm+0x3b>
    }
  }
  kfree((char*)pgdir);
80108144:	83 ec 0c             	sub    $0xc,%esp
80108147:	ff 75 08             	pushl  0x8(%ebp)
8010814a:	e8 ce aa ff ff       	call   80102c1d <kfree>
8010814f:	83 c4 10             	add    $0x10,%esp
}
80108152:	90                   	nop
80108153:	c9                   	leave  
80108154:	c3                   	ret    

80108155 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108155:	f3 0f 1e fb          	endbr32 
80108159:	55                   	push   %ebp
8010815a:	89 e5                	mov    %esp,%ebp
8010815c:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010815f:	83 ec 04             	sub    $0x4,%esp
80108162:	6a 00                	push   $0x0
80108164:	ff 75 0c             	pushl  0xc(%ebp)
80108167:	ff 75 08             	pushl  0x8(%ebp)
8010816a:	e8 be f8 ff ff       	call   80107a2d <walkpgdir>
8010816f:	83 c4 10             	add    $0x10,%esp
80108172:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80108175:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108179:	75 0d                	jne    80108188 <clearpteu+0x33>
    panic("clearpteu");
8010817b:	83 ec 0c             	sub    $0xc,%esp
8010817e:	68 c8 89 10 80       	push   $0x801089c8
80108183:	e8 0f 84 ff ff       	call   80100597 <panic>
  *pte &= ~PTE_U;
80108188:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010818b:	8b 00                	mov    (%eax),%eax
8010818d:	83 e0 fb             	and    $0xfffffffb,%eax
80108190:	89 c2                	mov    %eax,%edx
80108192:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108195:	89 10                	mov    %edx,(%eax)
}
80108197:	90                   	nop
80108198:	c9                   	leave  
80108199:	c3                   	ret    

8010819a <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
8010819a:	f3 0f 1e fb          	endbr32 
8010819e:	55                   	push   %ebp
8010819f:	89 e5                	mov    %esp,%ebp
801081a1:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
801081a4:	e8 bc f9 ff ff       	call   80107b65 <setupkvm>
801081a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
801081ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801081b0:	75 0a                	jne    801081bc <copyuvm+0x22>
    return 0;
801081b2:	b8 00 00 00 00       	mov    $0x0,%eax
801081b7:	e9 e7 00 00 00       	jmp    801082a3 <copyuvm+0x109>
  for(i = 0; i < sz; i += PGSIZE){
801081bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801081c3:	e9 b3 00 00 00       	jmp    8010827b <copyuvm+0xe1>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801081c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081cb:	83 ec 04             	sub    $0x4,%esp
801081ce:	6a 00                	push   $0x0
801081d0:	50                   	push   %eax
801081d1:	ff 75 08             	pushl  0x8(%ebp)
801081d4:	e8 54 f8 ff ff       	call   80107a2d <walkpgdir>
801081d9:	83 c4 10             	add    $0x10,%esp
801081dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
801081df:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801081e3:	75 0d                	jne    801081f2 <copyuvm+0x58>
      panic("copyuvm: pte should exist");
801081e5:	83 ec 0c             	sub    $0xc,%esp
801081e8:	68 d2 89 10 80       	push   $0x801089d2
801081ed:	e8 a5 83 ff ff       	call   80100597 <panic>
    if(!(*pte & PTE_P))
801081f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801081f5:	8b 00                	mov    (%eax),%eax
801081f7:	83 e0 01             	and    $0x1,%eax
801081fa:	85 c0                	test   %eax,%eax
801081fc:	75 0d                	jne    8010820b <copyuvm+0x71>
      panic("copyuvm: page not present");
801081fe:	83 ec 0c             	sub    $0xc,%esp
80108201:	68 ec 89 10 80       	push   $0x801089ec
80108206:	e8 8c 83 ff ff       	call   80100597 <panic>
    pa = PTE_ADDR(*pte);
8010820b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010820e:	8b 00                	mov    (%eax),%eax
80108210:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108215:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
80108218:	e8 a1 aa ff ff       	call   80102cbe <kalloc>
8010821d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108220:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80108224:	74 66                	je     8010828c <copyuvm+0xf2>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108226:	83 ec 0c             	sub    $0xc,%esp
80108229:	ff 75 e8             	pushl  -0x18(%ebp)
8010822c:	e8 76 f3 ff ff       	call   801075a7 <p2v>
80108231:	83 c4 10             	add    $0x10,%esp
80108234:	83 ec 04             	sub    $0x4,%esp
80108237:	68 00 10 00 00       	push   $0x1000
8010823c:	50                   	push   %eax
8010823d:	ff 75 e4             	pushl  -0x1c(%ebp)
80108240:	e8 aa ce ff ff       	call   801050ef <memmove>
80108245:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
80108248:	83 ec 0c             	sub    $0xc,%esp
8010824b:	ff 75 e4             	pushl  -0x1c(%ebp)
8010824e:	e8 47 f3 ff ff       	call   8010759a <v2p>
80108253:	83 c4 10             	add    $0x10,%esp
80108256:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108259:	83 ec 0c             	sub    $0xc,%esp
8010825c:	6a 06                	push   $0x6
8010825e:	50                   	push   %eax
8010825f:	68 00 10 00 00       	push   $0x1000
80108264:	52                   	push   %edx
80108265:	ff 75 f0             	pushl  -0x10(%ebp)
80108268:	e8 64 f8 ff ff       	call   80107ad1 <mappages>
8010826d:	83 c4 20             	add    $0x20,%esp
80108270:	85 c0                	test   %eax,%eax
80108272:	78 1b                	js     8010828f <copyuvm+0xf5>
  for(i = 0; i < sz; i += PGSIZE){
80108274:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010827b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010827e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108281:	0f 82 41 ff ff ff    	jb     801081c8 <copyuvm+0x2e>
      goto bad;
  }
  return d;
80108287:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010828a:	eb 17                	jmp    801082a3 <copyuvm+0x109>
      goto bad;
8010828c:	90                   	nop
8010828d:	eb 01                	jmp    80108290 <copyuvm+0xf6>
      goto bad;
8010828f:	90                   	nop

bad:
  freevm(d);
80108290:	83 ec 0c             	sub    $0xc,%esp
80108293:	ff 75 f0             	pushl  -0x10(%ebp)
80108296:	e8 16 fe ff ff       	call   801080b1 <freevm>
8010829b:	83 c4 10             	add    $0x10,%esp
  return 0;
8010829e:	b8 00 00 00 00       	mov    $0x0,%eax
}
801082a3:	c9                   	leave  
801082a4:	c3                   	ret    

801082a5 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801082a5:	f3 0f 1e fb          	endbr32 
801082a9:	55                   	push   %ebp
801082aa:	89 e5                	mov    %esp,%ebp
801082ac:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801082af:	83 ec 04             	sub    $0x4,%esp
801082b2:	6a 00                	push   $0x0
801082b4:	ff 75 0c             	pushl  0xc(%ebp)
801082b7:	ff 75 08             	pushl  0x8(%ebp)
801082ba:	e8 6e f7 ff ff       	call   80107a2d <walkpgdir>
801082bf:	83 c4 10             	add    $0x10,%esp
801082c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
801082c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082c8:	8b 00                	mov    (%eax),%eax
801082ca:	83 e0 01             	and    $0x1,%eax
801082cd:	85 c0                	test   %eax,%eax
801082cf:	75 07                	jne    801082d8 <uva2ka+0x33>
    return 0;
801082d1:	b8 00 00 00 00       	mov    $0x0,%eax
801082d6:	eb 2a                	jmp    80108302 <uva2ka+0x5d>
  if((*pte & PTE_U) == 0)
801082d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082db:	8b 00                	mov    (%eax),%eax
801082dd:	83 e0 04             	and    $0x4,%eax
801082e0:	85 c0                	test   %eax,%eax
801082e2:	75 07                	jne    801082eb <uva2ka+0x46>
    return 0;
801082e4:	b8 00 00 00 00       	mov    $0x0,%eax
801082e9:	eb 17                	jmp    80108302 <uva2ka+0x5d>
  return (char*)p2v(PTE_ADDR(*pte));
801082eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082ee:	8b 00                	mov    (%eax),%eax
801082f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082f5:	83 ec 0c             	sub    $0xc,%esp
801082f8:	50                   	push   %eax
801082f9:	e8 a9 f2 ff ff       	call   801075a7 <p2v>
801082fe:	83 c4 10             	add    $0x10,%esp
80108301:	90                   	nop
}
80108302:	c9                   	leave  
80108303:	c3                   	ret    

80108304 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108304:	f3 0f 1e fb          	endbr32 
80108308:	55                   	push   %ebp
80108309:	89 e5                	mov    %esp,%ebp
8010830b:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
8010830e:	8b 45 10             	mov    0x10(%ebp),%eax
80108311:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80108314:	eb 7f                	jmp    80108395 <copyout+0x91>
    va0 = (uint)PGROUNDDOWN(va);
80108316:	8b 45 0c             	mov    0xc(%ebp),%eax
80108319:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010831e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108321:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108324:	83 ec 08             	sub    $0x8,%esp
80108327:	50                   	push   %eax
80108328:	ff 75 08             	pushl  0x8(%ebp)
8010832b:	e8 75 ff ff ff       	call   801082a5 <uva2ka>
80108330:	83 c4 10             	add    $0x10,%esp
80108333:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
80108336:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010833a:	75 07                	jne    80108343 <copyout+0x3f>
      return -1;
8010833c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108341:	eb 61                	jmp    801083a4 <copyout+0xa0>
    n = PGSIZE - (va - va0);
80108343:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108346:	2b 45 0c             	sub    0xc(%ebp),%eax
80108349:	05 00 10 00 00       	add    $0x1000,%eax
8010834e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
80108351:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108354:	3b 45 14             	cmp    0x14(%ebp),%eax
80108357:	76 06                	jbe    8010835f <copyout+0x5b>
      n = len;
80108359:	8b 45 14             	mov    0x14(%ebp),%eax
8010835c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
8010835f:	8b 45 0c             	mov    0xc(%ebp),%eax
80108362:	2b 45 ec             	sub    -0x14(%ebp),%eax
80108365:	89 c2                	mov    %eax,%edx
80108367:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010836a:	01 d0                	add    %edx,%eax
8010836c:	83 ec 04             	sub    $0x4,%esp
8010836f:	ff 75 f0             	pushl  -0x10(%ebp)
80108372:	ff 75 f4             	pushl  -0xc(%ebp)
80108375:	50                   	push   %eax
80108376:	e8 74 cd ff ff       	call   801050ef <memmove>
8010837b:	83 c4 10             	add    $0x10,%esp
    len -= n;
8010837e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108381:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108384:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108387:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
8010838a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010838d:	05 00 10 00 00       	add    $0x1000,%eax
80108392:	89 45 0c             	mov    %eax,0xc(%ebp)
  while(len > 0){
80108395:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108399:	0f 85 77 ff ff ff    	jne    80108316 <copyout+0x12>
  }
  return 0;
8010839f:	b8 00 00 00 00       	mov    $0x0,%eax
}
801083a4:	c9                   	leave  
801083a5:	c3                   	ret    
