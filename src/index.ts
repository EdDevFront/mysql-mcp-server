#!/usr/bin/env node

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ErrorCode,
  ListToolsRequestSchema,
  McpError,
} from "@modelcontextprotocol/sdk/types.js";
import * as mysql from "mysql2/promise";

class MySQLMCPServer {
  private server: Server;
  private connection: mysql.Connection | null = null;

  constructor() {
    this.server = new Server(
      {
        name: "mysql-mcp-server",
        version: "1.0.1",
      },
      {
        capabilities: {
          tools: {},
        },
      }
    );

    this.setupToolHandlers();
    this.setupErrorHandling();
  }

  private setupErrorHandling(): void {
    this.server.onerror = (error) => {
      console.error("[MCP Error]", error);
    };

    process.on("SIGINT", async () => {
      await this.cleanup();
      process.exit(0);
    });

    process.on("uncaughtException", (error) => {
      console.error("[MySQL MCP] Uncaught exception:", error);
      process.exit(1);
    });

    process.on("unhandledRejection", (reason, promise) => {
      console.error("[MySQL MCP] Unhandled rejection:", reason);
    });
  }

  private async cleanup(): Promise<void> {
    if (this.connection) {
      await this.connection.end();
    }
  }

  private async getConnection(): Promise<mysql.Connection> {
    if (!this.connection) {
      const config = {
        host: process.env.MYSQL_HOST || "localhost",
        port: parseInt(process.env.MYSQL_PORT || "3306"),
        user: process.env.MYSQL_USER || "root",
        password: process.env.MYSQL_PASSWORD || "",
        database: process.env.MYSQL_DATABASE || "test",
      };

      try {
        this.connection = await mysql.createConnection(config);
      } catch (error) {
        throw new McpError(
          ErrorCode.InternalError,
          `Failed to connect to MySQL: ${error}`
        );
      }
    }
    return this.connection;
  }

  private setupToolHandlers(): void {
    this.server.setRequestHandler(ListToolsRequestSchema, async () => {
      return {
        tools: [
          {
            name: "mysql_query",
            description: "Execute a MySQL query and return results",
            inputSchema: {
              type: "object",
              properties: {
                query: {
                  type: "string",
                  description: "The SQL query to execute",
                },
              },
              required: ["query"],
            },
          },
          {
            name: "mysql_list_tables",
            description: "List all tables in the current database",
            inputSchema: {
              type: "object",
              properties: {},
            },
          },
          {
            name: "mysql_describe_table",
            description: "Describe the structure of a table",
            inputSchema: {
              type: "object",
              properties: {
                table: {
                  type: "string",
                  description: "The name of the table to describe",
                },
              },
              required: ["table"],
            },
          },
        ],
      };
    });

    this.server.setRequestHandler(CallToolRequestSchema, async (request) => {
      const { name, arguments: args } = request.params;

      try {
        const connection = await this.getConnection();

        switch (name) {
          case "mysql_query": {
            const { query } = args as { query: string };

            if (!query.trim()) {
              throw new McpError(
                ErrorCode.InvalidParams,
                "Query cannot be empty"
              );
            }

            const [results] = await connection.execute(query);

            return {
              content: [
                {
                  type: "text",
                  text: JSON.stringify(results, null, 2),
                },
              ],
            };
          }

          case "mysql_list_tables": {
            const [results] = await connection.execute("SHOW TABLES");
            return {
              content: [
                {
                  type: "text",
                  text: JSON.stringify(results, null, 2),
                },
              ],
            };
          }

          case "mysql_describe_table": {
            const { table } = args as { table: string };

            if (!table) {
              throw new McpError(
                ErrorCode.InvalidParams,
                "Table name is required"
              );
            }

            const [results] = await connection.execute(
              `DESCRIBE ${mysql.escapeId(table)}`
            );
            return {
              content: [
                {
                  type: "text",
                  text: JSON.stringify(results, null, 2),
                },
              ],
            };
          }

          default:
            throw new McpError(
              ErrorCode.MethodNotFound,
              `Unknown tool: ${name}`
            );
        }
      } catch (error) {
        if (error instanceof McpError) {
          throw error;
        }
        throw new McpError(
          ErrorCode.InternalError,
          `Database operation failed: ${error}`
        );
      }
    });
  }

  async run(): Promise<void> {
    try {
      const transport = new StdioServerTransport();
      await this.server.connect(transport);
    } catch (error) {
      console.error("[MySQL MCP] Failed to start:", error);
      throw error;
    }
  }
}

// Start the server
const server = new MySQLMCPServer();
server.run().catch((error) => {
  console.error("[MySQL MCP] Fatal error:", error);
  process.exit(1);
});
