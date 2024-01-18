page 50701 Library
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
                        if Rec."Title" = '' then
                        begin
                            Message('Please enter the book title.');
                        end;
                    end;
                }
                field("Author"; Rec."Author")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Author" = '' then
                        begin
                            Message('Please enter the book Author.'); 
                        end;
                    end;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    
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
                    var
                        myInt: Integer;
                    begin
                        if Rec."Genre" = '' then
                        begin
                            Message('Please enter the book Genre.'); 
                        end;
                    end;
                }
                field("Publisher"; Rec."Publisher")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Publisher" = '' then
                        begin
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
                        if Rec."Book Price" = '' then
                        begin
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
   
    trigger OnModifyRecord(): Boolean
    begin
        Rec.UpdatePrequelSequel();
        // if(Rec."Edit Sequel" = true) then
        // begin
        // libraryBooks.SetFilter("Book ID", '=%1', Rec."Prequel ID");
        // libraryBooks.FindFirst();
        // libraryBooks.Sequel := Rec.Title;
        // libraryBooks."Sequel ID" := Rec."Book ID";
        // libraryBooks.Modify();
        // end;
    end;
}