unit htmlbuilder_main_form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, Menus, SynEdit, DateTimePicker, child_dialog, db_create_tables,
  db_helpers, db_insertdemo, dbmemo_autocomplete,
  types_for_app, SQLDB, SQLite3Conn, selection_history_manager,
  fontsettings, const_for_app, AsyncQueue;

type

  { TStarterHtmlBuilder }

  TStarterHtmlBuilder = class(TForm)
    acSaveDatabase: TAction;
    acOpenDatabase: TAction;
    acOpenContentChild: TAction;
    acOpenCssChild: TAction;
    acOpenBlockChild: TAction;
    acOpenSectionChild: TAction;
    acOpenPresetsChild: TAction;
    acOpenTagsChild: TAction;
    acOpenTagsPagesChild: TAction;
    acOpenAttachmentsChild: TAction;
    acOpenJsChild: TAction;
    acOpenImagesChild: TAction;
    acOpenMenuChild: TAction;
    acOpenMenuItemChild: TAction;
    ActionList1: TActionList;
    btnTestContentElement: TButton;
    btnTestOtherMaterial: TButton;
    mnuOpenMenuItemChild: TMenuItem;
    mnuOpenMenuChild: TMenuItem;
    mnuOpenImagesChild: TMenuItem;
    mnuOpenJsChild: TMenuItem;
    mnuOpenAttachmentsChild: TMenuItem;
    mnuOpenTagsPagesChild: TMenuItem;
    mnuOpenTagsChild: TMenuItem;
    mnuOpenPresetsChild: TMenuItem;
    mnuOpenSectionChild: TMenuItem;
    mnuOpenBlockChild: TMenuItem;
    mnuOpenContentChild: TMenuItem;
    mnuOpenCssChild: TMenuItem;
    mnuSite: TMenuItem;
    mnuMainMenu: TMainMenu;
    mnuDatabase: TMenuItem;
    mnuSaveDatabase: TMenuItem;
    mnuOpenDatabase: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    conn: TSQLite3Connection;
    temp_sql: TSQLQuery;
    trans: TSQLTransaction;


    Cache: TStringList;

    { Вызов дочерних окон со списками элементов }
    procedure acOpenAttachmentsChildExecute(Sender: TObject);
    procedure acOpenBlockChildExecute(Sender: TObject);
    procedure acOpenContentChildExecute(Sender: TObject);
    procedure acOpenCssChildExecute(Sender: TObject);
    procedure acOpenDatabaseExecute(Sender: TObject);
    procedure acOpenImagesChildExecute(Sender: TObject);
    procedure acOpenJsChildExecute(Sender: TObject);
    procedure acOpenMenuChildExecute(Sender: TObject);
    procedure acOpenMenuItemChildExecute(Sender: TObject);
    procedure acOpenSectionChildExecute(Sender: TObject);
    procedure acOpenPresetsChildExecute(Sender: TObject);
    procedure acOpenTagsChildExecute(Sender: TObject);
    procedure acOpenTagsPagesChildExecute(Sender: TObject);
    procedure btnTestContentElementClick(Sender: TObject);
    procedure btnTestOtherMaterialClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
  private
    SelectionHistoryManager: TSelectionHistoryManager;
    lastFocusedControl: TControl;
    rubrication_start: string;
    windowNum: integer;

    { Список названий страниц }
    Titles: TMemo;

    { Список URL для страниц }
    Urls: TMemo;

    { Список разделов сайта }
    Sections: TMemo;

    { Словарь для отношения теги - страницы }
    PagesTree: sdict;

    { Список URL для разделов }
    SiteSectionUrls: TMemo;

    { Список URL для заголовков разделов }
    SiteSectionTitles: TMemo;

    { Хранит отношение раздел сайта - иерархия }
    SiteSectionTree: sdict;

    { Список имен CSS }
    CssTitles: TStringList;

    { Список имен JS}
    JsTitles: TStringList;

    { Отображение для тегов}
    Tags: sdict;

    { Словарь для связи теги - страницы}
    mTagsPages: TagsPagesMap;

    { Словарь для связи id изображения - название изображения}
    Images: sdict;

    { Словарь для связи id вложения - название вложения}
    Attachments: sdict;


    { Какое порядок используется для сортировки }
    POrs: sdict;

    { Какое поле используется для сортировки }
    POrf: sdict;


    { Список доступных настроек }
    SitePresets: TMemo;

    { Список SQL запросов }
    sqls: sqls_list;
    { Имя файла, в котором хранится база }
    db_filename: string;
    { Список глобальных блоков }
    Blocks: TStringList;
    { Хранит специальные настройки программы }
    special_settings: TSpecial_Settings;


    { Очередь для записи файлов}
    Writer: TFilesQueue;
    procedure changeDataSources();
    procedure SilentMessage(msg: string);
    procedure initdbSQL();
    procedure initTransactionSQL();
    procedure makeSqlInactive();
    procedure makeSqlActive();
    procedure doScan();
    procedure refreshTrees();
    procedure initFontsState();
    procedure setFontsToUI(SomeFont: TFont);
    procedure SaveSpecialSettings(path: string);
    procedure RestoreSpecialSettings(path: string);
    procedure loadfromui_special_setting();
    procedure updateui_special_setting();
    procedure viewTablesSQL();
    procedure makeCreationTables();
  public


  end;

