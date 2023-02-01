TITLE Program Template     (Project5.asm)

; Author: 
; Last Modified:
; OSU email address: ONID_ID@oregonstate.edu
; Course number/section:   CS271 Section ???
; Project Number:                 Due Date:
; Description: This file is provided as a template from which you may work
;              when developing assembly projects in CS271.

INCLUDE Irvine32.inc

; (insert macro definitions here)

; (insert constant definitions here)
ARRAYSIZE = 200	;max size of array
LO = 10
HI = 29

.data
intro1		BYTE	"Generating, Sorting, and Counting Random Integers!", 0
intro2		BYTE	"Programmed by Michael", 0
intro3		BYTE	"This program generates 200 random numbers in the range [10 ... 29], displays the "
			BYTE	"original list, sorts the list, displays the median value of the list, displays the "
			BYTE	"list sorted in ascending order, then displays the number offset instances of each "
			BYTE	"generated value, starting with the number of 10s.", 0

unsort		BYTE	"Your unsorted random numbers: ", 0
median		BYTE	"The median value of the array: ", 0
sort		BYTE	"Your sorted random numbers: ",0
instances	BYTE	"Your list of instances of each generated number, starting with the number of 10s: ", 0

spaces		BYTE	" ", 0

goodbye		BYTE	"Goodbye, and thanks for using this program!", 0

array		DWORD	200 DUP(?)
countARRAY	DWORD	200 DUP(?)
cArraySize	DWORD	0

.code
main PROC
	;introduce the program
	push OFFSET intro1
	push OFFSET intro2
	push OFFSET intro3
	call introduction

	;fill the array
	push OFFSET array
	push ARRAYSIZE
	push HI
	push LO
	call fillArray
	call CrLf

	;display text for unsorted array
	push OFFSET unsort
	call displayTitle
	call CrLf

	;display the unsorted list
	push OFFSET array
	push ARRAYSIZE
	push OFFSET spaces
	call displayArray ;display array call 1
	call CrLf
	call CrLf

	;sort the array
	push OFFSET array
	push ARRAYSIZE
	call sortList

	;display text for median
	push OFFSET median
	call displayTitle

	;display median
	push OFFSET array
	push ARRAYSIZE 
	call displayMedian
	call CrLf
	call CrLf

	;display text for sorted array
	push OFFSET sort
	call displayTitle
	call CrLf

	;display sorted list
	push OFFSET array
	push ARRAYSIZE
	push OFFSET spaces
	call displayArray ;display array call 2
	call CrLf
	call CrLf

	;display text for instances list
	push OFFSET instances
	call displayTitle
	call CrLf

	;count the numbers in the array and store them in countArray
;	push OFFSET array
;	push OFFSET countArray
;	push ARRAYSIZE
;	push OFFSET cArraySize
;	call countList

	;display the counted array
;	push OFFSET countArray
;	push cArraySize
;	push OFFSET spaces
;	call displayArray ;display array call 3
;	call CrLf
;	call CrLf

	;display goodbye message
	push OFFSET goodbye
	call displayTitle
	CALL CrLf

	exit
main ENDP

;introduces the program
;receives: addresses of intro1, intro2, and intro3
;registers changed: ebp, edx
introduction PROC
	push ebp
	mov ebp, esp

	mov edx, [ebp+16]
	call WriteString
	call CrLf

	mov edx, [ebp+12]
	call WriteString
	call CrLf
	call CrLf

	mov edx, [ebp+8]
	call WriteString
	call CrLf

	pop ebp
	ret 12
introduction ENDP

;fills array with random numbers within the specified range
;receives: address of array, array's size, upper and lower bounds
;registers change: ebp, ecx, eax
fillArray PROC
	push ebp
	mov ebp, esp

	mov esi, [ebp+20] ;address of array
	mov ecx, [ebp+16] ;arraySize

	getNumber:
	;generate a random number within our range
	mov eax, [ebp+12] ;hi
	sub eax, [ebp+8] ;lo
	inc eax
	call RandomRange
	add eax, [ebp+8] ;lo

	;store the random number in our next array position
	mov [esi], eax
	add esi, 4
	loop getNumber

	pop ebp
	ret 16
