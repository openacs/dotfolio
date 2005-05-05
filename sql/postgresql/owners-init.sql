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
-- Initialise the dotFOLIO Owners package
--
-- @author ncarroll@ee.usyd.edu.au
-- @version $Id$
--


create function inline_1()
returns integer as '
declare
    foo                         integer;
    gid				integer;
    sid				integer;
    dotfolio_users_group_id       integer;
begin

    PERFORM acs_rel_type__create_type(
        ''dotfolio_owner_profile_rel'',
        ''dotFOLIO Profile Owner'',
        ''dotFOLIO Profile Owners'',
	''dotfolio_user_profile_rel'',
        ''dotfolio_owner_profile_rels'',
        ''rel_id'',
        ''dotfolio_owner_profile_rel'',
        ''profiled_group'',
        null,
        0,
        null,
        ''user'',
        null,
        0,
        1
    );

    select min(impl_id)
    into foo
    from acs_sc_impls
    where impl_name = ''dotfolio_owner_profile_provider'';

    gid := profiled_group__new(
        foo,
        ''dotFOLIO Owners''
    );

    sid := rel_segment__new(
        ''dotFOLIO Owners'',
        gid,
        ''dotfolio_owner_profile_rel''
    );

    insert
    into dotfolio_user_types
    (type, pretty_name, rel_type, group_id, segment_id)
    values
    (''owner'', ''#dotfolio.owner_role_pretty_name#'', ''dotfolio_owner_profile_rel'', gid, sid);

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
