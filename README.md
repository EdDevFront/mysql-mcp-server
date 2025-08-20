# MySQL MCP Server

Servidor MCP (Model Context Protocol) para fornecer acesso a bancos MySQL/MariaDB a extensões AI no VS Code.

Este projeto funciona com qualquer instalação MySQL/MariaDB — local, remota, conteinerizada ou em nuvem.

## Instalação

Instale a versão publicada (scoped) globalmente:

```bash
npm install -g @edsamo/mysql-mcp-server
```

Ou instale localmente no projeto:

```bash
npm install @edsamo/mysql-mcp-server
```

Após instalar globalmente, o comando disponível é `mcp-server-mysql`.

## Configuração

### Opção 1 — `.vscode/mcp.json` (recomendada por projeto)

Crie `.vscode/mcp.json` no seu projeto:

```json
{
  "servers": {
    "mysql": {
      "command": "mcp-server-mysql",
      "env": {
        "MYSQL_HOST": "localhost",
        "MYSQL_PORT": "3306",
        "MYSQL_USER": "root",
        "MYSQL_PASSWORD": "",
        "MYSQL_DATABASE": "sua_database"
      }
    }
  }
}
```

### Opção 2 — `settings.json` do VS Code (configuração global)

Adicione em `settings.json` do VS Code:

```json
{
  "mcp.servers": {
    "mysql": {
      "command": "mcp-server-mysql",
      "env": {
        "MYSQL_HOST": "localhost",
        "MYSQL_PORT": "3306",
        "MYSQL_USER": "root",
        "MYSQL_PASSWORD": "",
        "MYSQL_DATABASE": "sua_database"
      }
    }
  }
}
```

Para abrir `settings.json` no VS Code: `Ctrl+Shift+P` → "Preferences: Open Settings (JSON)".

## Exemplos de uso

Exemplos de `env` comuns:

- Local (XAMPP/WAMP):

```json
{
  "MYSQL_HOST": "localhost",
  "MYSQL_PORT": "3306",
  "MYSQL_USER": "root",
  "MYSQL_PASSWORD": "",
  "MYSQL_DATABASE": "app_db"
}
```

- Docker (porta customizada):

```json
{
  "MYSQL_HOST": "localhost",
  "MYSQL_PORT": "3307",
  "MYSQL_USER": "mysql_user",
  "MYSQL_PASSWORD": "mysql_pass",
  "MYSQL_DATABASE": "app_db"
}
```

- Remoto (VPS / IP público):

```json
{
  "MYSQL_HOST": "203.0.113.10",
  "MYSQL_PORT": "3306",
  "MYSQL_USER": "remote_user",
  "MYSQL_PASSWORD": "secure",
  "MYSQL_DATABASE": "prod_db"
}
```

## Funcionalidades

- Execução de queries SQL (`mysql_query`)
- Listagem de tabelas (`mysql_list_tables`)
- Descrição de esquema (`mysql_describe_table`)
- Suporte a conexões remotas e via SSH tunnel

## Como publicar (referência)

Se precisar publicar você mesmo, use o nome scoped (`@seu-usuario/mysql-mcp-server`) e execute:

```bash
npm login
npm run build
npm publish --access public
```

## Licença

MIT
