page 90255 "All Library Books"
{
    PageType = ListPart;
    ApplicationArea = All;
    AutoSplitKey = true;
    UsageCategory = Administration;
    SourceTable = Library;
    Caption = 'All Library Books';
    DelayedInsert = true;
    Extensible = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    // SourceTableView = WHERE(SetupTableID = FILTER(Page::"General Setup"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Author field.';
                }
                field("Book Grade"; Rec."Book Grade")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Book Grade Justification"; Rec."Book Grade Justification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Grade Justification field.';
                }
                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Price field.';
                }
                field("Book Status"; Rec."Book Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    
}
