page 90260 "Library Specifications Dash"
{
    Caption = 'Library Specifications Dash';
    PageType = Card;
    ApplicationArea = All;
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    SourceTable = "Library Specification";

    layout
    {
        area(Content)
        {
            group("Library Filters")
            {

                field("Book Author"; "Book Author")
                {
                    Caption = 'Book Author';
                    ApplicationArea = All;
                    TableRelation = Author."Author Name";
                    ToolTip = 'Filters the list of books by author when selected.';
                    trigger OnValidate();
                    begin
                        Rec.SetFilter("Author Filter", '=%1', "Book Author");
                        CurrPage.Update();
                    end;
                }
                field("Book Genre"; "Book Genre")
                {
                    Caption = 'Book Genre';
                    ApplicationArea = All;
                    TableRelation = Genre."Genre Name";
                    ToolTip = 'Filters the list of books by Genre when selected.';
                    trigger OnValidate();
                    begin
                        Rec.SetFilter("Genre Filter", '=%1', "Book Genre");
                        CurrPage.Update();
                    end;
                }
                field("Date"; Date)
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                    ToolTip = 'Filters the list of books to display books added before the selected date.';
                    trigger OnValidate();
                    begin
                        Rec.SetFilter("Date Filter", '..%1', "Date");
                        CurrPage.Update();
                    end;
                }
            }
            group("Library Totals")
            {

                field("Total available books"; Rec."Total available books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total available books field.';
                }
                field("Total damaged books"; Rec."Total damaged books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total damaged books field.';
                }
                field("Total new books"; Rec."Total new books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total new books field.';
                }
                field("Total rented books"; Rec."Total rented books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total rented books field.';
                }
                field("Total unique books"; Rec."Total unique books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total unique books field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Reset Filters")
            {
                Caption = 'Reset Filters';
                ApplicationArea = All;
                Image = Cancel;

                trigger OnAction()
                begin
                    Rec.Reset();
                    "Book Author" := '';
                    "Book Genre" := '';
                    "Date" := CalcDate('<CM+1M>');
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
    var
        "Book Author": Text[500];
        "Book Genre": Text[500];
        Date: Date;
}