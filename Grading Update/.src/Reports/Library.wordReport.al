report 50250 "Library Books"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "Library Books";
    
    dataset
    {
        dataitem(DataItemName; Library)
        {
            column(Author_DataItemName; Author)
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

}