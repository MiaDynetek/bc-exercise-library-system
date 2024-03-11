codeunit 90250 "Library Books API"
{
    procedure AddNewAPIBooks(LibraryBooksTemp: Record Library temporary)
    var
        Library: Record Library;
        Library1: Record Library;
        ReturnMsg: Text;
        AuthBirthDate: Text;
        AuthDeathDate: Text;
        AuthBio: Text;
        AuthPersonalName: Text;
        AuthName: Text;
        AuthorData: Text;
        ReturnSearchedBooks: Codeunit "Return Searched Books";
        Authors: List of [Text];
        AuthorKey: Text;
        Author: Record Author;
        Author1: Record Author;
        Counter: Integer;
        ImageInStream: InStream;
        CalculateCurrentAge: Integer;
        CurrDate: Date;
    begin
        // if LibraryBooksTemp.FindSet() then
        //     repeat
        Library.SetFilter(Title, '=%1', LibraryBooksTemp."Book Title");
        if Library.FindFirst() = false then begin

            Library1.Init();
            Library1.Validate("Book ID", Library1.NextNumberSeries());
            Library1.Validate(Title, LibraryBooksTemp."Book Title");
            Library1.Validate(Created, LibraryBooksTemp.Created);
            Library1.Validate(Description, LibraryBooksTemp.Description);
            Library1.Validate("Book Status", BookStatus::Available);
            Library1.Validate("Date Added", WorkDate());

            Authors := LibraryBooksTemp."Author Open Library ID".Split(',');
            foreach AuthorKey in Authors do begin
                Counter := Counter + 1;
                if AuthorKey <> '' then begin
                    AuthorData := ReturnSearchedBooks.GetAuthorDetails(Library.RemoveAllQuotes(AuthorKey));
                    AuthName := Library.GetAuthorDataItem(AuthorData, 'name');
                    Author.SetFilter("Author Name", '=%1', AuthName);
                    if Author.FindFirst() = false then begin
                        AuthBirthDate := Library.GetAuthorDataItem(AuthorData, 'birth_date');
                        AuthDeathDate := Library.GetAuthorDataItem(AuthorData, 'death_date');
                        AuthBio := Library.GetAuthorDataItem(AuthorData, 'bio');
                        AuthPersonalName := Library.GetAuthorDataItem(AuthorData, 'personal_name');
                        Author1.Init();
                        if Evaluate(CurrDate, ConvertMonthToInt(AuthBirthDate)) then begin
                            CalculateCurrentAge := Abs(WorkDate() - CurrDate);
                            Author1.Validate("Current Age", Format(CalculateCurrentAge));
                        end;
                        Author1.Validate("Open Library ID", Library.RemoveAllQuotes(AuthorKey));
                        Author1.Validate("Author Name", Library.RemoveAllQuotes(AuthName));
                        Author1.Validate("Birth Date", Library.RemoveAllQuotes(AuthBirthDate));
                        Author1.Validate("Death Date", Library.RemoveAllQuotes(AuthDeathDate));
                        Author1.Validate(Bio, Library.RemoveAllQuotes(AuthBio));
                        Author1.Validate("Personal Name", Library.RemoveAllQuotes(AuthPersonalName));
                        Author1.Insert();
                        Library.UpdatePhoto('', '2', AuthorData, Author1);
                        if Counter = 1 then begin
                            Library1."Book Author" += Author1."Author Name";
                        end else begin
                            Library1."Book Author" += '|' + Author1."Author Name";
                        end;
                    end;
                end;
            end;
            Library1.Insert();
        end;

        //until LibraryBooksTemp.Next() = 0;
    end;
    local procedure ConvertMonthToInt(Date: Text): Text
    var
        DateSections: List of [Text];
        Month: Text;
    begin
        if Date.Contains(' ') = false then
        exit;
        DateSections := Date.Split(' ');
        if DateSections.Get(2).Contains('Jan') then begin
            Month := '01';
        end;
        if DateSections.Get(2).Contains('Feb') then begin
            Month := '02';
        end;
        if DateSections.Get(2).Contains('Mar') then begin
            Month := '03';
        end;
        if DateSections.Get(2).Contains('Apr') then begin
            Month := '04';
        end;
        if DateSections.Get(2).Contains('May') then begin
            Month := '05';
        end;
        if DateSections.Get(2).Contains('Jun') then begin
            Month := '06';
        end;
        if DateSections.Get(2).Contains('Jul') then begin
            Month := '07';
        end;
        if DateSections.Get(2).Contains('Aug') then begin
            Month := '08';
        end;
        if DateSections.Get(2).Contains('Sep') then begin
            Month := '09';
        end;
        if DateSections.Get(2).Contains('Oct') then begin
            Month := '10';
        end;
        if DateSections.Get(2).Contains('Nov') then begin
            Month := '11';
        end;
        if DateSections.Get(2).Contains('Dec') then begin
            Month := '12';
        end;
        exit(DateSections.Get(1) + Month + DateSections.Get(3));
    end;

}