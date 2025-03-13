{ Фрейм со списком страниц сайта в табличной форме }
unit image_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids, ActnList, Menus;

type

  { TfrmImages }

  TfrmImages = class(TFrame)
    acOpenImage_Element: TAction;
    aclImages: TActionList;
    dbgImages: TDBGrid;
    dsImages: TDataSource;
    dbNav_Images: TDBNavigator;
    conn: TSQLite3Connection;
    mnuOpenImage_Element: TMenuItem;
    pmImages: TPopupMenu;
    sqlImages: TSQLQuery;
    trans: TSQLTransaction;
    procedure acOpenImage_ElementExecute(Sender: TObject);

  private

  public
    DatabaseName: string;

    procedure setFileName(theFilename: string);

  end;

implementation

uses child_dialog;

{ TfrmImages }



procedure TfrmImages.acOpenImage_ElementExecute(Sender: TObject);
var
  itemId : String;
  parentForm : TFrameLoader;
begin
  itemId := sqlImages.FieldByName('image_id').AsString;
   if Assigned(Owner) and (Owner is TFrameLoader) then
  begin
    // parentForm := TFrameLoader(Owner); // Cast Owner to TfrmParent
    // parentForm.loadFrame('content_element', itemId); // Call the parent form's method
       parentForm :=  TFrameLoader.Create(Self.Parent);
       parentForm.loadFrame('image_element', itemId);
       parentForm.Show;
  end
end;

procedure TfrmImages.setFileName(theFilename: string);
begin
  DatabaseName := theFilename;
  conn.DatabaseName:=theFileName;
  sqlImages.FileName:=theFileName;
end;

initialization
  {$I image_frame.lrs}

end.
