# Formation Flutter avancé (04 - 05/11)

## Optimisations
### const

- Le mot clé `const` évite d'allouer plusieurs fois la même valeur en mémoire. 
- Tant qu'une valeur n'est pas utilisée, elle n'est pas allouée en mémoire. 
- En revanche, une fois qu'elle l'est, elle persistera sur toute la durée de vie de l'application (GC compris).

### Scroll

- Les Widgets `ListView` et `SingleChildScrollView` (+ `Column`) sont équivalents. Même si tous les éléments ne sont pas affichés à l'écran, toutes les méthodes `build()` sont appelées.
- Il faut privilégier `ListView.builder` / `ListView.separated` ou l'API des `Sliver`.

### Visibilité

- Le Widget `Visibility` ne cache pas un élément, mais le remplace par un autre (`SizedBox` de 0x0 par défaut)
- Le Widget `Offstage` permet d'avoir un Widget dans l'arbre, mais qu'il ne soit pas calculé
- Le Widget `Opacity` fait tout comme si un Widget était là, mais ce n'est qu'au dernier moment que son opacité est changée.
