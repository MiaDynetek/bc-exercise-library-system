page 90257 "Book Analysis"
{
    Caption = 'Book Analysis';
    PageType = CardPart;
    // ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = "Book Analysis";
    
    layout
    {
        area(Content)
        {
            cuegroup(Books)
            {
                field("Recently added books"; Rec."Recently added books")
                {
                    ApplicationArea = All;
                    Caption='Recently added books';
                    DrillDownPageId=LibraryBookList;
                }
            }
        }
    }
    
    trigger OnOpenPage();
    begin
        Rec.InsertIfNotExists();
    end;
}