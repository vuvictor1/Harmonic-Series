/*
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Victor V. Vu                                                                *
; Email:        vuvictor@csu.fullerton.edu                                                  *
; Section:      Cpsc 240-07                                                                 *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Harmonic Series                                                             *
; This File: output_one_line.c                                                              *
; Description: Called by compute sum to output each series of harmonc sum                   *
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
#include <stdio.h>

extern void output_one_line(int i, double h_sum, int n);

// makes i value and outputs correct format
void output_one_line(int i, double h_sum, int n) {
  if (i < 100) {
    printf(" %d               %.9lf\n", i, h_sum);
  }
  else if (i % 84 == 0) {
    printf("%d               %.9lf\n", i, h_sum);
  }
  else if (i >= n) {
    printf("%d               %.9lf\n", n, h_sum);
  }
}
