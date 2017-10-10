
let script_map_ref : (string UCoreLib.UMap.t) ref = ref (UCoreLib.UMap.empty ~eq:(=))


let set_from_file filename =
  let channel = open_in filename in
  let script_list = DataParser.main DataLexer.expr (Lexing.from_channel channel) in
  let script_map = script_list |> CharBasis.map_of_list (fun s -> s) in
  begin
    script_map_ref := script_map;
  end


let find_opt uch =
  match UCoreLib.UChar.of_int (Uchar.to_int uch) with
  | None            -> None
  | Some(uch_ucore) -> (!script_map_ref) |> UCoreLib.UMap.find_opt uch_ucore