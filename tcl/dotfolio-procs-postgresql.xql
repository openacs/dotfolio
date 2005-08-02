<?xml version="1.0"?>
<queryset>
  <rdbms><type>postgresql</type><version>7.4</version></rdbms>

<fullquery name="dotfolio::create_dotfolio_for_user.create_dotfolio">
    <querytext>
        select dotfolio__new (
            null,                    -- dotfolio_id,
    	    :owner_id,
            :node_id,
            :package_id,
            :username,
            current_timestamp,       -- creation_date
            :user_id,
            :peeraddr,               -- creation_ip,
            null                     -- context_id
                )
      </querytext>
</fullquery>
 
  <fullquery name="dotfolio::create_dotfolio_for_user.set_live">
    <querytext>
      UPDATE cr_items SET live_revision=latest_revision
          WHERE item_id=:welcome_content_id
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::create_dotfolio_for_user.get_users_names">
    <querytext>
      SELECT first_names, last_name FROM dotfolio_users
          WHERE user_id = :owner_id
    </querytext>
  </fullquery>  

  <fullquery name="dotfolio::has_dotfolio_p.has_dotfolio">
    <querytext>
      SELECT dotfolio__has_p(:user_id) AS has_dotfolio_p
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::group_id_from_user_type.get_group_id">
    <querytext>
	SELECT group_id FROM dotfolio_user_types WHERE type = :user_type
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::object_type_pretty_name.pretty_name">
    <querytext>
        SELECT t.pretty_name FROM acs_object_types t, acs_objects o
            WHERE  o.object_id = :object_id
            AND t.object_type = o.object_type
    </querytext>
  </fullquery>

</queryset>
