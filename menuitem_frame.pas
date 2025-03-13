unit menuitem_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  DBCtrls, DBGrids, imdichildframe;

type

  { TfrmMenu_Item }

  TfrmMenu_Item = class(TFrame, IMDI_Child_Frame)
    conn: TSQLite3Connection;
    dbgMenuItem: TDBGrid;
    dbNav_MenuItem: TDBNavigator;
    dsMenuItem: TDataSource;
    sqlMenuItem: TSQLQuery;
    trans: TSQLTransaction;
  private

  public
    DatabaseName : String;
    procedure setFileName(theFileName : String);

  end;

implementation

{ TfrmMenu_Item }

procedure TfrmMenu_Item.setFileName(theFileName: String);
begin
  DatabaseName := theFileName;
  conn.DatabaseName:=theFileName;
  sqlMenuItem.FileName:=theFileName;
end;

initialization
  {$I menuitem_frame.lrs}

end.

