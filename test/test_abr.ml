open Ouv.Arbre_binaire
open Ouv.Abr

(*Test ABR*)

let test_abr n =
  let a = generer_abr n in
  let noeuds = (nombre_noeuds_internes a = n) in
  let feuilles = (nombre_feuilles a = n + 1) in

  Printf.printf
    "ABR n=%d | noeuds=%b | feuilles=%b\n"
    n noeuds feuilles;
  noeuds && feuilles

let () =
  Random.self_init ();

  let tests =
    [ test_abr 0;
      test_abr 1;
      test_abr 5;
      test_abr 10;
      test_abr 50 ]
  in
  if List.for_all (fun x -> x) tests then
    print_endline "\nTESTS OK!!"
  else
    print_endline "\nTESTS PAS OK!!"
