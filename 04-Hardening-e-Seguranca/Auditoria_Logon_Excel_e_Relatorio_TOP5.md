# 📊 Auditoria de Segurança: Relatório TOP 5 de Falhas de Logon (Excel)

Este projeto demonstra a capacidade de transformar logs de segurança brutos em relatórios gerenciais concisos, utilizando o Visualizador de Eventos e a Tabela Dinâmica do Excel **no ambiente Windows nativo**.

## 1. Geração e Exportação de Logs

### 1.1. Geração de Eventos

* **Ação:** Tentativas de logon propositalmente incorretas foram realizadas (`Win + L`) para gerar eventos de falha de logon.

### 1.2. Exportação da Fonte de Dados

1.  O **Visualizador de Eventos (`eventvwr.msc`)** foi aberto.
2.  O log foi filtrado pelo **ID de Evento 4625** (Falha de Logon).
3.  O log filtrado foi exportado no formato **CSV** ou **XML** para análise no Excel.

## 2. Análise e Criação do Relatório Gerencial

### 2.1. Importação e Preparação

Os dados foram importados para o Excel utilizando a função **"De Texto/CSV"** (para contornar o bloqueio do menu "Obter Dados" do Excel) e carregados na planilha.

### 2.2. Criação do Relatório TOP 5 (Tabela Dinâmica)

A Tabela Dinâmica foi utilizada para agrupar e contar a frequência dos eventos.

1.  **Linhas:** O campo **Identificador do Evento** (ou `ns1:EventID`) foi arrastado para **Linhas**.
2.  **Valores:** O mesmo campo **Identificador do Evento** foi arrastado para **Valores** (função Contagem).

* **Resultado:** O **ID 4625** (Falha de Logon) isolou-se no topo da tabela com a maior contagem (simulando um ataque), validando a habilidade de criar um relatório de **urgência gerencial** a partir de dados brutos de auditoria.

## 3. Lição Final

A Tabela Dinâmica é a ferramenta mais eficiente para transformar dados de auditoria volumosos em relatórios gerenciais concisos, provando o domínio tanto dos logs do sistema operacional quanto das ferramentas de análise de dados.
