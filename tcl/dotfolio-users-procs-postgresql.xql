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

</queryset>