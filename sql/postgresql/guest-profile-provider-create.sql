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
-- Implementation of the profile provider interface for dotFOLIO Guests.
--
-- @author ncarroll@ee.usyd.edu.au
-- @version $Id$
--


create function inline_0()
returns integer as '
begin

    -- create the implementation
    perform acs_sc_impl__new(
        ''profile_provider'',
        ''dotfolio_guest_profile_provider'',
        ''dotfolio_guest_profile_provider''
    );

    -- add the bindings to the method implementations

        -- name method
        perform acs_sc_impl_alias__new(
            ''profile_provider'',
            ''dotfolio_guest_profile_provider'',
            ''name'',
            ''dotfolio_guest_profile_provider::name'',
            ''TCL''
        );

        -- prettyName method
        perform acs_sc_impl_alias__new(
            ''profile_provider'',
            ''dotfolio_guest_profile_provider'',
            ''prettyName'',
            ''dotfolio_guest_profile_provider::prettyName'',
            ''TCL''
        );

        -- render method
        perform acs_sc_impl_alias__new(
            ''profile_provider'',
            ''dotfolio_guest_profile_provider'',
            ''render'',
            ''dotfolio_guest_profile_provider::render'',
            ''TCL''
        );

    -- bind this implementation to the interface it implements
    perform acs_sc_binding__new(
        ''profile_provider'',
        ''dotfolio_guest_profile_provider''
    );

    return 0;

end;' language 'plpgsql';

select inline_0();
drop function inline_0();
