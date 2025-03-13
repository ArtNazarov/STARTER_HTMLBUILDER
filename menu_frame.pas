{ Фрейм со списком страниц сайта в табличной форме }
unit menu_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids, ActnList, Menus;

type

  { TfrmMenu }

  TfrmMenu = class(TFrame)
    aclMenu: TActionList;
    acMenuItem_Element: TAction;
    dbgMenu: TDBGrid;
    dsMenu: TDataSource;
    dbNav_Menu: TDBNavigator;
    conn: TSQLite3Connection;
    mnuOpenMenuItem_Element: TMenuItem;
    pmMenu: TPopupMenu;
    sqlMenu: TSQLQuery;
    trans: TSQLTransaction;
    procedure acMenuItem_ElementExecute(Sender: TObject);

  private

  public
    DatabaseName : String;

    procedure setFileName(theFilename : String);

  end;

implementation

uses child_dialog;

{ TfrmMenu }




procedure TfrmMenu.acMenuItem_ElementExecute(Sender: TObject);

  var
    itemId : String;
    parentForm : TFrameLoader;
  begin
    itemId := sqlMenu.FieldByName('menu_id').AsString;
     if Assigned(Owner) and (Owner is TFrameLoader) then
    begin
      // parentForm := TFrameLoader(Owner); // Cast Owner to TfrmParent
      // parentForm.loadFrame('content_element', itemId); // Call the parent form's method
         parentForm :=  TFrameLoader.Create(Self.Parent);
         parentForm.loadFrame('menu_element', itemId);
         parentForm.Show;
    end
  end;

procedure TfrmMenu.setFileName(theFilename: String);
begin
  DatabaseName := theFilename;
  conn.DatabaseName:=theFilename;
  sqlMenu.FileName:=theFilename;
end;

initialization
  {$I menu_frame.lrs}

end.

