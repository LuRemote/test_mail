# payload.ps1 (simplified test)
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("LNK file executed successfully!", "Test", "OK", "Information")