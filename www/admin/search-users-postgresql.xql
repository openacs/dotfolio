<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.1</version></rdbms>

  <fullquery name="get_users">
    <querytext>
      SELECT DISTINCT user_id, username, first_names, last_name, email, pretty_type as user_type
          FROM dotfolio_users
          WHERE (lower(email) LIKE lower('%' || :q || '%') OR
                 lower(first_names) LIKE lower('%' || :q || '%') OR
                 lower(last_name) LIKE lower('%' || :q || '%') OR
                 lower(username) LIKE lower('%' || :q || '%'))
    </querytext>
  </fullquery>
</queryset>