pageextension 90251 "Library Book List Extention" extends LibraryBookList
{
    layout
    {

        addafter(Title)
        {
            field("Book Author"; Rec."Book Author")
            {
                ToolTip = 'Specifies the value of the Author field.';
                ApplicationArea = All;
            }
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
            field("Book Cover"; Rec."Book Cover")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Book Cover field.';
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
        UpdateBookStatusOnLoad: Codeunit UpdateBookStatusOnLoad;
    begin
        UpdateBookStatusOnLoad.Run();
        //Rec.AddNewAuthor();
        Rec.AddNewGenre();
    end;

}