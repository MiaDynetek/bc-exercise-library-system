page 90104 LibraryRoleCenter
{

    PageType = RoleCenter;
    Caption = 'Library Role Center';

    layout
    {
        area(RoleCenter)
        {
            group(Group1)
            {
                Caption = 'Book Analysis';
                part(part1; "Open Library")
                {
                    ApplicationArea = All;
                }
            }
           
        }
    }
}

profile MyProfile
{
    ProfileDescription = 'Library Profile';
    RoleCenter = LibraryRoleCenter;
    Caption = 'Library Profile';
}

