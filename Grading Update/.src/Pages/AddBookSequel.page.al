page 50256 AddBookSequel
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Library;
    Caption = 'Book Sequel';

    layout
    {
        area(Content)
        {
            group("Book Information")
            {
                field("Title"; Rec."Title")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin

                        if Rec."Title" = '' then begin
                            Message('Please enter the book title.');
                        end;

                    end;
                }
                field("Author"; Rec."Author")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin

                        if Rec."Author" = '' then begin
                            Message('Please enter the book Author.');
                        end;

                    end;
                }
                field("Series"; Rec."Series")
                {
                    Lookup = true;
                    TableRelation = BookSeries;
                    ToolTip = 'Specifies the value of the Series Name field.';

                }
                field("Genre"; Rec."Genre")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin

                        if Rec."Genre" = '' then begin
                            Message('Please enter the book Genre.');
                        end;

                    end;
                }
                field("Publisher"; Rec."Publisher")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    trigger OnValidate()
                    begin

                        if Rec."Publisher" = '' then begin
                            Message('Please enter the book Publisher.');
                        end;

                    end;
                }
                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin

                        if Rec."Book Price" = '' then begin
                            Message('Please enter the book Price.');
                        end;
                        
                    end;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    ApplicationArea = All;

                }
                field("Pages"; Rec."Pages")
                {
                    ApplicationArea = All;
                }
                field("Prequel"; Rec."Prequel")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sequel"; Rec."Sequel")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Edit Sequel"; Rec."Edit Sequel")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prequel ID"; Rec."Prequel ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sequel ID"; Rec."Sequel ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Book Status"; Rec."Book Status")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin

                        if (Rec."Book Status" <> enum::BookStatus::"Pending Grading") and (Rec."Display Message" = true) then begin
                            Rec."Book Status" := enum::BookStatus::"Pending Grading";
                            Message('Please assess the condition of the book and update the grade field accordingly.');
                        end;
                       
                    end;
                }
                field("Book Grade"; Rec."Book Grade")
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                    trigger OnValidate()
                    begin

                        if Rec."Display Message" = true then begin
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
                            Rec.Validate("Display Message", false);
                        end;

                    end;
                }
                field("Display Message"; Rec."Display Message")
                {
                    ToolTip = 'Specifies the value of the Display Message field.';
                    Visible = false;
                }
                field("Book ID"; Rec."Book ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book ID field.';
                }


            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        Rec.UpdatePrequelSequel();
        Rec.UpdateStatusGradeD();
    end;

    trigger OnOpenPage()
    begin

        if (Rec."Display Message" = true) then begin
            Message('Please assess the condition of the book and update the grade field accordingly.');
        end;

    end;

    trigger OnClosePage()
    begin

         Rec.ValidateFieldsAddLog();
         
    end;
}