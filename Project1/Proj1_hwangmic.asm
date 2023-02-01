TITLE Project1    (project1.asm)

; Author: Michael Hwang
; Last Modified: 1/23/2022
; OSU email address: hwangmic@oregonstate.edu
; Course number/section:   CS271 Section 400
; Project Number: 1                Due Date: 1/23/2022
; Description: This program will find the sums and differences of 3 numbers that are entered in decreasing. 
;			   The numbers must be entered in decreasing order for the program to work properly.
;			   If the user wants to repeat the program, enter 1 on the last prompt.
;			   Any non 1 inputs will end the program.

INCLUDE Irvine32.inc

.data
input1		SDWORD ?		;user input 1
input2		SDWORD ?		;user input 2
input3		SDWORD ?		;user input 3

sum1		SDWORD ?		;sum of A + B
sum2		SDWORD ?		;sum of A + C
sum3		SDWORD ?		;sum of B + C
sum4		SDWORD ?		;sum of A + B + C

dif1		SDWORD ?		;difference of A - B
dif2		SDWORD ?		;difference of A - C
dif3		SDWORD ?		;difference of B - C

prompt1		BYTE "First number: ", 0		;user input 1
prompt2		BYTE "Second number: ", 0		;user input 2
prompt3		BYTE "Third number: ", 0		;user input 3

intro1		BYTE "Elementary Arithmetic by Michael H.", 0
intro2		BYTE "**EC: Program repeats until user chooses to quit.", 0
instruction	BYTE "Enter 3 numbers A > B > C, and I'll show you the sums and differences.", 0
goodbye1	BYTE "Thanks for using Elementary Arithmetic!  Goodbye!", 0

plus		BYTE " + ", 0
minus		BYTE " - ", 0
equal		BYTE " = ",0

looper		BYTE "Would you like to try again? (1 for yes, != 1 for no): ", 0	;extra credit

.code
main PROC

;print title and purpose of program
	mov		edx, OFFSET intro1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET intro2
	call	WriteString
	call	CrLf
	call	CrLf

top:		;top of the user chosen loop

;print instruction text
	mov		edx, OFFSET instruction
	call	WriteString
	call	CrLf

;print prompt to get first user input
	mov		edx, OFFSET prompt1
	call	WriteString
	call	ReadInt
	mov		input1, eax

;print prompt to get second user input
	mov		edx, OFFSET prompt2
	call	WriteString
	call	ReadInt
	mov		input2, eax

;print prompt to get third user input
	mov		edx, OFFSET prompt3
	call	WriteString
	call	ReadInt
	mov		input3, eax

;calculations
;sum of A + B
	mov		eax, input1
	add		eax, input2
	mov		sum1, eax

;sum of A + C
	mov		eax, input1
	add		eax, input3
	mov		sum2, eax

;sum of B + C
	mov		eax, input2
	add		eax, input3
	mov		sum3, eax

;difference of A - B
	mov		eax, input1
	sub		eax, input2
	mov		dif1, eax

;difference of A - C
	mov		eax, input1
	sub		eax, input3
	mov		dif2, eax

;difference of B - C
	mov		eax, input2
	sub		eax, input3
	mov		dif3, eax

;sum of A + B + C
	;find the sum of A + B
	mov		eax, input1
	add		eax, input2
	mov		sum4, eax
	;adding C to the sum of A + B
	mov		eax, sum4
	add		eax, input3
	mov		sum4, eax


;print out sum A + B
	;print input 1
	mov		eax, input1
	call	WriteDec
	;print plus sign
	mov		edx, OFFSET plus
	call	WriteString
	;print input 2
	mov		eax, input2
	call	WriteDec
	;print equal sign
	mov		edx, OFFSET equal
	call	WriteString
	;print sum of first two inputs
	mov		eax, sum1
	call	WriteDec
	call	CrLF

;print out sum A + C
	;print input 1
	mov		eax, input1
	call	WriteDec
	;print plus sign
	mov		edx, OFFSET plus
	call	WriteString
	;print input 3
	mov		eax, input3
	call	WriteDec
	;print equal sign
	mov		edx, OFFSET equal
	call	WriteString
	;print sum of first two inputs
	mov		eax, sum2
	call	WriteDec
	call	CrLF

;print out sum B + C
	;print input 1
	mov		eax, input2
	call	WriteDec
	;print plus sign
	mov		edx, OFFSET plus
	call	WriteString
	;print input 2
	mov		eax, input3
	call	WriteDec
	;print equal sign
	mov		edx, OFFSET equal
	call	WriteString
	;print sum of first two inputs
	mov		eax, sum3
	call	WriteDec
	call	CrLF

;print out sum A - B
	;print input 1
	mov		eax, input1
	call	WriteDec
	;print minus sign
	mov		edx, OFFSET minus
	call	WriteString
	;print input 2
	mov		eax, input2
	call	WriteDec
	;print equal sign
	mov		edx, OFFSET equal
	call	WriteString
	;print sum of first two inputs
	mov		eax, dif1
	call	WriteDec
	call	CrLF

;print out sum A - C
	;print input 1
	mov		eax, input1
	call	WriteDec
	;print minus sign
	mov		edx, OFFSET minus
	call	WriteString
	;print input 3
	mov		eax, input3
	call	WriteDec
	;print equal sign
	mov		edx, OFFSET equal
	call	WriteString
	;print sum of first two inputs
	mov		eax, dif2
	call	WriteDec
	call	CrLF

;print out sum B - C
	;print input 2
	mov		eax, input2
	call	WriteDec
	;print minus sign
	mov		edx, OFFSET minus
	call	WriteString
	;print input 3
	mov		eax, input3
	call	WriteDec
	;print equal sign
	mov		edx, OFFSET equal
	call WriteString
	;print sum of first two inputs
	mov		eax, dif3
	call	WriteDec
	call	CrLF

;print out sum of A + B + C
	;print input 1
	mov		eax, input1
	call	WriteDec
	;print plus sign
	mov		edx, OFFSET plus
	call	WriteString
	;print input 2
	mov		eax, input2
	call	WriteDec
	;print plus sign
	mov		edx, OFFSET plus
	call	WriteString
	;print input 3
	mov		eax, input3
	call	WriteDec
	;print equal sign
	mov		edx, OFFSET equal
	call	WriteString
	;print sum of first two inputs
	mov		eax, sum4
	call	WriteDec
	call	CrLF

;do again loop
	mov		edx, OFFSET looper	;print loop message
	call	WriteString
	call	ReadInt				;read user input
	cmp		eax, 1				;compare user input to 1
	je		top					;jump to first number prompt if user input is 1

;print goodbye
	mov		edx, OFFSET goodbye1
	call	WriteString
	call	CrLf

Invoke ExitProcess,0	; exit to operating system

main ENDP

; (insert additional procedures here)

END main
