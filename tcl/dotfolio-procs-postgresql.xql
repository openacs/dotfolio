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

</queryset>
