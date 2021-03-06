;Nick Mancuso
;CIS130-401
;
;This is short program to convert an 8-bit hex number into 
;binary and print it to the console
;-----------------------------------------------------------------------

title Hex to Binary Converter (p2bin08.asm)

.model small

.data

myNum byte 7ah

message db "Number in hex is 7A",0dh,0ah,"Its binary format is $"

numSize = 8

.code

main proc

	mov ax,@data					;mov data to ax
	mov ds,ax						;mov data from ax to data segment

	;set up message print
	mov ah,9h						;mov 9h to ah for INT21 call to print
								;	a '$' terminated string
								
	mov dx,OFFSET message			;set starting point for func 9h

	int 21h							;call 21h to print to console

	;set up L1 for printing myNum in binary
	mov bl,myNum					;mov myNum to bl for L1
	mov cx, numSize					;mov size of number to counter

	;mov 2h to ah to set up single char print from INT 21
	mov ah, 2h

	;L1 left carries each bit to overflow, and adds 30 to get the correct
	;ASCII char then calls DOS INT 21 to print it
	L1:	
							
		rcl bl, 1	
		mov dl, 30h
		adc dl, 0h
		int 21h
		loop L1

	;set up exit, call INT 21
	mov ax,4c00h
	int 21h

main endp

end main
