#!/bin/bash

echo "🚀 MySQL MCP Server - Script de Publicação"
echo "=========================================="

# Verificar se está logado no npm
if ! npm whoami > /dev/null 2>&1; then
    echo "❌ Você não está logado no npm."
    echo "Execute: npm login"
    exit 1
fi

echo "✅ Usuário npm:" $(npm whoami)

# Verificar se o build funciona
echo "🔨 Fazendo build..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Build falhou!"
    exit 1
fi

echo "✅ Build concluído"

# Verificar se o package.json tem informações corretas
echo "📝 Verificando package.json..."
if grep -q "seu.email@exemplo.com" package.json; then
    echo "⚠️  ATENÇÃO: Atualize as informações no package.json:"
    echo "   - author: Seu nome e email real"
    echo "   - repository: URL do seu repositório GitHub"
    echo "   - homepage: URL do seu repositório GitHub"
    read -p "Continuar mesmo assim? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Fazer pack para testar
echo "📦 Criando package de teste..."
npm pack

if [ $? -ne 0 ]; then
    echo "❌ Pack falhou!"
    exit 1
fi

echo "✅ Package criado com sucesso"

# Perguntar se quer publicar
read -p "🚀 Publicar no npm agora? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📤 Publicando..."
    npm publish
    
    if [ $? -eq 0 ]; then
        echo "🎉 Publicado com sucesso!"
        echo "📋 Verificar em: https://www.npmjs.com/package/mysql-mcp-server"
        echo "💡 Instalar com: npm install -g mysql-mcp-server"
        
        # Limpar arquivo de teste
        rm -f mysql-mcp-server-*.tgz
        
        # Commit no git se houver mudanças
        if [ -n "$(git status --porcelain)" ]; then
            read -p "💾 Fazer commit no git? (y/n): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                git add .
                git commit -m "Release version $(node -p "require('./package.json').version")"
                echo "✅ Commit realizado"
                
                read -p "⬆️  Fazer push para GitHub? (y/n): " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    git push
                    echo "✅ Push realizado"
                fi
            fi
        fi
    else
        echo "❌ Falha na publicação!"
        exit 1
    fi
else
    echo "🔄 Publicação cancelada"
    # Limpar arquivo de teste
    rm -f mysql-mcp-server-*.tgz
fi

echo "✨ Processo concluído!"
