; ----- void  xordraw(int x, int y, int x2, int y2)


IF !__CPU_INTEL__ & !__CPU_GBZ80__
    SECTION code_graphics
    
    PUBLIC  xordraw
    PUBLIC  _xordraw
    PUBLIC  ___xordraw

    EXTERN  asm_xordraw
.xordraw
._xordraw
.___xordraw
    push    ix
    ld      ix,2
    add     ix,sp
    ld      l,(ix+6)    ;y0
    ld      h,(ix+8)    ;x0
    ld      e,(ix+2)    ;y1
    ld      d,(ix+4)    ;x1
    pop     ix
    jp      asm_xordraw
    
ENDIF
