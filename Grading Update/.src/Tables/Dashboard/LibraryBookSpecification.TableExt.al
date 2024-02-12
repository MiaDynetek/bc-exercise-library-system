// tableextension 90258 "Library Book Specification " extends Library
// {
//     Caption = 'Library Specification';
//     DataClassification = ToBeClassified;
//     Extensible = true;
//     LookupPageId = LibraryBookList;
//     DrillDownPageId = LibraryBookList;
    
//     fields
//     {
//         field(90010;"Library Dash"; Integer)
//         {
//             Caption = 'Library Dash';
//             DataClassification = ToBeClassified;
//             AutoIncrement = true;
//         }
//         field(90020;"Author"; Code[20])
//         {
//             Caption = 'Author';
//             DataClassification = ToBeClassified;
//             TableRelation = Author;
            
//         }
//         field(90030;"Genre"; Text[100])
//         {
//             Caption = 'Genre';
//             DataClassification = ToBeClassified;
//         }
//         field(90050;"Date"; Date)
//         {
//             Caption = 'Date';
//             DataClassification = ToBeClassified;
//         }
//         field(90060;"Total unique books"; Integer)
//         {
//             Caption = 'Total unique books';
//             FieldClass = FlowField;
//             CalcFormula = count(Library WHERE(Title = filter('<>''''')));
//             Editable = false;
//         }
//         // field(90070; "Total unique books Filter"; Text[50])
//         // {
//         //     Caption = 'Total unique books Filter';
//         //     FieldClass = FlowFilter;
//         // }
//         field(90080;"Total new books"; Integer)
//         {
//             AutoFormatType = 1;
//             CalcFormula = count(Library where("Book Grade" = filter('=''A''')));
//             Caption = 'Total new books';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         // fieSld(90090; "Total new books Filter"; Enum)
//         // {
//         //     Caption = 'Total new books Filter';
//         //     FieldClass = FlowFilter;
//         // }
//         field(90100;"Total damaged books"; Integer)
//         {
//             AutoFormatType = 1;
//             CalcFormula = count(Library where("Book Grade" = filter('=''D''')));
//             Caption = 'Total damaged books';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         // field(90200; "Total damaged books Filter"; Text[200])
//         // {
//         //     Caption = 'Total damaged books Filter';
//         //     FieldClass = FlowFilter;
//         // }
//         field(90300;"Total rented books"; Integer)
//         {
//             AutoFormatType = 1;
//             CalcFormula = count(Library where("Book Status" = filter('=''Rented''')));
//             Caption = 'Total rented books';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         // field(90400; "Total rented books Filter"; Text[200])
//         // {
//         //     Caption = 'Total rented books Filter';
//         //     FieldClass = FlowFilter;
//         // }
//         field(90500;"Total available books"; Integer)
//         {
//             AutoFormatType = 1;

//             CalcFormula = count(Library where("Book Status" = filter('=''Available''')));
//             Caption = 'Total available books';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         // field(90600; "Total available books Filter"; Text[200])
//         // {
//         //     Caption = 'Total available books Filter';
//         //     FieldClass = FlowFilter;
//         // }
//         field(90700;"Recently added books"; Integer)
//         {
//             AutoFormatType = 1;
//             CalcFormula = count(Library where("Date Added" = field("Recently added books Filter")));
//             Caption = 'Recently added books';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(90800; "Recently added books Filter"; Date)
//         {
//             Caption = 'Recently added books Filter';
//             FieldClass = FlowFilter;
//         }
//     }
    
//     keys
//     {
//         key(PK; "Library Dash")
//         {
//             Clustered = true;
//         }
//     }
//      var
//         RecordHasBeenRead: Boolean;

//     procedure GetRecordOnce()
//     begin
//         if RecordHasBeenRead then
//             exit;
//         Get();
//         RecordHasBeenRead := true;
//     end;

//     procedure InsertIfNotExists()
//     begin
//         Reset();
//         if not Get() then begin
//             Init();
//             Insert(true);
//         end;
//     end;
// }