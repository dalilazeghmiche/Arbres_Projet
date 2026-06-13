(*Q1.4 : algorithme de Rémy optimal*)

open Arbre_binaire

type cellule = {
  mutable gauche : int;
  mutable droite : int;
  mutable parent : int;
  mutable est_gauche : bool;
}

let creer_vide () = {
  gauche = -1;
  droite = -1;
  parent = -1;
  est_gauche = false;
}

let tableau_vers_arbre tab racine =
  let rec construire i =
    if i = -1 then Feuille
    else
      let c = tab.(i) in
      if c.gauche = -1 && c.droite = -1 then Feuille
      else Noeud (construire c.gauche, construire c.droite)
  in
  construire racine

let generer_arbre n =
  Random.self_init ();

  if n = 0 then Feuille
  else begin
    let taille_max = 2 * n + 1 in
    let tab = Array.init taille_max (fun _ -> creer_vide ()) in

    let noeuds = Array.make taille_max 0 in
    noeuds.(0) <- 0;
    let nb_noeuds = ref 1 in
    let prochain_indice = ref 1 in
    let racine = ref 0 in

    for _ = 1 to n do
      let idx = Random.int !nb_noeuds in
      let cible = noeuds.(idx) in

      let nouveau_interne = !prochain_indice in
      let nouvelle_feuille = !prochain_indice + 1 in
      prochain_indice := !prochain_indice + 2;

      let parent_cible = tab.(cible).parent in
      let etait_gauche = tab.(cible).est_gauche in

      tab.(nouveau_interne).parent <- parent_cible;
      tab.(nouveau_interne).est_gauche <- etait_gauche;

      if parent_cible <> -1 then
        if etait_gauche then tab.(parent_cible).gauche <- nouveau_interne
        else tab.(parent_cible).droite <- nouveau_interne
      else
        racine := nouveau_interne;

      if Random.bool () then begin
        tab.(nouveau_interne).gauche <- cible;
        tab.(nouveau_interne).droite <- nouvelle_feuille;
        tab.(cible).est_gauche <- true;
        tab.(nouvelle_feuille).est_gauche <- false;
      end else begin
        tab.(nouveau_interne).gauche <- nouvelle_feuille;
        tab.(nouveau_interne).droite <- cible;
        tab.(nouvelle_feuille).est_gauche <- true;
        tab.(cible).est_gauche <- false;
      end;

      tab.(cible).parent <- nouveau_interne;
      tab.(nouvelle_feuille).parent <- nouveau_interne;

      noeuds.(idx) <- nouveau_interne;
      noeuds.(!nb_noeuds) <- nouvelle_feuille;
      incr nb_noeuds
    done;

    tableau_vers_arbre tab !racine
  end
  