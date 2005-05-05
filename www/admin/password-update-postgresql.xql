<?xml version="1.0"?>
<queryset>

    <fullquery name="user_information">      
        <querytext>
            SELECT first_names, 
                   last_name,
                   email,
                   url
            FROM cc_users
            WHERE user_id = :user_id
      </querytext>
  </fullquery>
 
</queryset>