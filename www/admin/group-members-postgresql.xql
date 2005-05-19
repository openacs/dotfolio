<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.4</version></rdbms>

  <fullquery name="group_name">
    <querytext>
      SELECT group_name
          FROM groups
          WHERE group_id = :group_id
    </querytext>
  </fullquery>

  <fullquery name="group_members">
    <querytext>
      SELECT d.last_name || ', ' || d.first_names AS name,
          pretty_type, d.user_id
          FROM dotfolio_users d, group_member_map g
          WHERE g.group_id = :group_id AND g.member_id = d.user_id
	  ORDER BY name ASC
    </querytext>
  </fullquery>

  <fullquery name="non_group_members">
    <querytext>
      SELECT d.last_name || ', ' || d.first_names AS name,
          pretty_type, d.user_id
	  FROM dotfolio_users d LEFT OUTER JOIN group_member_map g
	  ON g.member_id = d.user_id
	  WHERE g.member_id NOT IN (SELECT member_id
	      FROM group_member_map WHERE group_id = :group_id)
	  GROUP BY d.user_id, d.last_name, d.first_names, pretty_type
    </querytext>
  </fullquery>

</queryset>
