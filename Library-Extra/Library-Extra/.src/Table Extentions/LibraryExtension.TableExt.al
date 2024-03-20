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
        field(90000; "Open Library ID"; Text[1000])
        {
            Caption = 'Open Library ID';
        }
        field(90010; "Book Title"; Text[500])
        {
            Caption = 'Title';
            NotBlank = true;
        }
        field(90020; "Created"; Text[500])
        {
            Caption = 'Created';
            NotBlank = true;
        }
        field(90030; "Description"; Text[2048])
        {
            Caption = 'Description';
        }
        field(90040; "Search Title"; Text[500])
        {
            Caption = 'Search Title';
            NotBlank = true;
        }
        field(90050; "Author Open Library ID"; Text[500])
        {
            Caption = 'Author Open Library ID';
            NotBlank = true;
        }
        field(90060; "Book Author"; Text[500])
        {
            Caption = 'Book Author';
            TableRelation = Author."Author Name";
            NotBlank = true;
        }
        field(90070; "Book Cover"; MediaSet)
        {
            Caption = 'Book Cover';
        }
        field(90080; "Subject Places"; Text[500])
        {
            Caption = 'Subject Places';
        }
        field(90090; "Subject"; Text[500])
        {
            Caption = 'Subject';
        }
        field(90100; "Subject People"; Text[500])
        {
            Caption = 'Subject People';
        }
        field(90110; "Latest Revision"; Text[500])
        {
            Caption = 'Latest Revision';
        }
    }
    fieldgroups
    {
        addlast(DropDown; Title, "Book Cover")
        {

        }
    }
    
    procedure GetBookAuthor(BookID: Text[500]; GetSpecificBookData: Text): Text
    var
        JsonObject: JsonObject;
        JsonObject1: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
        JsonArray: JsonArray;
        JsonTokenValue: JsonToken;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        if AATJSONHelper.GetJsonArray(JsonObject, 'author_name', JsonArray) then begin
            foreach JsonToken in JsonArray do begin
                Message(Format(JsonToken));
            end;
            // JsonTokenValue := JsonToken;
            // if JsonToken.IsObject = true then begin
            //     JsonObject1 := JsonToken.AsObject();
            //     JsonObject1.Get('value', JsonTokenValue);
            //     Exit(Format(JsonTokenValue));
            // end else begin
            //     Exit(Format(JsonToken));
            // end;
        end else begin
            Exit(Format('N/A'));
        end;
    end;

    procedure GetBookDescription(BookID: Text[500]; GetSpecificBookData: Text): Text
    var
        JsonObject: JsonObject;
        JsonObject1: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
        JsonTokenValue: JsonToken;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        if JsonObject.Get('description', JsonToken) then begin
            JsonTokenValue := JsonToken;
            if JsonToken.IsObject = true then begin
                JsonObject1 := JsonToken.AsObject();
                JsonObject1.Get('value', JsonTokenValue);
                Exit(Format(JsonTokenValue));
            end else begin
                Exit(Format(JsonToken));
            end;
        end else begin
            Exit(Format('N/A'));
        end;
    end;

    procedure GetBookCreated(BookID: Text[500]; GetSpecificBookData: Text): Text
    var
        JsonObject: JsonObject;
        JsonObject1: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
        JsonTokenValue: JsonToken;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        if JsonObject.Get('created', JsonToken) then begin
            JsonObject1 := JsonToken.AsObject();
            if JsonObject1.Get('value', JsonTokenValue) then begin
                Exit(Format(JsonTokenValue));
            end else begin
                exit('N/A');
            end;
        end else begin
            exit('N/A');
        end;
    end;

    procedure GetSubjectInformation(GetSpecificBookData: Text; FieldName: Text): Text
    var
        JsonObject: JsonObject;
        JsonObject1: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
        JsonTokenValue: JsonToken;
        JsonArray: JsonArray;
        AllSubjectPlaces: Text;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        if AATJSONHelper.GetJsonArray(JsonObject, FieldName, JsonArray) then begin
            foreach JsonToken in JsonArray do begin
                AllSubjectPlaces := AllSubjectPlaces + Format(JsonToken) + '\';
            end;
            exit(AllSubjectPlaces);
        end else begin
            exit('N/A');
        end;
    end;

    procedure GetLatestRevision(GetSpecificBookData: Text): Text
    var
        JsonObject: JsonObject;
        JsonObject1: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
        JsonTokenValue: JsonToken;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        if JsonObject.Get('latest_revision', JsonToken) then begin
            Exit(Format(JsonToken));
        end else begin
            exit('N/A');
        end;
    end;

    procedure GetAuthorDataItem(GetSpecificBookData: Text; AuthorDataItem: Text): Text
    var
        JsonObject: JsonObject;
        JsonObject1: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
        JsonTokenValue: JsonToken;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        if JsonObject.Get(AuthorDataItem, JsonToken) then begin
            exit(Format(JsonToken));
        end else begin
            exit('N/A');
        end;
    end;

    procedure GetAuthorPhotoURL(GetSpecificBookData: Text): Text
    var
        JsonObject: JsonObject;
        JsonObject1: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
        JsonTokenValue: JsonToken;
        JsonArrary: JsonArray;
        Counter: Integer;
        ImageURL: Text;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        AATJSONHelper.GetJsonArray(JsonObject, 'photos', JsonArrary);
        foreach JsonToken in JsonArrary do begin
            Counter := Counter + 1;
            if Counter = 1 then begin
                ImageURL := 'https://covers.openlibrary.org/b/id/' + Format(JsonToken) + '.jpg';
                exit(ImageURL);
            end;
        end;
    end;

    procedure RemoveAllQuotes(FinalOutput: Text): Text
    var
        RemoveTags: List of [Text];
        PureOutput: Text;
    begin
        if FinalOutput.Contains('"') then begin
            RemoveTags := FinalOutput.Split('"');
            if RemoveTags.Count() = 2 then begin
                PureOutput := RemoveTags.Get(1);
                Exit(PureOutput);
            end else begin
                PureOutput := RemoveTags.Get(2);
                Exit(PureOutput);
            end;
        end else begin
            PureOutput := Created;
            Exit(PureOutput);
        end;
    end;

    procedure GetBookTitle(BookID: Text[500]; GetSpecificBookData: Text): Text
    var
        JsonObject: JsonObject;
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonToken: JsonToken;
    begin
        AATJSONHelper.InitializeJsonObjectFromText(GetSpecificBookData);
        JsonObject := AATJSONHelper.GetJsonObject();
        if JsonObject.Get('title', JsonToken) then begin
            Exit(Format(JsonToken));
        end else begin
            exit('N/A');
        end;
    end;

    procedure AddBookSequel()
    var
        NewLibrary: Record Library;
        NewAddBookSequelPage: Page AddBookSequel;
    begin
        NewLibrary.Init();
        // NewLibrary.Validate("Book ID", NextNumberSeries());
        NewLibrary.Validate("Book Author", Rec."Book Author");
        NewLibrary.Validate(Series, Rec.Series);
        NewLibrary.Validate(Genre, Rec.Genre);
        NewLibrary.Validate(Publisher, Rec.Publisher);
        NewLibrary.Validate(Prequel, Rec.Title);
        //   NewLibrary.Validate("Prequel ID", Rec."Book ID");
        NewLibrary.Validate("Edit Sequel", true);
        NewLibrary.Validate("Book Status", enum::BookStatus::"Pending Grading");
        NewLibrary.Validate("Display Message", true);
        NewLibrary.Insert();
        NewAddBookSequelPage.SetRecord(NewLibrary);
        NewAddBookSequelPage.Run();

    end;

    procedure NextNumberSeries(): Text
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextNum: Text[1000];
        GeneralSetup: Record "General Library Setup";
    begin
        GeneralSetup.GetRecordOnce();
        GeneralSetup.TestField("No. Series");
        NextNum := NoSeriesMgt.GetNextNo(GeneralSetup."No. Series", WorkDate(), true);
        exit(NextNum);
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
        GeneralSetup: Record "General Library Setup";
    begin

        NewBookTransactionsLog.Init();
        GeneralSetup.Get();
        GeneralSetup.TestField("No. Series");
        NextNum := NoSeriesMgt.GetNextNo(GeneralSetup."No. Series", WorkDate(), true);
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

    procedure GetNextID(): Text[1000]
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextNum: Text[1000];
        GeneralSetup: Record "General Library Setup";
    begin
        GeneralSetup.GetRecordOnce();
        GeneralSetup.TestField("No. Series");
        NextNum := NoSeriesMgt.GetNextNo(GeneralSetup."No. Series", WorkDate(), true);
        Exit(GeneralSetup."No. Series" + NextNum);
    end;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextNum: Text[1000];
        GeneralSetup: Record "General Library Setup";
    begin
        GeneralSetup.GetRecordOnce();
        GeneralSetup.TestField("No. Series");
        NextNum := NoSeriesMgt.GetNextNo(GeneralSetup."No. Series", WorkDate(), true);
        Rec."Book ID" := GeneralSetup."No. Series" + NextNum;
        // AddNewAuthor();
        AddNewGenre();
    end;

    trigger OnModify()
    begin
        //AddNewAuthor();
        AddNewGenre();
    end;

    // procedure AddNewAuthor()
    // var
    //     Author: Record Author;
    //     Author1: Record Author;
    // begin
    //     if Rec."Book Author" <> '' then begin
    //         Author.SetRange("Author Name", Rec.Author);
    //         if not Author.FindLast() then begin
    //             Author1.Init();
    //             Author1."Author Name" := Rec.Author;
    //             Author1.Insert();
    //         end;
    //     end;
    // end;

    procedure AddNewGenre()
    var
        Genre: Record Genre;
        Genre1: Record Genre;
    begin
        if Rec."Genre" <> '' then begin
            Genre.SetRange("Genre Name", Rec."Genre");
            if not Genre.FindLast() then begin
                Genre1.Init();
                Genre1."Genre Name" := Rec."Genre";
                Genre1.Insert();
            end;
        end;
    end;

    procedure UpdatePhoto(RequestURL: Text; Type: Text; AuthorReturnData: Text; CurrentAuthor: Record Author)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        SearchTitle: Text;
        "Return Searched Books": Codeunit "Return Searched Books";
        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        InStr: InStream;
        HttpRequestMessage: HttpRequestMessage;
        RequestHeaders: HttpHeaders;
        RequestBody: Text[250];
        HttpContent: HttpContent;
        ContentHeaders: HttpHeaders;
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        RestTempBlob: Codeunit "Temp Blob";
        ResponseInstream: InStream;
        ResponseImg: InStream;
        ImageURL: Text;
    begin
        HttpRequestMessage.Method := 'GET';
        if Type = '1' then begin
            HttpRequestMessage.SetRequestUri(RequestURL);
        end;
        if Type = '2' then begin
            if AuthorReturnData.Contains('photos') = false then
                exit;
            ImageURL := GetAuthorPhotoURL(AuthorReturnData);
            HttpRequestMessage.SetRequestUri(ImageURL);
        end;
        HttpRequestMessage.GetHeaders(RequestHeaders);

        HttpContent.WriteFrom(RequestBody);
        HttpContent.GetHeaders(ContentHeaders);
        if ContentHeaders.Contains('Content-Type') then
            ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');
        HttpRequestMessage.Content(HttpContent);
        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        RestTempBlob.CreateInStream(ResponseInstream);
        HttpResponseMessage.Content().ReadAs(ResponseImg);
        if Type = '1' then begin
            Rec."Book Cover".ImportStream(ResponseImg, 'Cover');
            Rec.Modify(true);
        end;
        if Type = '2' then begin
            CurrentAuthor."Picture".ImportStream(ResponseImg, 'Picture');
            CurrentAuthor.Modify(true);
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