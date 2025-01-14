
; char *basename_ext(char *s)

SECTION code_clib
SECTION code_string

PUBLIC basename_ext

EXTERN asm_basename_ext


basename_ext:
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
IF __CPU_GBZ80__
   call asm_basename_ext
   ld   d,h
   ld   e,l
   ret
ELSE
    jp asm_basename_ext
ENDIF


; SDCC bridge for Classic
IF __CLASSIC && !__CPU_GBZ80__
PUBLIC _basename_ext
defc _basename_ext = basename_ext
ENDIF


; Clang bridge for Classic
IF __CLASSIC
PUBLIC ___basename_ext
defc ___basename_ext = basename_ext
ENDIF

