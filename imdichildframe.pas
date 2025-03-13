unit imdichildframe;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils;

type
  IMDI_Child_Frame = interface
    // must contains procedure setFileName
    procedure setFileName(theFileName : String);
    end;

implementation

end.

