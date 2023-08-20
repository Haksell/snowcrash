(gdb) disassemble
Dump of assembler code for function main:
   0x08048946 <+0>:	push   %ebp
   0x08048947 <+1>:	mov    %esp,%ebp
   0x08048949 <+3>:	push   %ebx
   0x0804894a <+4>:	and    $0xfffffff0,%esp
   0x0804894d <+7>:	sub    $0x120,%esp
   0x08048953 <+13>:	mov    %gs:0x14,%eax
   0x08048959 <+19>:	mov    %eax,0x11c(%esp)
   0x08048960 <+26>:	xor    %eax,%eax
   0x08048962 <+28>:	movl   $0x0,0x10(%esp)
   0x0804896a <+36>:	movl   $0x0,0xc(%esp)
   0x08048972 <+44>:	movl   $0x1,0x8(%esp)
   0x0804897a <+52>:	movl   $0x0,0x4(%esp)
   0x08048982 <+60>:	movl   $0x0,(%esp)
   0x08048989 <+67>:	call   0x8048540 <ptrace@plt>
   0x0804898e <+72>:	test   %eax,%eax
   0x08048990 <+74>:	jns    0x80489a8 <main+98>
   0x08048992 <+76>:	movl   $0x8048fa8,(%esp)
   0x08048999 <+83>:	call   0x80484e0 <puts@plt>
   0x0804899e <+88>:	mov    $0x1,%eax
   0x080489a3 <+93>:	jmp    0x8048eb2 <main+1388>
   0x080489a8 <+98>:	movl   $0x8048fc4,(%esp)
   0x080489af <+105>:	call   0x80484d0 <getenv@plt>
   0x080489b4 <+110>:	test   %eax,%eax
   0x080489b6 <+112>:	je     0x80489ea <main+164>
   0x080489b8 <+114>:	mov    0x804b040,%eax
   0x080489bd <+119>:	mov    %eax,%edx
   0x080489bf <+121>:	mov    $0x8048fd0,%eax
   0x080489c4 <+126>:	mov    %edx,0xc(%esp)
   0x080489c8 <+130>:	movl   $0x25,0x8(%esp)
   0x080489d0 <+138>:	movl   $0x1,0x4(%esp)
   0x080489d8 <+146>:	mov    %eax,(%esp)
   0x080489db <+149>:	call   0x80484c0 <fwrite@plt>
   0x080489e0 <+154>:	mov    $0x1,%eax
   0x080489e5 <+159>:	jmp    0x8048eb2 <main+1388>
   0x080489ea <+164>:	movl   $0x0,0x4(%esp)
   0x080489f2 <+172>:	movl   $0x8048ff6,(%esp)
   0x080489f9 <+179>:	call   0x8048500 <open@plt>
   0x080489fe <+184>:	test   %eax,%eax
   0x08048a00 <+186>:	jle    0x8048a34 <main+238>
   0x08048a02 <+188>:	mov    0x804b040,%eax
   0x08048a07 <+193>:	mov    %eax,%edx
   0x08048a09 <+195>:	mov    $0x8048fd0,%eax
   0x08048a0e <+200>:	mov    %edx,0xc(%esp)
   0x08048a12 <+204>:	movl   $0x25,0x8(%esp)
   0x08048a1a <+212>:	movl   $0x1,0x4(%esp)
   0x08048a22 <+220>:	mov    %eax,(%esp)
   0x08048a25 <+223>:	call   0x80484c0 <fwrite@plt>
   0x08048a2a <+228>:	mov    $0x1,%eax
   0x08048a2f <+233>:	jmp    0x8048eb2 <main+1388>
   0x08048a34 <+238>:	movl   $0x0,0x4(%esp)
   0x08048a3c <+246>:	movl   $0x8049009,(%esp)
   0x08048a43 <+253>:	call   0x804871c <syscall_open>
   0x08048a48 <+258>:	mov    %eax,0x14(%esp)
   0x08048a4c <+262>:	cmpl   $0xffffffff,0x14(%esp)
   0x08048a51 <+267>:	jne    0x8048e88 <main+1346>
   0x08048a57 <+273>:	mov    0x804b040,%eax
   0x08048a5c <+278>:	mov    %eax,%edx
   0x08048a5e <+280>:	mov    $0x804901c,%eax
   0x08048a63 <+285>:	mov    %edx,0xc(%esp)
   0x08048a67 <+289>:	movl   $0x46,0x8(%esp)
   0x08048a6f <+297>:	movl   $0x1,0x4(%esp)
   0x08048a77 <+305>:	mov    %eax,(%esp)
   0x08048a7a <+308>:	call   0x80484c0 <fwrite@plt>
   0x08048a7f <+313>:	mov    $0x1,%eax
   0x08048a84 <+318>:	jmp    0x8048eb2 <main+1388>
   0x08048a89 <+323>:	movl   $0x8049063,0x4(%esp)
   0x08048a91 <+331>:	lea    0x1c(%esp),%eax
   0x08048a95 <+335>:	mov    %eax,(%esp)
   0x08048a98 <+338>:	call   0x8048843 <isLib>
   0x08048a9d <+343>:	test   %eax,%eax
   0x08048a9f <+345>:	je     0x8048aae <main+360>
   0x08048aa1 <+347>:	movl   $0x1,0x10(%esp)
   0x08048aa9 <+355>:	jmp    0x8048e89 <main+1347>
   0x08048aae <+360>:	cmpl   $0x0,0x10(%esp)
   0x08048ab3 <+365>:	je     0x8048e89 <main+1347>
   0x08048ab9 <+371>:	movl   $0x8049068,0x4(%esp)
   0x08048ac1 <+379>:	lea    0x1c(%esp),%eax
   0x08048ac5 <+383>:	mov    %eax,(%esp)
   0x08048ac8 <+386>:	call   0x8048843 <isLib>
   0x08048acd <+391>:	test   %eax,%eax
   0x08048acf <+393>:	je     0x8048e46 <main+1280>
   0x08048ad5 <+399>:	mov    0x804b060,%eax
   0x08048ada <+404>:	mov    %eax,%edx
   0x08048adc <+406>:	mov    $0x804906c,%eax
   0x08048ae1 <+411>:	mov    %edx,0xc(%esp)
   0x08048ae5 <+415>:	movl   $0x20,0x8(%esp)
   0x08048aed <+423>:	movl   $0x1,0x4(%esp)
   0x08048af5 <+431>:	mov    %eax,(%esp)
   0x08048af8 <+434>:	call   0x80484c0 <fwrite@plt>
   0x08048afd <+439>:	call   0x80484b0 <getuid@plt>
   0x08048b02 <+444>:	mov    %eax,0x18(%esp)
   0x08048b06 <+448>:	mov    0x18(%esp),%eax
   0x08048b0a <+452>:	cmp    $0xbbe,%eax
   0x08048b0f <+457>:	je     0x8048ccb <main+901>
   0x08048b15 <+463>:	cmp    $0xbbe,%eax
   0x08048b1a <+468>:	ja     0x8048b68 <main+546>
   0x08048b1c <+470>:	cmp    $0xbba,%eax
   0x08048b21 <+475>:	je     0x8048c3b <main+757>
   0x08048b27 <+481>:	cmp    $0xbba,%eax
   0x08048b2c <+486>:	ja     0x8048b4d <main+519>
   0x08048b2e <+488>:	cmp    $0xbb8,%eax
   0x08048b33 <+493>:	je     0x8048bf3 <main+685>
   0x08048b39 <+499>:	cmp    $0xbb8,%eax
   0x08048b3e <+504>:	ja     0x8048c17 <main+721>
   0x08048b44 <+510>:	test   %eax,%eax
   0x08048b46 <+512>:	je     0x8048bc6 <main+640>
   0x08048b48 <+514>:	jmp    0x8048e06 <main+1216>
   0x08048b4d <+519>:	cmp    $0xbbc,%eax
   0x08048b52 <+524>:	je     0x8048c83 <main+829>
   0x08048b58 <+530>:	cmp    $0xbbc,%eax
   0x08048b5d <+535>:	ja     0x8048ca7 <main+865>
   0x08048b63 <+541>:	jmp    0x8048c5f <main+793>
   0x08048b68 <+546>:	cmp    $0xbc2,%eax
   0x08048b6d <+551>:	je     0x8048d5b <main+1045>
   0x08048b73 <+557>:	cmp    $0xbc2,%eax
   0x08048b78 <+562>:	ja     0x8048b95 <main+591>
   0x08048b7a <+564>:	cmp    $0xbc0,%eax
   0x08048b7f <+569>:	je     0x8048d13 <main+973>
   0x08048b85 <+575>:	cmp    $0xbc0,%eax
   0x08048b8a <+580>:	ja     0x8048d37 <main+1009>
   0x08048b90 <+586>:	jmp    0x8048cef <main+937>
   0x08048b95 <+591>:	cmp    $0xbc4,%eax
   0x08048b9a <+596>:	je     0x8048da3 <main+1117>
   0x08048ba0 <+602>:	cmp    $0xbc4,%eax
   0x08048ba5 <+607>:	jb     0x8048d7f <main+1081>
   0x08048bab <+613>:	cmp    $0xbc5,%eax
   0x08048bb0 <+618>:	je     0x8048dc4 <main+1150>
   0x08048bb6 <+624>:	cmp    $0xbc6,%eax
   0x08048bbb <+629>:	je     0x8048de5 <main+1183>
   0x08048bc1 <+635>:	jmp    0x8048e06 <main+1216>
   0x08048bc6 <+640>:	mov    0x804b060,%eax
   0x08048bcb <+645>:	mov    %eax,%edx
   0x08048bcd <+647>:	mov    $0x8049090,%eax
   0x08048bd2 <+652>:	mov    %edx,0xc(%esp)
   0x08048bd6 <+656>:	movl   $0x21,0x8(%esp)
   0x08048bde <+664>:	movl   $0x1,0x4(%esp)
   0x08048be6 <+672>:	mov    %eax,(%esp)
   0x08048be9 <+675>:	call   0x80484c0 <fwrite@plt>
   0x08048bee <+680>:	jmp    0x8048e2f <main+1257>
   0x08048bf3 <+685>:	mov    0x804b060,%eax
   0x08048bf8 <+690>:	mov    %eax,%ebx
   0x08048bfa <+692>:	movl   $0x80490b2,(%esp)
   0x08048c01 <+699>:	call   0x8048604 <ft_des>
   0x08048c06 <+704>:	mov    %ebx,0x4(%esp)
   0x08048c0a <+708>:	mov    %eax,(%esp)
   0x08048c0d <+711>:	call   0x8048530 <fputs@plt>
   0x08048c12 <+716>:	jmp    0x8048e2f <main+1257>
   0x08048c17 <+721>:	mov    0x804b060,%eax
   0x08048c1c <+726>:	mov    %eax,%ebx
   0x08048c1e <+728>:	movl   $0x80490cc,(%esp)
   0x08048c25 <+735>:	call   0x8048604 <ft_des>
   0x08048c2a <+740>:	mov    %ebx,0x4(%esp)
   0x08048c2e <+744>:	mov    %eax,(%esp)
   0x08048c31 <+747>:	call   0x8048530 <fputs@plt>
   0x08048dc2 <+1148>:	jmp    0x8048e2f <main+1257>
   0x08048dc4 <+1150>:	mov    0x804b060,%eax
   0x08048dc9 <+1155>:	mov    %eax,%ebx
   0x08048dcb <+1157>:	movl   $0x8049204,(%esp)
   0x08048dd2 <+1164>:	call   0x8048604 <ft_des>
   0x08048dd7 <+1169>:	mov    %ebx,0x4(%esp)
   0x08048ddb <+1173>:	mov    %eax,(%esp)
   0x08048dde <+1176>:	call   0x8048530 <fputs@plt>
   0x08048de3 <+1181>:	jmp    0x8048e2f <main+1257>
   0x08048de5 <+1183>:	mov    0x804b060,%eax
   0x08048dea <+1188>:	mov    %eax,%ebx
   0x08048dec <+1190>:	movl   $0x8049220,(%esp)
   0x08048df3 <+1197>:	call   0x8048604 <ft_des>
   0x08048df8 <+1202>:	mov    %ebx,0x4(%esp)
   0x08048dfc <+1206>:	mov    %eax,(%esp)
   0x08048dff <+1209>:	call   0x8048530 <fputs@plt>
   0x08048e04 <+1214>:	jmp    0x8048e2f <main+1257>
   0x08048e06 <+1216>:	mov    0x804b060,%eax
   0x08048e0b <+1221>:	mov    %eax,%edx
   0x08048e0d <+1223>:	mov    $0x8049248,%eax
   0x08048e12 <+1228>:	mov    %edx,0xc(%esp)
   0x08048e16 <+1232>:	movl   $0x38,0x8(%esp)
   0x08048e1e <+1240>:	movl   $0x1,0x4(%esp)
   0x08048e26 <+1248>:	mov    %eax,(%esp)
   0x08048e29 <+1251>:	call   0x80484c0 <fwrite@plt>
   0x08048e2e <+1256>:	nop
   0x08048e2f <+1257>:	mov    0x804b060,%eax
   0x08048e34 <+1262>:	mov    %eax,0x4(%esp)
   0x08048e38 <+1266>:	movl   $0xa,(%esp)
   0x08048e3f <+1273>:	call   0x8048520 <fputc@plt>
   0x08048e44 <+1278>:	jmp    0x8048ead <main+1383>
   0x08048e46 <+1280>:	movl   $0x8049281,0x4(%esp)
   0x08048e4e <+1288>:	lea    0x1c(%esp),%eax
   0x08048e52 <+1292>:	mov    %eax,(%esp)
   0x08048e55 <+1295>:	call   0x80487be <afterSubstr>
   0x08048e5a <+1300>:	test   %eax,%eax
   0x08048e5c <+1302>:	jne    0x8048e89 <main+1347>
   0x08048e5e <+1304>:	mov    0x804b040,%eax
   0x08048e63 <+1309>:	mov    %eax,%edx
   0x08048e65 <+1311>:	mov    $0x8049294,%eax
   0x08048e6a <+1316>:	mov    %edx,0xc(%esp)
   0x08048e6e <+1320>:	movl   $0x30,0x8(%esp)
   0x08048e76 <+1328>:	movl   $0x1,0x4(%esp)
   0x08048e7e <+1336>:	mov    %eax,(%esp)
   0x08048e81 <+1339>:	call   0x80484c0 <fwrite@plt>
   0x08048e86 <+1344>:	jmp    0x8048ead <main+1383>
   0x08048e88 <+1346>:	nop
   0x08048e89 <+1347>:	mov    0x14(%esp),%eax
   0x08048e8d <+1351>:	mov    %eax,0x8(%esp)
   0x08048e91 <+1355>:	movl   $0x100,0x4(%esp)
   0x08048e99 <+1363>:	lea    0x1c(%esp),%eax
   0x08048e9d <+1367>:	mov    %eax,(%esp)
   0x08048ea0 <+1370>:	call   0x804874c <syscall_gets>
   0x08048ea5 <+1375>:	test   %eax,%eax
   0x08048ea7 <+1377>:	jne    0x8048a89 <main+323>
   0x08048ead <+1383>:	mov    $0x0,%eax
   0x08048eb2 <+1388>:	mov    0x11c(%esp),%edx
   0x08048eb9 <+1395>:	xor    %gs:0x14,%edx
   0x08048ec0 <+1402>:	je     0x8048ec7 <main+1409>
   0x08048ec2 <+1404>:	call   0x80484a0 <__stack_chk_fail@plt>
   0x08048ec7 <+1409>:	mov    -0x4(%ebp),%ebx
   0x08048eca <+1412>:	leave  
   0x08048ecb <+1413>:	ret    
End of assembler dump.