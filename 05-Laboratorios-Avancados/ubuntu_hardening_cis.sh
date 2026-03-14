#!/bin/bash
# ==============================================================================
# Hardening Script para Ubuntu Server - Alinhado com CIS Benchmarks
# Equivalente ao script GPO-CIS Windows (Políticas de Senha, Firewall e Auditoria)
# ==============================================================================

# Cores para o output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # Sem cor

echo -e "${GREEN}Aplicando politicas de Senha e Bloqueio de conta...${NC}"

# 1 e 2. Políticas de Senha e Bloqueio (PAM)
# Define tamanho mínimo de 14 caracteres e bloqueio após 5 falhas
sudo apt install libpam-pwquality -y > /dev/null
# Configura complexidade mínima
sudo sed -i 's/password\s*requisite\s*pam_pwquality.so.*/password requisite pam_pwquality.so retry=3 minlen=14 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1/' /etc/pam.d/common-password
# Configura bloqueio de conta (lockoutthreshold: 5)
echo "auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900" | sudo tee -a /etc/pam.d/common-auth

# ==============================================================================
# 3. Opções de Segurança e Acesso Local
# ==============================================================================
echo -e "${GREEN}Configurando limites de inatividade e seguranca de console...${NC}"

# Limite de Inatividade (TMOUT = 900 segundos / 15 minutos)
echo "readonly TMOUT=900" | sudo tee -a /etc/profile
echo "export TMOUT" | sudo tee -a /etc/profile

# Desabilitar login de root via SSH (Melhor prática CIS)
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# ==============================================================================
# 4. UFW Firewall (Equivalente ao Windows Defender Firewall)
# ==============================================================================
echo -e "${GREEN}Configurando perfis do Firewall (UFW) e habilitando Logs...${NC}"

# Define comportamento padrão (Bloquear entrada / Permitir saída)
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Portas essenciais (SSH e Wazuh Dashboard)
sudo ufw allow ssh
sudo ufw allow 443/tcp
sudo ufw allow 1514/tcp # Comunicação de Agentes Wazuh
sudo ufw allow 1515/tcp # Registro de Agentes Wazuh

# Habilitar logs do Firewall (Equivalente ao LogAllowed/LogBlocked do seu script)
sudo ufw logging high
sudo ufw --force enable

# ==============================================================================
# 5. Serviços do Servidor (Desativar Impressão / CUPS)
# ==============================================================================
echo -e "${GREEN}Desativando o servico de Impressao (CUPS) - Equivalente ao Print Spooler...${NC}"

sudo systemctl disable --now cups.service > /dev/null 2>&1
sudo systemctl disable --now avahi-daemon > /dev/null 2>&1

# ==============================================================================
# 7. Politicas de Auditoria Avancada (Auditd)
# ==============================================================================
echo -e "${GREEN}Configurando Auditoria Avancada via Auditd (Equivalente ao AuditPol)...${NC}"

sudo apt install auditd -y > /dev/null

# Regras de auditoria: Monitorar execuções de comandos (Process Creation)
echo "-a always,exit -F arch=b64 -S execve -k audit_comando" | sudo tee -a /etc/audit/rules.d/audit.rules
# Monitorar alterações no arquivo de senhas
echo "-w /etc/shadow -p wa -k mudanças_senha" | sudo tee -a /etc/audit/rules.d/audit.rules

sudo service auditd restart

echo -e "${CYAN}Script de Hardening Ubuntu concluido com sucesso!${NC}"
