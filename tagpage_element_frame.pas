unit tagpage_element_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, ExtCtrls, DBCtrls, StdCtrls;

type

  { TFrame5 }

  TFrame5 = class(TFrame)
    dbeTagCaption: TDBEdit;
    dbeTagId: TDBEdit;
    dbNav_Tags: TDBNavigator;
    lbTagCaption: TLabel;
    lbTagId: TLabel;
    panTagsForm: TPanel;
  private

  public

  end;

implementation

initialization
  {$I tagpage_element_frame.lrs}

end.

