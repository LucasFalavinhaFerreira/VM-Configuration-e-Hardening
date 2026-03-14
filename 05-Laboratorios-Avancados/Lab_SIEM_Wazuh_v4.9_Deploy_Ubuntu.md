# Laboratório SIEM: Implementação Wazuh v4.9 via Docker

Este write-up documenta a transição de uma infraestrutura Windows/WSL2 instável para uma arquitetura robusta baseada em **Ubuntu Server 24.04 LTS**, eliminando gargalos de performance e conflitos de virtualização.]

## 1. Arquitetura do Sistema e Recursos

Para garantir a estabilidade do Indexer e do Dashboard, a arquitetura foi simplificada para rodar nativamente sobre o Kernel Linux. 

* **Host:** Ubuntu Server 24.04 LTS (Headless). 
* **Orquestração:** Docker Engine v28.2.2 & Docker Compose. 
* **Recursos:** 6GB RAM | 2 CPUs | 84GB Storage (LVM). 
* **Rede:** Interface `enp0s3` em modo Bridge para visibilidade externa. 



## 2. Troubleshooting e Engenharia de Sistemas

A implementação exigiu intervenções diretas no sistema operacional para suportar a carga de trabalho do SIEM.

### 2.1. Pivotagem de Arquitetura (Bypass do Windows/WSL2)
* **Problema:** Instabilidade de memória e crashes de kernel em ambiente aninhado (Nested Virtualization). 
* **Solução:** Migração para Ubuntu Server dedicado, removendo camadas de abstração desnecessárias e otimizando o consumo de RAM. 

### 2.2. Configuração de Rede (Netplan & DNS)
* **Problema:** Interface de rede em estado *unmanaged* e falhas de resolução DNS. 
* **Solução:** Configuração manual via Netplan (`/etc/netplan/50-cloud-init.yaml`) para forçar o gerenciamento via DHCP e DNS externo (8.8.8.8). 

### 2.3. Tuning de Kernel (Indexer Memory Maps)
* **Problema:** O container do Wazuh Indexer falhava ao iniciar devido ao limite de `vm.max_map_count`. 
* **Solução:** Ajuste do parâmetro para `262144` via `sysctl.conf`, garantindo estabilidade ao motor de busca. 

## 3. Guia de Implementação (Deploy)

Comandos executados para o provisionamento da Stack em modo Single-Node: 

```bash
# Provisionamento do ambiente Docker
sudo apt update && sudo apt install docker.io docker-compose -y

# Ajuste persistente do Kernel
sudo sysctl -w vm.max_map_count=262144

# Deploy da Stack Wazuh v4.9.2
git clone [https://github.com/wazuh/wazuh-docker.git](https://github.com/wazuh/wazuh-docker.git) -b v4.9.2
cd wazuh-docker/single-node
sudo docker-compose up -d

4. Resultados e Próximos Passos

    Acesso: Interface gráfica estabilizada em https://[IP_DA_VM]. 

    Performance: Consumo de CPU em idle reduzido para < 5%. 

    Resiliência: Snapshot SISTEMA_BASE_OK criado para Disaster Recovery. 

Próximos Passos:

    [ ] Deploy de agentes em endpoints Windows/Linux. 

    [ ] Integração com regras de detecção do framework MITRE ATT&CK. 

    [ ] Configuração de alertas via Webhooks (Slack/Telegram).
