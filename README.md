# MySQL MCP Server

A Model Context Protocol (MCP) server that provides MySQL database access for VS Code AI extensions. Works with any MySQL or MariaDB server - local, remote, cloud, or containerized.

## Installation

```bash
npm install -g mysql-mcp-server
```

## Configuration

Create `.vscode/mcp.json` in your project:

```json
{
  "mcpServers": {
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

## Features

- SQL query execution
- Table listing
- Schema inspection
- Works with any MySQL/MariaDB server
- Remote database support
- Cloud database compatibility

## License

MIT
