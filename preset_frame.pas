{ Фрейм со списком страниц сайта в табличной форме }
unit preset_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids;

type

  { TfrmPreset }

  TfrmPreset = class(TFrame)
    dbgPreset: TDBGrid;
    dsPreset: TDataSource;
    dbNav_Preset: TDBNavigator;
    conn: TSQLite3Connection;
    sqlPreset: TSQLQuery;
    trans: TSQLTransaction;


  private

  public
    DatabaseName: string;

    procedure setFileName(theFilename: string);

  end;

implementation

{ TfrmPreset }




procedure TfrmPreset.setFileName(theFilename: string);
begin
  DatabaseName := theFilename;
  conn.DatabaseName:=theFilename;
  sqlPreset.FileName:=theFilename;
end;

initialization
  {$I preset_frame.lrs}

end.
