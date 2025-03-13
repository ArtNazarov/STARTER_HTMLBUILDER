{ Дочерняя подчиненная MDI форма, в которую грузится фрейм }
unit child_dialog;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls,
  Graphics, Dialogs, css_frame,
  block_frame, section_frame, preset_frame,
  tag_frame,  tagpages_frame,
  js_frame, image_frame,  menu_frame, menuitem_frame,
  content_element_frame, attachment_frame,
  css_element_frame, image_element_frame,
  js_element_frame,  tag_element_frame,
  SQLite3Conn, SQLDB, db_helpers ;

type




  { TFrameLoader }

  TFrameLoader = class(TForm)


    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);


  private


  public
    DatabaseName: string;




    procedure loadFrame(strTypeOfFrame: string; id_of_element : string);

  end;

var
  FrameLoader: TFrameLoader;

implementation

uses content_frame, attachment_element_frame, block_element_frame;

{ TFrameLoader }


procedure TFrameLoader.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   CloseAction := TCloseAction.caMinimize;
end;

procedure TFrameLoader.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

end;





procedure TFrameLoader.loadFrame(strTypeOfFrame: string; id_of_element: string);
var
  frmContent: TfrmContent; // фрейм с таблицей страниц
  frmCss: TfrmCss_Styles; // фрейм с таблицей CSS
  frmBlock: TfrmBlocks; // фрейм со списком блоков
  frmSection: TfrmSection; // фрейм со списком разделов
  frmPreset: TfrmPreset; // фрейм со списком пресетов
  frmTags: TfrmTags; // фрейм со списком тегов
  frmTagsPages: TfrmTagsPages; // фрейм со списком тег-страница
  frmAttachments: TfrmAttachments; // фрейм с вложениями
  frmJs : TfrmJs; // фрейм со скриптами
  frmImages : TfrmImages; // фрейм с изображениями
  frmMenu : TfrmMenu; // фрейм с меню
  frmContent_Element  : TfrmContent_Element; // фрейм со страницей
  frmMenuItem : TfrmMenu_Item; // фрейм с пунктами меню
  frmAttachment_Element : TfrmAttachment_Element; // фрейм с вложенным документом
  frmBlock_Element : TfrmBlock_Element; // фрейм с одним блоком
  frmCss_Element : TfrmCss_Element; // фрейм с одним стилем
  frmImage_Element : TfrmImage_Element; // фрейм с одним изображением
  frmJs_Element : TfrmJs_Element; // фрейм с одним скриптом
  frmTag_Element : TfrmTag_Element; // фрейм с одним тегом


