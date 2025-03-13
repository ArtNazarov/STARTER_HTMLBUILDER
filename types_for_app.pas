{ Some types for storing data}
unit types_for_app;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB,
  db_helpers, db_create_tables, replacers, DateUtils, fgl, regexpr;

type

  { Special setting of whole application }
  TSpecial_Settings = record
    useTree: boolean;
    ext: string[255];
    zipCommandLine: string[255];
    Locale: integer;
    numOfRecords: integer;
    fileManager: string[255];
    pathToBuild: string[255];
    pathToGhPages: string[255];
    LocalWysiwygExpress: string[255];
    ArchiveName: string[255];
    UseModule: boolean;
    UseGlobalsFromFiles: boolean;
    ftpIp: string[32];
    ftpUserName: string[255];
    ftpPassword: string[255];
    ftpPort: string[6];
    webLocalServerIp: string[32];
    webLocalServerPort: string[6];
  end;

  { Properties of section }
  TSection_Record = record
    id, section, preset, note, full_text, tree: string
  end;

  { Properties of menus }
  Menu = record
    menu_id: string;
    menu_caption: string;
    menu_wrap_tpl: string;
    menu_item_tpl: string;
  end;

  { Properties of menu item }
  MenuItem = record
    menu_item_id: string;
    menu_item_caption: string;
    menu_item_type: string;
    menu_item_link_for: string;
    menu_item_menu_id: string; // внешний ключ
  end;

  { Properties of preset }
  PresetRecord = record

    id, sitename, dirpath, headtpl, bodytpl, sectiontpl, itemtpl, orf, ors,
    tags_tpl, item_tag_tpl: string;
  end;

  { Properties of tag }
  Tag = record
    tag_id: string;
    tag_caption: string;
  end;

  { Properties of tag link }
  Tag_Page_Link = record
    id_tag_page: string;
    id_tag: string;
    id_page: string;
    tree: string;
  end;

  { Hashmap dictationary for pairing String to String }
  sdict = specialize TFPGmap<string, string>;{define type under type}
  { Hashmap dictationary for pairing String to Tag_Page_Link }
  TagsPagesMap = specialize TFPGmap<string, Tag_Page_Link>;
  { Hashmap dictationary for pairing String to Tag }
  TagsMap = specialize TFPGmap<string, Tag>;

  { List for sql queries}
  sqls_list = array[byte] of TSQLquery;

  { User Record properties}
  user_records = array[0..7] of record
    Name: string;
    Value: string;
    end;

  { Rubrication properties}
  rubric_pages = record
    pages_total: array[0..255] of byte; // число страниц
    section_index: array[0..255] of byte;
    sectionhtml: array[0..255] of string;
    number_of_page: array[0..255] of byte;
    rubric_counter: byte;


  end;

  { Page pair for content_id and caption}
  page_pairs = record
    content_id: string;
    Caption: string;
  end;

  { Parameters of section }
  section_params = record
    id: string;
    section: string;
    note: string;
    full_text: string;
    content_id: string;
    Caption: string;
    sectiontpl: string;
    headtpl: string;
    itemtpl: string;
    dirpath: string;
    tree: string;
    pages: array[0..255] of page_pairs;
    pages_counter: byte; // счетчик страниц

  end;

  { List of section properties }
  section_list = record
    sections: array[0..255] of section_params;
    section_counter: byte; // счетчик разделов
  end;

  { Parameters of page }
  page_params = record
    id: string;
    title: string;
    body: string;
    dt: TDateTime;
    section_id: string;
    section_title: string;
    sitename: string;
    dirpath: string;
    headtpl: string;
    bodytpl: string;
    sectiontpl: string;
    tree: string;
    dir: string;
    user_field_names: array[0..7] of string;
    user_field_values: array[0..7] of string;
    tags: string;
  end;

  {HashMap String to Page_Params}
  PagesMap = specialize TFPGmap<string, page_params>;

  { TImageRecord for representation image }
  TImageRecord = record
    image_id: string;
    image_caption: string;
    image_data: string; // hex format

  end;


  { TAttachmentRecord for representation any document }
  TAttachmentRecord = record
    attachment_id: string;
    attachment_caption: string;
    attachment_data: string; // hex format

  end;

  { TBufferHistoryRecord for representation info from SelectionHistory}
  TBufferHistoryRecord = class(TObject)
    key_buf: string;
    Value: string;
  end;

  PBufferHistoryRecord = ^TBufferHistoryRecord;

  { TEmojiShortCode for representation pair emoji and it shortcode }
  TEmojiShortCode = record
    shortcode: string;
    utf8symbol: string;
  end;

  { TEmojiShortCodesArray for representation dynamic array of shortcodes }
  TEmojiShortCodesArray = array of TEmojiShortCode;

  { String function }
  TFuncStr = function(s: string): string of object;




  {Array of string functions}
  TFuncStrArray = array of TFuncStr;




implementation

end.
