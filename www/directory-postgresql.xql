<?xml version="1.0"?>

<queryset>

  <fullquery name="portfolios">
    <querytext>
      SELECT du.last_name || ', ' || du.first_names AS name,
	  d.owner_id, du.email, d.node_id,
	  site_node__url(d.node_id) AS url
      FROM dotfolio_users du LEFT OUTER JOIN dotfolios d
      ON du.user_id = d.owner_id
      WHERE dotfolio__has_p(du.user_id) = 't' AND
          upper(substr(du.last_name, 1, 1)) = :section
    </querytext>
  </fullquery>

  <fullquery name="portfolios_other">
    <querytext>
      SELECT du.last_name || ', ' || du.first_names AS name,
	  d.owner_id, du.email, d.node_id,
	  site_node__url(d.node_id) AS url
      FROM dotfolio_users du LEFT OUTER JOIN dotfolios d
      ON du.user_id = d.owner_id
      WHERE dotfolio__has_p(du.user_id) = 't' AND
          upper(substr(du.last_name, 1, 1)) NOT IN ('[join $dimension_list "\', \'"]')
    </querytext>
  </fullquery>

  <fullquery name="portfolios_all">
    <querytext>
      SELECT du.last_name || ', ' || du.first_names AS name,
	  d.owner_id, du.email, d.node_id,
	  site_node__url(d.node_id) AS url
      FROM dotfolio_users du LEFT OUTER JOIN dotfolios d
      ON du.user_id = d.owner_id
      WHERE dotfolio__has_p(du.user_id) = 't'
	ORDER BY lower(du.last_name) asc
    </querytext>
  </fullquery>
    
</queryset>
