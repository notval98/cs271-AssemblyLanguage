TITLE Prime Numbers     (project4.asm)

; Author: Michael Hwang
; Last Modified: 2/20/2022
; OSU email address: hwangmic@oregonstate.edu
; Course number/section:   CS271 Section 400
; Project Number:  4               Due Date: 2/20/2022
; Description: 



INCLUDE Irvine32.inc

min		equ		1
max		equ		200

.data
greeting       byte    "Welcome to the Prime Number Generator by Michael Hwang",0
instruction    byte    "Enter the number of primes you would like to display [1 - 200]: ", 0
error           byte    "Number out of range, try again: ", 0
farewell		byte	"Thank you for using the program, goodbye. ", 0

threeSpaces byte "   ", 0
ten  byte 10

num			sdword	0



.code
main PROC

  call introduction

  call getUserData

  call showPrimes

  call farewell

  Invoke ExitProcess,0  
main ENDP
;=====================================


;function to print greeting to user
introduction PROC
  mov   edx, offset greeting
  call  WriteString
  call	CrLf

  ret
greetUser ENDP
;=====================================


;function to get user input for primes
getUserData PROC

top:      ;called until input is valid
  call	ReadInt ;read choice into eax
  cmp	eax, inputMin
  jl	error
  cmp	eax, inputMax
  jg	error
  ret

error:
  mov edx, offset error
  call WriteString
  call CrLf
  jmp top

getUserData ENDP
;=====================================


;prints 10 prime numbers per line with at least 3 spaces between 
showPrimes PROC
  
  
  ret
showPrimes ENDP
;=====================================


;print farewell message at end of program
farewell	PROC
  mov	edx, offset	farewell
  call	WriteString
  call CrLf

  ret
farewell ENDP
;=====================================


END main
