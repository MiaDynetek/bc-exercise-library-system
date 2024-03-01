page 90253 "Grade and Status Setup"
{
    PageType = ListPart;
    ApplicationArea = All;
    AutoSplitKey = true;
    UsageCategory = Lists;
    SourceTable = "Grade and Status Setup";
    Caption = 'Grade and Status Setup';
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
                field(BookGrade; Rec.BookGrade)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BookGrade field.';
                }
                field(BookStatus; Rec.BookStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BookStatus field.';
                }
                // field(SetupTableID; Rec.SetupTableID)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the SetupTableID field.';
                //     Visible = false;
                // }

            }
        }
    }
    
}
