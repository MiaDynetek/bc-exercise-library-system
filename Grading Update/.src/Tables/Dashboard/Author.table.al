table 90250 "Author"
{
    Caption = 'Author';
    // DataCaptionFields = "Author Name", "Auther ID";
    LookupPageId = Authors;
    DrillDownPageId = Authors;

    fields
    {

        field(10; "Author Name"; Text[500])
        {
            Caption = 'Auther Name';
            DataClassification = ToBeClassified;
        }
        field(20; "Open Library ID"; Text[500])
        {
            Caption = 'Open Library ID';
            DataClassification = ToBeClassified;
        }
        field(30; "Birth Date"; Text[500])
        {
            Caption = 'Birth Date';
            DataClassification = ToBeClassified;
        }
        field(40; "Death Date"; Text[500])
        {
            Caption = 'Death Date';
            DataClassification = ToBeClassified;
        }
        field(50; "Bio"; Text[2048])
        {
            Caption = 'Bio';
            DataClassification = ToBeClassified;
        }
        field(60; "Personal Name"; Text[500])
        {
            Caption = 'Personal Name';
            DataClassification = ToBeClassified;
        }
        field(70; "Work Count"; Text[500])
        {
            Caption = 'Work Count';
            DataClassification = ToBeClassified;
        }
        field(80; "Top Work"; Text[500])
        {
            Caption = 'Top Work';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Author Name")
        {
            Clustered = true;
        }
    }

}