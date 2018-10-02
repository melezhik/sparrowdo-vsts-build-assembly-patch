# from http://blogs.msdn.com/b/dotnetinterop/archive/2008/04/21/powershell-script-to-batch-update-assemblyinfo-cs-with-new-version.aspx
#
# AssemblyInfoPatchVersion.ps1
#
# Set the version in all the AssemblyInfo.cs or AssemblyInfo.vb files in any subdirectory.
#
# usage:  
#  from cmd.exe: 
#     powershell.exe AssemblyInfoPatchVersion.ps1  2.8.3.0
# 
#  from powershell.exe prompt: 
#     .\AssemblyInfoPatchVersion.ps1  2.8.3.0
#
# last saved Time-stamp: <Wednesday, April 23, 2008  11:46:40  (by dinoch)>
#


function Usage
{
  echo "Usage: ";
  echo "  from cmd.exe: ";
  echo "     powershell.exe AssemblyInfoPatchVersion.ps1  2.8.3.0";
  echo " ";
  echo "  from powershell.exe prompt: ";
  echo "     .\AssemblyInfoPatchVersion.ps1  2.8.3.0";
  echo " ";
}


function Update-SourceVersion
{

  Param ([string]$Version)
  Param ([string]$Revision)

  $NewVersion = 'AssemblyVersion("' + $Version + '")';
  $NewFileVersion = 'AssemblyFileVersion("' + $Version + '.' + $Revision '")';

  foreach ($o in $input) 
  {
    Write-output $o.FullName
    $TmpFile = $o.FullName + ".tmp"

     Get-Content $o.FullName -encoding utf8 |
        %{$_ -replace 'AssemblyVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $NewVersion } |
        %{$_ -replace 'AssemblyFileVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $NewFileVersion }  |
        Set-Content $TmpFile -encoding utf8
    
    move-item $TmpFile $o.FullName -force
  }
}


function Update-AllAssemblyInfoFiles ( $version )
{
  foreach ($file in "AssemblyInfo.cs", "AssemblyInfo.vb" ) 
  {
    get-childitem -recurse |? {$_.Name -eq $file} | Update-SourceVersion $version ;
  }
}


# validate arguments 

echo "AssemblyVersion: ";
echo $args[0];

echo "Revision: ";
echo $args[1];

$assembly_version = $args[0];
$revision = $args[1];


$r= [System.Text.RegularExpressions.Regex]::Match("$assembly_version.$revision", "^[0-9]+(\.[0-9]+){1,3}$");

if ($r.Success)
{
  Update-AllAssemblyInfoFiles $assembly_version, $revision;
}
else
{
  echo " ";
  echo "Bad Input!"
  echo " ";
  Usage ;
  exit 1;
}
