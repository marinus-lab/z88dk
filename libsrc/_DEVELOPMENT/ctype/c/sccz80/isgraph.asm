
; int isgraph(int c)

SECTION code_clib
SECTION code_ctype

PUBLIC isgraph
PUBLIC isgraph_fastcall

EXTERN asm_isgraph, error_zc

isgraph:
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

isgraph_fastcall:

   inc h
   dec h
   jp nz, error_zc

   ld a,l
   call asm_isgraph
   
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
PUBLIC _isgraph
defc _isgraph = isgraph
PUBLIC _isgraph_fastcall
defc _isgraph_fastcall = isgraph_fastcall
ENDIF

; Clang bridge for Classic
IF __CLASSIC
PUBLIC ___isgraph
defc ___isgraph = isgraph
ENDIF

