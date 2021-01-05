--
--  Copyright (C) 2005 WEG
--
--  This file is part of dotFOLIO.
--
--  dotFOLIO is free software; you can redistribute it and/or modify it
--  under the terms of the GNU General Public License as published by the
--  Free Software Foundation; either version 2 of the License, or (at your
--  option) any later version.
--
--  dotFOLIO is distributed in the hope that it will be useful, but WITHOUT
--  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
--  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
--  for more details.
--

--
-- The dotFOLIO system
-- Initialize the dotFOLIO Admins package
--
-- @author ncarroll@ee.usyd.edu.au
-- @version $Id$
--


create function inline_1()
returns integer as '
declare
    foo                         integer;
    gid				integer;
    sid                         integer;
    dotfolio_users_group_id     integer;
begin

    PERFORM acs_rel_type__create_type(
        ''dotfolio_admin_profile_rel'',
        ''dotFOLIO Profile Admin'',
        ''dotFOLIO Profile Admins'',
	''dotfolio_user_profile_rel'',
        ''dotfolio_admin_profile_rels'',
        ''rel_id'',
        ''dotfolio_admin_profile_rel'',
        ''profiled_group'',
        null,
        0,
        null::integer,
        ''user'',
        null,
        0,
        1
    );

    select min(impl_id)
    into foo
    from acs_sc_impls
    where impl_name = ''dotfolio_admin_profile_provider'';

    gid := profiled_group__new(
        foo,
        ''dotFOLIO Admins''
    );

    sid := rel_segment__new(
        ''dotFOLIO Admins'',
        gid,
        ''dotfolio_admin_profile_rel''
    );

    insert
    into dotfolio_user_types
    (type, pretty_name, rel_type, group_id, segment_id)
    values
    (''admin'', ''#dotfolio.staff_role_pretty_name#'', ''dotfolio_admin_profile_rel'', gid, sid);

    select group_id
    into dotfolio_users_group_id
    from groups
    where group_name = ''dotFOLIO Users'';

    foo := composition_rel__new(
        dotfolio_users_group_id,
        gid
    );

    return 0;

end;
' language 'plpgsql';

select inline_1();
drop function inline_1();
