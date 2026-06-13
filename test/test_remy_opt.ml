open Ouv.Arbre_binaire

(*Fonctions de test auxiliaires*)

let rec est_binaire_plein = function
  | Feuille -> true
  | Noeud (g, d) -> est_binaire_plein g && est_binaire_plein d

let rec nombre_feuilles = function
  | Feuille -> 1
  | Noeud (g, d) -> nombre_feuilles g + nombre_feuilles d

let rec nombre_noeuds_internes = function
  | Feuille -> 0
  | Noeud (g, d) ->
      1 + nombre_noeuds_internes g + nombre_noeuds_internes d

(*Tests unitaires*)

let test_structure n =
  let a = generer_arbre n in
  let ok1 = est_binaire_plein a in
  let ok2 = (nombre_noeuds_internes a = n) in
  let ok3 = (nombre_feuilles a = n + 1) in

  Printf.printf "Test n=%d | plein=%b | noeuds=%b | feuilles=%b\n"
    n ok1 ok2 ok3;

  ok1 && ok2 && ok3

let run_tests () =
  Random.self_init ();
  let tests =
    [ test_structure 0;
      test_structure 1;
      test_structure 5;
      test_structure 10;
      test_structure 50;
      test_structure 100; 
      test_structure 1000; ]
  in
  if List.for_all (fun x -> x) tests then
    print_endline "\nTESTS OK!!! (question 1.4)"
  else
    print_endline "\nTESTS PAS OK!!! (question 1.4)"
    
let () = run_tests ()
