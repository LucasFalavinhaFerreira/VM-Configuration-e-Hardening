# 🏗️ Implementação de Laboratório: Posture (CIS Benchmarks) & SIEM (Wazuh)

Este write-up registra o provisionamento técnico e a superação de desafios críticos na criação de um ambiente de análise de postura de segurança.

## 1. Especificações da Infraestrutura (Host Virtualizado)

O ambiente foi construído sobre uma VM no VirtualBox com foco em alta performance e suporte a virtualização de segundo nível.

* **SO:** Windows 11 Pro (x64)
* **Hardware:** 8GB RAM | 4 vCPUs | 80GB VHD (SSD)
* **Rede:** Modo Bridge (Garante que a VM receba um IP na mesma sub-rede do SIEM para visibilidade total).
* **Virtualização Aninhada:** Habilitação de suporte a hardware virtual dentro da VM para execução de Docker/WSL2.
    * **Comando:** `VBoxManage modifyvm "NOME_DA_VM" --nested-hw-virt on`

## 2. Desafios Superados e Soluções Técnicas

### 2.1. Bypass de Privilégios (Recuperação de Acesso Administrativo)
Durante o provisionamento inicial (OOBE), o sistema resultou em um usuário padrão sem permissões de administrador, bloqueando o UAC.

* **Solução:** Utilização do vetor de ataque via `utilman.exe` no Windows Recovery Environment (WinRE):
    1. Acesso ao CMD via ferramentas de recuperação.
    2. Substituição: `copy cmd.exe utilman.exe` no diretório `System32`.
    3. Gatilho: Execução do CMD com privilégios de SYSTEM na tela de login para ativação da conta Administrador local.

### 2.2. Estabilização e UX da VM
Correções aplicadas para garantir a usabilidade do laboratório:
* **Input:** Troca do driver de apontamento para **Tablet USB Multitouch** para sanar problemas de precisão do mouse (*mouse jumping*).
* **Interatividade:** Instalação dos *VirtualBox Guest Additions* para suporte a Clipboard bidirecional e redimensionamento dinâmico.

## 3. Preparação para o Stack de Segurança (Em Andamento)

A base do laboratório depende da ativação de recursos de virtualização para suportar o Docker Desktop via WSL2.

### 3.1. Habilitação de Recursos via DISM
Comandos executados via PowerShell para ativar os componentes necessários:
```powershell
# Ativação do WSL e Plataforma de Máquina Virtual
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

```

### 3.2. Automatização de Software

Download do instalador do Docker via CLI para agilizar o provisionamento:

```powershell
Invoke-WebRequest -Uri "[https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe)" -OutFile "DockerInstaller.exe"

```

---

**Próxima Etapa:** Instalação do Agente Wazuh e início das auditorias baseadas nos Benchmarks CIS para Windows 11.
