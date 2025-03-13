unit js_element_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, LResources, Forms, Controls,
  ExtCtrls, StdCtrls, DBCtrls,
  imdichildframe;

type

  { TfrmJs_Element }

  TfrmJs_Element = class(TFrame, IMDI_Child_Frame)
    btnEditorJs: TButton;
    dsJs_Element: TDataSource;
    dbeJsScriptId: TDBEdit;
    dbeScriptPath: TDBEdit;
    dbmJsScriptFile: TDBMemo;
    dbNav_JsScripts: TDBNavigator;
    lbJsScriptId: TLabel;
    lbJsScriptPath: TLabel;
    lbScriptFile: TLabel;
    panJsProps: TPanel;
    conn: TSQLite3Connection;
    sqlJs_Element: TSQLQuery;
    trans: TSQLTransaction;
  private

  public

        DatabaseName : String;
    procedure setFileName(theFileName : String);

  end;

implementation

{ TfrmJs_Element }

procedure TfrmJs_Element.setFileName(theFileName: String);
begin
       DatabaseName := theFileName;
     conn.DatabaseName:=theFileName;
     sqlJs_Element.FileName:=theFileName;
end;

initialization
  {$I js_element_frame.lrs}

end.

