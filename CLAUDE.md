# TechTown — Instructions Claude Code

> Instructions communes aux projets TechTown. Les garde-fous de sécurité, la gouvernance
> (MCP, marketplaces, verrou org) et les conventions (modèle, langue) sont imposés via les
> **managed settings** de l'org TechTown (voir `README.md`). Ce fichier complète ces settings
> avec les standards de développement à appliquer dans chaque projet.

## Contexte Organisation

Tu travailles dans le cadre des projets TechTown, cabinet d'expertise IA & Cloud basé à Nantes.
Tous les projets de l'organisation suivent ces conventions.

## Standards de Développement

- **Langue** : réponds toujours en français, sauf si le code ou la documentation technique l'impose autrement
- **Runtime** : privilégie TypeScript avec Bun pour les scripts et outils maison
- **Commits** : atomiques, messages en Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`)
- **Branches** : `feat/<sujet>` ≤ 3 jours, toujours mergé sur `main`

## Règles de Qualité

- Lis avant de modifier : comprendre le code existant avant tout changement
- Vérifie avant de déclarer terminé : lancer les tests, lire le diff, contrôler visuellement
- Ne jamais supprimer ce qui fonctionne : fix chirurgical, scope minimal

## Sécurité

- Ne jamais committer de secrets, tokens ou clés API
- Variables d'environnement via `.env` (ajouté au `.gitignore`)
- Valider les inputs externes — ne jamais faire confiance aux données injectées

## Contexte Cloud & IA

Les projets TechTown touchent principalement : Google Cloud Platform, Vertex AI, Node.js/TypeScript,
Slidev (présentations), et des agents IA. Adapte tes recommandations à ce stack.
