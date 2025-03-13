{ Фрейм со списком страниц сайта в табличной форме }
unit tag_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids, Menus, ActnList;

type

  { TfrmTags }

  TfrmTags = class(TFrame)
    aclTags: TActionList;
    acOpenTag_Element: TAction;
    dbgTags: TDBGrid;
    dsTags: TDataSource;
    dbNav_Tags: TDBNavigator;
    conn: TSQLite3Connection;
    mnuOpenTag_Element: TMenuItem;
    pmTags: TPopupMenu;
    sqlTags: TSQLQuery;
    trans: TSQLTransaction;
    procedure acOpenTag_ElementExecute(Sender: TObject);

  private

  public
    DatabaseName : String;

    procedure setFileName(theFilename : String);

  end;

implementation

uses child_dialog;

{ TfrmTags }




procedure TfrmTags.acOpenTag_ElementExecute(Sender: TObject);
var
  itemId : String;
  parentForm : TFrameLoader;
begin
  itemId := sqlTags.FieldByName('tag_id').AsString;
   if Assigned(Owner) and (Owner is TFrameLoader) then
  begin
    // parentForm := TFrameLoader(Owner); // Cast Owner to TfrmParent
    // parentForm.loadFrame('content_element', itemId); // Call the parent form's method
       parentForm :=  TFrameLoader.Create(Self.Parent);
       parentForm.loadFrame('tag_element', itemId);
       parentForm.Show;
  end
end;

procedure TfrmTags.setFileName(theFilename: String);
begin
  DatabaseName := theFilename;
  conn.DatabaseName:= theFilename;
  sqlTags.FileName:= theFilename;
end;

initialization
  {$I tag_frame.lrs}

end.

