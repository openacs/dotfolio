<?xml version="1.0"?>

<queryset>

  <fullquery name="select_admin_name">
    <querytext>
      SELECT first_names || ' ' || last_name
          FROM persons
          WHERE person_id = :admin_user_id
    </querytext>
  </fullquery>
    
</queryset>
