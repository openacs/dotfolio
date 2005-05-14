<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.4</version></rdbms>

  <fullquery name="delete_group">
    <querytext>
      DELETE FROM dotfolio_group_adviser_map WHERE group_id = :group_id
    </querytext>
  </fullquery>

</queryset>
