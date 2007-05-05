<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.1</version></rdbms>

  <fullquery name="dotfolio::user_p.select_count">
    <querytext>
      SELECT count(*)
          FROM dual
          WHERE exists (SELECT 1
          FROM dotfolio_users
          WHERE user_id = :user_id)
    </querytext>
  </fullquery>


  <fullquery name="dotfolio::dotfolio_p.dotfolio_count">
    <querytext>
	SELECT 1
          FROM dotfolios
          WHERE owner_id = :user_id
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::get_user_types_as_options.select_user_types_as_options_without_guest">
    <querytext>
      SELECT pretty_name, type
          FROM dotfolio_user_types
	  WHERE type != 'guest'
          ORDER BY pretty_name
    </querytext>
  </fullquery>

  <fullquery name="dotfolio::get_user_types_as_options.select_user_types_as_options">
    <querytext>
      SELECT pretty_name, type
          FROM dotfolio_user_types
          ORDER BY pretty_name
    </querytext>
  </fullquery>

</queryset>
