table 90103 BookTransactions
{
    DataClassification = ToBeClassified;
    Caption = 'Book Transactions';

    fields
    {
        field(210; "Rent ID "; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        // field(220;"Status"; Enum Statuses)
        // {
        //     DataClassification = ToBeClassified;

        // }
        field(230; "Date Rented"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

        }
        field(240; "Customer Name"; Text[50])
        {
            TableRelation = Customer;
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(250; "Book ID"; Text[1000])
        {
            TableRelation = Library."Book ID";
            DataClassification = ToBeClassified;
        }
        field(260; "Book Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        // field(90;"Status"; Text[50])
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(270; "Return Date"; Date)
        {
            Caption = '';
            NotBlank = true;
        }
        field(280; "Days Rented"; Integer)
        {
            Caption = '';
            NotBlank = true;
        }
        // field(290; "Grade"; Enum Grades)
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(300; "Grade Justification"; Text[1000])
        {
            Caption = '';
            NotBlank = true;
        }
        field(310; "Display Message"; Boolean)
        {
            Caption = '';
        }
        // field(330; "No. Series"; Code[1000])
        // {
        //     Caption = '';
        //     TableRelation = "No. Series";
        // }
    }

    keys
    {
        key(PK; "Rent ID ")
        {
            Clustered = true;
        }
        //     key(FK; "Customer Name", "Book ID")
        //     {
        //        Unique = true; 
        //     }
    }

    fieldgroups
    {
        // fieldgroup(DropDown;"Book Status")
        // {

        // }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        rentBook2.Run();

    end;

    trigger OnModify()
    begin
        //LibraryBook.Rented := Rec."Book Rented";
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin
    end;

    var
        RentedBook1: Record BookTransactions;
        rentBook2: Page RentBook;

}