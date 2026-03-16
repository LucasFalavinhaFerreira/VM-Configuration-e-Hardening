# Relatório de Descomissionamento e Migração: Projeto Linux Server

## 1. Resumo do Ambiente Legado (Server Teste)
* **Plataforma:** Ubuntu Server sobre Hyper-V (WLAN).
* **Arquitetura:** Wazuh SIEM via Docker Compose.
* **Status Final:** **DESATIVADO** por instabilidade persistente de I/O e corrupção de volumes.

## 2. Histórico de Erros Críticos (Post-Mortem)
O provisionamento original revelou obstáculos técnicos severos que serviram de base para o endurecimento da nova infraestrutura:

* **Conflito de Nomenclatura TLS:** Descompasso entre aliases do script (`wazuh.manager`) e exigências do Filebeat (`filebeat.pem`).
* **Erro Crítico EISDIR:** O Docker mapeava arquivos PEM como diretórios devido ao cache de volume e latência do host.
* **Deadlock de Shell:** Congelamentos de terminal durante a montagem de volumes via Wi-Fi.
* **Persistência Corrompida:** O daemon do Docker manteve descritores inválidos mesmo após purga, exigindo uso de caminhos absolutos e flags de imutabilidade (:ro).

## 3. Novo Ambiente de Destino: VMware ESXi (USITLAB02)
A migração move o projeto para uma infraestrutura de classe empresarial, eliminando gargalos de hardware.

### Especificações do Host
* **Hardware:** HP ProLiant DL360 G6.
* **Processamento:** 8 CPUs x Intel Xeon E5620 @ 2.40GHz.
* **Memória:** 119.99 GB RAM.
* **Storage:** 2.99 TB (Capacidade Total).
* **Hypervisor:** VMware ESXi 6.7.0.

## 4. Estratégia de Migração: "Clean Slate"
Para mitigar a transferência de metadados inválidos, o processo será realizado via **Clean Install** em vez de migração de imagem.

### 4.1. Provisionamento da VM Dedicada
* **Configuração Sugerida:** 4 vCPUs e 8GB de RAM.
* **Network Mapping:** Alocação em rede de gerenciamento com IP estático (Faixa `192.168.111.x`).

### 4.2. Hardening e Orquestração
* **Docker Engine:** Instalação limpa no SO convidado.
* **Persistência Granular:** Manutenção de caminhos absolutos e volumes granulares, validando as práticas recomendadas de segurança do projeto original.
