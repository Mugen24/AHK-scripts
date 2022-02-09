#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

VarSetCapacity(powerstatus, 1+1+1+1+4+4)
success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)

acLineStatus:=ReadInteger(&powerstatus,0,1,false)
batteryFlag:=ReadInteger(&powerstatus,1,1,false)
batteryLifePercent:=ReadInteger(&powerstatus,2,1,false)
batteryLifeTime:=ReadInteger(&powerstatus,4,4,false)
batteryFullLifeTime:=ReadInteger(&powerstatus,8,4,false)

output=

  (LTrim

    AC Status: %acLineStatus%

    Battery Flag: %batteryFlag%

    Battery Life (percent): %batteryLifePercent%

    Battery Life (time): %batteryLifeTime%

    Battery Life (full time): %batteryFullLifeTime%

  )

#MsgBox, %output%


ReadInteger( p_address, p_offset, p_size, p_hex=true )
{
  value = 0
  old_FormatInteger := a_FormatInteger
  if ( p_hex )
    SetFormat, integer, hex
  else
    SetFormat, integer, dec
  loop, %p_size%
    value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
  SetFormat, integer, %old_FormatInteger%
  return, value
}

ChangeDisplayFrequency(Frequency) {
   VarSetCapacity(DEVMODE, 156, 0)
   NumPut(156, DEVMODE, 36, "UShort")
   DllCall("EnumDisplaySettingsA", "Ptr", 0, "UInt", -1, "Ptr", &DEVMODE)
   NumPut(0x400000, DEVMODE, 40)
   NumPut(Frequency, DEVMODE, 120, "UInt")
   Return DllCall("ChangeDisplaySettingsA", "Ptr", &DEVMODE, "UInt", 0)
}

ReadAC(){
	VarSetCapacity(powerstatus, 1+1+1+1+4+4)
	success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)
	acLineStatus:=ReadInteger(&powerstatus,0,1,false)
	return acLineStatus
}

isAc := acLineStatus
AcStatus := isAc;
limit := 0;

changeDis(call){
	MsgBox, call	
	return
}

while(true){
	isAc := ReadAc()

	if(isAc != AcStatus){
		limit := 1;
		AcStatus := isAc
	}

	if(isAc == 1 and limit == 1){
		sleep(5mins)

		if(isAc == 1){
			changeDis(165)
			limit := 0;
		}
	}

	else if(isAc == 0 and limit == 1){
		sleep(5mins)

		if(isAc == 0){
			changeDis(60)
			limit := 0;
		}
	}
}

