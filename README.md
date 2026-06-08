# TwuBus Dashboard

Bem-vindo ao repositório do TwuBus Dashboard! Este projeto é composto por um frontend em React, um backend em Node.js e um banco de dados PostgreSQL.

## Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas em sua máquina:
- [Node.js](https://nodejs.org/) (versão 18 ou superior)
- [PostgreSQL](https://www.postgresql.org/)
- [Docker](https://www.docker.com/) e Docker Compose (opcional, para rodar com containers)
- Git

---

## 🚀 Passo a passo para rodar localmente (Modo Manual)

### 1. Configuração do Banco de Dados
O backend requer um banco de dados PostgreSQL em execução.

1. Acesse o seu PostgreSQL e crie o usuário e o banco de dados (recomenda-se utilizar uma senha segura):
   ```sql
   CREATE USER twubus WITH PASSWORD 'sua_senha_segura';
   CREATE DATABASE twubus_db OWNER twubus;
   ```

2. Inicialize as tabelas do banco de dados utilizando o script disponibilizado:
   ```bash
   # Você pode executar este comando no terminal para importar a estrutura inicial
   psql -U twubus -d twubus_db -f database/init.sql
   ```

### 2. Configurando Variáveis de Ambiente
Na raiz do projeto, o arquivo `.env` já contém algumas configurações. Certifique-se de que as credenciais do banco de dados em `DATABASE_URL` (e as variáveis `DB_PASS`, etc) correspondem ao que foi configurado no passo anterior (ex: altere para `sua_senha_segura`).

### 3. Executando o Backend
Abra um terminal, acesse a pasta `backend` e inicie o servidor:

```bash
cd backend
npm install
npm run dev
```
O servidor backend estará rodando em `http://localhost:3000`.

### 4. Executando o Frontend
Em outro terminal, acesse a pasta `frontend` e inicie o React:

```bash
cd frontend
npm install
# Opcional: force a porta 3001 caso não queira usar o prompt interativo do React
# Linux/macOS: PORT=3001 npm start
# Windows: set PORT=3001 && npm start
npm start
```
A aplicação tentará abrir na porta 3000 por padrão. Como o backend já está utilizando essa porta, o terminal perguntará se você deseja utilizar outra porta (geralmente a `3001`). Digite `Y` (sim) para confirmar. O frontend ficará disponível em `http://localhost:3001`.

---

## 🐳 Passo a passo para rodar localmente (Com Docker)

O projeto conta com um arquivo `docker-compose.yml` que facilita a inicialização das aplicações Frontend e Backend utilizando containers.

**Aviso importante:** O arquivo `docker-compose.yml` atual espera conectar ao banco de dados rodando na máquina host (`host.docker.internal`). 

### 1. Configuração do Banco de Dados Host
Você precisa ter o PostgreSQL rodando nativamente na sua máquina na porta `5432` com o banco `twubus_db` criado (conforme o Passo 1 do modo manual).

### 2. Subindo os Containers
Na raiz do projeto, rode o seguinte comando para construir e iniciar os containers:

```bash
docker-compose up --build
```
Isso fará com que o sistema inicie:
- O **Frontend** na porta `3001` (`http://localhost:3001`)
- O **Backend** na porta `3000` (`http://localhost:3000`)

Para parar a execução, utilize `Ctrl+C` no terminal ou rode:
```bash
docker-compose down
```

---

## 📁 Estrutura do Projeto

- **/frontend** - Aplicação web construída em React.
- **/backend** - API construída em Node.js utilizando Express.
- **/database** - Scripts SQL para criação das tabelas iniciais.
- **/scripts** - Scripts utilitários.
- **/logs** - Armazenamento de logs (se gerados pela API).
- **docker-compose.yml** - Orquestração dos serviços (Frontend/Backend) no Docker.
- **.env** - Arquivo centralizado de variáveis de ambiente.
