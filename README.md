# UacBypass

A demo to bypass windows 10 **default** UAC configuration using COM Handler Hijack.  

## Requirements

- An administrator account with UAC enabled.
- UAC level is set to default.
- Tested on Windows 10.10.0.17134 (English) x86/x64.

## Description

This module will bypass Windows UAC by creating COM handler registry entries in the HKCU hive.
When certain high integrity processes are loaded, these registry entries are referenced resulting in the process loading user-controlled DLLs. 
These DLLs contain the payloads that result in elevated sessions. 
Registry key modifications are cleaned up after payload invocation.

## References

- https://wikileaks.org/ciav7p1/cms/page_13763373.html
- https://github.com/FuzzySecurity/Defcon25/Defcon25_UAC-0day-All-Day_v1.2.pdf
- https://github.com/rapid7/metasploit-framework/blob/master/modules/exploits/windows/local/bypassuac_comhijack.rb