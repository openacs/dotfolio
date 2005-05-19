<?xml version="1.0"?>

<queryset>

  <fullquery name="portfolios">
    <querytext>
      SELECT du.last_name || ', ' || du.first_names AS name,
	  d.owner_id, du.email, d.node_id,
	  site_node__url(d.node_id) AS url,
	  dotfolio__has_p(du.user_id) AS has_dotfolio_p,
	  acs_permission__permission_p(
	      :root_object_id,du.user_id,
	      'admin') AS site_wide_admin_p,
          (SELECT count(*) FROM acs_objects 
              WHERE creation_user = du.user_id
              AND object_type = 'pinds_blog_entry') AS blog_entries
      FROM dotfolio_users du LEFT OUTER JOIN dotfolios d
      ON du.user_id = d.owner_id
      WHERE du.type = 'owner'
      AND du.user_id IN (SELECT member_id FROM group_member_map g,
          dotfolio_group_adviser_map m
	  WHERE m.adviser_id = :user_id and m.group_id = g.group_id)
      [template::list::orderby_clause -orderby -name "portfolios"]
    </querytext>
  </fullquery>
    
</queryset>
