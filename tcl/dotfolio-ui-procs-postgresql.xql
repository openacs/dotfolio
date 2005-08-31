<?xml version="1.0"?>
<queryset>
  <rdbms><type>postgresql</type><version>7.4</version></rdbms>

  <fullquery name="dotfolio::ui::created_rel_p.creation_user">
    <querytext>
      SELECT creation_user FROM acs_objects WHERE object_id = :rel_id
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::ui::is_content_folder_p.object_type">
    <querytext>
      SELECT object_type FROM acs_objects
	WHERE object_id = :object_id
        AND object_type = 'content_folder'
    </querytext>
  </fullquery>

</queryset>
