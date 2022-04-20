#!/bin/bash

#;********************************************************************************************
#; Author: Victor V. Vu                                                                      *
#; Section: Cpsc 240-07                                                                      *
#; Descrption: BASH compilation file                                                         *
#;                                                                                           *
#; Copyright (C) 2022 Victor V. Vu                                                           *
#; This program is free software: you can redistribute it and/or modify it under the terms   *
#; of the GNU General Public License version 3 as published by the Free Software Foundation. *
#; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
#; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
#; See the GNU General Public License for more details. A copy of the GNU General Public     *
#; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
#;********************************************************************************************
#; Programmed in Ubuntu-based Linux Platform.                                                *
#; To run program, type in terminal: "sh r.sh"                                               *
#*********************************************************************************************

#Removes old files when creating a new compilation
rm *.o
rm *.out

echo "Compiling files..."

#Compiles the assembly code
nasm -f elf64 -o clock_check.o clock_check.asm #-g -gdwarf

#Compiles the C++ code
g++ -c -m64 -std=c++17 -fno-pie -no-pie -o harmonic.o harmonic.cpp #-g

#Compiles the assembly code
nasm -f elf64 -o manager.o manager.asm #-g -gdwarf

#Link files together
g++ -m64 -std=c++17 -fno-pie -no-pie -o ./linked.out clock_check.o harmonic.o manager.o -lm #-g

echo "Compilation successful! Running Program:"

#Runs the file linked.out
./linked.out
