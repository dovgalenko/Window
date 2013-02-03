include macros\macros.inc

IDC_MAINSTATUS   Equ 1

IDC_MENUEXIT     Equ 10

@Start
@Uses gdi32, user32, comctl32, kernel32

.xlist
include macros\Menu.mac
include macros\Window.mac
include macros\Status.mac
.list

.data?
hIcon        Dd ?
hBrush       Dd ?
hCursor      Dd ?
hImage       Dd ?
hInstance    Dd ?

@DefineMenu    Menu
@DefineStatus  Example
@DefineWindow  Example

.code
; Main program cycle
WinMain Proc

  mov    hInstance, @Result(GetModuleHandle, NULL)
  mov    hIcon, @Result(LoadIcon, hInstance, 100)
  mov    hCursor, @Result(LoadCursor,NULL,IDC_ARROW)
  mov    hBrush, @Result(GetSysColorBrush, COLOR_APPWORKSPACE)

  @CreateWindow  Example, hInstance, NULL,'Example_wnd', \
                 WS_OVERLAPPED+WS_CAPTION+WS_SYSMENU+WS_VISIBLE, \
                 WS_EX_APPWINDOW, 'Example', \
                 hIcon, hBrush, hCursor, NULL

  @SetWndSize Example, 700, 600
  @MoveWnd Example, 100, 100

  @CreateMenu Menu
  @AppendMenu Menu, 'Exit', IDC_MENUEXIT
  @AttachMenu Example, Menu

  @CreateStatus Example, Example, IDC_MAINSTATUS
  @SetStatusParts Example, 2,300,-1,0,0,0,0,0,0,0,0
  @SetStatusText Example, 'Example program window...', 0, 0
  @SetStatusText Example, 'The CHEMI$T Copyright(C)2001', 0, 1

  @ProcessMsgs Example, FALSE

  @DestroyMenu Menu
  @DestroyWindow Example
  invoke ExitProcess, 0
WinMain Endp
        End WinMain
