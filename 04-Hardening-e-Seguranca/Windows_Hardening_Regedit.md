# 🛡️ Hardening Extremo: Bloqueio de CMD via Regedit (Windows Home Nativo)

Este projeto simula a aplicação de uma *Baseline* de Hardening e o Princípio do Menor Privilégio (PoLP) em um **ambiente Windows 11 Home nativo**. O uso do **Editor de Registro (`regedit.exe`)** foi necessário para contornar a ausência de ferramentas como o `gpedit.msc`.

## 1. Objetivo e Vetor de Configuração

* **Objetivo:** Bloquear o acesso ao Prompt de Comando (`cmd.exe`) para um usuário padrão (PoLP).
* **Vetor:** Criação manual da chave de política no **Registro do Windows**, replicando a ação de uma GPO de domínio.
* **Ambiente:** Windows 11 Home (Ambiente nativo do usuário, não VM).

## 2. Implementação da Política de Bloqueio

### 2.1. Caminho de Navegação no Registro

A chave de política foi criada no caminho:
HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System

* **Ação:** A chave `System` foi criada manualmente, pois ela não existia por padrão em instalações limpas do Windows Home.

### 2.2. Criação e Ativação da Regra

1.  Um novo valor **DWORD (32-bit)** chamado `DisableCMD` foi criado dentro da chave `System`.
2.  O valor da chave foi definido como **`1`** (Ativado/Habilitado).

* **Teste de Sucesso:** A tentativa de execução do `cmd.exe` resultou na mensagem: "O prompt de comando foi desativado pelo administrador."

## 3. Reversão e PoLP

* **Reversão:** A política foi revertida mudando o valor de `DisableCMD` de **`1`** para **`0`** no Registro.
* **Lição de PoLP:** A regra foi aplicada com sucesso em perfis de usuário específicos, comprovando o domínio da aplicação de **Posturas de Segurança** via manipulação direta do Registro em um sistema não empresarial.
