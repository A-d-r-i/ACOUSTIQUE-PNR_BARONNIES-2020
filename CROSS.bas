Attribute VB_Name = "CROSS"
Sub CROSS(ByVal Target As Range, Cancel As Boolean)
	If UCase(Target) = "x" Then Target = "" Else Target = "x"
		Cancel = True
End Sub
