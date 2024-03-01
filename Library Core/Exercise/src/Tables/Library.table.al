table 90103 Library
{
    Caption = 'Library';
    DataClassification = ToBeClassified;
    Extensible = true;
    fields
    {
        field(10; "Book ID"; Text[1000])
        {
            // AutoIncrement = true;
            Caption = '';

            // TableRelation = "No. Series";
        }
        field(20; "Title"; Text[50])
        {
            Caption = '';
            NotBlank = true;
        }
        field(30; "Author"; Text[50])
        {
            Caption = '';
            NotBlank = true;
            ObsoleteState = Removed;
        }
        field(40; "Rented"; Boolean)
        {
            Caption = '';
            ObsoleteState = Removed;
        }
        field(120; "Series"; Integer)
        {
            TableRelation = BookSeries."Series ID ";
            Caption = '';
            NotBlank = true;
        }
        field(50; "Genre"; Text[50])
        {
            Caption = '';
            NotBlank = true;
        }
        field(60; "Publisher"; Text[50])
        {
            Caption = '';
            NotBlank = true;
        }
        field(70; "Book Price"; Text[50])
        {
            Caption = '';
            NotBlank = true;
        }
        field(80; "Publication Date"; Date)
        {
            Caption = '';
            NotBlank = true;
        }
        field(90; "Pages"; Integer)
        {
            Caption = '';
            NotBlank = true;
        }
        field(150; "Prequel"; Text[50])
        {
            Caption = '';
            NotBlank = true;
        }
        field(160; "Sequel"; Text[50])
        {
            Caption = '';
            NotBlank = true;
        }
        field(100; "Prequel ID"; Text[1000])
        {
            Caption = '';
            NotBlank = true;
        }
        field(110; "Sequel ID"; Text[1000])
        {
            Caption = '';
            NotBlank = true;
        }

        field(140; "Rented Count"; Integer)
        {
            Caption = '';
            NotBlank = true;
        }

        field(170; "Edit Sequel"; Boolean)
        {
            Caption = '';
            NotBlank = true;
        }

        // field(180; "Status"; Enum Statuses)
        // {
        //     Caption = '';
        //     NotBlank = true;   
        // }
        // field(190; "Grade"; Enum Grades)
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(200; "Grade Justification"; Text[1000])
        {
            Caption = '';
            NotBlank = true;
        }
        field(210; "Rent ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(220; "Display Message"; Boolean)
        {
            Caption = '';
        }
    }
    keys
    {
        key(PK; "Book ID")
        {
            Clustered = true;
        }
        // key(FK; "Series")
        // {
        //    Unique = true; 
        // }
    }


    procedure OpenLibraryPage()
    var
        Library: Page LibraryBookList;
    begin
        Library.Editable(false);
        Library.Run();
    end;

    procedure UpdatePrequelSequel()
    var
        libraryBooks: Record Library;
    begin
        if (Rec."Edit Sequel" = true) then begin
            libraryBooks.SetFilter("Book ID", '=%1', Rec."Prequel ID");
            if libraryBooks.IsEmpty() then
                exit;
            libraryBooks.FindFirst();
            libraryBooks.Sequel := Rec.Title;
            libraryBooks."Sequel ID" := Rec."Book ID";
            libraryBooks.Modify();
        end;
    end;

    procedure LastTwoYearsFilter()
    var
        Today: Date;
        TwoYearsAgo: Date;
        NewField: Text[50];
        Library: Record Library;
    begin
        Today := WorkDate();
        TwoYearsAgo := Today - 730;
        Rec.SetFilter("Publication Date", '>%1', TwoYearsAgo);
    end;

}
