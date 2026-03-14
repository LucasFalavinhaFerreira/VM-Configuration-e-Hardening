# 📉 Post-Mortem: Falha de Virtualização Aninhada e Migração de Arquitetura

Este documento detalha a análise de causa raiz de erros críticos de memória e a decisão estratégica de migrar o laboratório de SIEM de Windows 11 para Ubuntu Server 24.04 LTS.

## 1. Sumário de Erros e Conflitos de Camadas

A tentativa de rodar o Wazuh via Docker em uma instância Windows 11 Guest gerou um empilhamento de 5 camadas de abstração, resultando em instabilidade sistêmica.

### 1.1. Conflitos de Hypervisors e Memória
* **Erro de Virtualização Aninhada:** O WSL2 e o Docker não detectavam suporte a hardware devido às restrições do VirtualBox em repassar extensões VT-x/AMD-V por padrão.
* **Conflito de Memória (0x00000000):** O recurso de **VBS (Integridade da Memória)** no Host físico impediu o VirtualBox de gerenciar a CPU com baixa latência, causando crashes no processo `VirtualBoxVM.exe`.
* **Corrupção de Kernel:** O motor do WSL2 entrou em conflito com o endereçamento de memória (*Nested Paging*) do processador Intel de 10ª Geração, gerando loops de Reparo Automático e BSOD.

## 2. Análise de Causa Raiz (RCA)

A arquitetura original exigia um custo de processamento proibitivo para a "pilha" de virtualização (Windows Host -> VirtualBox -> Windows Guest -> WSL2 -> Docker).Em um hardware com 8GB de RAM e CPU i3, essa sobrecarga resultou em estouro de buffer e corrupção de ponteiros de memória

## 3. Estratégia de Recuperação e Nova Arquitetura

A instância Windows 11 foi descartada em favor de uma arquitetura de **Servidor Nativo**, visando eficiência e estabilidade.

### 3.1. Migração para Ubuntu Server 24.04 LTS
* **Eficiência de Recursos:** Redução do consumo base de RAM do SO de 4GB para ~500MB, liberando recursos para os containers do Wazuh.
* **Docker Engine Nativo:** Eliminação da camada WSL2.O Docker agora opera diretamente no Kernel Linux, removendo conflitos de tradução de memória.

### 3.2. Plano de Implementação (Next Steps)
1. **Bridge Networking:** Configuração para acesso externo ao Dashboard do SIEM via navegador do host físico.
2. **Docker Compose Deploy:** Orquestração automatizada do Wazuh Indexer, Server e Dashboard.
3. **CIS Benchmarks:** Início da análise de postura após estabilização do novo ambiente Linux.

---

**Veredito Técnico:** O descarte da instância Windows foi necessário para remover a dívida técnica de performance e garantir a integridade dos dados de auditoria no SIEM.
