# techtown-claude-code

Configuration Claude Code **niveau organisation** pour TechTown.
La gouvernance se fait via les **managed settings** poussés depuis la console admin Anthropic (TechTown n'a pas de MDM).

## Contenu

| Fichier | Rôle |
|---------|------|
| `managed-settings.template.json` | **Source de vérité versionnée** du JSON poussé dans la console admin Anthropic (settings managés, inviolables) |
| `CLAUDE.md` | Instructions Claude communes aux projets TechTown (à référencer/copier par projet) |

## Comment c'est déployé

Les managed settings ne se déploient **pas par git** — ils vivent côté serveur Anthropic :

1. Édite `managed-settings.template.json` dans ce repo (diff/historique git que la console n'offre pas).
2. Copie son contenu dans **console admin → Claude Code → Paramètres gérés** (`claude.ai/admin-settings/claude-code`).
3. Clique **« Mettre à jour les paramètres »**.
4. Chaque poste les récupère dans `~/.claude/remote-settings.json` (au démarrage + refetch ~horaire).

> ⚠️ **Les managed settings sont fetchés selon l'org authentifiée.** Pour les voir s'appliquer, Claude Code doit être connecté sous l'**org TechTown** (`/login` → choisir TechTown). Une session connectée à une autre org (client, perso) ne verra jamais ces settings.

> ⚠️ La console valide contre le [schéma Claude Code](https://json.schemastore.org/claude-code-settings.json). Des paramètres invalides peuvent **désactiver Claude Code pour toute l'org** — toujours valider (`jq . managed-settings.template.json`) avant de coller.

## Ce que contient la config managée

- **Sécurité** : `deny` des secrets (`.env`, `~/.ssh`, `~/.config/gcloud`, `~/.aws`, `~/.gnupg`) + `curl|sh` ; `ask` sur les effets destructifs (force push, `reset --hard`, `gcloud/gsutil/terraform delete`, `rm -rf`, formatage disque…).
- **Serveurs MCP fournis** : `managedMcpServers` distribue [Meetown](https://github.com/techtown-fr/meetown) (`https://mcp.meetown.techtown.fr/mcp`) à tout le monde — rien à installer, chacun s'authentifie une fois en OAuth via `/mcp` (Google SSO @techtown.fr). Visible sous **Managed MCPs**, non supprimable localement mais désactivable pour soi. Ces serveurs ne passent pas par l'allowlist `allowedMcpServers`. Requiert Claude Code ≥ 2.1.259, d'où `requiredMinimumVersion`.
- **Marketplace TechTown** : `extraKnownMarketplaces` enregistre [techtown-marketplace](https://github.com/techtown-fr/techtown-marketplace) sur chaque poste (plus besoin de `claude plugin marketplace add`), avec `autoUpdate: true` pour que les nouvelles versions des plugins arrivent sans action. Enregistrer la marketplace n'installe aucun plugin : c'est `enabledPlugins` qui en impose.
- **Gouvernance** : `forceLoginOrgUUID` (verrou org TechTown), `allowedMcpServers` + `allowManagedMcpServersOnly` (allowlist MCP : github, context7, playwright), `strictKnownMarketplaces` (2 marketplaces officielles Anthropic), `disableBypassPermissionsMode`.
- **Conventions org** : `model` (claude-sonnet-4-6), `language` (français), `companyAnnouncements`, `attribution`, `includeGitInstructions`, `requiredMinimumVersion`.

**Choix de design :** les `allow` ne sont **pas** verrouillés au niveau managé — chaque collaborateur garde ses `allow` projet/user. Le managé n'impose que les garde-fous `ask`/`deny` et la gouvernance. L'auto-mode n'est **pas** bloqué.

## Niveaux de settings dans Claude Code

```
Priorité (du plus fort au plus faible)
┌────────────────────────────────────────────────────────┐
│ Managed  (console admin / server-managed)   ← INVIOLABLE │  ← ce repo
│ CLI args                                                 │
│ Local    .claude/settings.local.json (gitignore)         │
│ Projet   .claude/settings.json (commité)                 │
│ User     ~/.claude/settings.json                         │
└────────────────────────────────────────────────────────┘

Cache local des managed settings fetchés : ~/.claude/remote-settings.json (lecture seule)
```

## Instructions org (`CLAUDE.md`)

`CLAUDE.md` n'est pas distribuable via managed settings. Pour l'appliquer à un projet, copie-le ou référence-le :

```bash
curl -s https://raw.githubusercontent.com/techtown-fr/techtown-claude-code/main/CLAUDE.md > CLAUDE.md
```

## Contribuer

PRs bienvenues. Soumettre à `benjamin.bourgeois@techtown.fr` ou `nikolas.bouron@techtown.fr` pour review.
