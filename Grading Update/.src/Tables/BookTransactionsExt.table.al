tableextension 50251 "Book Transaction Extension" extends BookTransactions
{
    fields
    {
        field(320; "Book Grade Justification"; Text[1000])
        {
            Caption = '';
            NotBlank = true;  
        }
        field(330; "Book Return Date"; Date)
        {
            Caption = '';
            NotBlank = true;  
        }
        field(340;"Book Status"; Enum BookStatus)
        {
            DataClassification = ToBeClassified;
            
        }
        field(350;"Book Grade"; Enum BookGrade)
        {
            DataClassification = ToBeClassified;
            
        }
        field(360; "Display Messages"; Boolean)
        {
            Caption = '';
        }
        field(380; "Day(s) Rented"; Integer)
        {
            Caption = '';
            NotBlank = true;  
        }
    }
    
    procedure UpdateRentedBook()
    var
        LibraryBooks: Record Library;
        BookTransactions: Record BookTransactions;
    begin

        LibraryBooks.SetRange("Book ID", Rec."Book ID");
        LibraryBooks.FindFirst();
        BookTransactions.SetRange("Book ID", Rec."Book ID");
        LibraryBooks.Validate("Book Status", Rec."Book Status");
        BookTransactions.SetRange("Book Status",enum::BookStatus::Rented);

        if (Rec."Book Status" = enum::BookStatus::Rented) then begin
            LibraryBooks.Validate("Rented Count", BookTransactions.Count());
        end;

        LibraryBooks.Validate("Book Grade", Rec."Book Grade");
        LibraryBooks.Validate("Grade Justification", Rec."Grade Justification");
        LibraryBooks.Modify();

    end;


    procedure ValidateFields()
    var
        CurrLibraryBook: Record Library;
        CurrRentBookPage: Page RentBook;
    begin
        if (Rec."Book Status" = enum::BookStatus::" ") or (Rec."Book Grade" = enum::BookGrade::" ") then
        begin
            CurrLibraryBook.SetRange("Book ID",Rec."Book ID");
            CurrLibraryBook.FindFirst();
            // currPage.SetRecord(getCurrBook);
            // currPage.Run();
            // Message('Please select a status and grade.');
        end;
    end;
}