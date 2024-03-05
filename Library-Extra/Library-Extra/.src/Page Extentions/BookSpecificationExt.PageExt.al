pageextension 90250 BookSpecificationExt extends BookSpecifications
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
            field("Date Added"; Rec."Date Added")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Date Added field.';
            }
            field("Author"; Rec."Book Author")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    if Rec."Book Author" = '' then begin
                        Message('Please enter the book Author.');
                    end;
                end;
            }
            field("Book Cover"; Rec."Book Cover")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Book Cover field.';
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