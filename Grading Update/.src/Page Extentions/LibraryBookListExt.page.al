pageextension 90251 "Library Book List Extention" extends LibraryBookList
{
    layout
    {
        
        addafter(Title)
        {
           
            field("Book Status"; Rec."Book Status")
            {
                ToolTip = 'Specifies the value of the Status field.';
                ApplicationArea = All;
            }
            field("Book Grade"; Rec."Book Grade")
            {
                ToolTip = 'Specifies the value of the Grade field.';
                ApplicationArea = All;
            }
            field("Date Added"; Rec."Date Added")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Date Added field.';
            }
            
        }
    }
    
    actions
    {
        addlast(Processing)
        {
            action("Rent Book ")
            {
                Caption = 'Rent Book';
                ToolTip = 'Select this action to rent the currently selected book.';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                begin
                    Rec.RentBook();
                end;
            }
            action("Return Book")
            {
                Caption = 'Return Book';
                ToolTip = 'Select this action to return the currently selected book.';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                begin
                    Rec.ReturnBook();
                end;
            }   
            action("Books that are Receiving Repair")
            {
                Caption = 'Books that are Receiving Repair';
                ToolTip = 'Select this action to view all books that are receiving repair.';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                begin
                    Rec.FilterBooksReceivingRepair();
                end;
            }
             action("Archive Book")
            {
                Caption = 'Archive Book';
                ToolTip = 'Select this action to Archive the selected book.';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                begin
                    Rec.ArchiveBooks();
                end;
            }
            action("Add Book Sequel ")
            {
                Caption = 'Add Book Sequel';
                ToolTip = 'Select this action to add a new book as a sequel to the selected book.';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                begin
                    Rec.AddBookSequel();
                end;
            }
        }
    }
     trigger OnOpenPage()
    var
        lbooks: Record Library;
        genre: Record Genre;
        genre1: Record Genre;
        // author: Record Author;
        // author1: Record Author;
        // counter: Integer;
        UpdateBookStatusOnLoad: Codeunit UpdateBookStatusOnLoad;
    begin 
        UpdateBookStatusOnLoad.Run();
        // lbooks.SetFilter(Author, '<>''''');
        // if lbooks.FindSet() then
        // repeat
        // author1.SetRange("Author Name", lbooks.Author);
        //     // if author1.FindLast() then
        //     //     counter := author1."Auther ID" + 1;
        //     if not author1.FindSet() then
        //     begin
        //         author.Init();
        //         author."Author Name" := lbooks.Author;
        //         author.Insert();
        //     end;
        // until lbooks.Next() = 0;

        // if lbooks.FindSet() then
        // repeat
        // genre1.SetRange("Genre Name", lbooks.Genre);
        //     // if author1.FindLast() then
        //     //     counter := author1."Auther ID" + 1;
        //     if not genre1.FindSet() then
        //     begin
        //         genre.Init();
        //         genre."Genre Name" := lbooks.Genre;
        //         genre.Insert();
        //     end;
        // until lbooks.Next() = 0;
    end;
 
}