fillArray ENDP

;dispay the title of the upcoming array
;receives: address of title to display
;registers changed: ebp, edx
displayTitle PROC
	push ebp
	mov ebp, esp

	mov edx, [ebp+8] ;whichever string was pushed in main
	call WriteString

	pop ebp
	ret 4
displayTitle ENDP

;displays the called array
;receives: address of array, size of the array, and spaces string
;registers changed: ebp, ecx, edx, ebx, eax
displayArray PROC
	push ebp
	mov ebp, esp

	;setup the list and counter
	mov esi, [ebp+16] ;address of array
	mov ecx, [ebp+12] ;arraySize
	mov edx, [ebp+8] ;spaces

	;setup a columns counter
	mov ebx, 20

	;display the array
	L1:
	mov eax, [esi]
	call WriteDec
	call WriteString
	add esi, 4
	dec ebx
	cmp ebx, 0
	jnz continue

	;if out of columns, make a new line
	mov ebx, 20 ;reset columns counter
	call CrLf
	continue:
	loop L1

	pop ebp
	ret 12
displayArray ENDP

;sort the list from lowest to highest
;works by comparing the first number in the list to the rest of the numbers
;if a number that is lower than the current number is found, the two are switched
;and the sear5ch starts over from th beginning of that current number
;once that number reaches an endpoint i.e. no more numbers to switch
;the function move to the next number in the list and does the same
;receives: address of array, array's size
;registers cahnged: ebp, ecx, ebx, eax
sortList PROC
	push ebp
	mov ebp, esp

	mov ecx, [ebp+8] ;arraySize
	mov esi, [ebp+12] ;array
	sub ecx, 1 ;keep the loop in bounds

	start:
	push esi
	mov ebx, 0

	compare: 
	mov eax, [esi] ;move the next number into eax
	cmp eax, [esi+4] ;compare numbers
	jg switch ;jump here if numbers need to be switched
	inc ebx ;if no switch occurs, add ebx to the counter
	add esi, 4
	cmp ebx, ecx ;compare with what's left
	je L1 ;if no more numbers loop around again
	jmp compare

	switch:
	push eax
	push ebx
	call exchangeElements
	pop ebx
	pop eax
	pop esi
	jmp start

	;if no switch, and at max, loop to the next number to be compared
	L1:
	pop esi
	add esi, 4
	loop start

	pop ebp
	ret 8 
sortList ENDP

;swaps elements at current ESI position with element assuming it is a DWORD
;at next position +4 address
;recieves: esi pointed to array position (must be setup before calling)
;registers changed: ebp, eax, ebx
exchangeElements PROC
	push ebp
	mov ebp, esp

	;swap elements in array
	mov eax, [esi] ;current number
	mov ebx, [esi+4] ;next number in array
	mov [esi], ebx
	mov [esi+4], eax

	pop ebp
	ret
exchangeElements ENDP

;displays the median in an array
;receives: array, array's total size, address of median variable
;registers changed: ebp, ebx, edx, eax
displayMedian PROC
	push ebp
	mov ebp, esp
	mov ebx, 2
	mov esi, [ebp+12] ;array

	;check if list size is even or odd
	mov edx, 0
	mov eax, [ebp+8] ;arraySize
	cdq
	idiv ebx
	mov ecx, eax ;move into the counter for following loops
	cmp edx, 0 ;if 0, arraySize is even
	je L2

	;odd array
	mov ecx, eax
	sub ecx, 1
	L1:
	add esi, 4
	loop L1
	mov eax, [esi]
	jmp continue

	;even array
	L2:
	add esi, 4
	loop L2
	;if no direct media, combine two middle numebrs to get average of those
	mov eax, [esi]
	add eax, [esi-4]
	mov ebx, 2
	mov ebx, 2
	cdq
	idiv ebx

	;display the new median
	continue: 
	call WriteDec

	pop ebp
	ret 8
displayMedian ENDP

;counts the number of instances of each number
;receives: address of array, array's size
;registers changed: ebp, ecx, eax, ebx, edx
countList PROC

countList ENDP

addToList PROC
	
addToList ENDP

END main