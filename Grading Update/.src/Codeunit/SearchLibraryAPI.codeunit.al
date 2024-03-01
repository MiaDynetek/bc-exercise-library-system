codeunit 90252 "Search Library API"
{
    procedure AddTempBooks(Rec: Text): List of [Text]
    var
        AATJSONHelper: Codeunit "AAT JSON Helper";
        JsonArray: JsonArray;
        JsonObject: JsonObject;
        JsonObject2: JsonObject;
        JsonToken: JsonToken;
        JsonTokenID: JsonToken;
        LibraryBooksTemp1: Record "Library Books Temp";
        LibraryBooksTemp: Page "Library Books Temp";
        BookData: List of [Text];
        BookID: Text[500];
        Description: Text;
        Created: Text;
        Title: Text;
        SpecificBookData: Text;
    begin
        if Rec = '' then begin
            Message('Please enter a book title.');
        end;
        if Rec <> '' then begin
            AATJSONHelper.InitializeJsonObjectFromText(GetSearchedBooks(Rec));
            JsonObject := AATJSONHelper.GetJsonObject();
            AATJSONHelper.GetJsonArray(JsonObject, 'docs', JsonArray);
            foreach JsonToken in JsonArray do begin
                if format(JsonToken).Contains('key') then begin
                    JsonObject2 := JsonToken.AsObject();
                    JsonObject2.Get('key', JsonTokenID);
                    BookID := DelChr(Format(JsonTokenID), '=', '/works/');
                    Message(BookID);
                    SpecificBookData := GetSpecificBookData(BookID);
                    Description := GetBookDescription(BookID, SpecificBookData);
                    Created := GetBookCreated(BookID, SpecificBookData);
                    Title := GetBookTitle(BookID, SpecificBookData);
                    BookData.Add(BookID + '-"Desc"-' + Description + '-"Created"-' + Created + '-"Title"-' + Title);
                end;
            end;
            exit(BookData);
        end;
    end;

    local procedure GetSpecificBookData(BookID: Text[500]): Text
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        PureBookID: List of [Text];
    begin
        PureBookID := BookID.Split('"');
        AATRestHelper.LoadAPIConfig('00000001');
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + '/books/' + PureBookID.Get(2));
        AATRestHelper.AddBasicAuthHeader();
        AATRestHelper.AddRequestHeader('accept', 'application/json');
        if not AATRestHelper.Send() then begin
            if AATRestHelper.IsTransmitIssue() then
                Error('Failed to send Request. Check URL and try again.');

            DisplayAPIFailureMessage(AATRestHelper);
        end;

        Exit(AATRestHelper.GetResponseContentAsText());
    end;

    local procedure GetBookDescription(BookID: Text[500]; GetSpecificBookData: Text): Text
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
            end;
        end else begin
            Exit(Format('N/A'));
        end;
    end;

    local procedure GetBookCreated(BookID: Text[500]; GetSpecificBookData: Text): Text
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

    local procedure GetBookTitle(BookID: Text[500]; GetSpecificBookData: Text): Text
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


    local procedure AddBooksToTempTable(Title: Text): Record "Library Books Temp"
    var
        LibraryBooksTemp: Record "Library Books Temp";
    begin
        LibraryBooksTemp.Init();
        LibraryBooksTemp.Validate(Title, Title);
        LibraryBooksTemp.Insert();
        exit(LibraryBooksTemp);
    end;

    local procedure GetSearchedBooks(Rec: Text): Text
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        SearchTitle: Text;
    begin
        SearchTitle := ConvertStr(Rec, ' ', '+');
        AATRestHelper.LoadAPIConfig('00000001');
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + '/search.json?q=' + SearchTitle + '&limit=2');
        AATRestHelper.AddBasicAuthHeader();

        if not AATRestHelper.Send() then begin
            if AATRestHelper.IsTransmitIssue() then
                Error('Failed to send Request. Check URL and try again.');

            DisplayAPIFailureMessage(AATRestHelper);
        end;

        Exit(Format(AATRestHelper.GetResponseContentAsText()));

    end;

    procedure GetAuthorDetails(AuthorKey: Text): Text
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        PureBookID: List of [Text];
    begin
        PureBookID := AuthorKey.Split('"');
        AATRestHelper.LoadAPIConfig('00000001');
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + '/authors/' + PureBookID.Get(2) + '/works.json');
        Message(AATRestHelper.GetAPIConfigBaseEndpoint() + '/authors/' + PureBookID.Get(2) + '/works.json');
        AATRestHelper.AddBasicAuthHeader();
        AATRestHelper.AddRequestHeader('accept', 'application/json');
        if not AATRestHelper.Send() then begin
            if AATRestHelper.IsTransmitIssue() then
                Error('Failed to send Request. Check URL and try again.');

            DisplayAPIFailureMessage(AATRestHelper);
        end;

        Exit(AATRestHelper.GetResponseContentAsText());
    end;

    local procedure DisplayAPIFailureMessage(var AATRestHelper: Codeunit "AAT REST Helper")
    var
        ErrorBreakDownLbl: Label 'Code: %1\Message: %2\Reason: %3', Comment = '%1=Error Code, %2 = Err Message %3 = Err. Reason';
    begin
        Error(
        StrSubstNo(
        ErrorBreakDownLbl,
        AATRestHelper.GetHttpStatusCode(),
        AATRestHelper.GetResponseContentAsText(),
        AATRestHelper.GetResponseReasonPhrase()
        )
        );
    end;

    var
        globalVar: Text;
}