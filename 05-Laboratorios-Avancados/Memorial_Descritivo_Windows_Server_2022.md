# Memorial Descritivo: Laboratório de Hardening Windows Server 2022

Este projeto registra a configuração de uma instância de servidor de alta fidelidade sobre infraestrutura **VMware ESXi**, focada em performance determinística e aplicação de **Security Baselines**.

## 1. Camada de Virtualização e Hardware Virtual

Diferente de instalações padrão, os recursos foram alocados para eliminar latências de abstração e garantir integridade total do SO.

* **Gerenciamento de Memória:** Configuração de **12GB de RAM com Memory Reservation total**, eliminando o *swapping* e garantindo que o SO opere sempre em memória física.
* **Armazenamento de Alta Performance:** Implementação de disco de 100GB em modo **Thick Provision Eager Zeroed**, priorizando a estabilidade de I/O durante auditorias intensivas de disco.
* **Integridade de Boot:** Uso de firmware **EFI** com tabela de partição **GPT**, garantindo suporte a recursos modernos de segurança de boot.

## 2. Estabilização do Guest OS e Rede

Superação de desafios de conectividade e performance de drivers no ambiente empresarial.

* **Rede Paravirtualizada:** Migração para o adaptador **VMXNET3** e instalação manual das **VMware Tools** (Build 7253323) para suporte a drivers de alto desempenho.
* **Topologia de Rede:** Configuração de **IP Estático (Rede 192.168.111.xxx)** para garantir rotas fixas de ingestão de logs e atualizações de segurança.
* **Ergonomia Técnica:** Ajuste de VRAM para habilitar alta definição no console web, facilitando a auditoria visual detalhada.



## 3. Toolchain de Auditoria e Conformidade

Preparação do sistema para a aplicação de diretivas de segurança sem a necessidade de um Domain Controller (DC).

* **LGPO.exe (Local Group Policy Object):** Implantação do utilitário no PATH do sistema para controle granular via linha de comando.
* **Policy Analyzer:** Configuração da ferramenta para mapeamento de **drift** (desvio). Diagnóstico inicial revelou >300 itens de não-conformidade no estado nativo (*Out-of-the-Box*).
* **Gestão de Templates:** Migração manual de arquivos **.admx e .adml** (Security Baseline Windows Server 2022) para o repositório central de políticas (`PolicyDefinitions`).

## 4. Segurança Operacional e Rollback

Como medida de continuidade, foi estabelecido um **Checkpoint Crítico** ("Pre-Baseline"). Esta camada de segurança permite a reversão imediata em caso de falhas críticas ou bloqueios de acesso causados por diretivas de hardening agressivas.

---

**Veredito Técnico:** O ambiente foi estruturado para ser uma referência de segurança (Golden Image), unindo performance de hardware empresarial com as melhores práticas de auditoria da Microsoft.
