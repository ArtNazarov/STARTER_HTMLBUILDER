unit content_element_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, LResources, Forms, Controls,
  ExtCtrls, StdCtrls, DBCtrls, ComCtrls, DBDateTimePicker, IpHtml;

type

  { TfrmContent_Element }

  TfrmContent_Element = class(TFrame)
    btnAttachTagToMaterial: TButton;
    btnEditorContent: TButton;
    btnLoadFromWysiwyg: TButton;
    btnOpenWithWysiwyg: TButton;
    btnRemoveAssocTag: TButton;
    btnRemoveOneTag: TButton;
    dsContent_Element: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    dbePageField1: TDBEdit;
    dbePageField2: TDBEdit;
    dbePageField3: TDBEdit;
    dbePageField4: TDBEdit;
    dbePageField5: TDBEdit;
    dbePageField6: TDBEdit;
    dbePageField7: TDBMemo;
    dbSelectorTag: TDBLookupComboBox;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    fCaption: TDBEdit;
    fContent: TDBMemo;
    fID: TDBEdit;
    IpHtmlPanel1: TIpHtmlPanel;
    Label1: TLabel;
    Label4: TLabel;
    lbAttachTagToPage: TLabel;
    lbCategory: TLabel;
    lbDt: TLabel;
    lbTagsOnPageTab: TLabel;
    listTags: TListBox;
    PageControl3: TPageControl;
    PageControl4: TPageControl;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel29: TPanel;
    Panel6: TPanel;
    panPageMainProps: TPanel;
    panPagePropsContainer: TPanel;
    selSection: TDBLookupComboBox;
    conn: TSQLite3Connection;
    sqlContent_Element: TSQLQuery;
    trans: TSQLTransaction;
    tabEditorProps: TTabSheet;
    tabMainProps: TTabSheet;
    tabPreviewContent: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
  private

  public
    DatabaseName : String;
    procedure setFileName(theFileName : String);

  end;

implementation

{ TfrmContent_Element }

procedure TfrmContent_Element.setFileName(theFileName: String);
begin
  DatabaseName := theFileName;
  conn.DatabaseName:=theFileName;
  sqlContent_Element.FileName:=theFileName;
end;

initialization
  {$I content_element_frame.lrs}

end.

