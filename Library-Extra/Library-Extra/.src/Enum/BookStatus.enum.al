enum 90251 BookStatus
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Rented")
    {
        Caption = 'Rented';
    }
    value(2; "Available")
    {
        Caption = 'Available';
    }
    value(3; "Overdue")
    {
        Caption = 'Overdue';
    }
    value(4; "Out for repair")
    {
        Caption = 'Out for repair';
    }
    value(5; "Pending Grading")
    {
        Caption = 'Pending Grading';
    }
    value(6; "In Poor Condition")
    {
        Caption = 'In Poor Condition';
    }
}