#!/bin/bash

# Script de sincronização automática do repositório Retok com GitHub
# Este script adiciona, comita e envia alterações para o GitHub

cd "/Users/mateus/Documents/Prestação de Serviços/Retok"

# Verificar se há mudanças
if [[ -n $(git status -s) ]]; then
    # Adicionar todas as alterações
    git add .

    # Criar commit com data e hora
    git commit -m "Sincronização automática - $(date '+%d/%m/%Y às %H:%M')

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

    # Enviar para o GitHub
    git push origin master

    echo "$(date '+%Y-%m-%d %H:%M:%S') - Sincronização realizada com sucesso" >> "/Users/mateus/Documents/Prestação de Serviços/Retok/.git-sync.log"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Nenhuma alteração para sincronizar" >> "/Users/mateus/Documents/Prestação de Serviços/Retok/.git-sync.log"
fi
