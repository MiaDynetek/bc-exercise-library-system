tableextension 90251 "Book Transaction Extension" extends BookTransactions
{
    fields
    {
        field(50000; "Book Grade Justification"; Text[1000])
        {
            Caption = '';
            NotBlank = true;
        }
        field(50010; "Book Return Date"; Date)
        {
            Caption = '';
            NotBlank = true;
        }
        field(50020; "Book Status"; Enum BookStatus)
        {
            DataClassification = ToBeClassified;

        }
        field(50030; "Book Grade"; Enum BookGrade)
        {
            DataClassification = ToBeClassified;

        }
        field(50040; "Display Messages"; Boolean)
        {
            Caption = '';
        }
    }

    procedure UpdateRentedBook()
    var
        LibraryBooks: Record Library;
        BookTransactions: Record BookTransactions;
    begin

        LibraryBooks.SetRange("Book ID", Rec."Book ID");
        if LibraryBooks.IsEmpty() then
            exit;
        LibraryBooks.FindFirst();
        BookTransactions.SetRange("Book ID", Rec."Book ID");
        LibraryBooks.Validate("Book Status", Rec."Book Status");
        BookTransactions.SetRange("Book Status", enum::BookStatus::Rented);

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
        if (Rec."Book Status" = enum::BookStatus::" ") or (Rec."Book Grade" = enum::BookGrade::" ") then begin
       //     CurrLibraryBook.SetRange("Book ID", Rec."Book ID");
            CurrLibraryBook.FindFirst();
            // currPage.SetRecord(getCurrBook);
            // currPage.Run();
            // Message('Please select a status and grade.');
        end;
    end;

    procedure ValidateDaysRented()
    var
        GeneralSetup: Record "General Library Setup";
    begin
        GeneralSetup.GetRecordOnce();
        GeneralSetup.TestField("No. Series");
        if (Rec."Days Rented" > GeneralSetup.EndAmount) or (Rec."Days Rented" < GeneralSetup.StartAmount) then begin
            Message('Please provide a number between 3-5.');
            Rec.Validate("Days Rented", GeneralSetup.StartAmount);
            Rec.Validate("Return Date", Rec."Date Rented" + Rec."Days Rented");
        end;

        if (Rec."Days Rented" <= GeneralSetup.EndAmount) and (Rec."Days Rented" >= GeneralSetup.StartAmount) then begin
            Rec.Validate("Return Date", Rec."Date Rented" + Rec."Days Rented");
        end;

    end;

    procedure DisplayMessageGradeMandatory(Type: Integer)
    begin
        if Type = 1 then
        begin
            if Rec."Display Message" = true then begin
                Rec.Validate("Book Status", enum::BookStatus::Available);
                Rec.Validate("Display Message", false);
            end;
        end;
        if Type = 2 then
        begin
            if (Rec."Display Message" = true) and (Rec."Book Grade" <> enum::BookGrade::" ") then begin
                Rec.Validate("Book Status", enum::BookStatus::Available);
                Rec.Validate("Display Message", false);
            end;

        end;
    end;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextNum: Text[1000];
        GeneralSetup: Record "General Library Setup";
    begin
        GeneralSetup.Get();
        GeneralSetup.TestField("No. Series");
        NextNum := NoSeriesMgt.GetNextNo(GeneralSetup."No. Series", WorkDate(), true);
        Rec."Rent ID " := GeneralSetup."No. Series" + NextNum;
    end;
}