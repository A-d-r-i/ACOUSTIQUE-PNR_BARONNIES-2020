Attribute VB_Name = "DUPLICATION"
Sub DUPLICATION()
    With Sheets("SHEET1")
        dl = .Cells(Rows.Count, 1).End(xlUp).Row
        Set ws = Sheets("SHEET2")
        NB = 6
        k = 1
        For i = 1 To dl
            .Cells(i, 1).Copy ws.Cells(k, 1).Resize(NB)
            k = k + NB
        Next i
    End With
End Sub

