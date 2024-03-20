codeunit 90251 "Return Searched Books"
{
    procedure GetSearchedBooks(Rec: Text): Text
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        SearchTitle: Text;
    begin
        SearchTitle := ConvertStr(Rec, ' ', '+');
        AATRestHelper.LoadAPIConfig('T00001');
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + '/search.json?q=' + SearchTitle + '&limit=2');
        AATRestHelper.AddBasicAuthHeader();

        if not AATRestHelper.Send() then begin
            if AATRestHelper.IsTransmitIssue() then
                Error('Failed to send Request. Check URL and try again.');

            DisplayAPIFailureMessage(AATRestHelper);
        end;

        Exit(Format(AATRestHelper.GetResponseContentAsText()));

    end;

    procedure DisplayAPIFailureMessage(var AATRestHelper: Codeunit "AAT REST Helper")
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

    procedure GetSpecificBookData(BookID: Text[500]): Text
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        PureBookID: List of [Text];
    begin
        PureBookID := BookID.Split('"');
        AATRestHelper.LoadAPIConfig('T00001');
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

    procedure GetAuthorDetails(AuthorKey: Text): Text
    var
        AATRestHelper: Codeunit "AAT REST Helper";
    begin
        AATRestHelper.LoadAPIConfig('T00001');
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + '/authors/' + AuthorKey + '.json');
        AATRestHelper.AddBasicAuthHeader();
        AATRestHelper.AddRequestHeader('accept', 'application/json');
        if not AATRestHelper.Send() then begin
            if AATRestHelper.IsTransmitIssue() then
                Error('Failed to send Request. Check URL and try again.');

            DisplayAPIFailureMessage(AATRestHelper);
        end;

        Exit(AATRestHelper.GetResponseContentAsText());
    end;
// local procedure UpdateBookandUserImages()
// var
//         AATRestHelper: Codeunit "AAT REST Helper";
//     begin
//         AATRestHelper.LoadAPIConfig('T00001');
//         AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + '/authors/' + AuthorKey + '.json');
//         AATRestHelper.AddBasicAuthHeader();
//         AATRestHelper.AddRequestHeader('accept', 'application/json');
//         if not AATRestHelper.Send() then begin
//             if AATRestHelper.IsTransmitIssue() then
//                 Error('Failed to send Request. Check URL and try again.');

//             DisplayAPIFailureMessage(AATRestHelper);
//         end;

//         Exit(AATRestHelper.GetResponseContentAsText());
//     end;

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
        Library: Record library;
    begin
        HttpRequestMessage.Method := 'GET';
        if Type = '1' then begin
            HttpRequestMessage.SetRequestUri(RequestURL);
        end;
        if Type = '2' then begin
            if AuthorReturnData.Contains('photos') = false then
                exit;
            ImageURL := Library.GetAuthorPhotoURL(AuthorReturnData);
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
            Library."Book Cover".ImportStream(ResponseImg, 'Cover');
            Library.Modify(true);
        end;
        if Type = '2' then begin
            CurrentAuthor."Picture".ImportStream(ResponseImg, 'Picture');
            CurrentAuthor.Modify(true);
        end;
    end;
}