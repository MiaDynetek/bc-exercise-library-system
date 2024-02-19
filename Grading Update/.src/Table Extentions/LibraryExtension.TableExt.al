tableextension 90250 "Library Extension" extends Library
{
    DrillDownPageId = LibraryBookList;
    fields
    {
        field(50050; "Book Status"; Enum BookStatus)
        {
            Caption = 'Book Status';
            NotBlank = true;
        }
        field(50060; "Book Grade"; Enum BookGrade)
        {
            Caption = 'Book Grade';
            DataClassification = ToBeClassified;
        }
        field(50070; "Display Messages"; Boolean)
        {
            Caption = 'Display Messages';
            DataClassification = ToBeClassified;
        }
        field(50080; "Book Grade Justification"; Text[1000])
        {
            Caption = 'Book Grade Justification';
            NotBlank = true;
        }
        field(50090; "Date Added"; Date)
        {
            Caption = 'Date Added';
            NotBlank = true;
        }
        
    }


    procedure AddBookSequel()
    var
        NewLibrary: Record Library;
        NewAddBookSequelPage: Page AddBookSequel;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextNum: Text[1000];
        GeneralSetup: Record "General Setup";
    begin
        GeneralSetup.GetRecordOnce();
        GeneralSetup.TestField("No. Series");
        NextNum := NoSeriesMgt.GetNextNo(GeneralSetup."No. Series", WorkDate(), true);
        NewLibrary.Init();
        NewLibrary.Validate("Book ID", GeneralSetup."No. Series" + NextNum);
        NewLibrary.Validate(Author, Rec.Author);
        NewLibrary.Validate(Series, Rec.Series);
        NewLibrary.Validate(Genre, Rec.Genre);
        NewLibrary.Validate(Publisher, Rec.Publisher);
        NewLibrary.Validate(Prequel, Rec.Title);
        NewLibrary.Validate("Prequel ID", Rec."Book ID");
        NewLibrary.Validate("Edit Sequel", true);
        NewLibrary.Validate("Book Status", enum::BookStatus::"Pending Grading");
        NewLibrary.Validate("Display Message", true);
        NewLibrary.Insert();
        NewAddBookSequelPage.SetRecord(NewLibrary);
        NewAddBookSequelPage.Run();

    end;

    procedure RentBook()
    var
        NewBookTransactions: Record BookTransactions;
        NewRentedBook: Page RentBook;
    begin

        if (Rec."Book Status" <> enum::BookStatus::Available) then begin
            Message('This book may not currently be rented, please change the book status to Available before attempting to rent again.');
        end;

        if (Rec."Book Status" = enum::BookStatus::Available) then begin
            NewBookTransactions.Init();
            NewBookTransactions.Validate("Book Name", Rec.Title);
            NewBookTransactions.Validate("Book ID", Rec."Book ID");
            NewBookTransactions.Validate("Date Rented", System.Today());
            NewBookTransactions.Validate("Days Rented", 3);
            NewBookTransactions.Validate("Return Date", Today() + 3);
            NewBookTransactions.Validate("Book Status", "Book Status"::Rented);
            NewBookTransactions.Validate("Book Grade", Rec."Book Grade");
            NewBookTransactions.Validate("Book Grade Justification", Rec."Book Grade Justification");
            NewBookTransactions.Insert();
            NewRentedBook.SetRecord(NewBookTransactions);
            NewRentedBook.Run();
        end;

    end;

    procedure ReturnBook()
    var
        PreviousBookTransactions: Record BookTransactions;
        NewBookTransactions: Record BookTransactions;
        NewRentBook: Page RentBook;
    begin

        if (Rec."Book Status" <> enum::BookStatus::Rented) then begin
            if (Rec."Book Status" <> enum::BookStatus::Overdue) then begin
                Message('Before attempting to change the status of this book to available, please ensure it is currently marked as rented or overdue.');
            end;
        end;

        PreviousBookTransactions.SetRange("Book ID", Rec."Book ID");
        PreviousBookTransactions.SetCurrentKey("Date Rented");
        PreviousBookTransactions.Ascending();
        PreviousBookTransactions.FindLast();

        if (Rec."Book Status" = enum::BookStatus::Rented) or (Rec."Book Status" = enum::BookStatus::Overdue) then begin
            NewBookTransactions.Init();
            NewBookTransactions.Validate("Book Name", Rec.Title);
            NewBookTransactions.Validate("Book ID", Rec."Book ID");
            NewBookTransactions.Validate("Date Rented", System.Today());
            NewBookTransactions.Validate("Days Rented", 3);
            NewBookTransactions.Validate("Return Date", Today() + 3);
            NewBookTransactions.Validate("Book Status", enum::BookStatus::"Pending Grading");
            NewBookTransactions.Validate("Display Message", true);
            NewBookTransactions.Validate("Customer Name", PreviousBookTransactions."Customer Name");
            NewBookTransactions.Validate("Book Grade", Rec."Book Grade");
            NewBookTransactions.Validate("Grade Justification", Rec."Grade Justification");
            NewBookTransactions.Insert();
            NewRentBook.SetRecord(NewBookTransactions);
            NewRentBook.Run();
        end;

    end;

    procedure FilterReceivingRepair()
    begin

        Rec.SetRange("Book Status", enum::BookStatus::"Out for repair");

    end;

    procedure ArchiveBook()
    begin

        Rec.Validate("Book Status", enum::BookStatus::"In Poor Condition");
        Rec.Modify();
        Message('The book you selected have been set to In Poor Condition.');
        Rec.AddLog(enum::BookStatus::"In Poor Condition");

    end;


    procedure AddLog(CurrentBookStatus: enum BookStatus)
    var
        NewBookTransactionsLog: Record BookTransactions;
    begin

        NewBookTransactionsLog.Init();
        NewBookTransactionsLog.Validate("Book Name", Rec.Title);
        NewBookTransactionsLog.Validate("Book ID", Rec."Book ID");
        NewBookTransactionsLog.Validate("Book Status", CurrentBookStatus);
        NewBookTransactionsLog.Validate("Book Grade", Rec."Book Grade");
        NewBookTransactionsLog.Validate("Grade Justification", Rec."Grade Justification");
        NewBookTransactionsLog.Insert();

    end;

    procedure FilterBooksReceivingRepair()
    begin

        Rec.SetRange("Book Status", enum::BookStatus::"Out for repair");

    end;
    // procedure FilterBooksDashCriteria("Book Author": Text; "Book Genre": Text; Type: Integer; FilterAll: Boolean)
    // begin
    //     Rec.Reset();
    //     if (("Book Author" <> '') and ((Type = 0) or (FilterAll = true))) then
    //         Rec.SetFilter(Rec.Author, '=%1', "Book Author");
    //     if (("Book Genre" <> '') and ((Type = 1) or (FilterAll = true))) then
    //     Rec.SetFilter(Rec.Genre, '=%1', "Book Genre");
        
    //     if ((Type = 2) or (FilterAll = true)) then
    //     begin
    //         Rec.SetFilter(Rec."Date Added", '<>%1',0D);
    //         Rec.SetFilter(Rec."Date Added", '<=%1', Rec.Date);
    //     end;
    // end;

    procedure ArchiveBooks()
    begin

        Rec.Validate("Book Status", enum::BookStatus::"In Poor Condition");
        Rec.Modify();
        Message('The book you selected have been set to In Poor Condition.');
        Rec.AddLogs(enum::BookStatus::"In Poor Condition");

    end;


    procedure AddLogs(CurrentBookStatus: enum BookStatus)
    var
        NewBookTransactionsLog: Record BookTransactions;
    begin

        NewBookTransactionsLog.Init();
        NewBookTransactionsLog.Validate("Book Name", Rec.Title);
        NewBookTransactionsLog.Validate("Book ID", Rec."Book ID");
        NewBookTransactionsLog.Validate("Book Status", CurrentBookStatus);
        NewBookTransactionsLog.Validate("Book Grade", Rec."Book Grade");
        NewBookTransactionsLog.Validate("Grade Justification", Rec."Grade Justification");
        NewBookTransactionsLog.Insert();

    end;

    procedure AddLogCodeunit(CurrentBookStatus: enum BookStatus; LibraryLog: Record Library)
    var
        NewBookTransactionsLog: Record BookTransactions;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextNum: Text[1000];
        GeneralSetup: Record "General Setup";
    begin

        NewBookTransactionsLog.Init();
        GeneralSetup.Get();
        GeneralSetup.TestField("No. Series");
        NextNum := NoSeriesMgt.GetNextNo(GeneralSetup."No. Series", WorkDate(), true);
        //NewBookTransactionsLog.Validate("Rent ID ", GeneralSetup."No. Series" + NextNum);
        NewBookTransactionsLog.Validate("Book Name", Rec.Title);
        NewBookTransactionsLog.Validate("Book ID", Rec."Book ID");
        NewBookTransactionsLog.Validate("Book Status", CurrentBookStatus);
        NewBookTransactionsLog.Validate("Book Grade", Rec."Book Grade");
        NewBookTransactionsLog.Validate("Grade Justification", Rec."Grade Justification");
        NewBookTransactionsLog.Insert();

    end;

    procedure UpdateStatusGradeD()
    begin

        if Rec."Book Grade" = enum::BookGrade::D then begin
            Rec.Validate("Book Status", enum::BookStatus::"Out for repair");
        end;

    end;

    procedure ValidateFieldsAddLog()
    var
        GetCurrentLibraryBook: Record Library;
        NewBookTransactionsLog: Record BookTransactions;
        BookSpecificationsPage: Page BookSpecifications;
    begin
        if (Rec."Book Status" = enum::BookStatus::" ") or (Rec."Book Grade" = enum::BookGrade::" ") then begin
            GetCurrentLibraryBook.SetRange("Book ID", Rec."Book ID");
            if GetCurrentLibraryBook.IsEmpty() then
                exit;
            GetCurrentLibraryBook.FindFirst();
            BookSpecificationsPage.SetRecord(GetCurrentLibraryBook);
            BookSpecificationsPage.Run();
            Message('Please select a status and grade.');
        end;

        NewBookTransactionsLog.Init();
        NewBookTransactionsLog.Validate("Book Name", Rec.Title);
        NewBookTransactionsLog.Validate("Book ID", Rec."Book ID");
        NewBookTransactionsLog.Validate("Book Status", Rec."Book Status");
        NewBookTransactionsLog.Validate("Book Grade", Rec."Book Grade");
        NewBookTransactionsLog.Validate("Grade Justification", Rec."Grade Justification");
        NewBookTransactionsLog.Insert();
    end;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextNum: Text[1000];
        GeneralSetup: Record "General Setup";
    begin
        GeneralSetup.GetRecordOnce();
        GeneralSetup.TestField("No. Series");
        NextNum := NoSeriesMgt.GetNextNo(GeneralSetup."No. Series", WorkDate(), true);
        Rec."Book ID" := GeneralSetup."No. Series" + NextNum;
        AddNewAuthor();
        AddNewGenre();
    end;
    trigger OnModify()
    begin
        AddNewAuthor();
        AddNewGenre();
    end;
    procedure AddNewAuthor()
    var
        Author: Record Author;
        Author1: Record Author;
    begin
        if Rec.Author <> '' then
        begin
            Author.SetRange("Author Name", Rec.Author);
            if not Author.FindLast() then begin
                Author1.Init();
                Author1."Author Name" := Rec.Author;
                Author1.Insert();
            end;
        end;
    end;
    procedure AddNewGenre()
    var
        Genre: Record Genre;
        Genre1: Record Genre;
    begin
        if Rec."Genre" <> '' then
        begin
            Genre.SetRange("Genre Name", Rec."Genre");
            if not Genre.FindLast() then begin
                Genre1.Init();
                Genre1."Genre Name" := Rec."Genre";
                Genre1.Insert();
            end;
        end;
    end;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

    var
        RecordHasBeenRead: Boolean;
}