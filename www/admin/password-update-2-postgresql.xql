<?xml version="1.0"?>

<queryset>

  <fullquery name="select_user_email">
      <querytext>                                                             
          SELECT email
	      FROM registered_users
	      WHERE user_id = :user_id
      </querytext>
  </fullquery>
</queryset>