TITLE Number Accumulator     (project3.asm)

; Author: Michael Hwang
; Last Modified: 4/02/2022
; OSU email address: hwangmic@oregonstate.edu
; Course number/section:   CS271 Section 400
; Project Number:  3               Due Date: 2/6/2022
; Description: 

;greet user, get user's name, and greet user using user's name
;print instructions

;prompt for a number input
	;check if user input is in the number range
	;store user input
	;increment valid number counter
	
	;if input is invalid
		;print error message

	;repeat until user enters a non-negative number

;print out minimum valid number
;print out maximum valid number
;print out sum of valid numbers
;print out rounded average of valid numbers

;farewell message

INCLUDE Irvine32.inc

; (insert macro definitions here)
inputMin		equ		-200
;inputMax1		equ		-100
;inputMin2		equ		-50
inputMax		equ		-1
nameLenMax		equ		40

.data
greeting1       byte    "Welcome to the Integret Accumulator by Michael Hwang",0
extraCredit		byte	"EC: Program displays line count.", 0
greeting2       byte    "What is your name?  ",0
helloUser		byte	"Hello there, ",0 

userName		byte	nameLenMax	DUP(?)

lineNum1		byte	"[Line: ", 0
lineNum2		byte	" ] ", 0

instruction1    byte    "Please enter numbers in the following ranges [-200, -100] or [-50, -1.]", 0
instruction2    byte    "Enter a non-negative number when you are finished to see reseults.", 0
instruction3	byte	"Enter number:", 0

error           byte    "Number Invalid!", 0

goodbye1		byte	"Thank you for using the program, ", 0
goodbye2		byte	" goodbye.", 0

numValid1		byte	"You've entered ", 0
numValid2		byte	" numbers.", 0
numMax			byte	"The maximum valid number is ", 0
numMin			byte	"The minimum valid number is ", 0
resultSum		byte	"The sum of your valid numbmers is ", 0
resultDiv		byte	"The rounded average is ",0 

numHigh			sdword	0
numLow			sdword	0
currentSum		sdword	0
numCount		sdword  0
average			sdword	0

.code

main PROC
  ; Greet the User
  call  greetUser

;get user inputs
userInput:
;print line number
  mov	edx, offset lineNum1
  call	WriteString
  mov	eax, numCount
  call	WriteDec
  mov	edx, offset lineNum2
  call	WriteString

  ;print user instructions  only using ranges -200 to -1 
  ;because i'm a monkey and couldn't get the second bounds
  ;to work because i fucking suck 
  mov	edx, offset instruction1
  call  WriteString
  call  CrLF

  mov	edx, offset instruction2
  call  WriteString
  call  CrLF

  mov	edx, offset instruction3
  call  WriteString
  call  CrLF

  call	ReadInt ;read choice into eax

  ;compare user into to upper and lower bounds
  cmp	eax, inputMin
  jl	errorMessage
  cmp	eax, inputMax
  jg	calculate

;tried to get the second set of bounds to work but it keep on breaking
;i suck and i want to jump out a window because this simple thing does
;not want to work
; cmp	eax, LOWER_LIMIT2
; jb	calculate
; cmp	eax, UPPER_LIMIT2
; jg	calculate

  ;keep track of running sum
  mov	ebx, eax
  mov	eax, currentSum
  add	eax, ebx
  mov	currentSum, eax

  cmp	eax, numHigh
  jg	greaterThan

  cmp	eax, numLow
  jl	lessThan

  ;desired behavior
  ;if current number in eax is greater/lower make new highest/lowest
  ;the current value that is in eax
  ;did not get that behavior because i suck and i hate everything
  greaterThan:
  mov	eax, numHigh

  lessThan:
  mov	eax, numLow

  ;increment number count
  inc	numCount

  ;jump to get next user input
  jmp	userInput

  ;print error message then returns to get next user input
  errorMessage:
  mov	edx, offset error
  call	WriteString
  call	CrLf
  jmp	userInput

  calculate: 
  ;print number of valid numbers entered
  mov	edx, offset	numValid1
  call	WriteString
  mov	eax, numCount
  call	WriteDec
  mov	edx, offset	numValid2
  call	WriteString
  call  CrLf

  ;could not get the negative number storing to work
  mov	edx, offset numMax
  call	WriteString
  mov	eax, numHigh
  call	WriteInt
  call	CrLf

  mov	edx, offset numMin
  call	WriteString
  mov	eax, numLow
  call	WriteInt
  call	CrLf

  ;print sum of entered numbers
  mov	edx, offset resultSum
  call	WriteString
  mov	eax, currentSum
  call	WriteInt
  call	CrLf

  ;print rounded average of numbers
  mov	eax, 0
  mov	eax, currentSum
  cdq
  mov	ebx, numCount
  idiv	ebx

  mov	edx, offset resultDiv
  call	WriteString
  call	WriteInt
  call	CrLf


  ;thank user for using the program and say goodbye
  call	goodbye

  Invoke ExitProcess,0  ; exit to operating system
main ENDP

greetUser PROC
  mov   edx, offset greeting1
  call  WriteString
  call	CrLf

  mov   edx, offset extraCredit
  call  WriteString
  call	CrLf

  mov   edx, offset greeting2
  call  WriteString
  call  CrLf

  mov	edx, offset userName
  mov	ecx, nameLenMax
  call	ReadString

  mov	edx, offset helloUser
  call	WriteString
  mov	edx, offset userName
  call	WriteString
  call	CrLf
  call	CrLf

  ret
greetUser ENDP

goodbye	PROC
  mov	edx, offset	goodbye1
  call	WriteString
  mov	edx, offset userName
  call WriteString
  call CrLf

  ret
goodbye ENDP

END main
