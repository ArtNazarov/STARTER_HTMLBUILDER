{ Фрейм со списком страниц сайта в табличной форме }
unit js_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids, ActnList, Menus;

type

  { TfrmJs }

  TfrmJs = class(TFrame)
    aclJs: TActionList;
    acOpenJs_Element: TAction;
    dbgJs: TDBGrid;
    dsJs: TDataSource;
    dbNav_Js: TDBNavigator;
    conn: TSQLite3Connection;
    mnuOpenJs_Element: TMenuItem;
    pmJs: TPopupMenu;
    sqlJs: TSQLQuery;
    trans: TSQLTransaction;
    procedure acOpenJs_ElementExecute(Sender: TObject);

  private

  public
    DatabaseName: string;

    procedure setFileName(theFilename: string);

  end;

implementation

uses child_dialog;

{ TfrmJs }



procedure TfrmJs.acOpenJs_ElementExecute(Sender: TObject);
var
  itemId : String;
  parentForm : TFrameLoader;
begin
  itemId := sqlJs.FieldByName('js_id').AsString;
   if Assigned(Owner) and (Owner is TFrameLoader) then
  begin
    // parentForm := TFrameLoader(Owner); // Cast Owner to TfrmParent
    // parentForm.loadFrame('content_element', itemId); // Call the parent form's method
       parentForm :=  TFrameLoader.Create(Self.Parent);
       parentForm.loadFrame('js_element', itemId);
       parentForm.Show;
  end
end;

procedure TfrmJs.setFileName(theFilename: string);
begin
  DatabaseName := theFilename;
  conn.DatabaseName := theFilename;
  sqlJs.FileName:= theFilename;
end;

initialization
  {$I js_frame.lrs}

end.
