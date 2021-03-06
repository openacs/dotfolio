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
-- Drop implementation of the profile provider interface for dotFOLIO Admins.
--
-- @author ncarroll@ee.usyd.edu.au
-- @version $Id$
--


create function inline_0()
returns integer as '
declare
    foo                         integer;
begin

    -- drop the binding between this implementation and the interface it
    -- implements
    perform acs_sc_binding__delete(
        ''profile_provider'',
        ''dotfolio_admin_profile_provider''
    );

    -- drop the bindings to the method implementations

        -- name method
        perform acs_sc_impl_alias__delete(
            ''profile_provider'',
            ''dotfolio_admin_profile_provider'',
            ''name''
        );

        -- prettyName method
        perform acs_sc_impl_alias__delete(
            ''profile_provider'',
            ''dotfolio_admin_profile_provider'',
            ''prettyName''
        );

        -- render method
        perform acs_sc_impl_alias__delete(
            ''profile_provider'',
            ''dotfolio_admin_profile_provider'',
            ''render''
        );

    -- drop the implementation
    perform acs_sc_impl__delete(
        ''profile_provider'',
        ''dotfolio_admin_profile_provider''
    );

    return 0;
end;
' language 'plpgsql';

select inline_0();
drop function inline_0();
