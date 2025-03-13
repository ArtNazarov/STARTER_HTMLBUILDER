unit menu_element_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, DBCtrls, StdCtrls,
  imdichildframe, DB, SQLite3Conn, SQLDB;

type

  { TfrmMenu_Element }

  TfrmMenu_Element = class(TFrame, IMDI_Child_Frame)
    dbeMenu_id: TDBEdit;
    dbeMenu_caption: TDBEdit;
    dbmMenu_wrap_tpl: TDBMemo;
    dbmMenu_item_tpl: TDBMemo;
    dbNav_Menu_Element: TDBNavigator;
    dsMenu_Element: TDataSource;
    conn: TSQLite3Connection;
    lbMenuId: TLabel;
    lbMenuCaption: TLabel;
    lbMenuWrapTpl: TLabel;
    lbMenuItemTpl: TLabel;
    sqlMenu_Element: TSQLQuery;
    trans: TSQLTransaction;
  private

  public
              DatabaseName: string;

    procedure setFileName(theFilename: string);
  end;

implementation

{ TfrmMenu_Element }

procedure TfrmMenu_Element.setFileName(theFilename: string);
begin
    DatabaseName := theFilename;
  conn.DatabaseName:=theFilename;
  sqlMenu_Element.FileName:=theFilename;
end;

initialization
  {$I menu_element_frame.lrs}

end.

