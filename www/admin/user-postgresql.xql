<?xml version="1.0"?>

<queryset>

  <fullquery name="select_user_info">      
    <querytext>
      SELECT first_names,
          last_name,
	  email,
	  screen_name,
	  creation_date as registration_date,
	  creation_ip,
	  last_visit,
	  member_state,
	  email_verified_p
	  FROM cc_users
	  WHERE user_id = :user_id
      </querytext>
  </fullquery>

  <fullquery name="select_dotfolio_user_info">
    <querytext>
      SELECT * FROM dotfolio_users
          WHERE dotfolio_users.user_id = :user_id
    </querytext>
  </fullquery>

  <fullquery name="select_portrait_info">      
    <querytext>
      SELECT cr_items.live_revision as revision_id,
          coalesce(cr_revisions.title, 'view this portrait')
	  as portrait_title
	  FROM acs_rels,
	  cr_items,
	  cr_revisions
	  WHERE acs_rels.object_id_two = cr_items.item_id
	  AND cr_items.live_revision = cr_revisions.revision_id
	  AND acs_rels.object_id_one = :user_id
	  AND acs_rels.rel_type = 'user_portrait_rel'
    </querytext>
  </fullquery>
    
</queryset>
