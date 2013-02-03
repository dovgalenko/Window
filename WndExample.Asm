.data
szWheelTitle Db 'Wheel message', 0

.code
; Message handlers for window Example
@WndHandlerStart   Example, WheelUp

  invoke MessageBox, NULL, @Text('Wheel rotated upwards'), ADDR szWheelTitle, MB_OK
@WndHandlerEnd     Example, WheelUp

@WndHandlerStart   Example, WheelDown

  invoke MessageBox, NULL, @Text('Wheel rotated backwards'), ADDR szWheelTitle, MB_OK
@WndHandlerEnd     Example, WheelDown

@WndHandlerStart   Example, Close

  @GetHwnd Example
  invoke MessageBox, eax, @Text('Are you sure?'), @Text('Quit'), MB_YESNO
  .if eax == IDYES
    mov   eax, FALSE
  .else
    mov   eax, TRUE
  .endif
@WndHandlerEnd     Example, Close

@WndHandlerStart   Example, Create

  ; You can add any picture filename and it will be the background of your window
  invoke LoadImage,NULL, @Text('SomePicture.bmp'), IMAGE_BITMAP,0,0,LR_LOADFROMFILE
  mov    hImage, eax
  @SetWndImage Example, hImage

@WndHandlerEnd     Example, Create

@WndHandlerStart   Example, Destroy

  invoke DeleteObject, hImage
@WndHandlerEnd     Example, Destroy

@WndHandlerStart   Example, Help

  mov  eax, hWin
  mov  ebx, lParam
  @AssumePtr  HELPINFO
    .if [ebx].iContextType == HELPINFO_WINDOW && [ebx].hItemHandle == eax
      invoke MessageBox, NULL, @Text('Help requested for our window!'), @Text('Help'), MB_OK
    .endif
  @AssumeNo
@WndHandlerEnd     Example, Help

@WndMnuHandlerStart Exit

  invoke SendMessage, hWndExample, WM_CLOSE, 0, 0
@WndMnuHandlerEnd   Exit

@WndHandlerStart   Example, WM_SIZING

  mov  eax, TRUE
@WndHandlerEnd     Example, WM_SIZING

; Main window procedure
@WndProcedureBegin Example, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT

  ; Menu handlers
  @WndMenuHandler  IDC_MENUEXIT, Exit

  ; Sample user handler
  @WndUserHandler  Example, WM_SIZING
@WndProcedureEnd   Example
