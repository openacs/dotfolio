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
-- Create the dotFOLIO Guests package
--
-- @author ncarroll@ee.usyd.edu.au
-- @version $Id$
--


create table dotfolio_guest_profile_rels (
    rel_id                      integer
                                constraint dotfolio_guest_profile_rels_rel_fk
                                references dotfolio_user_profile_rels (rel_id)
                                constraint dotfolio_guest_profile_rels_pk
                                primary key
);

\i guest-profile-provider-create.sql
\i guests-init.sql
\i guests-package-create.sql
