table 90254 "Library Specification"
{
    DataClassification = ToBeClassified;
    

    fields
    {
        field(90100; "Library Specification ID"; Integer)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(90110; "Total unique books"; Integer)
        {
            Caption = 'Total unique books';
            FieldClass = FlowField;
            CalcFormula = count(Library);
            Editable = false;
        }
        field(90120; "Total new books"; Integer)
        {
            CalcFormula = count(Library where("Book Grade" = Const(A),
                                Author = field("Author Filter"),
                                Genre = field("Genre Filter"),
                                "Date Added" = field("Date Filter")));
            Caption = 'Total new books';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90130; "Total damaged books"; Integer)
        {
            CalcFormula = count(Library where("Book Grade" = Const(D),
                                Author = field("Author Filter"),
                                Genre = field("Genre Filter"),
                                "Date Added" = field("Date Filter")));
            Caption = 'Total damaged books';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90140; "Total rented books"; Integer)
        {
            CalcFormula = count(Library where("Book Status" = Const(Rented),
                                Author = field("Author Filter"),
                                Genre = field("Genre Filter"),
                                "Date Added" = field("Date Filter")));
            Caption = 'Total rented books';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90150; "Total available books"; Integer)
        {
            CalcFormula = count(Library where("Book Status" = Const(Available),
                                Author = field("Author Filter"),
                                Genre = field("Genre Filter"),
                                "Date Added" = field("Date Filter")));
            Caption = 'Total available books';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90160; "Author Filter"; Text[500])
        {
            Caption = 'Author Filter';
            FieldClass = FlowFilter;
        }
        field(90170; "Genre Filter"; Text[500])
        {
            Caption = 'Genre Filter';
            FieldClass = FlowFilter;
        }
        field(90180; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Library Specification ID")
        {
            Clustered = true;
        }
    }
    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

}