open Ouv.Arbre_binaire
open Ouv.Remy_optimal
open Ouv.Abr
open Unix

(*Mesures sur les arbres*)
let taille_gauche = function
  | Feuille -> 0
  | Noeud (g, _) -> nombre_noeuds_internes g

let profondeur_moyenne_feuilles arbre =
  let rec aux profondeur = function
    | Feuille -> (profondeur, 1)
    | Noeud (g, d) ->
        let (s1, c1) = aux (profondeur + 1) g in
        let (s2, c2) = aux (profondeur + 1) d in
        (s1 + s2, c1 + c2)
  in
  let (somme, nb) = aux 0 arbre in
  float_of_int somme /. float_of_int nb

(*Validation expérimentale de la complexité linéaire*)
let _mesurer_temps_construction gen n =
  let t0 = gettimeofday () in
  let _ = gen n in
  let t1 = gettimeofday () in
  (t1 -. t0) *. 1000.0

(*Chronométrage*)
let time f =
  let t0 = gettimeofday () in
  let x = f () in
  let t1 = gettimeofday () in
  (x, (t1 -. t0) *. 1000.0)  (* ms *)

(*Expérimentations*)
let tailles = [50; 100; 200; 500; 1000; 2000; 5000]
let repetitions = 50

let () =
  Random.self_init ();

  let oc = open_out "results.csv" in
  output_string oc
    "algo,n,rep,hauteur,largeur,prof_feuilles,taille_gauche,time_ms\n";

  let run algo_name gen n rep =
    let (a, t) = time (fun () -> gen n) in
    Printf.fprintf oc
      "%s,%d,%d,%d,%d,%.4f,%d,%.4f\n"
      algo_name
      n
      rep
      (hauteur a)
      (largeur a)
      (profondeur_moyenne_feuilles a)
      (taille_gauche a)
      t
  in

  List.iter (fun n ->
    for r = 1 to repetitions do
      run "Remy" generer_arbre n r;
      run "ABR" generer_abr n r
    done
  ) tailles;

  close_out oc;

