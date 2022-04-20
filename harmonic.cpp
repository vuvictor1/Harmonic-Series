/*
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Victor V. Vu                                                                *
; Email:        vuvictor@csu.fullerton.edu                                                  *
; Section:      Cpsc 240-07                                                                 *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Harmonic Series                                                             *
; This File: harmonic.cpp                                                                   *
; Description: Handles welcome and return text, calls on manager for computation            *
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
*/
// required headers
#include <cstdio>
#include <iomanip>
#include <iostream>
#include <string.h>
#include <time.h>

extern "C" double manager(); // includes manager as external function

int main() {

  std::cout << "\nWelcome to Harmonic Sum created by author Victor Vu." << std::endl << std::endl;

  double value = manager(); // Data is being returned from the assembly file

  std::cout << "\nThe main function received " << std::fixed << std::setprecision(10) << value << " and will keep it." << std::endl;

  return 0;
}
