# 🛠️ VM Configuration e Hardening Labs

Este repositório documenta meus estudos práticos em **Administração de Sistemas**, **Configuração de Redes** e **Hardening de Segurança** utilizando Máquinas Virtuais (VMs).

O foco é demonstrar a capacidade de **provisionar, configurar, proteger e solucionar problemas** em ambientes de infraestrutura de TI, uma habilidade fundamental para a área de Sistemas de Informação.

---

## 📁 Estrutura do Conteúdo e Habilidades

O conteúdo está organizado por etapas do ciclo de vida da infraestrutura:

### 1. ⚙️ Configuração Base (`/01-Configuracao-Base`)
Documentação do processo inicial de *setup* de ambientes virtuais, incluindo a solução de problemas de *boot* e compatibilidade.

* **Lab 01: Criação de Mídia Bootável do Parrot OS:** Detalhes da solução de problemas de *file system* (FAT32 vs. ExFAT) e compatibilidade de hardware com ferramentas como Ventoy e Rufus.
    * [Link para o Lab 01](./01-Configuracao-Base/Lab_Bootable_ParrotOS.md)

### 2. 🌐 Networking e Diagnóstico (`/02-Networking-e-Diagnostico`)
(Em Breve) Notas sobre a configuração de interfaces de rede (NAT, Bridge) e comandos essenciais para diagnóstico de conectividade.

### 3. 🔒 Hardening e Segurança (`/04-Hardening-e-Seguranca`)
(Em Breve) Foco na proteção de sistemas operacionais e serviços, incluindo a configuração de firewalls e gerenciamento de permissões.

### 4. ⚙️ Scripts e Automação (`/05-Scripts-e-Automacao`)
(Em Breve) Scripts em Bash ou PowerShell desenvolvidos para automatizar tarefas de rotina nas VMs.

---

## 💡 Habilidades Demonstradas

Este portfólio demonstra as seguintes competências:

| Categoria | Competência Específica |
| :--- | :--- |
| **Administração de SO** | Instalação, gerenciamento de sistemas de arquivos (ExFAT, FAT32) e familiaridade com distribuições de segurança (Parrot OS). |
| **Solução de Problemas** | Capacidade de diagnosticar e resolver erros de compatibilidade de hardware e limitações de software (ex: uso de Ventoy para contornar falhas do Rufus). |
| **Infraestrutura** | Conhecimento fundamental sobre mídias bootáveis e ambientes de virtualização. |

> **Próximos Passos:** O foco agora será na documentação da **configuração de firewalls** e no **hardening de serviços** dentro de uma VM persistente.
