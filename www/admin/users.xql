<?xml version="1.0"?>

<queryset>

    <fullquery name="select_dotfolio_roles">
        <querytext>
            SELECT dotfolio_user_types.type, 
                dotfolio_user_types.pretty_name || ' (' || 
                    (SELECT count(*) FROM dotfolio_users
                     WHERE dotfolio_users.type = dotfolio_user_types.type) ||
                ')', ''
                FROM dotfolio_user_types
                ORDER BY dotfolio_user_types.pretty_name
        </querytext>
    </fullquery>

</queryset>
