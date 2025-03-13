{ Фрейм со списком страниц сайта в табличной форме }
unit attachment_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids, Menus, ActnList;

type

  { TfrmAttachments }

  TfrmAttachments = class(TFrame)
    aclAttachment: TActionList;
    acOpenAttachmentElement: TAction;
    dbgAttachments: TDBGrid;
    dsAttachments: TDataSource;
    dbNav_Attachments: TDBNavigator;
    conn: TSQLite3Connection;
    mnuOpenAttachmentElement: TMenuItem;
    pmAttachments: TPopupMenu;
    sqlAttachments: TSQLQuery;
    trans: TSQLTransaction;
    procedure acOpenAttachmentElementExecute(Sender: TObject);

  private

  public
    DatabaseName : String;

    procedure setFileName(theFilename : String);

  end;

implementation

uses
  child_dialog;

{ TfrmAttachments }




procedure TfrmAttachments.acOpenAttachmentElementExecute(Sender: TObject);
var
  itemId : String;
  parentForm : TFrameLoader;
begin
  itemId := sqlAttachments.FieldByName('attachment_id').AsString;
   if Assigned(Owner) and (Owner is TFrameLoader) then
  begin
    // parentForm := TFrameLoader(Owner); // Cast Owner to TfrmParent
    // parentForm.loadFrame('content_element', itemId); // Call the parent form's method
       parentForm :=  TFrameLoader.Create(Self.Parent);
       parentForm.loadFrame('attachment_element', itemId);
       parentForm.Show;
  end
end;

procedure TfrmAttachments.setFileName(theFilename: String);
begin
  DatabaseName := theFilename;
  conn.DatabaseName:=theFileName;
  sqlAttachments.FileName:=theFileName;
end;

initialization
  {$I attachment_frame.lrs}

end.

