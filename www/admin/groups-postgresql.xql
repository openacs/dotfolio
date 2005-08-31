<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.4</version></rdbms>

  <fullquery name="select_groups">
    <querytext>
      SELECT groups.group_name,
	dotfolio_users.last_name || ', ' ||
	  dotfolio_users.first_names AS adviser, groups.group_id
        FROM groups, dotfolio_group_adviser_map, dotfolio_users
	WHERE groups.group_id = dotfolio_group_adviser_map.group_id
	AND dotfolio_group_adviser_map.adviser_id = dotfolio_users.user_id
        ORDER BY groups.group_id ASC
    </querytext>
  </fullquery>

</queryset>
