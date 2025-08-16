# ✅ Checklist de Publicação

## Antes de Publicar

### 1. Informações do Projeto
- [ ] Atualizar `author` no package.json com seu nome e email
- [ ] Atualizar `repository` com a URL do seu GitHub
- [ ] Atualizar `homepage` com a URL do seu GitHub
- [ ] Verificar se o `name` do package está único

### 2. Contas e Logins
- [ ] Criar conta no npm.com
- [ ] Criar repositório no GitHub
- [ ] Fazer login: `npm login`

### 3. Código e Build
- [ ] Código funcionando: `npm run build`
- [ ] Testar package: `npm pack`
- [ ] README.md atualizado

## Publicação

### Opção 1: Manual
```bash
# 1. Login
npm login

# 2. Build
npm run build

# 3. Publicar
npm publish

# 4. Git
git add .
git commit -m "Release v1.0.1"
git push
```

### Opção 2: Script Automático (Windows)
```bash
publish.bat
```

### Opção 3: Script Automático (Linux/Mac)
```bash
chmod +x publish.sh
./publish.sh
```

## Após Publicar

### Verificações
- [ ] Package no npm: https://www.npmjs.com/package/mysql-mcp-server
- [ ] Código no GitHub: https://github.com/SEU_USUARIO/mysql-mcp-server
- [ ] Instalação funciona: `npm install -g mysql-mcp-server`
- [ ] Comando funciona: `mcp-server-mysql --version`

### Atualizações Futuras
```bash
# Para mudanças pequenas (1.0.1 → 1.0.2)
npm version patch
npm publish

# Para novas features (1.0.0 → 1.1.0)
npm version minor
npm publish

# Para mudanças que quebram compatibilidade (1.0.0 → 2.0.0)
npm version major
npm publish
```

## 🚨 Problemas Comuns

| Problema | Solução |
|----------|---------|
| Nome já existe | Mude o `name` no package.json para algo único |
| Login falha | Verificar credenciais em npm.com |
| Build falha | Corrigir erros e executar `npm run build` |
| Git push falha | Verificar se o repositório GitHub existe |
| Package não aparece | Aguardar alguns minutos, npm pode demorar |

## 📞 Ajuda

- npm docs: https://docs.npmjs.com/
- GitHub docs: https://docs.github.com/
- Semver: https://semver.org/
