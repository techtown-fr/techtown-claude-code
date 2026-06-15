#!/usr/bin/env bash
# deploy.sh — Applique les settings Claude Code TechTown org-level au projet courant
# Usage : curl -s https://raw.githubusercontent.com/techtown-fr/techtown-claude-code/main/scripts/deploy.sh | bash

set -euo pipefail

ORG_REPO="techtown-fr/techtown-claude-code"
RAW_BASE="https://raw.githubusercontent.com/${ORG_REPO}/main"

echo "🚀 TechTown Claude Code — Déploiement settings org-level"
echo "   Repo source : https://github.com/${ORG_REPO}"
echo ""

# Vérifier qu'on est dans un repo git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "❌ Ce script doit être exécuté depuis la racine d'un repo git."
  exit 1
fi

# Créer .claude/ si absent
mkdir -p .claude

# Déployer settings.json
if [ -f ".claude/settings.json" ]; then
  echo "⚠️  .claude/settings.json existe déjà."
  echo "   Sauvegarde → .claude/settings.json.bak"
  cp .claude/settings.json .claude/settings.json.bak
fi

curl -s "${RAW_BASE}/settings.json" > .claude/settings.json
echo "✅ .claude/settings.json déployé"

# Vérifier que le JSON est valide
if command -v jq &> /dev/null; then
  jq . .claude/settings.json > /dev/null && echo "✅ JSON valide"
else
  python3 -m json.tool .claude/settings.json > /dev/null && echo "✅ JSON valide (python3)"
fi

# Déployer CLAUDE.md (seulement si absent — ne pas écraser un CLAUDE.md projet existant)
if [ ! -f "CLAUDE.md" ]; then
  curl -s "${RAW_BASE}/CLAUDE.md" > CLAUDE.md
  echo "✅ CLAUDE.md déployé"
else
  echo "ℹ️  CLAUDE.md existant conservé."
  echo "   Pour inclure les standards TechTown, ajoutez en tête de votre CLAUDE.md :"
  echo "   @$(pwd)/CLAUDE.md  (ou référencez la version GitHub)"
fi

echo ""
echo "🎉 Déploiement terminé !"
echo "   Vérifiez avec : claude → /config"
echo "   model   = claude-sonnet-4-6"
echo "   language = french"
