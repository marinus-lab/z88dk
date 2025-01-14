
; int isprint(int c)

SECTION code_clib
SECTION code_ctype

PUBLIC isprint
PUBLIC isprint_fastcall

EXTERN asm_isprint, error_zc

isprint:
IF __CPU_GBZ80__
   ld  hl,sp+2
   ld  a,(hl+)
   ld  h,(hl)
   ld  l,a
ELIF __CPU_RABBIT__
   ld hl,(sp+2)
ELSE
   pop de
   pop hl
   push hl
   push de
ENDIF

isprint_fastcall:

   inc h
   dec h
   jp nz, error_zc

   ld a,l
   call asm_isprint
   
   ld l,h
IF __CPU_GBZ80__
   ld d,h
   ld e,l
ENDIF
   ret c
   
   inc l
IF __CPU_GBZ80__
   inc e
ENDIF
   ret


; SDCC bridge for Classic
IF __CLASSIC
PUBLIC _isprint
defc _isprint = isprint
PUBLIC _isprint_fastcall
defc _isprint_fastcall = isprint_fastcall
ENDIF

; Clang bridge for Classic
IF __CLASSIC
PUBLIC ___isprint
defc ___isprint = isprint
ENDIF

