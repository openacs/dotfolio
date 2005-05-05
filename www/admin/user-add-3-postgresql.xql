<?xml version="1.0"?>

<queryset>

  <fullquery name="select_admin_email">
    <querytext>
      SELECT email
          FROM parties
          WHERE party_id = :admin_user_id
    </querytext>
  </fullquery>
    
</queryset>
