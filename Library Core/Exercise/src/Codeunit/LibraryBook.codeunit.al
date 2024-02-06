codeunit 90100 LibarayBookMgmt
{
    trigger OnRun()
    var
        flag: Boolean;
        bookListLength: Integer;
        i: Integer;
        j: Integer;
        temp: Integer;
        temp1: Text[50];
        rentedAmount: List of [Integer];
        bookName: List of [Text[50]];
        books: Record Library;
        popupMessage: Text[500];
        counter: Integer;
        addRecordsCount: Integer;
        last3: Integer;
        last2: Integer;
        last1: Integer;
        tempVal1: Integer;
        testMessage: Text[1000];
        book1: Text[1000];
        book2: Text[1000];
        book3: Text[1000];
    begin
        if books.FindSet() then
            repeat

                if books."Rented Count" <> 0 then begin
                    rentedAmount.Add(books."Rented Count");
                    bookName.Add(books.Title);
                end;

            until books.Next() = 0;
        bookListLength := rentedAmount.Count();

        for i := 1 to bookListLength - 1 do begin
            flag := false;
            for j := 1 to bookListLength - 1 do begin
                tempVal1 := j + 1;
                if rentedAmount.Get(j) > rentedAmount.Get(j + 1) then begin

                    temp := rentedAmount.Get(j + 1);
                    rentedAmount.Set(j + 1, rentedAmount.Get(j));
                    rentedAmount.Set(j, temp);
                    // popupMessage := popupMessage + Format(rentedAmount.Get(j));

                    temp1 := bookName.Get(j + 1);
                    bookName.Set(j + 1, bookName.Get(j));
                    bookName.Set(j, temp1);

                    flag := true;

                end;
            end;

        end;
        //popupMessage := 'Top three most rented books: \';

        if bookListLength <> 0 then begin
            if bookListLength >= 3 then begin
                last3 := bookListLength - 2;
                book3 := Format(bookName.Get(last3));
            end;
            if bookListLength >= 2 then begin
                last2 := bookListLength - 1;
                book2 := Format(bookName.Get(last2));
            end;
            last1 := bookListLength;
            book1 := Format(bookName.Get(last1));
            popupMessage := 'Top three most rented books: \' + book1 + ' \ ' + book2 + ' \ ' + book3;
        end;
        if bookListLength = 0 then begin
            popupMessage := 'No books have been rented.';
        end;

        Message(popupMessage);
    end;


}