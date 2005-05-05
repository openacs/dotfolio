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
--
-- @author ncarroll@ee.usyd.edu.au
-- @version $Id$
--

-- Initialize the User Profile package

create function inline_1()
returns integer as '
declare
    foo                         integer;
begin

    perform acs_rel_type__create_type(
        ''dotfolio_user_profile_rel'',
        ''dotFOLIO Profile User'',
        ''dotFOLIO Profile Users'',
        ''user_profile_rel'',
        ''dotfolio_user_profile_rels'',
        ''rel_id'',
        ''dotfolio_user_profile_rel'',
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
    where impl_name = ''dotfolio_user_profile_provider'';

    foo := profiled_group__new(
        foo,
        ''dotFOLIO Users''
    );

    foo := rel_segment__new(
        ''dotFOLIO Users'',
        foo,
        ''dotfolio_user_profile_rel''
    );

    return(0);
end;
' language 'plpgsql';

select inline_1();
drop function inline_1();
