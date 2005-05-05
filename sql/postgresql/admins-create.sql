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


create table dotfolio_admin_profile_rels (
    rel_id                      integer
                                constraint dotfolio_adm_prfl_rels_rel_id_fk
                                references dotfolio_user_profile_rels (rel_id)
                                constraint dotfolio_admin_prfl_rels_pk
                                primary key
);

\i admin-profile-provider-create.sql
\i admins-init.sql
\i admins-package-create.sql
