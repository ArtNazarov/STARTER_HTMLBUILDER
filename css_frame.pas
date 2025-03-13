unit css_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLDB, SQLite3Conn, LResources, Forms, Controls,
  DBCtrls, DBGrids, ActnList, Menus;

type

  { TfrmCss_Styles }

  TfrmCss_Styles = class(TFrame)
    aclCss_Styles: TActionList;
    acOpenCss_Style: TAction;
    dsCss_Styles: TDataSource;
    dbgCss_Styles: TDBGrid;
    dbNav_Css_Styles: TDBNavigator;
    conn: TSQLite3Connection;
    mnuOpenCss_Style: TMenuItem;
    pmCss_Styles: TPopupMenu;
    sqlCss_Styles: TSQLQuery;
    trans: TSQLTransaction;
    procedure acOpenCss_StyleExecute(Sender: TObject);
  private

  public
        DatabaseName: string;

    procedure setFileName(theFilename: string);

  end;

implementation

uses child_dialog;

{ TfrmCss_Styles }

procedure TfrmCss_Styles.acOpenCss_StyleExecute(Sender: TObject);
var
  itemId : String;
  parentForm : TFrameLoader;
begin
  itemId := sqlCss_Styles.FieldByName('css_id').AsString;
   if Assigned(Owner) and (Owner is TFrameLoader) then
  begin
    // parentForm := TFrameLoader(Owner); // Cast Owner to TfrmParent
    // parentForm.loadFrame('content_element', itemId); // Call the parent form's method
       parentForm :=  TFrameLoader.Create(Self.Parent);
       parentForm.loadFrame('css_element', itemId);
       parentForm.Show;
  end
end;

procedure TfrmCss_Styles.setFileName(theFilename: string);
begin
       DatabaseName := theFileName;
     conn.DatabaseName:=theFileName;
     sqlCss_Styles.FileName:=theFileName;
end;

initialization
  {$I css_frame.lrs}

end.

