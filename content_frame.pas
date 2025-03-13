{ Фрейм со списком страниц сайта в табличной форме }
unit content_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids, Menus, ActnList ;

type



  { TfrmContent }

  TfrmContent = class(TFrame)
    acOpenContentElement: TAction;
    aclContents: TActionList;
    DBGrid1: TDBGrid;
    dsContent: TDataSource;
    dbNav_Content: TDBNavigator;
    conn: TSQLite3Connection;
    mnuOpenContentElement: TMenuItem;
    pmContents: TPopupMenu;
    sqlContent: TSQLQuery;
    trans: TSQLTransaction;
    procedure acOpenContentElementExecute(Sender: TObject);

  private

  public
    DatabaseName : String;

    procedure setFileName(theFilename : String);

  end;

implementation

uses
  child_dialog;

{ TfrmContent }




procedure TfrmContent.acOpenContentElementExecute(Sender: TObject);
var
  itemId : String;
  parentForm : TFrameLoader;
begin
  itemId := sqlContent.FieldByName('id').AsString;
   if Assigned(Owner) and (Owner is TFrameLoader) then
  begin
    // parentForm := TFrameLoader(Owner); // Cast Owner to TfrmParent
    // parentForm.loadFrame('content_element', itemId); // Call the parent form's method
       parentForm :=  TFrameLoader.Create(Self.Parent);
       parentForm.loadFrame('content_element', itemId);
       parentForm.Show;
  end
end;

procedure TfrmContent.setFileName(theFilename: String);
begin
  DatabaseName := theFilename;
end;

initialization
  {$I content_frame.lrs}

end.

