{ Фрейм со списком страниц сайта в табличной форме }
unit section_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  StdCtrls, DBCtrls, DBGrids;

type

  { TfrmSection }

  TfrmSection = class(TFrame)
    dbgSection: TDBGrid;
    dsSection: TDataSource;
    dbNav_Section: TDBNavigator;
    conn: TSQLite3Connection;
    sqlSection: TSQLQuery;
    trans: TSQLTransaction;

  private

  public
    DatabaseName: string;

    procedure setFileName(theFilename: string);

  end;

implementation

{ TfrmSection }




procedure TfrmSection.setFileName(theFilename: string);
begin
  DatabaseName := theFilename;
end;

initialization
  {$I section_frame.lrs}

end.
