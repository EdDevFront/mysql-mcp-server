# MySQL MCP Server

A Model Context Protocol (MCP) server that provides MySQL/MariaDB access to AI extensions in Visual Studio Code.

This project works with any MySQL/MariaDB installation — local, remote, containerized, or cloud-hosted.

## Installation

Install the published scoped package globally:

```bash
npm install -g @edsamo/mysql-mcp-server
```

Or install it locally in a project:

```bash
npm install @edsamo/mysql-mcp-server
```

After installing globally, the command available is `mcp-server-mysql`.

## Configuration

You can configure the server either per-project or globally in VS Code. The server reads configuration from environment variables; the examples below show how to provide them via the MCP server configuration.

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

Add the server configuration to your global VS Code settings (`settings.json`):

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

To open `settings.json` in VS Code: press `Ctrl+Shift+P` → "Preferences: Open Settings (JSON)".

## Common environment examples

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

- Docker (custom port):

```json
{
  "MYSQL_HOST": "localhost",
  "MYSQL_PORT": "3307",
  "MYSQL_USER": "mysql_user",
  "MYSQL_PASSWORD": "mysql_pass",
  "MYSQL_DATABASE": "app_db"
}
```

- Remote (VPS / public IP):

```json
{
  "MYSQL_HOST": "203.0.113.10",
  "MYSQL_PORT": "3306",
  "MYSQL_USER": "remote_user",
  "MYSQL_PASSWORD": "secure",
  "MYSQL_DATABASE": "prod_db"
}
```

## Features

- Execute SQL queries (`mysql_query`)
- List database tables (`mysql_list_tables`)
- Describe table schema (`mysql_describe_table`)
- Support for remote connections and SSH tunnels

## License

MIT
