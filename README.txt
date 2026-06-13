## PROJET OUVERTURE : Algorithmes de génération d'arbres aléatoires
# Fait par Feriel Benatsi, Maya Mebarkia et Dalila Zeghmiche

## DESCRIPTION DU PROJET

Ce projet implémente et compare deux algorithmes de génération aléatoire d'arbres binaires de taille n :
1.  Algorithme de Rémy (version optimisée en O(n)).
2.  Génération ABR (insertion aux feuilles en O(n)).

L'objectif est d'analyser les différences structurelles (hauteur, largeur, équilibre) entre la distribution uniforme (Rémy) et la distribution issue des arbres binaires de recherche (ABR).

## STRUCTURE DU PROJET

*   lib/ : Contient les implémentations des algorithmes.
    *   arbre_binaire.ml : Structure de données représentant un arbre binaire.
    *   remy_prototype.ml : Version naïve fonctionnelle.
    *   remy_optimal.ml : Version linéaire.
    *   abr.ml : Génération ABR linéaire.
*   test/ : Contient le programme d'expérimentation et les tests unitaires.
    *   experiment.ml : Lance les mesures et génère results.csv.
    *   test_abr.ml : Pour tester abr.ml.
    *   test_remy_opt.ml : Pour tester remy_optimal.ml.
    *   test_remy_prot.ml : Pour tester remy_prototype.ml.
*   bin/ : (Non utilisé pour les expérimentations).
*   resultats/ : Contient les graphiques générés par plot.py et results.csv.

## COMPILATION ET EXECUTION

# PREREQUIS
*   OCaml et Dune
*   Python 3 (avec matplotlib et pandas pour les graphiques)

# COMMANDES 
1. Compiler le projet
À la racine du dossier :
```bash
dune build

2. Lancer les expérimentations
dune exec test/experiment.exe 

3. Générer les courbes
python3 plot.py 
