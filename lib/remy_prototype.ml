(*Q1.2 : prototype algorithme de Rémy*)

open Arbre_binaire

(*Acces et remplacement par position*)

(*Récupère le sous-arbre correspondant a une position donnée*)
let rec sous_arbre_a_position arbre position =
  match arbre with
  | Feuille ->
      if position = 0 then Feuille
      else failwith "Position invalide"
  | Noeud (g, d) ->
      let total_gauche = nombre_total_noeuds g in
      if position < total_gauche then
        sous_arbre_a_position g position
      else if position = total_gauche then
        arbre
      else
        sous_arbre_a_position d (position - total_gauche - 1)

(*Remplace le sous-arbre a une position donnée*)
let rec remplacer_a_position arbre position nouveau =
  match arbre with
  | Feuille ->
      if position = 0 then nouveau
      else failwith "Position invalide"
  | Noeud (g, d) ->
      let total_gauche = nombre_total_noeuds g in
      if position < total_gauche then
        Noeud (remplacer_a_position g position nouveau, d)
      else if position = total_gauche then
        nouveau
      else
        Noeud (g, remplacer_a_position d (position - total_gauche - 1) nouveau)


(*Une étape de l'algorithme de Rémy*)
let etape_remy arbre =
  let total = nombre_total_noeuds arbre in
  let position = Random.int total in

  (* Sous-arbre choisi uniformément *)
  let sous_arbre = sous_arbre_a_position arbre position in

  (* Création du nouveau nœud interne *)
  let nouveau_noeud =
    if Random.bool () then
      Noeud (sous_arbre, Feuille)
    else
      Noeud (Feuille, sous_arbre)
  in

  remplacer_a_position arbre position nouveau_noeud

(*Génération d'un arbre de taille n*)
let generer_arbre n =
  Random.self_init ();
  let rec construire k arbre =
    if k = n then arbre
    else construire (k + 1) (etape_remy arbre)
  in
  construire 0 Feuille



  (*=================== complexité ===============*)
  (*-------------------Hypothese --------------*)
  (*
  n : nmbre de noeud interne 
  n+1: nmbre de feuille 
  2n+1 : nmbre totale de noeuds 


  une etape de remy : 

    nbr_totale_noeuds : parcours tous larbre -> O(taille) -> O(n)
  sous_arbre_a_position -> O(n)
  remplacer_a_position -> O(n)

  totale : O(n)

  generation :
   n fois etape de remy -> O(n²)
  *)