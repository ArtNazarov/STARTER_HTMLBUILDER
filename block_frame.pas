unit block_frame;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, DB, SQLite3Conn, SQLDB, LResources, Forms, Controls,
  DBCtrls, DBGrids, ActnList, Menus;

type

  { TfrmBlocks }

  TfrmBlocks = class(TFrame)
    acOpenBlock_Element: TAction;
    aclBlocks: TActionList;
    conn: TSQLite3Connection;
    dbgBlocks: TDBGrid;
    dbNav_Blocks: TDBNavigator;
    dsBlocks: TDataSource;
    mnuOpenBlock_Element: TMenuItem;
    ppBlocks: TPopupMenu;
    sqlBlocks: TSQLQuery;
    trans: TSQLTransaction;
    procedure acOpenBlock_ElementExecute(Sender: TObject);
  private

  public

  end;

implementation

uses
  child_dialog;


{ TfrmBlocks }

procedure TfrmBlocks.acOpenBlock_ElementExecute(Sender: TObject);
var
  itemId : String;
  parentForm : TFrameLoader;
begin
  itemId := sqlBlocks.FieldByName('id').AsString;
   if Assigned(Owner) and (Owner is TFrameLoader) then
  begin
    // parentForm := TFrameLoader(Owner); // Cast Owner to TfrmParent
    // parentForm.loadFrame('content_element', itemId); // Call the parent form's method
       parentForm :=  TFrameLoader.Create(Self.Parent);
       parentForm.loadFrame('block_element', itemId);
       parentForm.Show;
  end
end;

initialization
  {$I block_frame.lrs}

end.

