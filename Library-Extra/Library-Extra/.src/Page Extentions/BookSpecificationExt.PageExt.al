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
            field("Subject Places"; Rec."Subject Places")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subject Places field.';
            }
            field("Subject"; Rec."Subject")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subject field.';
            }
            field("Subject People"; Rec."Subject People")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subject People field.';
            }
            field("Latest Revision"; Rec."Latest Revision")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Latest Revision field.';
            }
            field("Book Genre"; Rec."Book Genre")
            {
                ApplicationArea = All;
                Caption = 'Book Genre';
                ToolTip = 'Specifies the value of the Book Genre field.';
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