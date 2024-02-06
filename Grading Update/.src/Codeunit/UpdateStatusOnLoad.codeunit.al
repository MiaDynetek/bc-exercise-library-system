codeunit 90250 UpdateBookStatusOnLoad
{
    trigger OnRun()
    var
        GradeAndStatusSetup: Record "Grade and Status Setup";
        Librarybooks: Record Library; 
    begin
        if Librarybooks.IsEmpty() then
        exit;
        if Librarybooks.FindSet() then
            repeat
                //Checking if the current book status is not set to pending grading or archived, this will ensure that records with these statuses are not updated.
                if (Librarybooks."Book Status" <> enum::BookStatus::"Pending Grading") and (Librarybooks."Book Status" <> enum::BookStatus::"In Poor Condition") then begin

                    // if (Librarybooks."Book Grade" = enum::BookGrade::D) and (Librarybooks."Book Status" <> enum::BookStatus::"Out for repair") then begin
                    //     UpdateStatus(Librarybooks, BookStatus::"Out for repair");
                    // end;55

                ValidateStatusOverdue(Librarybooks);                
                    
        if (Librarybooks."Rented Count" = 0) and (Librarybooks."Book Grade" <> enum::BookGrade::D) and (Librarybooks."Book Status" <> enum::BookStatus::Available) then begin
            //Update book status
            UpdateStatus(Librarybooks, BookStatus::Available);
        end;

        Clear(GradeAndStatusSetup);
        GradeAndStatusSetup.SetRange(BookGrade, Librarybooks."Book Grade");
        if GradeAndStatusSetup.FindFirst() then
        begin
            if GradeAndStatusSetup.BookStatus = enum::BookStatus::" " then
            GradeAndStatusSetup.FieldError(BookStatus);

            UpdateStatus(Librarybooks, GradeAndStatusSetup.BookStatus);
        end;

        // if GradeAndStatusSetup.FindSet() then
        // repeat
        //     if Librarybooks."Book Grade" = GradeAndStatusSetup.BookGrade then
        //     begin
        //         UpdateStatus(Librarybooks, GradeAndStatusSetup.BookStatus);
        //     end;
        // until GradeAndStatusSetup.Next() = 0;
    end;
    until Librarybooks.Next() = 0;
    
    end;

    local procedure ValidateStatusOverdue(LibraryBooks: Record Library)
    var
        BookTransactions: Record BookTransactions;
    begin
        if ((Librarybooks."Book Grade" = enum::BookGrade::D) or (BookTransactions.IsEmpty())) then
        exit;
        BookTransactions.SetRange("Book ID", Librarybooks."Book ID");
        //Check if there are any previous book records. If not, the book status will be updated to available.
        BookTransactions.SetCurrentKey("Date Rented");
        BookTransactions.Ascending();
        if BookTransactions.FindFirst() then begin
        if not ((BookTransactions."Return Date" < Today()) or (BookTransactions."Book Status" = enum::BookStatus::Rented)) then 
        exit;
        if not (BookTransactions."Return Date" <> 0D) and (Librarybooks."Book Status" <> enum::BookStatus::Overdue) then
        exit;
            UpdateStatus(Librarybooks, BookStatus::Overdue);
        end;
        if (BookTransactions.Count() = 0) and (Librarybooks."Book Status" <> enum::BookStatus::Available) then begin
            //Update book status
            UpdateStatus(Librarybooks, BookStatus::Available);
        end;
    end;

    local procedure UpdateStatus(LibraryBooks: Record Library; NewStatus: enum BookStatus)
    begin
        //Update book status
        Librarybooks.Validate("Book Status", NewStatus);
        Librarybooks.Modify();
        //Add Log to show status history.
        Librarybooks.AddLogCodeunit(NewStatus, Librarybooks);
    end;
}