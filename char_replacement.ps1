$dir = Read-Host -Prompt 'Enter the dir path'
while(!(Test-Path -Path $dir))
{
	Write-Host 'The directory does not exist'
    $dir = Read-Host -Prompt 'Enter the dir path'
}
$toReplace = Read-Host -Prompt 'Enter the char to replace'
$replacement = Read-Host -Prompt 'Enter the replacement'

$answer = Read-Host "Replace all '$toReplace' in '$dir' by '$replacement' ? [Y]Yes or [N]No"

while("y","n" -notcontains $answer)
{
	$answer = Read-Host "Replace all '$toReplace' in '$dir' by '$replacement' ? [Y]Yes or [N]No"
}

if($answer -eq 'Y')
{	
	[char[]]$replace = $toReplace
	$regex = ($replace | % {[regex]::Escape($_)}) -join '|'
	
	Write-Host 'BEFORE' -foregroundcolor "cyan"
	Write-Host '###################################' -foregroundcolor "cyan"
	Get-ChildItem -recurse -Path $dir
	Write-Host '###################################' -foregroundcolor "cyan"

	Get-ChildItem -recurse -Path $dir | 
	  ForEach { 
		if ($_.Name -match $regex) {
		  Ren $_.Fullname -NewName $($_.Name -replace $regex, $replacement)
		} 
	}
	
	Write-Host 'AFTER' -foregroundcolor "green"
	Write-Host '###################################' -foregroundcolor "green"
	Get-ChildItem -recurse -Path $dir
	Write-Host '###################################' -foregroundcolor "green"
}
else
{
	exit
}