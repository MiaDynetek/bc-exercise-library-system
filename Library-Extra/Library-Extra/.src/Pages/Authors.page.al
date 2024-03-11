page 90250 "Authors"
{
    Caption = 'Authors';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageId = Author;
    SourceTable = Author;

    layout
    {
        area(Content)
        {
            repeater("Author Data")
            {
                field("Author Name"; Rec."Author Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Author Name field.';
                }
                field(Bio; Rec.Bio)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bio field.';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Birth Date field.';
                }
                field("Death Date"; Rec."Death Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Death Date field.';
                }
                field("Open Library ID"; Rec."Open Library ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Open Library ID field.';
                }
                field("Personal Name"; Rec."Personal Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Personal Name field.';
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Personal Name field.';
                }
                field("Current Age"; Rec."Current Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Age field.';
                }
            }
        }
    }

}