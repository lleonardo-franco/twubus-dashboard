# 🚌 TwuBus Dashboard - Guia Completo para Iniciantes

Bem-vindo ao **TwuBus Dashboard**! Este guia foi feito especialmente para ajudar qualquer pessoa, mesmo sem experiência técnica, a instalar e rodar o projeto no seu próprio computador.

O sistema é dividido em três partes principais:
1. **Banco de Dados:** Onde as informações ficam salvas (PostgreSQL).
2. **Backend (Servidor):** O "motor" do sistema (Node.js).
3. **Frontend (Tela):** A interface onde você clica e interage (React).

Siga os passos abaixo com calma e atenção.

---

## 🛠️ Passo 1: Instalando os Programas Necessários

Antes de rodar o projeto, você precisa instalar alguns programas no seu computador. Todos são gratuitos.

### 1.1. Instalar o Node.js (Para o Frontend e Backend)
1. Acesse o site oficial: [https://nodejs.org/](https://nodejs.org/)
2. Baixe a versão recomendada para a maioria dos usuários (LTS - *Long Term Support*).
3. Abra o arquivo baixado e instale normalmente (basta clicar em *Next* / *Avançar* em todas as telas, aceitar os termos e finalizar).

### 1.2. Instalar o PostgreSQL (Para o Banco de Dados)
1. Acesse a página de download: [https://www.postgresql.org/download/](https://www.postgresql.org/download/)
2. Escolha o seu sistema operacional (Windows, macOS, etc.) e baixe o instalador interativo.
3. Durante a instalação:
   - Deixe todas as opções padrão marcadas.
   - **MUITO IMPORTANTE:** O instalador pedirá para você criar uma senha para o usuário principal (`postgres`). **Crie uma senha segura e anote-a**, você vai precisar dela em breve.
   - Mantenha a porta padrão (`5432`).
   - Finalize a instalação (não é necessário abrir o "Stack Builder" no final).

### 1.3. Instalar o Git (Para baixar o projeto)
1. Acesse: [https://git-scm.com/downloads](https://git-scm.com/downloads)
2. Baixe e instale com as configurações padrão (só clicar em *Next* até o fim).

---

## 📂 Passo 2: Baixando o Projeto

1. Crie uma pasta no seu computador onde você deseja guardar o projeto (por exemplo, na Área de Trabalho ou Documentos).
2. Abra essa pasta.
3. Se estiver no Windows, clique com o botão direito do mouse dentro do espaço em branco da pasta e selecione **"Open Git Bash here"** (Abrir Git Bash aqui) ou abra o terminal da sua preferência.
4. Digite o seguinte comando e aperte **Enter**:
   ```bash
   git clone https://github.com/lleonardo-franco/twubus-dashboard.git
   ```
5. Acesse a pasta do projeto que acabou de ser baixada:
   ```bash
   cd twubus-dashboard
   ```
*(Deixe esta janela preta/terminal aberta, usaremos ela em breve).*

---

## 🗄️ Passo 3: Configurando o Banco de Dados

Agora vamos preparar o local onde os dados ficarão salvos. Primeiro criaremos o banco de dados e depois atualizaremos as configurações do projeto com a senha que você escolheu.

### Pelo SQL Shell (psql):
1. No menu Iniciar do Windows ou barra de pesquisa do seu computador, procure por **SQL Shell (psql)** e abra-o.
2. Ele vai fazer várias perguntas (Server, Database, Port, Username). Vá apertando a tecla **Enter** para aceitar o padrão em todas elas.
3. Quando pedir a **Password** (Senha), digite a senha que você criou na instalação do PostgreSQL (Passo 1.2) e aperte Enter. *(Atenção: o cursor não vai se mover enquanto você digita a senha, isso é normal, apenas digite e aperte Enter).*
4. Agora você está dentro do banco de dados. Vamos criar o usuário do sistema (substitua `SUA_SENHA_AQUI` pela mesma senha segura que você criou ou por uma nova senha):
   ```sql
   CREATE USER twubus WITH PASSWORD 'SUA_SENHA_AQUI';
   ```
5. Agora vamos criar o banco de dados em si:
   ```sql
   CREATE DATABASE twubus_db OWNER twubus;
   ```
6. Você pode fechar a janela do SQL Shell.

### Carregando as tabelas iniciais:
1. Volte para a janela preta (terminal) que você deixou aberta na raiz da pasta do projeto.
2. O arquivo com as tabelas iniciais já está localizado dentro da pasta `database/init.sql`. Digite o comando abaixo para executar esse arquivo e criar as tabelas (ele pedirá a senha do usuário `twubus` que você acabou de criar):
   ```bash
   psql -U twubus -d twubus_db -f database/init.sql
   ```
*(Se o terminal disser que "psql não é reconhecido", você pode precisar fechar o terminal e abrir de novo, ou usar a ferramenta pgAdmin para abrir o arquivo `database/init.sql` e executá-lo manualmente).*

### Atualizando o arquivo de configuração (.env):
1. Na pasta do projeto (`twubus-dashboard`), abra o arquivo chamado `.env` usando o Bloco de Notas ou qualquer editor de texto.
2. Procure pelas linhas `DATABASE_URL` e `DB_PASS`.
3. Substitua a senha padrão (`TwuBus2024#Secure`) pela senha que você criou no passo anterior (`SUA_SENHA_AQUI`).
4. Salve e feche o arquivo.

---

## ⚙️ Passo 4: Iniciando o Servidor (Backend)

O backend é a parte que conecta a tela com o banco de dados.

1. Naquela janela preta (terminal) aberta na pasta do projeto, entre na pasta do backend digitando:
   ```bash
   cd backend
   ```
2. Instale as dependências (pacotes) necessárias com o comando:
   ```bash
   npm install
   ```
   *(Aguarde terminar, pode levar um ou dois minutos).*
3. Inicie o servidor:
   ```bash
   npm run dev
   ```
4. Se aparecer a mensagem indicando que o servidor está rodando na porta 3000, **deu tudo certo!**
5. **Aviso:** Não feche esta janela, deixe ela aberta minimizada enquanto você usa o sistema.

---

## 🖥️ Passo 5: Iniciando a Tela do Sistema (Frontend)

Agora vamos iniciar a parte visual onde você vai clicar.

1. Você precisará abrir **uma nova janela do terminal**. (Vá na pasta principal do projeto `twubus-dashboard`, clique com o botão direito e abra o Git Bash ou terminal novamente).
2. Entre na pasta do frontend:
   ```bash
   cd frontend
   ```
3. Instale as dependências com o comando:
   ```bash
   npm install
   ```
   *(Aguarde terminar).*
4. Inicie o frontend:
   ```bash
   npm start
   ```
5. O sistema perguntará se você deseja rodar em outra porta, pois a porta 3000 já está sendo usada pelo backend. Digite **Y** (Sim) e aperte Enter.
6. Pronto! O navegador de internet abrirá automaticamente na página do TwuBus Dashboard (geralmente no endereço `http://localhost:3001`).

---

## 🎉 Resumo para as Próximas Vezes

Toda vez que você desligar o computador e quiser abrir o sistema de novo, não precisará instalar nada de novo! Basta fazer isso:

1. Abrir um terminal na pasta `backend` e rodar: `npm run dev`
2. Abrir um outro terminal na pasta `frontend` e rodar: `npm start`
3. Acessar no seu navegador!

---

## 🐳 Opção Avançada: Rodando com Docker

Se você sabe o que é Docker e tem o **Docker Desktop** instalado, o processo é muito mais rápido:

1. Garanta que seu banco de dados nativo esteja rodando na porta 5432 com o banco `twubus_db` criado.
2. Na raiz do projeto, abra o terminal e rode:
   ```bash
   docker-compose up --build
   ```
3. Acesse `http://localhost:3001` no seu navegador.
