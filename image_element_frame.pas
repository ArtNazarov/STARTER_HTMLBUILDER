unit image_element_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLDB, SQLite3Conn, LResources, Forms, Controls,
  ExtCtrls, StdCtrls, DBCtrls;

type

  { TfrmImage_Element }

  TfrmImage_Element = class(TFrame)
    btnSetImage: TButton;
    dsImage_Element: TDataSource;
    dbeImageCaption: TDBEdit;
    dbeImageId: TDBEdit;
    dbImage: TDBImage;
    dbNav_Images: TDBNavigator;
    lbImageCaption: TLabel;
    lbImageData: TLabel;
    lbImageId: TLabel;
    panImageActions: TPanel;
    panImageView: TPanel;
    conn: TSQLite3Connection;
    sqlImage_Element: TSQLQuery;
    trans: TSQLTransaction;
  private

  public
        DatabaseName : String;
        procedure setFileName(theFileName : String);

  end;

implementation

{ TfrmImage_Element }

procedure TfrmImage_Element.setFileName(theFileName: String);
begin
     DatabaseName := theFileName;
     conn.DatabaseName:=theFileName;
     sqlImage_Element.FileName:=theFileName;
end;

initialization
  {$I image_element_frame.lrs}

end.

