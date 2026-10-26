param()
$ErrorActionPreference = 'Stop'
Push-Location -LiteralPath $PSScriptRoot
try {
    $rCommand = Get-Command Rscript.exe -ErrorAction SilentlyContinue
    $rCandidates = @((Join-Path $PSScriptRoot '..\tmp\R\bin\Rscript.exe'))
    if ($rCommand) { $rscriptPath = $rCommand.Source }
    else { $rscriptPath = $rCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1 }
    if (-not $rscriptPath) { throw 'Rscript nao encontrado. Instale R e inclua sua pasta bin no PATH.' }
    & $rscriptPath 'estrutura/codigos/executar_atualizacao.R'
    if ($LASTEXITCODE -ne 0) { throw "A execucao R falhou com codigo $LASTEXITCODE." }
}
finally { Pop-Location }
