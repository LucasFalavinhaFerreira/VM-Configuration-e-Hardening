# 🛡️ Relatório de Resposta a Incidentes: Deploy Wazuh v4.7.5

## 1. Sumário Executivo
* **Data do Incidente:** 14 de Março de 2026.
* **Duração:** ~10 horas de Troubleshooting.
* **Veredito:** Descarte de Instância por Corrupção de Metadados e Fadiga Operacional (*Clean Slate Strategy*).

## 2. Cronologia da Exaustão (Timeline)
O incidente progrediu de uma falha de hardware (E/S de disco) para uma corrupção lógica irreversível na orquestração do Docker.

| Período | Status | Eventos Críticos |
| :--- | :--- | :--- |
| **Manhã/Tarde** | Deploy Inicial | Primeiro crash por **Disk Full**/Latência de I/O em rede Bridge. |
| **Final da Tarde** | Loop de Montagem | Erro crítico: Docker criou diretórios onde deveriam estar arquivos `.pem`. |
| **Noite (Início)** | Crise de Interface | Falha do *Guest Additions*. Migração forçada para **SSH via PowerShell**. |
| **Noite (Meio)** | Guerra de Permissões | `docker-compose down --volumes` falhou em limpar o cache de *bind mounts*. |
| **Madrugada** | Corrupção de Sintaxe | Fadiga resultou em erros de indentação (YAML) via editor `nano`. |
| **00:00+** | **Decisão Executiva** | Ordem de destruição da instância para garantir a integridade do ambiente. |

## 3. Diagnóstico Técnico das Patologias

### 3.1. Persistência Viciada do Daemon (Docker Volume Persistence)
A falha inicial de disco causou um *race condition*. O Docker, ao tentar mapear arquivos inexistentes ou corrompidos, criou diretórios substitutos no `/var/lib/docker/volumes`. Esse comportamento tornou-se um "tumor" lógico, impedindo a subida correta dos certificados TLS mesmo após limpezas padrão.

### 3.2. Falha de Abstração e Risco Operacional
A manipulação manual de arquivos YAML sob fadiga extrema levou ao `ScannerError`. A ausência de suporte a *clipboard* no terminal nativo aumentou o risco de erro humano, provando que edições complexas exigem ferramentas de suporte (como VS Code via SSH).



## 4. Lições Aprendidas e Plano de Ataque (VM 2.0)

A "Batalha do Wazuh" gerou um novo protocolo de provisionamento para evitar a repetição dos erros:

1.  **Provisionamento de Disco:** Alocação de **100GB Fixo** (não dinâmico) para garantir IOPS estável e evitar quedas por latência.
2.  **Snapshot Pipeline:** Implementação de marcos de recuperação:
    * **Snap 01:** OS limpo + Docker instalado.
    * **Snap 02:** Certificados TLS gerados e validados.
3.  **Gestão de Configuração:** Uso obrigatório de **VS Code via SSH** para edição de arquivos de orquestração, mitigando erros de sintaxe.
4.  **Rede Estática:** Fixação de IP no boot para evitar dependência de DHCP instável durante o deploy.

---

**Conclusão Técnica:** Em cibersegurança, insistir em uma base logicamente comprometida é negligência. Recomeçar do zero garante que o ambiente final seja uma fonte confiável de dados para o SIEM.
