<?xml version="1.0"?>

<queryset>

  <fullquery name="entries">
    <querytext>
      SELECT be.entry_id, be.title, be.category_id,
          to_char(be.entry_date, 'HH24:MI:SS, DD Mon YYYY') AS entry_date
          FROM pinds_blog_entries be, acs_objects ao
          WHERE ao.creation_user = :owner_id
          AND ao.object_type = 'pinds_blog_entry'
          AND be.entry_id = ao.object_id
      [template::list::orderby_clause -orderby -name "entries"]
    </querytext>
  </fullquery>
    
</queryset>
