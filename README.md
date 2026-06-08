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

1. Acesse o seu PostgreSQL e crie o usuário e o banco de dados:
   ```sql
   CREATE USER twubus WITH PASSWORD 'TwuBus2024#Secure';
   CREATE DATABASE twubus_db OWNER twubus;
   ```

2. Inicialize as tabelas do banco de dados utilizando o script disponibilizado:
   ```bash
   # Você pode executar este comando no terminal para importar a estrutura inicial
   psql -U twubus -d twubus_db -f database/init.sql
   ```

### 2. Configurando Variáveis de Ambiente
Na raiz do projeto, o arquivo `.env` já contém as configurações padrão para o ambiente de desenvolvimento local. Certifique-se de que as credenciais do banco de dados em `DATABASE_URL` correspondem ao que foi criado.

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
npm start
```
A aplicação abrirá automaticamente no navegador em `http://localhost:3000` ou `http://localhost:3001`. (Se o React avisar que a porta 3000 está em uso, aceite rodar em outra porta).

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
