;********************************************************************************************
; Author 1 Information:                                                                     *
; Name: Aaron Lieberman                                                                     *
; Email: AaronLieberman@csu.fullerton.edu                                                   *
;                                                                                           *
; Author 2 Information:                                                                     *
; Name:         Victor V. Vu                                                                *
; Email:        vuvictor@csu.fullerton.edu                                                  *
; Section:      Cpsc 240-07                                                                 *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Harmonic Series                                                             *
; This File: clock_check.asm                                                                *
; Description: Called by manager to find clock speed of cpu                                 *
;********************************************************************************************
; Copyright (C) 2022 Victor V. Vu                                                           *
; This program is free software: you can redistribute it and/or modify it under the terms   *
; of the GNU General Public License version 3 as published by the Free Software Foundation. *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;********************************************************************************************
; Programmed in Ubuntu-based Linux Platform.                                                *
; To run program, type in terminal: "sh r.sh"                                               *
;********************************************************************************************

extern printf
extern atof

global clock_check

segment .data

segment .bss

section .text

clock_check:

; 15 pushes for  for asssembly to backup
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf
 ;------------

mov r14, 0x80000003 ; save info about cpu in r14

section_loop:
xor r13, r13 ; clear space in r13

mov rax, r14 ; mov cpu into rax
cpuid ; read cpu id to get brand
inc r14 ; increment r14 to read the next set of info

push rdx ; 4th set of chars
push rcx ; 3rd set of chars
push rbx ; 2nd set of chars
push rax ; 1st set of chars

register_loop:
xor r12, r12 ; zero out the r12
pop rbx ; get new string of 4 chars

char_loop:
mov rdx, rbx ; move string of 4 chars to rdx
and rdx, 0xFF ; gets the first char in string
shr rbx, 0x8 ; shifts string to get next char in next iteration

cmp rdx, 64 ; 64 is the char value for the @ sign
jne counter ; leaves r11, does not set flag
mov r11, 1 ; flag and counter to start storing chars in r10

counter:
cmp r11, 1 ; checks if flag is true
jl body ; skips incrementing if flag is false
inc r11 ; increments counter if flag is true

body:
cmp r11, 4 ; counter is greater than 4
jl loop_conditions
cmp r11, 7 ; counter is less than 7
jg loop_conditions

shr r10, 0x8 ; r10 acts as a queue for characters
shl rdx, 0x18 ; moves new character from rdx into free space for r10
or r10, rdx ; combine the registers

loop_conditions:
inc r12
cmp r12, 4 ; char loop
jne char_loop

inc r13
cmp r13, 4 ; register loop
jne register_loop

inc r15
cmp r15, 2 ; string loop
jne section_loop

exit:
push r10
xor rax, rax
mov rdi, rsp
call atof  ; converts the string representing the clock speed to a float
pop r10    ; the value to be returned is already in xmm0, and will be returned

; 15 pops required for assembly
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp

ret  ; return to caller
