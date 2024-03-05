page 90102 "General Library Setup"
{

    PageType = Card;
    SourceTable = "General Library Setup";
    Caption = 'General Library Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;
   
    layout
    {
        area(content)
        {
            group("Number Series")
            {

                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
            }
            group("Number of days a book may be rented")
            {

                field("Start Amount"; Rec.StartAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BeginDays field.';
                }
                field("End Amount"; Rec.EndAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EndDays field.';
                }
            }
          
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

}
