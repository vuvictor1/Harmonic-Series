;********************************************************************************************
; Author Information:                                                                       *
; Name:         Victor V. Vu                                                                *
; Email:        vuvictor@csu.fullerton.edu                                                  *
; Section:      Cpsc 240-07                                                                 *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Harmonic Series                                                             *
; This File: manager.asm                                                                    *
; Description: Called by harmonic to ask prompt and then calls on compute_sum for sum       *
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

extern compute_sum
extern output_one_line
extern clock_check

global manager ; Giving the function global scope

segment .data ; Indicates initialized data

item_prompt db "How many terms do you want to include? ", 0
int_format db "%ld", 0
time_tick db "Thank you. The time is now %lu tics.", 10
          db "The computation has begun.", 10, 10, 0
end_tick db 10, "The time is now %lu tics", 10, 10, 0
elapsed_time db "The elapsed time is %lu tics", 10, 10, 0
cpu_speed db "An Intel processor was detected. Your processor frequency in GHz: %.2lf GHz", 10, 10, 0
nanoseconds db "The elapsed time equals %lf nanoseconds", 10, 0
seconds db "The elapsed time equals %lf seconds", 10, 0
exit db 10, "The sum will be returned to the caller module.", 10, 0

segment .bss ; Indicates values that require user input

segment .text ; Stores executable code

manager: ; = int main() {} <--- assembly enters program

; Required 15 pushes and pops for asssembly to run
push       rbp

mov        rbp, rsp
push       rbx
push       rcx
push       rdx
push       rsi
push       rdi
push       r8
push       r9
push       r10
push       r11
push       r12
push       r13
push       r14
push       r15
pushf

; ask user for number of items
mov rax, 0
mov rdi, item_prompt
call printf

; take in user input
mov rdi, int_format
mov rsi, rsp
call scanf
; save input
mov r13, [rsp]

;Tick Calulator
;----------------------------------------------------
; clear space in rax & rdx
mov rax, 0
mov rdx, 0

cpuid ; get cpu information
rdtsc ; program reads time stamp

shl rdx, 32 ; shift 32 bits to the left
add rdx, rax ; add other half of ticks into rdx
mov r15, rdx ; store ticks into register 15

; print out starting tick
mov rax, 0
mov rdi, time_tick
mov rsi, r15
call printf

; call compute sum function
mov rax, 0
mov rdi, r13
call compute_sum

; find end tics time info
cpuid
rdtsc

; complete end tic
shl rdx, 32
add rdx, rax
mov r14, rdx ; store into r14

; print out end tics
mov rax, 0
mov rdi, end_tick
mov rsi, r14
call printf

; get elapsed_time of tick
; convert r15 and r 14 into floats
cvtsi2sd xmm15, r15
cvtsi2sd xmm14, r14

subsd xmm14, xmm15 ; take tic end minus with tic start
movsd xmm15, xmm14 ; store it inside xmm15
movsd xmm12, xmm15 ; copy elapsed_time

; print out elapsed tics
mov rax, 0
mov rdi, elapsed_time
movsd xmm0, xmm15
call printf

; get cpu speed
mov rax, 1
call clock_check
movsd xmm13, xmm0

; print cpu speed
mov rax, 1
mov rdi, cpu_speed
movsd xmm0, xmm13
call printf

 ;divide clockspeed with elapsed tics for nanoseconds
divsd xmm12, xmm13

; print out nanoseconds
;mov rax, 1
;mov rdi, nanoseconds
;movsd xmm0, xmm12
;call printf

; move 1 billion into xmm11
mov rax, 0x41cdcd6500000000
push rax
movsd xmm11, [rsp] ; dereference top of stack to move value
pop rax

; divide nanoseconds by 1 billion to get seconds
divsd xmm12, xmm11

; print out seconds
mov rax, 1
mov rdi, seconds
movsd xmm0, xmm12
call printf

; exit output before going back to main
mov rax, 0
mov rdi, exit
call printf

xorpd xmm0, xmm0 ; place holder to return 0

; Backs up 15 pushes and pop, required for assembly
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp

ret ; return statemnt
