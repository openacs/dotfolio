<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.4</version></rdbms>

  <fullquery name="delete_group">
    <querytext>
      DELETE FROM dotfolio_group_adviser_map WHERE group_id = :group_id
    </querytext>
  </fullquery>

  <fullquery name="get_member_names">
    <querytext>
      select u.first_names || ' ' || u.last_name || ' (' || u.email || ')' as member_name
      from dotfolio_groups g, 
           group_member_map m,
           cc_users u
      where g.group_id = m.group_id
            and g.group_id = :group_id
            and m.member_id = u.user_id
    </querytext>
  </fullquery>

</queryset>
