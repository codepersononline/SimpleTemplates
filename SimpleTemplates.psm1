<#
.SYNOPSIS
Render the given file to a string of HTML

.PARAMETER Path
The relative path of the file you want to render.

.PARAMETER Data
A hashtable of things you wish to pass into in the template.

.EXAMPLE
Render-Template .\index.pshtml

#>
Function Render-Template  {
param([Parameter(Mandatory=$true)] $Path, [hashtable]$Data)
	
	$Path = (Resolve-Path $Path).Path
	
	if(Test-Path -PathType Container -Path $Path) {
		throw 'Folder paths cannot be used.'
	}
	
	if($Data -is [hashtable]) {
		foreach($item in $Data.getEnumerator()) {
			New-Variable -Name $item.Name -Value $item.Value
		}
	}

	[string] $TextFile = [System.IO.File]::ReadAllText($path);
	[string] $HTMLWappedInHereString = [string]::Concat("@`"`n", $TextFile, "`n`"@");
	[string] $renderedHTML = [scriptblock]::Create($HTMLWappedInHereString).Invoke();
	
	$renderedHTML;
}

<#
.SYNOPSIS
Render the given expresxsion to JSON. Kind of useful when working with multiline expressions.

.PARAMETER Scriptblock
A powershell scriptblock

.EXAMPLE
JSON {1..10}
#>
function JSON { 
	param(
		[scriptblock]$Scriptblock
	)
	
	return  & $Scriptblock | 
			ConvertTo-JSON |
			% {$_ + [System.Environment]::NewLine};
} 
function Script {
	PROCESS { '<script>' + [string]$_ + '</script>'}
}

function Body {
	Begin { '<body>' }
	Process { [string]$_ }
	End { '</body>' }
}
function UL {
	Begin { '<ul>' }
	Process { '<li>' + [string]$_  +'</li>'}
	End { '</ul>' }
}

function OL {
	Begin { '<ol>' }
	Process { '<li>' + [string]$_  +'</li>'}
	End { '</ol>' }
}