<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.1</version></rdbms>

  <fullquery name="select_user_info">
    <querytext>
	SELECT email,
           first_names,
           last_name,
	   username
	   FROM registered_users
	   WHERE user_id = :user_id
    </querytext>
  </fullquery>
</queryset>