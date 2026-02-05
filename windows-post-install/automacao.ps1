
# ============================
#   Automacao pos-formatacao
# ============================

# Funções vazias que vamos preencher depois:

function Ensure-Admin {
	$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

	if (-not $isAdmin) {
		Write-Host "[!] Elevando privilégios..." -ForegroundColor Yellow
        
		$psi = New-Object System.Diagnostics.ProcessStartInfo
		$psi.FileName = "powershell.exe"
		$psi.Arguments = "-ExecutionPolicy Bypass -File `"$PSCommandPath`""
		$psi.Verb = "runas"

		try {
			[System.Diagnostics.Process]::Start($psi) | Out-Null
		}
		catch {
			Write-Host "O usuário cancelou a elevação." -ForegroundColor Red
		}

		exit
	}
}

function Update-Windows {
	Ensure-Admin
	Clear-Host
	Write-Host "`n[+] Atualizando o Windows..." -ForegroundColor Cyan
	
	# instalando PSWindowsUpdate (Caso não tenha, muito provavel não ter por ser pos-formatação)

	Write-Host "Verificando o modulo PSWindows-Update..."
	if (!(Get-Module -ListAvailable -Name PSWindowsUpdate)) {
		Write-Host "Modulo nao encontrado... Iniciando instalacao..." -ForegroundColor Yellow

		try {
			Install-PackageProvider -Name NuGet -Force -ErrorAction Stop
			Install-Module -Name PSWindowsUpdate -Force -Confirm:$false -ErrorAction Stop
			Write-Host "O modulo PSWindowsUpdate foi Instalado" -ForegroundColor Green
		}
		catch {
			Write-Host "Erro ao Instalar o Modulo..." -ForegroundColor Red
			return
		}	
	}
	Import-Module PSWindowsUpdate
	Clear-Host
	#progressbar 
	Write-Progress -Activity "Buscando atualizacoes..." -Status "Iniciando..." -PercentComplete 0

	#search updates
	$updates = Get-WindowsUpdate -MicrosoftUpdate
	
	Write-Progress -Activity "Buscando atualizacoes..." -Status "Concluido..." -Completed

	Clear-Host
	
	#installing updates
	Write-Host "Atualizacoes encontradas..." -ForegroundColor Cyan
	$updates | Format-Table
	
	Write-Host "`Iniciando instalacao..." -ForegroundColor Green

	$results = Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot

	Clear-Host
	Write-Host "A Instalacao foi concluida" -ForegroundColor Green

	#verifica se e necessario reinicio
	$needsReboot = $results | Where-Object { $_.RebootRequired -eq $true }
	if ($needsReboot) {
		Write-Host "`nAlgumas atualizacoes requerem a reinicializacao do sistema..." -ForegroundColor Yellow

		do {
			Write-Host ""
			Write-Host "[1] Reinicializar agora"
			Write-Host "[2] Reinicializar mais tarde"
			$choice = Read-Host "Escolha uma das opcoes"
		} until ($choice -in "1", "2")
		if ($choice -eq "1") {
			Write-Host "Reiniciando..." -ForegroundColor Cyan
			Restart-Computer -Force
		}
		else {
			Write-Host "OK, a reinicializacao ficou para mais tarde..." -ForegroundColor Green
			Start-Sleep -Seconds 2	
		}
	}
	else {
		Write-Host "Nenhuma reinicializacao e necessaria..." -ForegroundColor Green
		Write-Host ""
		Write-Host "Pressione ENTER para voltar ao menu..."
		Read-Host
		Clear-Host
		return
	}
}
Function Update-Drivers {
	Write-Host "`n[+] Atualizando os drivers do sistema..." -Foreground Cyan
	Write-Host "[!] Funcao ainda esta sendo implementada"
}

Function Install-Programs {
	Write-Host "`n[+] Instalando programas" -Foreground Cyan
	Write-Host "[!] Funcao ainda esta sendo implementada"
}

## show menu

function Show-Menu {
	Clear-Host
	Write-Host "====================================="
	Write-Host "  automacao para pos formatacao  "
	Write-Host "====================================="
	Write-Host ""
	Write-Host "[1] Atualizar Windows"
	Write-Host "[2] Atualizar Drivers"
	Write-Host "[3] Instalar Programas"
	Write-Host "[0] Sair"
	Write-Host ""
}

# loop principal (menu)
While ($true) {
	Show-Menu
	$choice = Read-Host "Selecione uma das opcoes:..."
	   
	switch ($choice) {
		"1" { Update-Windows }
		"2" { Update-Drivers }
		"3" { Install-Programs }
		"0" { Write-Host "Saindo..."; return }
		default { Write-Host "`nOpcao Invalida" -Foreground Red }
	}
	
	Write-Host "`Pressione qualquer tecla para voltar ao menu..."
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}	