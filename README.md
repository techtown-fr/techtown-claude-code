# techtown-claude-code

Configuration Claude Code de référence pour tous les projets TechTown.

## Contenu

| Fichier | Rôle |
|---------|------|
| `settings.json` | Paramètres CC org-level (modèle, langue, permissions, attribution) |
| `CLAUDE.md` | Instructions Claude communes à tous les projets TechTown |
| `scripts/deploy.sh` | Script d'adoption dans un projet existant |

## Déploiement dans un projet

### Option 1 — Script automatique (recommandé)

```bash
# Depuis la racine de votre projet TechTown
curl -s https://raw.githubusercontent.com/techtown-fr/techtown-claude-code/main/scripts/deploy.sh | bash
```

### Option 2 — Copie manuelle

```bash
# Créer le dossier .claude s'il n'existe pas
mkdir -p .claude

# Copier les settings org
curl -s https://raw.githubusercontent.com/techtown-fr/techtown-claude-code/main/settings.json \
  > .claude/settings.json

# Copier le CLAUDE.md org (ou le référencer depuis votre CLAUDE.md)
curl -s https://raw.githubusercontent.com/techtown-fr/techtown-claude-code/main/CLAUDE.md \
  > CLAUDE.md
```

> **Note :** Si votre projet a déjà un `.claude/settings.json`, fusionnez manuellement les clés.
> Les settings projet écrasent les settings org pour les clés communes — c'est le comportement attendu.

## Vérifier que les settings sont actifs

Après déploiement, ouvrez Claude Code depuis votre projet et exécutez `/config`.
Vous devez voir :
- `model` : `claude-sonnet-4-6`
- `language` : `french`

## Niveaux de settings dans Claude Code

```
Priorité (du plus fort au plus faible)
┌─────────────────────────────────────────┐
│  Local    .claude/settings.local.json   │ ← overrides personnels (gitignore)
│  Projet   .claude/settings.json         │ ← settings du projet (commités)
│  User     ~/.claude/settings.json       │ ← préférences personnelles
└─────────────────────────────────────────┘

[Enterprise uniquement]
  Managed  /Library/Application Support/ClaudeCode/managed-settings.json
           → déployé par IT via MDM, non-overridable par les utilisateurs
```

## Mise à jour

Pour mettre à jour un projet après une évolution des settings org :

```bash
curl -s https://raw.githubusercontent.com/techtown-fr/techtown-claude-code/main/scripts/deploy.sh | bash
```

## Contribuer

PRs bienvenues pour améliorer les standards TechTown.
Soumettre à `benjamin.bourgeois@techtown.fr` ou `nikolas.bouron@techtown.fr` pour review.
