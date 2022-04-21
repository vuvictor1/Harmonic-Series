;********************************************************************************************
; Author Information:                                                                       *
; Name:         Victor V. Vu                                                                *
; Email:        vuvictor@csu.fullerton.edu                                                  *
; Section:      Cpsc 240-07                                                                 *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Harmonic Series                                                             *
; This File: compute_sum.asm                                                                *
; Description: Called by manager to compute the harmonic sum and calls on output_one_line   *
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
extern scanf

extern output_one_line

global compute_sum ; Allows manager to call file

segment .data ; Indicates initialized data

header db "Term#		   Sum", 10, 0
sum_return db 10, "The sum of %ld terms is %lf", 10, 0

segment .bss ; Indicates values that require user input

the_array resq 2 ; array of 6 quad words reserved before run time.

segment .text ; Stores executable code

compute_sum: ; instructs program to enter assembly

;Backs up 15 pushes, required for assembly
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

mov r12, rdi ; move userinput into r12

; print out the header
mov rax, 0
mov rdi, header
call printf

; get the fraction 1/n
; convert 1 to float
mov rax, 1
cvtsi2sd xmm15, rax
mov r11, 1 ;  set n = 1

loop_begin:
; make the fraction 1 / n
cvtsi2sd xmm14, r11 ; convert n = 1 to float
movsd xmm13, xmm15 ; save 1.0 in xmm13
divsd xmm13, xmm14 ; divide 1.0 by n
addsd xmm11, xmm13 ; save fraction into xxm11

; call output_one_line
mov rax, 1
mov rdi, r11
movsd xmm0, xmm11
mov rsi, r12
call output_one_line

inc r11
; if n = 1 comparison
cmp r11, r12
jg loop_end

jmp loop_begin

loop_end:

mov rax, 1
mov rdi, sum_return
mov rsi, r12
movsd xmm0, xmm11
call printf

movsd xmm0, xmm11

; Backs up 15 pops, required for assembly
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

ret ; return value to caller
