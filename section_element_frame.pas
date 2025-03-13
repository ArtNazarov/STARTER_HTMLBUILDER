unit section_element_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, ExtCtrls, StdCtrls, DBCtrls;

type

  { TFrame3 }

  TFrame3 = class(TFrame)
    btnEditorForSectionFullText: TButton;
    btnEditorForSectionNote: TButton;
    btnRefreshTree: TButton;
    choicePreset: TDBLookupComboBox;
    dbeSectionCaption: TDBEdit;
    dbeSectionId: TDBEdit;
    dbeTree: TDBEdit;
    dbmSectionFullText: TDBMemo;
    dbmSectionNote: TDBMemo;
    dbNav_Sections: TDBNavigator;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    lbSpecification: TLabel;
    lbTree: TLabel;
    Panel19: TPanel;
  private

  public

  end;

implementation

initialization
  {$I section_element_frame.lrs}

end.

