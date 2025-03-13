unit attachment_element_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, LResources, Forms, Controls,
  ExtCtrls, StdCtrls, DBCtrls;

type

  { TfrmAttachment_Element }

  TfrmAttachment_Element = class(TFrame)
    btnGetAttachment: TButton;
    btnSetAttachment: TButton;
    dsAttachment_Element: TDataSource;
    dbeAttachmentCaption: TDBEdit;
    dbeAttachmentId: TDBEdit;
    dbNav_Attachments: TDBNavigator;
    lbAttachmentCaption: TLabel;
    lbAttachmentId: TLabel;
    lbIsFileUploaded: TLabel;
    panAttachmentForm: TPanel;
    panAttachmentsActions: TPanel;
    conn: TSQLite3Connection;
    sqlAttachment_Element: TSQLQuery;
    trans: TSQLTransaction;
  private

  public
    DatabaseName : String;
    procedure setFileName(theFileName : String);

  end;

implementation

{ TfrmAttachment_Element }

procedure TfrmAttachment_Element.setFileName(theFileName: String);
begin
     DatabaseName := theFileName;
     conn.DatabaseName:=theFileName;
     sqlAttachment_Element.FileName:=theFileName;
end;

initialization
  {$I attachment_element_frame.lrs}

end.