var
  StarterHtmlBuilder: TStarterHtmlBuilder;

implementation

{ TStarterHtmlBuilder }

procedure TStarterHtmlBuilder.initdbSQL;
begin
  // в начале иниц. транзакция
  try
    initTransactionSQL();
  except
    on E: Exception do
      ShowMessage('Error: ' + E.ClassName + #13#10 + E.Message);
  end;
  // по выходу из блока предполагается, что
  // либо база создана с нуля, либо уже заполнена
  SilentMessage('Начальная транзакция сделана...');

  // 2. переключаем источники данных
  changeDataSources(); // назначаем для 4 таблиц
  SilentMessage('Источники подключены...');
  viewTablesSQL(); // 3. вызываем запросы
  SilentMessage('Запросы выполнены...');
end;

procedure TStarterHtmlBuilder.initTransactionSQL();
var
  isOK: boolean;
begin

  db_filename := getCurrentDir() + DELIM + sqlite_filename;
  conn.DatabaseName := db_filename; // назначаем имя файла
  Caption := db_filename;
  try
    //Поскольку мы делаем эту базу данных впервые,
    // проверяем, существует ли уже файл
    isOK := FileExists(conn.DatabaseName);

    if isOK then
    begin

      conn.Open;

      trans.Active := True;

      conn.ExecuteDirect('End transaction');
      conn.ExecuteDirect('pragma synchronous = 0');
      conn.ExecuteDirect('pragma foreign_keys = off');
      conn.ExecuteDirect('pragma journal_mode = off');

      trans.Active := True;
      conn.ExecuteDirect('Begin transaction');


      // делать ничего не нужно, обработается при выходе, сообщаем
      SilentMessage('Файл найден!');
      checkConnect(conn, trans, 'initTransactionSQL');

    end

    else

    begin
      // Создаем базу данных и таблицы
      SilentMessage('Создаем базу с нуля');



      // запросы в рамках транзакции


      trans.Active := True;

      conn.ExecuteDirect('End transaction');
      conn.ExecuteDirect('pragma synchronous = 0');
      conn.ExecuteDirect('pragma foreign_keys = off');
      conn.ExecuteDirect('pragma journal_mode = off');
      trans.Active := True;
      conn.ExecuteDirect('Begin transaction');

      checkConnect(conn, trans, 'initTransactionSQL');
      try
        makeCreationTables(); // запросы на создание таблиц



        // пытаемся выполнить вставку данных

        insertDemoData(temp_sql, conn, trans);




        SilentMessage(msgBaseSuccess);
      except
        SilentMessage(msgErrorCreating);
      end;
    end;
  except
    SilentMessage(msgCantCheckDbFile);
  end;

end;



procedure TStarterHtmlBuilder.setFontsToUI(SomeFont: TFont);
begin
  // TODO  : SetFontsToUI
  (*
  fContent.Font := SomeFont;
  dbmSectionFullText.Font := SomeFont;
  dbeBlockHtml.Font := SomeFont;
  dbmCssStyle.Font := SomeFont;
  dbmJsScriptFile.Font := SomeFont;
  dbmMenuTpl.Font := SomeFont;
  dbmMenuItemTpl.Font := SomeFont;
  dbmHeadTemplate.Font := SomeFont;
  dbmBodyPagesTemplate.Font := SomeFont;
  dbmBodySectionsTemplate.Font := SomeFont;
  dbmTemplateOfItem.Font := SomeFont;
  dbmTagsTemplate.Font := SomeFont;
  dbmItemTagTemplate.Font := SomeFont;
  *)
end;

procedure TStarterHtmlBuilder.SaveSpecialSettings(path: string);
var
  fout: file of TSpecial_Settings;
begin

  loadfromui_special_setting();
  if path = '' then
    if SaveDialog1.Execute then
      path := SaveDialog1.FileName;
  if path <> '' then
  begin
    AssignFile(fout, path);
    Rewrite(fout);
    Write(fout, special_settings);
    closefile(fout);
  end;

end;

procedure TStarterHtmlBuilder.RestoreSpecialSettings(path: string);
var
  fin: file of TSpecial_Settings;
begin
  if path = '' then
    if OpenDialog1.Execute then
      path := SaveDialog1.FileName;
  if path <> '' then
  begin
    AssignFile(fin, path);
    Reset(fin);
    Read(fin, special_settings);
    closefile(fin);
    updateui_special_setting();
  end;
end;

procedure TStarterHtmlBuilder.loadfromui_special_setting();
begin
  (* TODO
  special_settings.ArchiveName := form1.edArchiveName.Text;
  special_settings.ext := form1.PrefferedExtension.Text;
  special_settings.fileManager := form1.edFileManager.Text;
  special_settings.Locale := form1.cboLocale.ItemIndex;
  special_settings.LocalWysiwygExpress := form1.edLocalWysigygServer.Text;
  special_settings.numOfRecords := StrToInt(form1.edItemsPerPage.Text);
  special_settings.pathToBuild := form1.edPathToBuild.Text;
  special_settings.UseGlobalsFromFiles := form1.chkGetBlocksFromFile.Checked;
  special_settings.UseModule := form1.chkUseModules.Checked;
  special_settings.useTree := form1.chkUseTrees.Checked;
  special_settings.zipCommandLine := form1.ZipArchiverCommand.Text;
  special_settings.pathToGhPages := form1.edGithubPagesPath.Text;

  special_settings.ftpIp := form1.edFtpIP.Text;
  special_settings.ftpUserName := form1.edFtpUsername.Text;
  special_settings.ftpPassword := form1.edFtpPassword.Text;
  special_settings.ftpPort := form1.edFtpPort.Text;

  special_settings.webLocalServerIp := form1.edIpAddress.Text;
  special_settings.webLocalServerPort := form1.edPort.Text;
  *)
end;

procedure TStarterHtmlBuilder.updateui_special_setting();
begin
  // TODO:  updateui_special_setting
end;

procedure TStarterHtmlBuilder.viewTablesSQL();
begin
  // TODO: viewTablesSQL
end;

procedure TStarterHtmlBuilder.makeCreationTables();
begin

  try

    checkConnect(conn, trans, 'makeCreationTables');

    createPagesSQL(conn, trans);
    createSectionsSQL(conn, trans);
    createBlocksSQL(conn, trans);
    createPresetsSQL(conn, trans);
    createCssSQL(conn, trans);
    createJsSQL(conn, trans);
    createTagsSQL(conn, trans);
    createTagsPagesSQL(conn, trans);
    createMenusSQL(conn, trans);
    createItemsForMenuSQL(conn, trans);
    createImagesSQL(conn, trans);
    createAttachmentsSQL(conn, trans);

  except
    on E: Exception do
      ShowMessage('Error: ' + E.ClassName + #13#10 + E.Message);
  end;
end;

procedure TStarterHtmlBuilder.initFontsState();
var
  FontManager: TFontManager;
begin
  FontManager := TFontManager.Create();
  setFontsToUI(FontManager.Font);

end;

procedure TStarterHtmlBuilder.refreshTrees();
begin
  //TODO:      refreshTrees
end;

procedure TStarterHtmlBuilder.doScan();
begin
  //TODO:      doScan
end;

procedure TStarterHtmlBuilder.makeSqlInactive();
begin
  //TODO:      makeSqlInactive
end;

procedure TStarterHtmlBuilder.makeSqlActive();
begin
  //TODO:      makeSqlActive
end;




procedure TStarterHtmlBuilder.FormCreate(Sender: TObject);
var
  index: integer;
  Control: TControl;
begin
  SelectionHistoryManager := TSelectionHistoryManager.Create();

  LastFocusedControl := nil;
  initFontsState();

  if not FileExists('special_settings.dat') then
    SaveSpecialSettings('special_settings.dat')
  else
  begin
    RestoreSpecialSettings('special_settings.dat');
    loadfromui_special_setting();
  end;
  SiteSectionTree := sdict.Create;
  PagesTree := sdict.Create;

  // rubrication_start := sqlRubrication.SQL.Text;

  initdbSQL();

  Cache := TStringList.Create;

  // TODO: dbNav_Content.DataSource.AutoEdit := True;
  // TODO: dbNav_Content.Enabled := True;

  // dbNav_Css.DataSource.AutoEdit := True;
  // dbNav_Css.Enabled := True;

  Titles := TMemo.Create(Self); // Заголовки
  Urls := TMemo.Create(Self); // URL страниц
  Sections := TMemo.Create(Self); // Разделы страниц
  CssTitles := TStringList.Create;
  JsTitles := TStringList.Create;

  Tags := sdict.Create;
  mTagsPages := TagsPagesMap.Create;

  POrf := sdict.Create();
  POrs := sdict.Create();

  Images := sdict.Create();
  Attachments := sdict.Create();


  SiteSectionUrls := TMemo.Create(Self); // URL разделов
  SiteSectionTitles := TMemo.Create(Self); // Заголовки разделов
  blocks := TStringList.Create();
  sitePresets := TMemo.Create(Self);

  doScan();
  //TODO: edPathToBuild.Text := GetEnvironmentVariable('HOME') + '/mysite';

end;

procedure TStarterHtmlBuilder.changeDataSources();
begin
  // TODO : changeDataSources
end;

procedure TStarterHtmlBuilder.SilentMessage(msg: string);
begin
  if (not SilentMode) then ShowMessage(msg);
end;



procedure TStarterHtmlBuilder.acOpenDatabaseExecute(Sender: TObject);
var
  filename: string;
begin
  if OpenDialog1.Execute then
  begin

    makeSqlInactive;

    filename := OpenDialog1.FileName;
    Caption := filename;
    conn.DatabaseName := filename;



    conn.Open;

    trans.Active := True;

    conn.ExecuteDirect('End transaction');
    conn.ExecuteDirect('pragma synchronous = 0');
    conn.ExecuteDirect('pragma foreign_keys = off');
    conn.ExecuteDirect('pragma journal_mode = off');

    trans.Active := True;
    conn.ExecuteDirect('Begin transaction');


    checkConnect(conn, trans, 'initTransactionSQL');
    makeSqlActive();
    doScan;
    refreshTrees;
  end;
end;

procedure TStarterHtmlBuilder.acOpenImagesChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('images', '');
  d.Caption := 'Окно таблицы изображений ' + IntToStr(windowNum);
  Inc(windowNum);

end;

procedure TStarterHtmlBuilder.acOpenJsChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('js', '');
  d.Caption := 'Окно скриптов ' + IntToStr(windowNum);
  Inc(windowNum);

end;

procedure TStarterHtmlBuilder.acOpenMenuChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('menu', '');
  d.Caption := 'Окно menu ' + IntToStr(windowNum);
  Inc(windowNum);

end;

procedure TStarterHtmlBuilder.acOpenMenuItemChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('menuitems', '');
  d.Caption := 'Окно элементов меню ' + IntToStr(windowNum);
  Inc(windowNum);

end;

procedure TStarterHtmlBuilder.acOpenSectionChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('section', '');
  d.Caption := 'Окно секции ' + IntToStr(windowNum);
  Inc(windowNum);

end;

procedure TStarterHtmlBuilder.acOpenPresetsChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('preset', '');
  d.Caption := 'Окно пресет ' + IntToStr(windowNum);
  Inc(windowNum);

end;

procedure TStarterHtmlBuilder.acOpenTagsChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('tag', '');
  d.Caption := 'Окно тегов ' + IntToStr(windowNum);
  Inc(windowNum);

end;

procedure TStarterHtmlBuilder.acOpenTagsPagesChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('tags_pages', '');
  d.Caption := 'Связь теги-страницы ' + IntToStr(windowNum);
  Inc(windowNum);

end;

procedure TStarterHtmlBuilder.btnTestContentElementClick(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);
  d.Show;
  d.loadFrame('content_element', 'index');
  d.Caption := 'Окно элемента контента ' + IntToStr(windowNum);
  Inc(windowNum);
end;

procedure TStarterHtmlBuilder.btnTestOtherMaterialClick(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('content_element', 'about');
  d.Caption := 'Окно контента ' + IntToStr(windowNum);
  Inc(windowNum);

end;


procedure TStarterHtmlBuilder.acOpenContentChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('content', '');
  d.Caption := 'Окно контента ' + IntToStr(windowNum);
  Inc(windowNum);

end;

procedure TStarterHtmlBuilder.acOpenBlockChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('block', '');
  d.Caption := 'Окно блоков сайта ' + IntToStr(windowNum);
  Inc(windowNum);
end;

procedure TStarterHtmlBuilder.acOpenAttachmentsChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('attachments', '');
  d.Caption := 'Окно вложений ' + IntToStr(windowNum);
  Inc(windowNum);
end;

procedure TStarterHtmlBuilder.acOpenCssChildExecute(Sender: TObject);
var
  d: TFrameLoader;
begin
  d := TFrameLoader.Create(Self);




  d.Show;

  d.loadFrame('css', '');
  d.Caption := 'Окно таблиц стилей ' + IntToStr(windowNum);
  Inc(windowNum);
end;

initialization
  {$I htmlbuilder_main_form.lrs}

end.
