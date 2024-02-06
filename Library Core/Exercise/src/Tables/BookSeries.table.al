table 90101 BookSeries
{
    DataClassification = ToBeClassified;
    Caption = 'Book Series';

    fields
    {
        field(410; "Series ID "; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            // TableRelation = "No. Series";
        }
        field(420; "Series Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        //  field(430; "No. Series"; Code[1000])
        // {
        //     Caption = '';
        //     TableRelation = "No. Series";
        // }
    }

    keys
    {
        key(PK; "Series ID ")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}