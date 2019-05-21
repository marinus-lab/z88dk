
	SECTION	code_fp_math32
	PUBLIC	_m32_floor
	PUBLIC	_m32_floor_fastcall

	EXTERN	m32_f2ulong
	EXTERN	m32_float32u
	EXTERN	m32_float32
	EXTERN	m32_unity
	EXTERN	m32_fssub_callee

; float floor(float f)
_m32_floor:
        pop     bc
        pop     hl
        pop     de
        push    de
        push    hl
        push    bc

; Entry: dehl = floating point number
_m32_floor_fastcall:
	bit	7,d
	push	af			;Save sign flag
	call	m32_f2ulong		;Exits dehl = number
	pop	af
	jr	nz,was_negative
	call	m32_float32u
	ret
was_negative:
	call	m32_float32
	; And subtract 1
	push	de
	push	hl
	call	m32_unity
	call	m32_fssub_callee
	ret