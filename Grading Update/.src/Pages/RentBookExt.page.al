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
            field("Day(s) Rented"; Rec."Day(s) Rented")
            {
                ToolTip = 'Specifies the value of the Days Rented field.';
                trigger OnValidate()
                begin

                    if Rec."Days Rented" > 5 then begin
                        Message('Please provide a number between 1-5.');
                    end;

                    if Rec."Days Rented" <= 5 then begin
                        Rec.Validate("Return Date", Rec."Date Rented" + Rec."Days Rented");
                    end;

                end;
            }
            
            field("Book Grade"; Rec."Book Grade")
            {
                ToolTip = 'Specifies the value of the Grade field.';
                trigger OnValidate()
                begin

                    if Rec."Display Message" = true then begin
                        Rec.Validate("Book Status", enum::BookStatus::Available);
                        Rec.Validate("Display Message", false);
                    end;

                end;
            }
            field("Grade Justification"; Rec."Grade Justification")
            {
                ToolTip = 'Specifies the value of the Grade Justification field.';
                MultiLine = true;
                trigger OnValidate()
                begin

                    if (Rec."Display Message" = true) and (Rec."Book Grade" <> enum::BookGrade::" ") then begin
                        Rec.Validate("Book Status", enum::BookStatus::Available);
                        Rec.Validate("Display Message", false);
                    end;

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