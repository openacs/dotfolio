<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.4</version></rdbms>

  <fullquery name="insert_group_adviser_ids">
    <querytext>
      INSERT INTO dotfolio_group_adviser_map (group_id, adviser_id)
	VALUES (:group_id, :adviser_id)
    </querytext>
  </fullquery>

</queryset>
