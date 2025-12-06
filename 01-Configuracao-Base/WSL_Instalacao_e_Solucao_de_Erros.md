# 🛠️ WSL: Guia de Instalação e Solução de Problemas do Kali Linux

## 1. Contexto e Objetivo

O objetivo era migrar a execução de comandos e ferramentas de segurança (ex: `utmpdump` para análise forense) de uma Máquina Virtual (VM) pesada para o ambiente leve e nativo do **WSL 2 (Windows Subsystem for Linux)**, visando eficiência no uso de hardware limitado.

## 2. Processo de Instalação e Solução de Erros

A instalação via linha de comando no Windows apresentou falhas de registro e inicialização que exigiram diagnóstico e correção.

### 2.1. Habilitação de Recursos e Primeira Instalação

* **Comando Inicial:** A habilitação dos recursos de virtualização do Windows (DISM) foi bem-sucedida, mas exigiu **múltiplas reinicializações** do sistema, conforme solicitado pelo Windows.
    ```powershell
    wsl --install
    wsl --install -d kali-linux 
    ```
* **Erro:** O sistema apresentava telas de terminal piscando ou falhava ao registrar a distribuição (não aparecia em `wsl -l -v`) devido a problemas de inicialização ou componentes incompletos do DISM.

### 2.2. Diagnóstico e Correção (Pisca-e-Fecha)

Quando o terminal do Kali falhava ao iniciar, a solução exigia a verificação e correção da versão do WSL e dos componentes de virtualização do hardware:

1.  **Verificação de Virtualização:** Foi confirmado no **Gerenciador de Tarefas** que a **Tecnologia de Virtualização** estava **Habilitada** na BIOS do host, um requisito obrigatório para o WSL 2.
2.  **Atualização do Kernel:** Garantir que o componente principal do WSL estivesse atualizado.
    ```powershell
    wsl --update
    ```
3.  **Registro e Inicialização:** Em casos de falha persistente de registro, a **Microsoft Store** foi utilizada como alternativa para baixar e registrar a distribuição, garantindo que o *prompt* para criar o usuário UNIX fosse exibido corretamente.

### 2.3. Configuração Final

A instalação foi concluída com sucesso, permitindo a criação do usuário UNIX (`cowboyhash`) e a abertura estável do terminal Kali no ambiente WSL 2.

* **Resultado:** Ambiente de linha de comando Linux leve, rápido e totalmente funcional para a execução de ferramentas como `utmpdump` e `last`.

## 3. Lição de Infraestrutura

A lição mais importante foi que, em ambientes Windows, a estabilidade do WSL depende da correta ativação das **Tecnologias de Virtualização do hardware** e da garantia de que os componentes do **WSL 2** estejam ativos, mesmo que o sistema operacional exija múltiplas reinicializações burocráticas para concluir o processo de instalação.
