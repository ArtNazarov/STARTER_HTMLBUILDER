unit tag_element_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLDB, SQLite3Conn, LResources, Forms, Controls,
  ExtCtrls, DBCtrls, StdCtrls, imdichildframe;

type

  { TfrmTag_Element }

  TfrmTag_Element = class(TFrame, IMDI_Child_Frame)
    dsTag_Element: TDataSource;
    dbeTagCaption: TDBEdit;
    dbeTagId: TDBEdit;
    dbNav_Tags: TDBNavigator;
    lbTagCaption: TLabel;
    lbTagId: TLabel;
    panTagsForm: TPanel;
    conn: TSQLite3Connection;
    sqlTag_Element: TSQLQuery;
    trans: TSQLTransaction;
  private

  public
        DatabaseName: string;

    procedure setFileName(theFilename: string);
  end;

implementation

{ TfrmTag_Element }

procedure TfrmTag_Element.setFileName(theFilename: string);
begin
    DatabaseName := theFilename;
  conn.DatabaseName := theFilename;
  sqlTag_Element.FileName:= theFilename;
end;

initialization
  {$I tag_element_frame.lrs}

end.

