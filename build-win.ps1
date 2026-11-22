Function Info($msg) {
  Write-Host -ForegroundColor DarkGreen "`nINFO: $msg`n"
}

Function Error($msg) {
  Write-Host -ForegroundColor Red "`n`nERROR: $msg"
  exit 1
}

Function CheckReturnCodeOfPreviousCommand($msg) {
  if ($LASTEXITCODE -ne 0) {
    Error "${msg}. Error code: $LASTEXITCODE"
  }
}

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$buildDir = "$PSScriptRoot/build/win-amd64"

Info "Find Visual Studio installation path"
$vswhereCommand = Get-Command -Name "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
$installationPath = & $vswhereCommand -prerelease -latest -property installationPath

Info "Open Visual Studio Developer PowerShell amd64"
& "$installationPath\Common7\Tools\Launch-VsDevShell.ps1" -Arch amd64 -SkipAutomaticLocation

foreach ($testDir in Get-ChildItem -LiteralPath "$PSScriptRoot/test" -Directory -Force) {
  $testBuildDir = "$buildDir/$($testDir.Name)"
  Info "Configure $($testDir.Name)"
  cmake -S $testDir.FullName -B $testBuildDir -G Ninja -D CMAKE_BUILD_TYPE=Release
  CheckReturnCodeOfPreviousCommand "CMake configure failed for $($testDir.Name)"

  Info "Build $($testDir.Name)"
  cmake --build $testBuildDir
  CheckReturnCodeOfPreviousCommand "CMake build failed for $($testDir.Name)"
}
