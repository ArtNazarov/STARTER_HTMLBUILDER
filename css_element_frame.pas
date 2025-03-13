unit css_element_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, LResources, Forms, Controls,
  ExtCtrls, StdCtrls, DBCtrls;

type

  { TfrmCss_Element }

  TfrmCss_Element = class(TFrame)
    btnEditorCssOpen: TButton;
    dsCss_Element: TDataSource;
    dbeCssId: TDBEdit;
    dbeCssPath: TDBEdit;
    dbmCssStyle: TDBMemo;
    dbNav_Css: TDBNavigator;
    lbCssPath: TLabel;
    lbCssStyle: TLabel;
    lbCSS_id: TLabel;
    panCSSElements: TPanel;
    conn: TSQLite3Connection;
    sqlCss_Element: TSQLQuery;
    trans: TSQLTransaction;
  private

  public
          DatabaseName : String;
    procedure setFileName(theFileName : String);
  end;

implementation

{ TfrmCss_Element }

procedure TfrmCss_Element.setFileName(theFileName: String);
begin
       DatabaseName := theFileName;
     conn.DatabaseName:=theFileName;
     sqlCss_Element.FileName:=theFileName;
end;

initialization
  {$I css_element_frame.lrs}

end.

