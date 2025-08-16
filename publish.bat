@echo off
echo 🚀 MySQL MCP Server - Script de Publicação
echo ==========================================

REM Verificar se está logado no npm
npm whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Você não está logado no npm.
    echo Execute: npm login
    pause
    exit /b 1
)

for /f %%i in ('npm whoami') do set NPM_USER=%%i
echo ✅ Usuário npm: %NPM_USER%

REM Build do projeto
echo 🔨 Fazendo build...
call npm run build
if %errorlevel% neq 0 (
    echo ❌ Build falhou!
    pause
    exit /b 1
)
echo ✅ Build concluído

REM Verificar package.json
findstr "seu.email@exemplo.com" package.json >nul
if %errorlevel% equ 0 (
    echo ⚠️  ATENÇÃO: Atualize as informações no package.json:
    echo    - author: Seu nome e email real
    echo    - repository: URL do seu repositório GitHub
    echo    - homepage: URL do seu repositório GitHub
    set /p CONTINUE="Continuar mesmo assim? (y/n): "
    if /i not "%CONTINUE%"=="y" exit /b 1
)

REM Criar package de teste
echo 📦 Criando package de teste...
call npm pack
if %errorlevel% neq 0 (
    echo ❌ Pack falhou!
    pause
    exit /b 1
)
echo ✅ Package criado com sucesso

REM Perguntar se quer publicar
set /p PUBLISH="🚀 Publicar no npm agora? (y/n): "
if /i "%PUBLISH%"=="y" (
    echo 📤 Publicando...
    call npm publish
    if %errorlevel% equ 0 (
        echo 🎉 Publicado com sucesso!
        echo 📋 Verificar em: https://www.npmjs.com/package/mysql-mcp-server
        echo 💡 Instalar com: npm install -g mysql-mcp-server
        
        REM Limpar arquivo de teste
        del mysql-mcp-server-*.tgz >nul 2>&1
        
        REM Verificar se há mudanças no git
        git status --porcelain | findstr . >nul
        if %errorlevel% equ 0 (
            set /p COMMIT="💾 Fazer commit no git? (y/n): "
            if /i "!COMMIT!"=="y" (
                git add .
                for /f %%v in ('node -p "require('./package.json').version"') do set VERSION=%%v
                git commit -m "Release version %VERSION%"
                echo ✅ Commit realizado
                
                set /p PUSH="⬆️  Fazer push para GitHub? (y/n): "
                if /i "!PUSH!"=="y" (
                    git push
                    echo ✅ Push realizado
                )
            )
        )
    ) else (
        echo ❌ Falha na publicação!
        pause
        exit /b 1
    )
) else (
    echo 🔄 Publicação cancelada
    REM Limpar arquivo de teste
    del mysql-mcp-server-*.tgz >nul 2>&1
)

echo ✨ Processo concluído!
pause
