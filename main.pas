{$mode Delphi}
program LireJSON;

uses
  SysUtils, Classes, fpjson, jsonparser;

var
  Fichier: TFileStream;
  Parser: TJSONParser;
  Donnees: TJSONData;
  Objet: TJSONObject;
begin
  try
    // Ouvre le fichier JSON
    Fichier := TFileStream.Create('data.json', fmOpenRead or fmShareDenyWrite);
    try
      // Crée le parser
      Parser := TJSONParser.Create(Fichier);
      try
        // Parse le contenu
        Donnees := Parser.Parse;
        try
          if Donnees.JSONType = jtObject then
          begin
            Objet := TJSONObject(Donnees);
            Writeln('Nom : ', Objet.Get('nom', 'inconnu'));
            Writeln('Âge : ', Objet.Get('age', 0));
            Writeln('Actif ? ', BoolToStr(Objet.Booleans['actif'], True));
          end;
        finally
          Donnees.Free;
        end;
      finally
        Parser.Free;
      end;
    finally
      Fichier.Free;
    end;
  except
    on E: Exception do
      Writeln('Erreur : ', E.Message);
  end;
end.