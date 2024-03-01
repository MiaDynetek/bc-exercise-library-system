page 90258 "Library Role"
{

    PageType = RoleCenter;
    Caption = 'Library Role';

    layout
    {
        area(RoleCenter)
        {
            group(Group1)
            {
                part(part1; "Book Analysis")
                {
                    ApplicationArea = All;
                }
            }
           
        }
    }
}

profile LibraryAdmin
{
    ProfileDescription = 'Library Admin';
    RoleCenter = "Library Role";
    Caption = 'Library Admin';
}

