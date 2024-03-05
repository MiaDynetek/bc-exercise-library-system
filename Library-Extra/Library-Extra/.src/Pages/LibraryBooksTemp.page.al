page 90257 "Library Books Temp"
{
    Caption = 'Add Book';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Library;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            group("Search Data")
            {
                field("Search Title"; "Search Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Search Title field.';
                }
            }
            repeater("Book Data")
            {
                field(Title; Rec."Book Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field.';
                    //Editable = false;
                }
                field(Created; Rec.Created)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created field.';
                    //Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                    //Editable = false;
                }
                field("Open Library ID"; Rec."Open Library ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Open Library ID field.';
                    //Editable = false;
                }
                field("Book Cover"; Rec."Book Cover")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Cover field.';
                }
                field("Book Cover URL"; Rec."Book Cover URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Cover field.';
                }
                // field("Temp Book ID"; Rec."Temp Book ID")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Temp Book ID field.';
                //     //Editable = false;
                // }
                // field("Add Book"; Rec."Add Book")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Add Book field.';
                //     //Editable = false;
                // }

            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Find Books")
            {
                ApplicationArea = All;
                Image = Action;
                ToolTip = 'Books with the title entered will be inserted into the table.';
                trigger OnAction()
                var
                    ReturnSearchedBooks: Codeunit "Return Searched Books";
                    Books: Text;
                    AATJSONHelper: Codeunit "AAT JSON Helper";
                    JsonArray: JsonArray;
                    JsonObject: JsonObject;
                    JsonObject2: JsonObject;
                    JsonObject3: JsonObject;
                    JsonToken: JsonToken;
                    JsonToken2: JsonToken;
                    JsonTokenID: JsonToken;
                    JsonTokenAuthor: JsonToken;
                    JsonArrayAuthor: JsonArray;
                    BookID: Text[500];
                    Description: Text;
                    Created: Text;
                    Title: Text;
                    SpecificBookData: Text;
                    DescriptionPure: Text;


                    FinalDescription: Text;
                    FinalCreated: Text;
                    FinalTitle: Text;
                    FinalBookID: Text;
                    RemoveTags: List of [Text];
                    LibraryBooks: Record Library;
                    LastID: Text;
                    CoverOut: Text;
                    RemoveBrackets: List of [Text];
                begin
                    Rec.DeleteAll(true);
                    Books := ReturnSearchedBooks.GetSearchedBooks("Search Title");
                    // Message(Books);
                    AATJSONHelper.InitializeJsonObjectFromText(Books);
                    JsonObject := AATJSONHelper.GetJsonObject();
                    AATJSONHelper.GetJsonArray(JsonObject, 'docs', JsonArray);
                    LastID := LibraryBooks."Book ID";
                    foreach JsonToken in JsonArray do begin
                        Rec.Init();
                        if format(JsonToken).Contains('key') then begin
                            JsonObject2 := JsonToken.AsObject();
                            JsonObject2.Get('key', JsonTokenID);
                            BookID := DelChr(Format(JsonTokenID), '=', '/works/');
                            if Rec."Open Library ID".Contains(BookID) = false then begin
                                SpecificBookData := ReturnSearchedBooks.GetSpecificBookData(BookID);
                                // Message(SpecificBookData);
                                Description := Rec.GetBookDescription(BookID, SpecificBookData);
                                Created := Rec.GetBookCreated(BookID, SpecificBookData);
                                Title := Rec.GetBookTitle(BookID, SpecificBookData);
                                DescriptionPure := CopyStr(Description, 1, 2048);
                                //LibraryBooks.FindLast();
                                Rec.Validate("Book ID", Rec.NextNumberSeries());
                                Rec.Validate("Open Library ID", Rec.RemoveAllQuotes(BookID));
                                Rec.Validate(Created, Rec.RemoveAllQuotes(Created));
                                Rec.Validate(Description, Rec.RemoveAllQuotes(DescriptionPure));
                                Rec.Validate("Book Title", Rec.RemoveAllQuotes(Title));
                                //Rec.GetBookAuthor(BookID, SpecificBookData);
                                // "Last ID" := "Last ID" + 1;
                                // // Rec.Validate("Temp Book ID", "Last ID");

                            end;
                        end;
                        if format(JsonToken).Contains('author_key') then begin
                            JsonObject2 := JsonToken.AsObject();
                            AATJSONHelper.GetJsonArray(JsonObject2, 'author_key', JsonArrayAuthor);
                            foreach JsonTokenAuthor in JsonArrayAuthor do begin
                                Rec."Author Open Library ID" := Rec."Author Open Library ID" + Format(JsonTokenAuthor) + ',';
                                // if Author.FindSet() then begin

                                // end;
                            end;
                        end;
                        Rec.Insert();
                        if format(JsonToken).Contains('cover_i') then begin
                            JsonObject3 := JsonToken.AsObject();
                            JsonToken2 := AATJSONHelper.GetJsonToken(JsonObject3, 'cover_i');
                            CoverOut := Format(JsonToken2);
                            Rec."Book Cover URL" := 'https://covers.openlibrary.org/b/id/' + CoverOut + '.jpg';
                            Rec.GetBookCover(Rec."Book Cover URL");
                        end;



                    end;
                end;

            }
            action("Add Book(s)")
            {
                ApplicationArea = All;
                Image = Action;
                ToolTip = 'Books with the title entered will be inserted into the table.';
                trigger OnAction()
                var
                    LibraryBooksAPI: Codeunit "Library Books API";
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            LibraryBooksAPI.AddNewAPIBooks(Rec);
                        //AddAPIBooksToLibrary(Rec);
                        until Rec.Next() = 0;
                    // "Return Text" += GetSelectionFilter();
                    // Message("Return Text");
                end;
            }
        }
    }
    // local procedure OnMultiSelectFind()
    // var
    //     recRef: RecordRef;
    //     LibraryBooksTemp: Page "Library Books Temp";
    //     SelectionFilterManagement: Codeunit SelectionFilterManagement;
    //     "Library Books Temp": Record "Library Books Temp";
    // begin
    //     recRef.GetTable("Library Books Temp");
    //     LibraryBooksTemp.SetSelectionFilter("Library Books Temp");
    //     Message(SelectionFilterManagement.GetSelectionFilter(recRef, "Library Books Temp".FieldNo("Temp Book ID")));
    // end;

    procedure AddAPIBooksToLibrary(LibraryBooksTemp: Record Library temporary)
    var
        Library: Record Library;
        ReturnMsg: Text;
    begin
        if LibraryBooksTemp.FindSet() then
            repeat
                ReturnMsg += LibraryBooksTemp.Title;
            until LibraryBooksTemp.Next() = 0;
        Message(ReturnMsg);
    end;
    // procedure GetSelectionFilter(): Text
    // var
    //     LibraryBooksTemp: Record "Library Books Temp";
    //     CRMIntegrationManagement: Codeunit "CRM Integration Management";
    //     BookRecordRef: RecordRef;
    // begin
    //     CurrPage.SetSelectionFilter(LibraryBooksTemp);
    //     LibraryBooksTemp.Next;
    //     if LibraryBooksTemp.Count = 1 then begin
    //         CRMIntegrationManagement.UpdateOneNow(LibraryBooksTemp.RecordId);
    //     end else begin
    //         BookRecordRef.GetTable(LibraryBooksTemp);
    //         CRMIntegrationManagement.UpdateMultipleNow(BookRecordRef);
    //     end;
    //     //exit(GetSelectionFilterForLibraryBook(LibraryBooksTemp));
    // end;
    // procedure GetSelectionFilter(): Text
    // var
    //     LibraryBooksTemp: Record "Library Books Temp";
    //     SelectionFilterManagement: Codeunit SelectionFilterManagement;
    //     RecRef: RecordRef;
    // begin
    //     CurrPage.SetSelectionFilter(LibraryBooksTemp);
    //     RecRef.GetTable(LibraryBooksTemp);
    //     exit(SelectionFilterManagement.GetSelectionFilter(RecRef, LibraryBooksTemp."Temp Book ID"));
    // end;

    // local procedure GetSelectionFilterForLibraryBook(var LibraryBook: Record "Library Books Temp"): Text
    // var
    //     RecRef: RecordRef;
    //     SelectionFilterManagement: Codeunit SelectionFilterManagement;
    // begin
    //     RecRef.GetTable(LibraryBook);
    //     exit(SelectionFilterManagement.GetSelectionFilter(RecRef, LibraryBook.FieldNo("Temp Book ID")));
    // end;

    // trigger OnOpenPage()
    // var
    //     LibraryBooksTemp: Page "Library Books Temp";
    //     LibraryBooksTemp2: Record "Library Books Temp";
    //     SelectionFilterManagement: Codeunit SelectionFilterManagement;
    //     RecRef: RecordRef;
    // begin
    //     //Clear(CurrPage);
    //     "Return Text" += GetSelectionFilter();
    //     //LibraryBooksTemp.SetTableView(LibraryBooksTemp2);
    //     //LibraryBooksTemp.LookupMode(true);
    //     // LibraryBooksTemp.SetSelectionFilter(LibraryBooksTemp2);
    //     // RecRef.GetTable(LibraryBooksTemp2);
    // end;

    var
        "Search Title": Text[1000];
        "Last ID": Integer;
        "Return Text": Text;
}