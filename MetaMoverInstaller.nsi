; MetaMover Installer Script
!define PRODUCT_NAME "MetaMover"
!define PRODUCT_VERSION "1.0"
!define INSTALL_DIR "$PROGRAMFILES64\${PRODUCT_NAME}"
!define PRODUCT_PUBLISHER "Ameliorates Development"

SetCompressor /SOLID lzma

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "MetaMoverInstaller.exe"
InstallDir "${INSTALL_DIR}"

Page directory
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

Section "MetaMover Application"
  SetOutPath "$INSTDIR"
  File "MetaMover.exe"
  File "libMetaMover.dll.a"

  ; Prompt to create a shortcut in the Start Menu
  MessageBox MB_YESNO "Would you like to create a Start Menu shortcut?" IDNO noStartMenuShortcut
  CreateShortcut "$SMPROGRAMS\MetaMover.lnk" "$INSTDIR\MetaMover.exe"
noStartMenuShortcut:

  ; Create a desktop shortcut (optional)
  MessageBox MB_YESNO "Would you like to create a desktop shortcut?" IDNO noDesktopShortcut
  CreateShortcut "$DESKTOP\MetaMover.lnk" "$INSTDIR\MetaMover.exe"
noDesktopShortcut:

  ; Add entry to Windows Add/Remove Programs
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME} ${PRODUCT_VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayIcon" "$INSTDIR\MetaMover.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "NoRepair" 1

  ; Add estimated size to Windows Add/Remove Programs
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "EstimatedSize" 50000  ; Size in KB (adjust as needed)
SectionEnd

Section -PostInstall
  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Uninstall"
  Delete "$INSTDIR\MetaMover.exe"
  Delete "$INSTDIR\libMetaMover.dll.a"
  Delete "$INSTDIR\Uninstall.exe"

  ; Remove the Start Menu shortcut
  Delete "$SMPROGRAMS\MetaMover.lnk"

  ; Remove the desktop shortcut
  Delete "$DESKTOP\MetaMover.lnk"

  ; Remove the installation directory if it's empty
  RMDir "$INSTDIR"

  ; Remove entry from Windows Add/Remove Programs
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
SectionEnd
