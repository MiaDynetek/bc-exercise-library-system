report 90250 "Library Books"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "Library Books";

    dataset
    {
        dataitem(DataItemName; Library)
        {

            column(Author_DataItemName; "Book Author")
            {
            }
            column(BookGrade_DataItemName; "Book Grade")
            {
            }
            column(BookGradeJustification_DataItemName; "Book Grade Justification")
            {
            }
            column(BookStatus_DataItemName; "Book Status")
            {
            }
            column(Genre_DataItemName; Genre)
            {
            }
            column(Title_DataItemName; Title)
            {
            }

        }
    }

    rendering
    {

        layout("Library Books")
        {
            Type = Word;
            LayoutFile = 'LibraryBooks.docx';
        }
    }
    labels
    {
        lblTitle = 'Title', Comment = 'Title', MaxLength = 999, Locked = true;
        lblGrade = 'Grade', Comment = 'Grade', MaxLength = 999, Locked = true;
        lblStatus = 'Status', Comment = 'Status', MaxLength = 999, Locked = true;
    }
}