<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.1</version></rdbms>

  <fullquery name="select_dotfolio_users">
    <querytext>
      SELECT dotfolio_users.user_id,
          dotfolio_users.username,
          dotfolio_users.first_names,
	  dotfolio_users.last_name,
	  dotfolio_users.email,
	  dotfolios.node_id,
	  site_node__url(dotfolios.node_id) as url,
	  dotfolio__has_p(dotfolio_users.user_id) as has_dotfolio_p,
	  acs_permission__permission_p(:root_object_id,dotfolio_users.user_id, 'admin') as site_wide_admin_p
      FROM dotfolio_users LEFT OUTER JOIN dotfolios
      ON dotfolio_users.user_id = dotfolios.owner_id
      WHERE dotfolio_users.type = :type
      ORDER BY dotfolio_users.last_name
      </querytext>
  </fullquery>

</queryset>