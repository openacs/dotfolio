<?xml version="1.0"?>
<queryset>
  <rdbms><type>postgresql</type><version>7.1</version></rdbms>

  <fullquery name="dotfolio::user::get_owner_id.select_owner_id">
    <querytext>
      SELECT owner_id FROM dotfolios WHERE node_id = :node_id
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::user::get_owner_username.select_username">
    <querytext>
      SELECT username FROM users WHERE user_id = :owner_id
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::user::portrait_p.select_portrait">
    <querytext>
      SELECT live_revision as revision_id, item_id
          FROM acs_rels a, cr_items c
	  WHERE a.object_id_two = c.item_id
	  AND a.object_id_one = :owner_id
	  AND a.rel_type = 'user_portrait_rel'
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::user::html_list_of_advisers.select_advisers">
    <querytext>
      SELECT last_name || ', ' || first_names AS adviser_name,
          user_id AS adviser_id
	  FROM dotfolio_users WHERE type = 'adviser'
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::user::adviser_p.adviser_p">
    <querytext>
      SELECT dotfolio__adviser_p (:user_id)
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::user::dotfolio_url.dotfolio_url">
    <querytext>
      SELECT site_node__url(d.node_id) AS url
          FROM dotfolio_users du LEFT OUTER JOIN dotfolios d
	  ON du.user_id = d.owner_id
	      WHERE du.type = 'owner' AND du.user_id = :user_id
    </querytext>
  </fullquery>

</queryset>
