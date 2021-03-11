---
title: "[TEST] pandoc-latex-admonition filter"

pandoc-latex-admonition:
  - color: Red
    classes: [warning]
    linewidth: 4
  - color: Red
    classes: [important]
    linewidth: 4
  - color: DarkSeaGreen
    classes: [tip]
    linewidth: 4
  - color: DarkSeaGreen
    classes: [note]
    linewidth: 4
  - color: DodgerBlue
    classes: [slide-content]
    linewidth: 4

---
### Outils : Sauvegarde / Restauration

<div class="slide-content">

  * Sauvegarde logique, pour une instance
    * `pg_dumpall` : sauvegarder l'instance PostgreSQL
  * Sauvegarde logique, pour une base de données
    * `pg_dump` : sauvegarder une base de données
    * `pg_restore` : restaurer une base de données PostgreSQL
  * Sauvegarde physique :
    * `pg_basebackup`
    * `pg_verifybackup`

</div>

<div class="notes">

Ces commandes sont essentielles pour assurer la sécurité des données du
serveur.

Comme son nom l'indique, `pg_dumpall` sauvegarde l'instance complète, autrement
dit toutes les bases mais aussi les objets globaux. À partir de la version 12,
il est cependant possible
d'exclure une ou plusieurs bases de cette sauvegarde.

Pour ne sauvegarder qu'une seule base, il est préférable de passer par l'outil
`pg_dump`, qui possède plus d'options. Il faut évidemment lui fournir le nom
de la base à sauvegarder. Pour sauvegarder notre base b1, il suffit de lancer
la commande suivante :

```bash
$ pg_dump -f b1.sql b1
```

Pour la restauration d'une sauvegarde, l'outil habituel est `pg_restore`.
`psql` est utilisé pour la restauration d'une sauvegarde faite en mode texte
(script SQL).

Ces deux outils réalisent des sauvegardes logiques, donc au niveau des objets
logiques (tables, index, etc).

La sauvegarde physique (donc au niveau des fichiers) à chaud est possible avec
`pg_basebackup`, qui copie un serveur en fonctionnement, journaux de
transaction inclus.  Son fonctionnement est nettement plus complexe qu'un
simple `pg_dump`.  `pg_basebackup` est utilisé par les outils de sauvegarde
PITR, et pour créer des serveurs secondaires.  `pg_verifybackup` permet de
vérifier une sauvegarde réalisée avec `pg_basebackup`.

</div>

