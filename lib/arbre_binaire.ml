(*Q1.1 : structure de donnée d'un arbre binaire)

(*Arbre binaire plein :
   - une feuille
   - ou un noeud interne avec exactement deux enfants*)
type arbre_binaire =
  | Feuille
  | Noeud of arbre_binaire * arbre_binaire

(*Nombre de noeuds internes*)
let rec nombre_noeuds_internes = function
  | Feuille -> 0
  | Noeud (g, d) ->
      1 + nombre_noeuds_internes g + nombre_noeuds_internes d

(*Nombre de feuilles*)
let rec nombre_feuilles = function
  | Feuille -> 1
  | Noeud (g, d) ->
      nombre_feuilles g + nombre_feuilles d

(*Nombre total de noeuds (internes + feuilles)*)
let nombre_total_noeuds a =
  nombre_noeuds_internes a + nombre_feuilles a

(*Hauteur de l'arbre*)
let rec hauteur = function
  | Feuille -> 0
  | Noeud (g, d) ->
      1 + max (hauteur g) (hauteur d)

(*Largeur de l'arbre (nombre max de nœuds à une même profondeur)*)
let largeur arbre =
  let rec noeuds_par_niveau = function
    | Feuille -> [1]
    | Noeud (g, d) ->
        let lg = noeuds_par_niveau g in
        let ld = noeuds_par_niveau d in
        let rec fusion l1 l2 = match l1, l2 with
          | [], l | l, [] -> l
          | h1::t1, h2::t2 -> (h1 + h2) :: fusion t1 t2
        in
        1 :: fusion lg ld
  in
  List.fold_left max 0 (noeuds_par_niveau arbre)
