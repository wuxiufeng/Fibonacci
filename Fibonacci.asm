global _start

section .text:
_start :

mov byte[loc],1
mov word[para],1
mov word[para2],1

mov ax,-1
PUSH ax ;sign

mov byte[argue],0

mov byte[colorsign],0

;read 1
_read :
mov eax,3
mov ebx,0
mov ecx,input
mov edx,1
int 80h

sub byte[input],30h

mov al,byte[input]

CMP al,0
JL _printfibonacci
CMP al,9
JG _printfibonacci
;else
mov ax,0
mov al,byte[argue]
mov bl,10
mul bl
movzx bx,byte[input]
add ax,bx
mov byte[argue],al ;argue=argue*10+input
JMP _read

_printfibonacci :
;color
movzx ax,byte[colorsign]
mov bl,7
div bl
mov byte[colorsign],ah

movzx ax,byte[argue]
CMP ax,1
JNG _printFirst

_calc :
;loc++
add byte[loc],1

;para=para+para2
mov ax,word[para]
mov word[tempPara],ax  ;temp=para
mov bx,word[para2]
add ax,bx
mov word[para],ax

mov ax,word[tempPara]
mov word[para2],ax

mov ax,word[para]
mov word[quotient],ax

mov al,byte[argue]
CMP al,byte[loc]
JG _calc

;print
_push :
mov ax,word[quotient]
mov dx,0
mov bx,10
div bx
mov word[remainder],dx
mov word[quotient],ax

mov ax,word[remainder]
PUSH ax

CMP word[quotient],0
JNE _push

;print
_nextprint :

POP ax
CMP ax,0
JL _line;jump if is negative
mov byte[result],al
add byte[result],30h

;color
CMP byte[colorsign],0
JE _set0
CMP byte[colorsign],1
JE _set1
CMP byte[colorsign],2
JE _set2
CMP byte[colorsign],3
JE _set3
CMP byte[colorsign],4
JE _set4
CMP byte[colorsign],5
JE _set5
CMP byte[colorsign],6
JE _set6

_set0:
mov eax,4
mov ebx,1
mov ecx,color1
mov edx,color1.length
int 80h
JMP _actual
_set1:
mov eax,4
mov ebx,1
mov ecx,color2
mov edx,color2.length
int 80h
JMP _actual
_set2:
mov eax,4
mov ebx,1
mov ecx,color3
mov edx,color3.length
int 80h
JMP _actual
_set3:
mov eax,4
mov ebx,1
mov ecx,color4
mov edx,color4.length
int 80h
JMP _actual
_set4:
mov eax,4
mov ebx,1
mov ecx,color5
mov edx,color5.length
int 80h
JMP _actual
_set5:
mov eax,4
mov ebx,1
mov ecx,color6
mov edx,color6.length
int 80h
JMP _actual
_set6:
mov eax,4
mov ebx,1
mov ecx,color7
mov edx,color7.length
int 80h
JMP _actual
_set7:
mov eax,4
mov ebx,1
mov ecx,color8
mov edx,color8.length
int 80h
JMP _actual

_actual :
mov eax,4
mov ebx,1
mov ecx,result
mov edx,1
int 80h
JMP _nextprint

_line :
mov eax,4
mov ebx,1
mov ecx,nextline
mov edx,1
int 80h

add byte[input],30h
CMP byte[input],0Ah
JE _exit

mov ax,-1
push ax

mov byte[argue],0
add byte[colorsign],1
JMP _read

_printFirst :
;color
CMP byte[colorsign],0
JE _setfirst0
CMP byte[colorsign],1
JE _setfirst1

_setfirst0:
mov eax,4
mov ebx,1
mov ecx,color1
mov edx,color1.length
int 80h
JMP _actual1
_setfirst1:
mov eax,4
mov ebx,1
mov ecx,color2
mov edx,color2.length
int 80h
JMP _actual1

_actual1 :
mov byte[temp],1
add byte[temp],30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,nextline
mov edx,1
int 80h

add byte[input],30h
CMP byte[input],0Ah
JE _exit

mov byte[argue],0
add byte[colorsign],1
JMP _read


_exit :
;color
mov eax,4
mov ebx,1
mov ecx,color8
mov edx,color8.length
int 80h

mov eax,1
mov ebx,0
int 80h

section .bss
input: resb 1
argue: resb 1
temp: resb 1
loc: resb 1
para2: resw 1
para: resw 1
tempPara: resw 1
result: resb 1
remainder: resw 1
quotient: resw 1
colorsign: resb 1

section .data
nextline: db 0Ah
section .data
color1: db 1Bh,'[31;1m',0
.length: equ $-color1
color2: db 1Bh,'[32;1m',0
.length: equ $-color2
color3: db 1Bh,'[33;1m',0
.length: equ $-color3
color4: db 1Bh,'[34;1m',0
.length: equ $-color4
color5: db 1Bh,'[35;1m',0
.length: equ $-color5
color6: db 1Bh,'[36;1m',0
.length: equ $-color6
color7: db 1Bh,'[37;1m',0
.length: equ $-color7
color8: db 1Bh,'[37;0m',0
.length: equ $-color8