begin
  if strTypeOfFrame = 'content' then
  begin
    frmContent := TfrmContent.Create(Self);
    frmContent.Parent := Self;
    frmContent.Align := alClient;
    frmContent.conn.DatabaseName := DatabaseName;

    open_sql('select * from content', frmContent.sqlContent);
    ShowMessage(IntToStr(frmContent.dsContent.DataSet.RecordCount));
    frmContent.sqlContent.Active := True;
    frmContent.dsContent.AutoEdit := True;
  end;

  { 2 Окно со списком стилей }
  if strTypeOfFrame = 'css' then
  begin
    frmCss := TfrmCss_Styles.Create(Self);
    frmCss.Parent := Self;
    frmCss.Align := alClient;
    frmCss.conn.DatabaseName := DatabaseName;

    open_sql('select * from css', frmCss.sqlCss_Styles);
    ShowMessage(IntToStr(frmCss.dsCss_Styles.DataSet.RecordCount));
    frmCss.sqlCss_Styles.Active := True;
    frmCss.dsCss_Styles.AutoEdit := True;

  end;

  { 3 Окно со списком блоков }
  if strTypeOfFrame = 'block' then
  begin
    frmBlock := TfrmBlocks.Create(Self);
    frmBlock.Parent := Self;
    frmBlock.Align := alClient;
    frmBlock.conn.DatabaseName := DatabaseName;

    open_sql('select * from block', frmBlock.sqlBlocks);
    ShowMessage(IntToStr(frmBlock.dsBlocks.DataSet.RecordCount));
    frmBlock.sqlBlocks.Active := True;
    frmBlock.dsBlocks.AutoEdit := True;

  end;


  { 4 Окно со списком секций }
  if strTypeOfFrame = 'section' then
  begin
    frmSection := TfrmSection.Create(Self);
    frmSection.Parent := Self;
    frmSection.Align := alClient;
    frmSection.conn.DatabaseName := DatabaseName;

    open_sql('select * from section', frmSection.sqlSection);
    ShowMessage(IntToStr(frmSection.dsSection.DataSet.RecordCount));
    frmSection.sqlSection.Active := True;
    frmSection.dsSection.AutoEdit := True;

  end;


    { 5 Окно со списком пресетов }
  if strTypeOfFrame = 'preset' then
  begin
    frmPreset := TfrmPreset.Create(Self);
    frmPreset.Parent := Self;
    frmPreset.Align := alClient;
    frmPreset.conn.DatabaseName := DatabaseName;
    frmPreset.setFileName(DatabaseName);
    open_sql('select * from section', frmPreset.sqlPreset);
    ShowMessage(IntToStr(frmPreset.dsPreset.DataSet.RecordCount));
    frmPreset.sqlPreset.Active := True;
    frmPreset.dsPreset.AutoEdit := True;

  end;

     { 6 Окно со списком тегов }
  if strTypeOfFrame = 'tag' then
  begin
    frmTags:= TfrmTags.Create(Self);
    frmTags.Parent := Self;
    frmTags.Align := alClient;
    frmTags.conn.DatabaseName := DatabaseName;
    frmTags.setFileName(DatabaseName);
    open_sql('select * from tags', frmTags.sqlTags);
    ShowMessage(IntToStr(frmTags.dsTags.DataSet.RecordCount));
    frmTags.sqlTags.Active := True;
    frmTags.dsTags.AutoEdit := True;

  end;

       { 7 Окно со списком тег-cтраница }
  if strTypeOfFrame = 'tags_pages' then
  begin
    frmTagsPages:= TfrmTagsPages.Create(Self);
    frmTagsPages.Parent := Self;
    frmTagsPages.Align := alClient;
    frmTagsPages.conn.DatabaseName := DatabaseName;
    frmTagsPages.setFileName(DatabaseName);
    open_sql('select * from tags_pages', frmTagsPages.sqlTagsPages);
    ShowMessage(IntToStr(frmTagsPages.dsTagsPages.DataSet.RecordCount));
    frmTagsPages.sqlTagsPages.Active := True;
    frmTagsPages.dsTagsPages.AutoEdit := True;

  end;

         { 8 Окно со списком вложений }
  if strTypeOfFrame = 'attachments' then
  begin
    frmAttachments:= TfrmAttachments.Create(Self);
    frmAttachments.Parent := Self;
    frmAttachments.Align := alClient;
    frmAttachments.conn.DatabaseName := DatabaseName;
    frmAttachments.setFileName(DatabaseName);
    open_sql('select * from attachments', frmAttachments.sqlAttachments);
    ShowMessage(IntToStr(frmAttachments.dsAttachments.DataSet.RecordCount));
    frmAttachments.sqlAttachments.Active := True;
    frmAttachments.dsAttachments.AutoEdit := True;

  end;

           { 9 Окно со списком скриптов }
  if strTypeOfFrame = 'js' then
  begin
    frmJs := TfrmJs.Create(Self);
    frmJs.Parent := Self;
    frmJs.Align := alClient;
    frmJs.conn.DatabaseName := DatabaseName;
    frmJs.setFileName(DatabaseName);
    open_sql('select * from js', frmJs.sqlJs);
    ShowMessage(IntToStr(frmJs.dsJs.DataSet.RecordCount));
    frmJs.sqlJs.Active := True;
    frmJs.dsJs.AutoEdit := True;

  end;

             { 10 Окно со списком изображений }
  if strTypeOfFrame = 'images' then
  begin
    frmImages := TfrmImages.Create(Self);
    frmImages.Parent := Self;
    frmImages.Align := alClient;
    frmImages.conn.DatabaseName := DatabaseName;
    frmImages.setFileName(DatabaseName);
    open_sql('select * from images', frmImages.sqlImages);
    ShowMessage(IntToStr(frmImages.dsImages.DataSet.RecordCount));
    frmImages.sqlImages.Active := True;
    frmImages.dsImages.AutoEdit := True;

  end;


               { 11 Окно для списка меню }
  if strTypeOfFrame = 'menu' then
  begin
    frmMenu := TfrmMenu.Create(Self);
    frmMenu.Parent := Self;
    frmMenu.Align := alClient;
    frmMenu.conn.DatabaseName := DatabaseName;
    frmMenu.setFileName(DatabaseName);
    open_sql('select * from menu', frmMenu.sqlMenu);
    ShowMessage(IntToStr(frmMenu.dsMenu.DataSet.RecordCount));
    frmMenu.sqlMenu.Active := True;
    frmMenu.dsMenu.AutoEdit := True;

  end;

                 { 12 Окно для списка элементов меню }
  if strTypeOfFrame = 'menuitems' then
  begin
    frmMenuItem := TfrmMenu_Item.Create(Self);
    frmMenuItem.Parent := Self;
    frmMenuItem.Align := alClient;
    frmMenuItem.conn.DatabaseName := DatabaseName;
    frmMenuItem.setFileName(DatabaseName);
    open_sql('select * from menu_item', frmMenuItem.sqlMenuItem);
    ShowMessage(IntToStr(frmMenuItem.dsMenuItem.DataSet.RecordCount));
    frmMenuItem.sqlMenuItem.Active := True;
    frmMenuItem.dsMenuItem.AutoEdit := True;

  end;

  (* --------------------- Окна элементов ------------------ *)

                   { 13 Окно для элемента контента }
  if strTypeOfFrame = 'content_element' then
  begin
    frmContent_Element := TfrmContent_Element.Create(Self);
    frmContent_Element.Parent := Self;
    frmContent_Element.Align := alClient;
    frmContent_Element.conn.DatabaseName := DatabaseName;
    frmContent_Element.setFileName(DatabaseName);
    open_sql('select * from content where id="' +id_of_element+ '"',
    frmContent_Element.sqlContent_Element);
    ShowMessage(IntToStr(frmContent_Element.dsContent_Element.DataSet.RecordCount));
    frmContent_Element.sqlContent_Element.Active := True;
    frmContent_Element.dsContent_Element.AutoEdit := True;

  end;


                     { 14 Окно для элемента вложения }
  if strTypeOfFrame = 'attachment_element' then
  begin
    frmAttachment_Element := TfrmAttachment_Element.Create(Self);
    frmAttachment_Element.Parent := Self;
    frmAttachment_Element.Align := alClient;
    frmAttachment_Element.conn.DatabaseName := DatabaseName;
    frmAttachment_Element.setFileName(DatabaseName);
    open_sql('select * from attachments where attachment_id="' +id_of_element+ '"',
    frmAttachment_Element.sqlAttachment_Element);
    ShowMessage(IntToStr(frmAttachment_Element.dsAttachment_Element.DataSet.RecordCount));
    frmAttachment_Element.sqlAttachment_Element.Active := True;
    frmAttachment_Element.dsAttachment_Element.AutoEdit := True;

  end;


                    { 15 Окно для блока }
  if strTypeOfFrame = 'block_element' then
  begin
    frmBlock_Element := TfrmBlock_Element.Create(Self);
    frmBlock_Element.Parent := Self;
    frmBlock_Element.Align := alClient;
    frmBlock_Element.conn.DatabaseName := DatabaseName;
    frmBlock_Element.setFileName(DatabaseName);
    open_sql('select * from block where id="' +id_of_element+ '"',
    frmBlock_Element.sqlBlock_Element);
    ShowMessage(IntToStr(frmBlock_Element.dsBlock_Element.DataSet.RecordCount));
    frmBlock_Element.sqlBlock_Element.Active := True;
    frmBlock_Element.dsBlock_Element.AutoEdit := True;

  end;



                      { 16 Окно для стиля }
  if strTypeOfFrame = 'css_element' then
  begin
    frmCss_Element := TfrmCss_Element.Create(Self);
    frmCss_Element.Parent := Self;
    frmCss_Element.Align := alClient;
    frmCss_Element.conn.DatabaseName := DatabaseName;
    frmCss_Element.setFileName(DatabaseName);
    open_sql('select * from css where css_id="' +id_of_element+ '"',
    frmCss_Element.sqlCss_Element);
    ShowMessage(IntToStr(frmCss_Element.dsCss_Element.DataSet.RecordCount));
    frmCss_Element.sqlCss_Element.Active := True;
    frmCss_Element.dsCss_Element.AutoEdit := True;

  end;


                        { 17 Окно для изображения }
  if strTypeOfFrame = 'image_element' then
  begin
    frmImage_Element := TfrmImage_Element.Create(Self);
    frmImage_Element.Parent := Self;
    frmImage_Element.Align := alClient;
    frmImage_Element.conn.DatabaseName := DatabaseName;
    frmImage_Element.setFileName(DatabaseName);
    open_sql('select * from images where image_id="' +id_of_element+ '"',
    frmImage_Element.sqlImage_Element);
    frmImage_Element.sqlImage_Element.Active := True;
    frmImage_Element.dsImage_Element.AutoEdit := True;

  end;




                         { 18 Окно для скрипта }
  if strTypeOfFrame = 'js_element' then
  begin
    frmJs_Element := TfrmJs_Element.Create(Self);
    frmJs_Element.Parent := Self;
    frmJs_Element.Align := alClient;
    frmJs_Element.conn.DatabaseName := DatabaseName;
    frmJs_Element.setFileName(DatabaseName);
    open_sql('select * from js where js_id="' +id_of_element+ '"',
    frmJs_Element.sqlJs_Element);
    frmJs_Element.sqlJs_Element.Active := True;
    frmJs_Element.dsJs_Element.AutoEdit := True;

  end;



                          { 19 Окно для тега }
  if strTypeOfFrame = 'tag_element' then
  begin
    ShowMessage('tag_element='+id_of_element);
    frmTag_Element := TfrmTag_Element.Create(Self);
    frmTag_Element.Parent := Self;
    frmTag_Element.Align := alClient;
    frmTag_Element.conn.DatabaseName := DatabaseName;
    frmTag_Element.setFileName(DatabaseName);
    open_sql('select * from tags where tag_id="' +id_of_element+ '"',
    frmTag_Element.sqlTag_Element);
    frmTag_Element.sqlTag_Element.Active := True;
    frmTag_Element.dsTag_Element.AutoEdit := True;

  end;




end;

initialization
  {$I child_dialog.lrs}

end.
