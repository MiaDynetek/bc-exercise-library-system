pageextension 50260 "Rent Book Extention" extends RentBook
{
    layout
    {
        addafter("Date Rented")
        {
            field("Book Status"; Rec."Book Status")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the status field.';
            }
            field("Day(s) Rented"; Rec."Days Rented")
            {
                ToolTip = 'Specifies the value of the Days Rented field.';
                trigger OnValidate()
                begin
                   Rec.ValidateDaysRented();
                end;
            }
            
            field("Book Grade"; Rec."Book Grade")
            {
                ToolTip = 'Specifies the value of the Grade field.';
                trigger OnValidate()
                begin
                    Rec.DisplayMessageGradeMandatory(1);
                end;
            }
            field("Grade Justification"; Rec."Grade Justification")
            {
                ToolTip = 'Specifies the value of the Grade Justification field.';
                MultiLine = true;
                trigger OnValidate()
                begin
                    Rec.DisplayMessageGradeMandatory(2);
                end;
            }
        }
    }
    
    trigger OnModifyRecord(): Boolean
    begin

        Rec.UpdateRentedBook();
    end;

    trigger OnClosePage()
    begin
        Rec.ValidateFields();
    end;
}