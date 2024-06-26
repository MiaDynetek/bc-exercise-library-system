page 90101 BookSpecifications
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Library;
    Caption = 'Book Specifications';
    DelayedInsert = true;

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
                    var
                        myInt: Integer;
                    begin
                        if Rec."Title" = '' then begin
                            Message('Please enter the book title.');
                        end;
                    end;
                }
                
                // field("Rented"; Rec."Rented")
                // {
                //     ApplicationArea = All;

                // }
                field("Series"; Rec."Series")
                {
                    Lookup = true;
                    TableRelation = BookSeries;
                    ToolTip = 'Specifies the value of the Series Name field.';

                }
                field("Publisher"; Rec."Publisher")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
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
                    var
                        myInt: Integer;
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


            }
        }
    }


    //  local procedure EnumValue(Number: Integer): Text
    // begin
    //     exit(F.GetEnumValueNameFromOrdinalValue(F.GetEnumValueOrdinal(Number)));
    // end;

    // procedure GetSelectedEnum(): Integer
    // begin
    //     exit(F.GetEnumValueOrdinal(Rec.Status));
    // end;

    // procedure SetupPage(TableNo: Integer; FieldNo: Integer)
    // var
    //     SelectLbl: Label 'Select ';
    // begin
    //     Ref.OPEN(TableNo);
    //     F := Ref.Field(FieldNo);
    //     Setrange(Status, 1, F.EnumValueCount());
    //     CurrPage.Caption(SelectLbl + F.Caption());
    // end;



}