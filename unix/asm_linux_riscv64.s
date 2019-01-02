// Copyright 2016-2019 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build !gccgo

#include "textflag.h"

//
// System calls for riscv64, Linux
//

// func Syscall(trap, a1, a2, a3 uintptr) (r1, r2 uintptr, err syscall.Errno)
TEXT ·Syscall(SB),NOSPLIT,$0-56
	JMP	syscall·Syscall(SB)

// func Syscall6(trap, a1, a2, a3, a4, a5, a6 uintptr) (r1, r2 uintptr, err syscall.Errno)
TEXT ·Syscall6(SB),NOSPLIT,$0-80
	JMP	syscall·Syscall6(SB)

// func SyscallNoError(trap, a1, a2, a3 uintptr) (r1, r2 uintptr)
TEXT ·SyscallNoError(SB),NOSPLIT,$0-48
	CALL	runtime·entersyscall(SB)
	MOV	a1+8(FP), A0
	MOV	a2+16(FP), A1
	MOV	a3+24(FP), A2
	MOV	$0, A3
	MOV	$0, A4
	MOV	$0, A5
	MOV	$0, A6
	MOV	trap+0(FP), A7	// syscall entry
	ECALL
	MOV	A0, r1+32(FP)	// r1
	MOV	A1, r2+40(FP)	// r2
	CALL	runtime·exitsyscall(SB)
	RET

// func RawSyscall6(trap, a1, a2, a3, a4, a5, a6 uintptr) (r1, r2 uintptr, err syscall.Errno)
TEXT ·RawSyscall(SB),NOSPLIT,$0-56
	JMP	syscall·RawSyscall(SB)

// func RawSyscall6(trap, a1, a2, a3, a4, a5, a6 uintptr) (r1, r2, err uintptr)
TEXT ·RawSyscall6(SB),NOSPLIT,$0-80
	JMP	syscall·RawSyscall6(SB)

// func RawSyscallNoError(trap, a1, a2, a3 uintptr) (r1, r2 uintptr)
TEXT ·RawSyscallNoError(SB),NOSPLIT,$0-48
	MOV	a1+8(FP), A0
	MOV	a2+16(FP), A1
	MOV	a3+24(FP), A2
	MOV	$0, A3
	MOV	$0, A4
	MOV	$0, A5
	MOV	$0, A6
	MOV	trap+0(FP), A7	// syscall entry
	ECALL
	MOV	A0, r1+32(FP)	// r1
	MOV	A1, r2+40(FP)	// r2
	RET
