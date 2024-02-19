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

                field("Book Author"; Rec."Book Author")
                {
                    Caption = 'Book Author';
                    ApplicationArea = All;
                    TableRelation = Author."Author Name";
                    ToolTip = 'Filters the list of books by author when selected.';
                    trigger OnValidate();
                    begin
                        if "Single Filter Mode" = true then
                        begin
                            Rec.Reset();
                            Rec."Book Genre" := '';
                            "Date" := 0D;
                        end;
                        Rec.SetFilter("Author Filter", '=%1', Rec."Book Author");
                        CurrPage.Update();
                    end;
                }
                field("Book Genre"; Rec."Book Genre")
                {
                    Caption = 'Book Genre';
                    ApplicationArea = All;
                    TableRelation = Genre."Genre Name";
                    ToolTip = 'Filters the list of books by Genre when selected.';
                    trigger OnValidate();
                    begin
                        if "Single Filter Mode" = true then
                        begin
                            Rec.Reset();
                            Rec."Book Author" := '';
                            "Date" := 0D;
                        end;
                        Rec.SetFilter("Genre Filter", '=%1', Rec."Book Genre");
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
                        if "Single Filter Mode" = true then
                        begin
                            Rec.Reset();
                            Rec."Book Author" := '';
                            Rec."Book Genre" := '';
                        end;
                        Rec.SetFilter("Date Filter", '..%1', "Date");
                        CurrPage.Update();
                    end;
                }
                field("Single Filter Mode"; "Single Filter Mode")
                {
                    Caption = 'Single Filter Mode';
                    ApplicationArea = All;
                    ToolTip = 'Clears all previous filters and only keeps present filters.';
                    trigger OnValidate();
                    begin
                        if "Single Filter Mode" = true then
                        begin
                            Rec.Reset();
                            Rec."Book Genre" := '';
                            Rec."Book Author" := '';
                            "Date" := 0D;
                            CurrPage.Update();
                        end; 
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
                    Rec."Book Author" := '';
                    Rec."Book Genre" := '';
                    "Date" := 0D;
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
    var
        Date: Date;
        "Single Filter Mode": Boolean;
}