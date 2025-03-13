{ Фрейм со списком страниц сайта в табличной форме }
unit tagpages_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids;

type

  { TfrmTagsPages }

  TfrmTagsPages = class(TFrame)
    dbgTagsPages: TDBGrid;
    dsTagsPages: TDataSource;
    dbNav_TagsPages: TDBNavigator;
    conn: TSQLite3Connection;
    sqlTagsPages: TSQLQuery;
    trans: TSQLTransaction;

  private

  public
    DatabaseName : String;

    procedure setFileName(theFilename : String);

  end;

implementation

{ TfrmTagsPages }





procedure TfrmTagsPages.setFileName(theFilename: String);
begin
  DatabaseName := theFilename;
  conn.DatabaseName:=theFileName;
  sqlTagsPages.FileName:=theFilename;
end;

initialization
  {$I tagpages_frame.lrs}

end.

