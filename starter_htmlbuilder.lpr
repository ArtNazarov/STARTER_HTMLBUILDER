program starter_htmlbuilder;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, htmlbuilder_main_form, child_dialog, css_frame,
  menuitem_frame, menu_frame, preset_frame, block_frame, content_element_frame,
  section_element_frame, tag_element_frame, tagpage_element_frame,
  block_element_frame,
css_element_frame, js_element_frame, 
image_element_frame, 
attachment_element_frame, imdichildframe, menu_element_frame
    { you can add units after this };

  {$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TStarterHtmlBuilder, StarterHtmlBuilder);
  Application.Run;
end.
