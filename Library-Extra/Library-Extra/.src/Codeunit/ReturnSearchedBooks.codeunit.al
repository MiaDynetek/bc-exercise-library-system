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

}