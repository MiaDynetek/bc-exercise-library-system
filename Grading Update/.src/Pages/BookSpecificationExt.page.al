pageextension 50250 BookSpecificationExt extends BookSpecifications
{
    layout
    {
        addafter(Title)
        {
            field("Book Status"; Rec."Book Status")
            {
                ApplicationArea = All;
            }
            field("Book Grade"; Rec."Book Grade")
            {
                ApplicationArea = All;
            }
            field("Grade Justification"; Rec."Grade Justification")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            field("Book ID"; Rec."Book ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Book ID field.';
                Visible = false;
            }

        }
        
    }
    trigger OnModifyRecord(): Boolean
    begin

        Rec.UpdateStatusGradeD();
        Rec.UpdatePrequelSequel();
        
    end;

    trigger OnClosePage()
    begin

        Rec.ValidateFieldsAddLog();

    end;

}