unit block_element_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLDB, SQLite3Conn, LResources, Forms, Controls,
  StdCtrls, DBCtrls;

type

  { TfrmBlock_Element }

  TfrmBlock_Element = class(TFrame)
    dbmBlock_Element_Markup: TDBMemo;
    dsBlock_Element: TDataSource;
    dbeBlock_Element_Id: TDBEdit;
    dbmBlock_Element_Remark: TDBMemo;
    dbNav_Block_Element: TDBNavigator;
    lbBlock_Element_Id: TLabel;
    lbBlock_Element_Markup: TLabel;
    lbBlock_Element_Memo: TLabel;
    conn: TSQLite3Connection;
    sqlBlock_Element: TSQLQuery;
    trans: TSQLTransaction;
  private

  public
    DatabaseName : String;
    procedure setFileName(theFileName : String);

  end;

implementation

{ TfrmBlock_Element }

procedure TfrmBlock_Element.setFileName(theFileName: String);
begin
     DatabaseName := theFileName;
     conn.DatabaseName:=theFileName;
     sqlBlock_Element.FileName:=theFileName;
end;

initialization
  {$I block_element_frame.lrs}

end.

