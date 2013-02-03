comment~

      Common macroses for Win32 Assembly.

      The CHEMI$T Copyright(C)2001      					      02.05.2001

~

@Info        MACRO
               %echo
               %echo The CHEMI$T Copyright(C)2004
               %echo
               %echo Версия компилятора : @Version
               %echo Дата компиляции    : @Date, @Time
               %echo
             ENDM

@Start       MACRO
               .586
               .model flat,stdcall
               option casemap:none

               include windows.inc
             ENDM

@Uses        MACRO Modules:VARARG
             IRP Module, <Modules>
               include &Module.inc
               includelib &Module.lib
             ENDM
             ENDM

@Includes    MACRO Modules:VARARG
             IRP Module, <Modules>
               include &Module.inc
             ENDM
             ENDM

@Result      MACRO Params:VARARG
               invoke Params
               EXITM <eax>
             ENDM

@Text	     MACRO szText
             LOCAL Text
             .data
               Text     Db szText, 0
             .code

             EXITM <OFFSET Text>
             ENDM

@GetMemory   MACRO Size
             IFDEF SHOWMEM
               IFDEF DEBUG
                 Push     eax
                 mov      eax, Size
                 PrintDec eax, 'MEM: !> Резервирование памяти.'
                 pop      eax
               ENDIF
             ENDIF
               invoke LocalAlloc, LMEM_FIXED or LMEM_ZEROINIT, &Size
             IFDEF SHOWMEM
               IFDEF DEBUG
                 PrintHex eax, ' выделенный адрес.'
               ENDIF
             ENDIF
             ENDM

@FreeMemory  MACRO mHandle
             IFDEF SHOWMEM
               IFDEF DEBUG
                 PrintText         'MEM: !> Высвобождение памяти.'
                 push   eax
                 mov    eax, mHandle
                 PrintHex eax, ' высвобождаемый адрес.'
                 pop    eax
               ENDIF
             ENDIF
               push   eax
               invoke LocalFree, mHandle
               pop    eax
             ENDM

@AssumeNo    MACRO
             ASSUME Ebx:NOTHING
             ENDM

@AssumePtr   MACRO lpData
             ASSUME Ebx:PTR &lpData
             ENDM


@MakeError    MACRO  Text
              %Out &Text
              .err
              ENDM

@DefineWindow MACRO Name
              .data?
                Wnd&Name     Dd ?
                hWnd&Name    Dd ?
                Msg&Name     MSG <?>
              .code
                include Wnd&Name.Asm
              ENDM

@DefineStatus MACRO Name
              IFNDEF stat&Name
                .data?
                stat&Name   Dd ?
              ENDIF
              ENDM

@DefineMenu   MACRO Name
              IFNDEF menu&Name
                .data?
                menu&Name   Dd ?
              ENDIF
              ENDM

@Debug        MACRO m3
              LOCAL @1
              LOCAL @2
              IFNDEF dlgTitle
              .data
                dlgTitle  Db 'Debug', 0
              ENDIF
              .data
              @1    Db '&m3 %lu', 0
              @2    Db 20 Dup (0)
              .code
                pushad
                invoke wsprintf, ADDR @2, ADDR @1, m3
                invoke MessageBox, NULL, ADDR @2, ADDR dlgTitle, MB_OK
                popad
              ENDM
