{ Фрейм со списком страниц сайта в табличной форме }
unit menu_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids;

type

  { TfrmMenu }

  TfrmMenu = class(TFrame)
    dbgMenu: TDBGrid;
    dsMenu: TDataSource;
    dbNav_Menu: TDBNavigator;
    conn: TSQLite3Connection;
    sqlMenu: TSQLQuery;
    trans: TSQLTransaction;

  private

  public
    DatabaseName : String;

    procedure setFileName(theFilename : String);

  end;

implementation

{ TfrmMenu }





procedure TfrmMenu.setFileName(theFilename: String);
begin
  DatabaseName := theFilename;
  conn.DatabaseName:=theFilename;
  sqlMenu.FileName:=theFilename;
end;

initialization
  {$I menu_frame.lrs}

end.

