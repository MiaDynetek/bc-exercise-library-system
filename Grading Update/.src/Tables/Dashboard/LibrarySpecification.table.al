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
        field(90190; "Book Author"; Text[500])
        {
            Caption = 'Book Author';
            TableRelation = Author."Author Name";
        }
        field(90200; "Book Genre"; Text[500])
        {
            Caption = 'Book Genre';
            TableRelation = Genre."Genre Name";
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

    // procedure ApplyFilters("Single Filter Mode": Boolean; Type: Integer)
    // begin
    //     if Type = 1 then
    //     begin
    //         if "Single Filter Mode" = true then
    //             Rec.Reset();
    //                 "Book Genre" := '';
    //                 "Date" := CalcDate('<CM+1M>');
    //         Rec.SetFilter("Author Filter", '=%1', "Book Author");
    //     end;
    //     if Type = 2 then
    //     begin
            
    //     end;
    //     if Type = 3 then
    //     begin
            
    //     end;
    // end;


}