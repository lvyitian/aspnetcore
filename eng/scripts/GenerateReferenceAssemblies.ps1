param(
    [switch]$ci
)
$ErrorActionPreference = 'stop'

$repoRoot = Resolve-Path "$PSScriptRoot/../.."

# Use Debug configuration to ensure [DebuggerStepThrough] attributes are generated.
$Configuration = 'Debug'

& "$repoRoot\build.ps1" -ci:$ci -noRestore -buildNative -configuration $Configuration

$msbuildEngine = 'dotnet'
& "$repoRoot\eng\common\msbuild.ps1" -ci:$ci "$repoRoot/eng/CodeGen.proj" `
    /t:GenerateReferenceSources `
    /bl:artifacts/log/genrefassemblies.binlog `
    /p:Configuration=$Configuration
