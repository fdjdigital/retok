#!/bin/bash

# Script de sincronização BIDIRECIONAL do repositório Retok com GitHub
# Este script baixa alterações do GitHub e envia alterações locais

cd "/Users/mateus/Documents/Prestação de Serviços/Retok"

LOG_FILE="/Users/mateus/Documents/Prestação de Serviços/Retok/.git-sync.log"

echo "$(date '+%Y-%m-%d %H:%M:%S') - Iniciando sincronização..." >> "$LOG_FILE"

# 1. BAIXAR alterações do GitHub para o computador
echo "$(date '+%Y-%m-%d %H:%M:%S') - Buscando alterações do GitHub..." >> "$LOG_FILE"
git fetch origin master

# Verificar se há alterações remotas
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Repositório local já está atualizado com GitHub" >> "$LOG_FILE"
elif [ $LOCAL = $BASE ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Baixando alterações do GitHub..." >> "$LOG_FILE"
    git pull origin master
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Alterações do GitHub baixadas com sucesso" >> "$LOG_FILE"
elif [ $REMOTE = $BASE ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Alterações locais precisam ser enviadas" >> "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Sincronizando alterações locais e remotas..." >> "$LOG_FILE"
    git pull origin master --no-rebase
fi

# 2. ENVIAR alterações locais para o GitHub
if [[ -n $(git status -s) ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Enviando alterações locais para GitHub..." >> "$LOG_FILE"

    # Adicionar todas as alterações
    git add .

    # Criar commit com data e hora
    git commit -m "Sincronização automática - $(date '+%d/%m/%Y às %H:%M')

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

    # Enviar para o GitHub
    git push origin master

    echo "$(date '+%Y-%m-%d %H:%M:%S') - Alterações enviadas para GitHub com sucesso" >> "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Nenhuma alteração local para enviar" >> "$LOG_FILE"
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Sincronização concluída!" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"
