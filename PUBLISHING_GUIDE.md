# Guia de Publicação - MySQL MCP Server

## 📋 Pré-requisitos

1. **Conta npm**: Crie uma conta em https://www.npmjs.com/
2. **Conta GitHub**: Crie uma conta em https://github.com/
3. **npm CLI**: Verificar se está instalado: `npm --version`
4. **Git**: Verificar se está instalado: `git --version`

## 🔧 Passo 1: Configurar Informações do Package

Edite o `package.json` e substitua:

```json
{
  "name": "mysql-mcp-server",
  "author": "SEU_NOME <seu.email@gmail.com>",
  "repository": {
    "type": "git",
    "url": "git+https://github.com/SEU_USUARIO/mysql-mcp-server.git"
  },
  "bugs": {
    "url": "https://github.com/SEU_USUARIO/mysql-mcp-server/issues"
  },
  "homepage": "https://github.com/SEU_USUARIO/mysql-mcp-server#readme"
}
```

## 🐙 Passo 2: Configurar GitHub

### 2.1 Criar Repositório no GitHub

1. Acesse https://github.com/new
2. Nome do repositório: `mysql-mcp-server`
3. Descrição: `MySQL Model Context Protocol Server for VS Code AI extensions`
4. Público ✅
5. Clique "Create repository"

### 2.2 Conectar Projeto Local ao GitHub

```bash
# No diretório do projeto
git init
git add .
git commit -m "Initial commit: MySQL MCP Server"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/mysql-mcp-server.git
git push -u origin main
```

## 📦 Passo 3: Publicar no npm

### 3.1 Login no npm

```bash
npm login
# Digite seu username, password e email do npm
```

### 3.2 Verificar se o nome está disponível

```bash
npm view mysql-mcp-server
# Se retornar erro 404, o nome está disponível
```

### 3.3 Build e Publicar

```bash
# Build do projeto
npm run build

# Testar o package localmente
npm pack

# Publicar (primeira vez)
npm publish

# Para futuras atualizações:
npm version patch  # incrementa versão (1.0.1 -> 1.0.2)
npm publish
```

## 🔄 Passo 4: Configurar Automação (Opcional)

### 4.1 Criar GitHub Actions (.github/workflows/publish.yml)

```yaml
name: Publish to npm

on:
  push:
    tags:
      - "v*"

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: "18"
          registry-url: "https://registry.npmjs.org"
      - run: npm ci
      - run: npm run build
      - run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

### 4.2 Configurar NPM Token no GitHub

1. npm.com → Account → Access Tokens → Generate New Token
2. GitHub → Seu Repositório → Settings → Secrets → New repository secret
3. Nome: `NPM_TOKEN`, Value: seu token do npm

## 📝 Comandos Resumidos

```bash
# 1. Configurar Git
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/SEU_USUARIO/mysql-mcp-server.git
git push -u origin main

# 2. Publicar npm
npm login
npm run build
npm publish

# 3. Para atualizações futuras
git add .
git commit -m "Descrição da mudança"
git push
npm version patch
npm publish
```

## ✅ Verificação Final

Após publicar, verificar:

- https://www.npmjs.com/package/mysql-mcp-server
- https://github.com/SEU_USUARIO/mysql-mcp-server
- Testar instalação: `npm install -g mysql-mcp-server`

## 🏷️ Dicas Importantes

1. **Nome único**: Se `mysql-mcp-server` já existir, use: `@SEU_USUARIO/mysql-mcp-server`
2. **Versioning**: Use semver (1.0.0 → 1.0.1 para patches, 1.1.0 para features)
3. **README**: Mantenha sempre atualizado no GitHub
4. **License**: MIT já está configurada
5. **Keywords**: Ajudam na descoberta no npm search

## 🚨 Problemas Comuns

- **Nome já existe**: Mude o nome no package.json
- **Login falha**: Verifique credenciais npm
- **Push falha**: Verifique se o repositório GitHub existe
- **Build falha**: Execute `npm run build` antes de publicar
