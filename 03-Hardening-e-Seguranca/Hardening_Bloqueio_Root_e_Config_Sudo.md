# 🛠️ Hardening: Configuração de Acesso `sudo` e Bloqueio de `root`

## 1. Contexto e Boas Práticas

Desde o Kali Linux 2020.1, a melhor prática de segurança é **não usar a conta `root`** para operações diárias. Este procedimento garante que o usuário administrativo (`CowboyHash`) seja o único caminho para obter privilégios elevados (`root`).

## 2. Configuração do Usuário com Acesso `sudo`

O objetivo é garantir que o usuário **CowboyHash** pertença ao grupo `sudo`, que permite a execução de comandos administrativos.

### 2.1. Criação do Usuário (Etapa Opcional/Necessária)

Se o usuário ainda não existisse (erro `usermod: user 'CowboyHash' does not exist`):

1.  **Criação do Usuário:**
    ```bash
    useradd -m CowboyHash
    ```
2.  **Definição da Senha:**
    ```bash
    passwd CowboyHash
    ```

### 2.2. Concessão de Privilégios `sudo`

Após confirmar que o usuário existe:

1.  **Mudar para `root`:** Necessário para modificar grupos de usuários.
    ```bash
    sudo su -
    ```
2.  **Adicionar ao Grupo `sudo`:**
    ```bash
    usermod -aG sudo CowboyHash
    ```

## 3. Bloqueio de Login Direto do `root` (Hardening)

Esta é a etapa crucial de segurança, que impede que a conta mais poderosa do sistema seja acessada diretamente (diminuindo a superfície de ataque).

1.  **Bloqueio da Senha:** O comando `passwd -l` (lock) impede o login direto da conta `root` no terminal e na interface gráfica.

    ```bash
    sudo passwd -l root
    ```

### 3.1. Verificação do Status de Segurança

* **Teste `sudo`:** O usuário `CowboyHash` deve usar `sudo whoami` com sucesso (retornando `root`).
* **Teste de Login:** Qualquer tentativa de login direto como usuário `root` (na tela de login ou terminal) deve ser **negada**, mesmo que a senha seja conhecida.

---

**Lição de Administração:** O login de `root` só deve ser acessado por meio de um usuário normal configurado com `sudo`. Este procedimento garante a segurança e conformidade com as boas práticas de ambientes Linux.
