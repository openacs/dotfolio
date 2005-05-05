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


-- drop guest users
\i guests-drop.sql

-- drop owners
\i owners-drop.sql

-- drop advisers
\i advisers-drop.sql

-- drop admins
\i admins-drop.sql

\i users-package-drop.sql
\i user-profile-provider-drop.sql

drop view dotfolio_users;

drop table dotfolio_user_types;
drop table dotfolio_user_profile_rels;