org 0x7C00
bits 16

section .data
    myString db 'Hello, World!', 0
main:
    mov si, myString    ; Load the address of the string into si
    call print_string   ; Call the print_string subroutine
    call get_disk       ; Call the get_disk subroutine
    jmp $               ; Infinite loop

print_string:
    mov ah, 0x0E        ; Function code for teletype output
    xor bh, bh          ; Clear bh register (page number)

print_loop:
    lodsb               ; Load byte from [si] into al and increment si
    test al, al         ; Check if it's the null terminator (end of string)
    jz .halt            ; If it is, jump to the end
    int 0x10            ; Call BIOS interrupt to print the character
    jmp print_loop      ; Repeat the process for the next character

.halt:
    ret                 ; Return from subroutine

get_disk:
    mov ah, 0x02        ; Function code for read sectors
    mov al, 1           ; Number of sectors to read
    xor dl, dl          ; Drive number (assuming the first floppy drive)
    mov ax, 0x1000      ; Destination address segment (adjust as needed)
    mov es, ax          ; Set the segment register es
    xor bx, bx          ; Destination address offset
    int 0x13            ; Call BIOS interrupt for disk read
    ret

times 510-($-$$) db 0
dw 0xAA55

