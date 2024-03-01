page 90256 "Book Transactions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BookTransactions;
    Caption = 'Book Transactions';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Caption = 'Transactions';
               
                field("Book Name"; Rec."Book Name")
                {
                    ToolTip = 'Specifies the value of the Book Name field.';
                }
                field("Return Date"; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Return Date field.';
                }
                field("Book Grade"; Rec."Book Grade")
                {
                    ToolTip = 'Specified the grade of the book rented.';
                }
                field("Book ID"; Rec."Book ID")
                {
                    ToolTip = 'Specifies the value of the Rent ID field.';
                    Visible = false;
                }
                field("Book Status"; Rec."Book Status")
                {
                    ToolTip = 'Specifies the value of the status field.';
                }
                field("Grade Justification"; Rec."Grade Justification")
                {
                    ToolTip = 'Specifies the value of the Grade Justification field.';
                }

            }
        }
    }
 
}