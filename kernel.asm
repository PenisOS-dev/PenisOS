	BITS 16			; we write 16 bit here

start:
	mov ax, 07C0h		; set up 4 kilobyte stack space after this
	add ax, 288		; 16 bytes per paragraph
	mov ss, ax
	mov sp, 4096

	mov ax, 07C0h
	mov ds, ax


	mov si, text_string	; call string function. si stands for source index (look that up if you need to)
	call print_string
	call option_menu

	jmp $			; everything loops back to here


	text_string db 'Welcome to PenisOS', 0


print_string:
	mov ah, 0Eh		; initialize 10h, the 'print char' function

option_menu:
	mov ax, os_version
	mov cx, 00000100b	; color code :O
	
	mov ax, option_1
	mov bx, option_2
	
	jmp option_menu

	os_version	db 'Version 0.0.1'
	
	option_1	db 'option 1'
	option_2	db 'option 2'

.repeat:
	lodsb			; get the string
	cmp al, 0
	je .done
	int 10h	
	jmp .repeat

.done:
	ret


	times 510-($-$$) db 0	; put zeroes on the remainder of the boot sector
	dw 0xAA55		; This is the standard assembly boot signature
