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
                field("Subject Places"; Rec."Subject Places")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subject Places field.';
                }
                field("Subject"; Rec."Subject")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subject field.';
                }
                field("Subject People"; Rec."Subject People")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subject People field.';
                }
                field("Latest Revision"; Rec."Latest Revision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Latest Revision field.';
                }
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
                    Author: Record Author;
                    LibraryBooks: Record Library;
                    LastID: Text;
                    CoverOut: Text;
                    SubjectInfo: Text;
                    RemoveBrackets: List of [Text];
                begin
                    Rec.DeleteAll(true);
                    Books := ReturnSearchedBooks.GetSearchedBooks("Search Title");
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
                                Description := Rec.GetBookDescription(BookID, SpecificBookData);
                                Created := Rec.GetBookCreated(BookID, SpecificBookData);
                                Title := Rec.GetBookTitle(BookID, SpecificBookData);
                                DescriptionPure := CopyStr(Description, 1, 2048);
                                Rec.Validate("Book ID", Rec.NextNumberSeries());
                                Rec.Validate("Open Library ID", Rec.RemoveAllQuotes(BookID));
                                Rec.Validate(Created, Rec.RemoveAllQuotes(Created));
                                Rec.Validate(Description, Rec.RemoveAllQuotes(DescriptionPure));
                                Rec.Validate("Book Title", Rec.RemoveAllQuotes(Title));
                                Rec.Validate("Subject Places", Rec.RemoveAllQuotes(Rec.GetSubjectInformation(SpecificBookData, 'subject_places')));
                                Rec.Validate("Subject People", Rec.RemoveAllQuotes(Rec.GetSubjectInformation(SpecificBookData, 'subject_people')));
                                Rec.Validate(Subject, Rec.RemoveAllQuotes(Rec.GetSubjectInformation(SpecificBookData, 'subjects')));
                                Rec.Validate("Latest Revision", Rec.RemoveAllQuotes(Rec.GetLatestRevision(SpecificBookData)));
                            end;
                        end;
                        if format(JsonToken).Contains('author_key') then begin
                            JsonObject2 := JsonToken.AsObject();
                            AATJSONHelper.GetJsonArray(JsonObject2, 'author_key', JsonArrayAuthor);
                            foreach JsonTokenAuthor in JsonArrayAuthor do begin
                                Rec."Author Open Library ID" := Rec."Author Open Library ID" + Format(JsonTokenAuthor) + ',';
                            end;
                        end;
                        Rec.Insert();
                        if format(JsonToken).Contains('cover_i') then begin
                            JsonObject3 := JsonToken.AsObject();
                            JsonToken2 := AATJSONHelper.GetJsonToken(JsonObject3, 'cover_i');
                            CoverOut := Format(JsonToken2);
                            Rec.UpdatePhoto('https://covers.openlibrary.org/b/id/' + CoverOut + '.jpg', '1', '', Author);
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
                        until Rec.Next() = 0;
                end;
            }
        }
    }

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

    var
        "Search Title": Text[1000];
}