{ Фрейм со списком страниц сайта в табличной форме }
unit tag_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids;

type

  { TfrmTags }

  TfrmTags = class(TFrame)
    dbgTags: TDBGrid;
    dsTags: TDataSource;
    dbNav_Tags: TDBNavigator;
    conn: TSQLite3Connection;
    sqlTags: TSQLQuery;
    trans: TSQLTransaction;

  private

  public
    DatabaseName : String;

    procedure setFileName(theFilename : String);

  end;

implementation

{ TfrmTags }





procedure TfrmTags.setFileName(theFilename: String);
begin
  DatabaseName := theFilename;
  conn.DatabaseName:= theFilename;
  sqlTags.FileName:= theFilename;
end;

initialization
  {$I tag_frame.lrs}

end.

