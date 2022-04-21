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

global compute_sum ; Allows manager to call file

segment .data ; Indicates initialized data

header db "Term#		   Sum", 10, 0
int_format db "%ld", 0

segment .bss ; Indicates values that require user input

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

mov r11, rdi ; move userinput into r11

; print out the header
mov rax, 0
mov rdi, header
call printf

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
