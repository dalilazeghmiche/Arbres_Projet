(*Q1.6 : affichage des arbres générés*)

open Arbre_binaire

(* Génère un fichier DOT Graphviz stylisé pour un arbre binaire plein *)
let ecrire_dot_stylise (nom_fichier : string) (a : arbre_binaire) =
  let oc = open_out nom_fichier in

  (* En-tête Graphviz *)
  output_string oc
    "digraph BinaryTree {\n\
     rankdir=TB;\n\
     node [shape=circle, style=filled, fillcolor=\"#667eea\", \
           fontcolor=white, fontsize=14, width=0.6];\n\
     leaf [shape=point, width=0.15, fillcolor=black];\n\n";

  (* Générateur d’identifiants uniques *)
  let compteur = ref 0 in
  let nouveau_id () =
    let id = !compteur in
    incr compteur;
    id
  in

  (* aux retourne (id, est_interne) *)
  let rec aux = function
    | Feuille ->
        let id = nouveau_id () in
        Printf.fprintf oc
          "  leaf%d [label=\"\"];\n"
          id;
        (id, false)

    | Noeud (g, d) ->
        let id = nouveau_id () in
        Printf.fprintf oc
          "  node%d [label=\"%d\"];\n"
          id id;

        let (idg, g_interne) = aux g in
        let (idd, d_interne) = aux d in

        Printf.fprintf oc
          "  node%d -> %s%d [label=\"G\", fontsize=10];\n"
          id (if g_interne then "node" else "leaf") idg;

        Printf.fprintf oc
          "  node%d -> %s%d [label=\"D\", fontsize=10];\n\n"
          id (if d_interne then "node" else "leaf") idd;

        (id, true)
  in

  ignore (aux a);
  output_string oc "\n}\n";
  close_out oc
