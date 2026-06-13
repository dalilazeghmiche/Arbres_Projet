(*Q1.7 : algorithme linéaire ABR*)

open Arbre_binaire

(*Génération d’un arbre binaire de type ABR en O(n)*)
let generer_abr n =
  Random.self_init ();

  (*Nombre total de nœuds (internes + feuilles)*)
  let taille_max = 2 * n + 1 in

  (*Représentation mutable de l’arbre*)
  let gauche = Array.make taille_max (-1) in
  let droite = Array.make taille_max (-1) in

  (*Tableau des feuilles actives*)
  let feuilles = Array.make (n + 1) 0 in
  let nb_feuilles = ref 1 in
  feuilles.(0) <- 0;
  let prochain = ref 1 in

  (*Construction itérative*)
  for _ = 1 to n do
    (*Choix uniforme d’une feuille en O(1)*)
    let k = Random.int !nb_feuilles in
    let feuille = feuilles.(k) in

    (*Création des deux nouvelles feuilles*)
    let f_g = !prochain in
    let f_d = !prochain + 1 in
    prochain := !prochain + 2;

    (*Remplacement de la feuille par un nœud interne*)
    gauche.(feuille) <- f_g;
    droite.(feuille) <- f_d;

    (*Suppression de la feuille choisie (swap avec la dernière)*)
    feuilles.(k) <- feuilles.(!nb_feuilles - 1);
    nb_feuilles := !nb_feuilles - 1;

    (*Ajout des deux nouvelles feuilles*)
    feuilles.(!nb_feuilles) <- f_g;
    feuilles.(!nb_feuilles + 1) <- f_d;
    nb_feuilles := !nb_feuilles + 2
  done;

  (*Conversion finale en arbre fonctionnel*)
  let rec construire i =
    if gauche.(i) = -1 && droite.(i) = -1 then
      Feuille
    else
      Noeud (construire gauche.(i), construire droite.(i))
  in

  construire 0
