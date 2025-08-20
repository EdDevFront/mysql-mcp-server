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

````json
{
  "servers": {
    "mysql": {
      "command": "mcp-server-mysql",
      "env": {
        "MYSQL_HOST": "localhost",
        # MySQL MCP Server

        This is a Model Context Protocol (MCP) server that provides MySQL/MariaDB access to AI extensions in VS Code.

        It works with any MySQL/MariaDB installation — local, remote, containerized, or cloud-hosted.

        ## Installation

        Install the published scoped package globally:

        ```bash
        npm install -g @edsamo/mysql-mcp-server
        ```

        Or install it locally in a project:

        ```bash
        npm install @edsamo/mysql-mcp-server
        ```

        After installing globally, the `mcp-server-mysql` command will be available.

        ## Configuration

        ### Option 1 — `.vscode/mcp.json` (per-project, recommended)

        Create `.vscode/mcp.json` in your project:

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
                "MYSQL_DATABASE": "your_database"
              }
            }
          }
        }
        ```

        ### Option 2 — VS Code `settings.json` (global)

        Add to your VS Code `settings.json`:

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
                "MYSQL_DATABASE": "your_database"
              }
            }
          }
        }
        ```

        To open `settings.json` in VS Code: `Ctrl+Shift+P` → "Preferences: Open Settings (JSON)".

        ## Usage examples

        Common `env` examples:

        - Local (XAMPP/WAMP):

        ```json
        {"MYSQL_HOST":"localhost","MYSQL_PORT":"3306","MYSQL_USER":"root","MYSQL_PASSWORD":"","MYSQL_DATABASE":"app_db"}
        ```

        - Docker (custom port):

        ```json
        {"MYSQL_HOST":"localhost","MYSQL_PORT":"3307","MYSQL_USER":"mysql_user","MYSQL_PASSWORD":"mysql_pass","MYSQL_DATABASE":"app_db"}
        ```

        - Remote (VPS / public IP):

        ```json
        {"MYSQL_HOST":"203.0.113.10","MYSQL_PORT":"3306","MYSQL_USER":"remote_user","MYSQL_PASSWORD":"secure","MYSQL_DATABASE":"prod_db"}
        ```

        ## Features

        - Execute SQL queries (`mysql_query`)
        - List database tables (`mysql_list_tables`)
        - Describe table schema (`mysql_describe_table`)
        - Support for remote connections and SSH tunnels

        ## Publishing (reference)

        If you need to publish yourself, use a scoped name (e.g. `@your-username/mysql-mcp-server`) and run:

        ```bash
        npm login
        npm run build
        npm publish --access public
        ```

        ## License

        MIT
````
