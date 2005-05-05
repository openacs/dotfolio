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


create table dotfolio_user_profile_rels (
    rel_id   integer
				constraint dotfolio_user_profile_rels_rel_id_fk
				references dotfolio_user_profile_rels (rel_id)
				constraint dotfolio_user_profile_rels_pk
				primary key,
    id				varchar(100)
);

create table dotfolio_user_types (
    type     			 varchar(100)
    				 constraint dotfolio_user_types_pk
				 primary key,
    pretty_name			 varchar(200),
    rel_type			 varchar(100)
    				 constraint dotfolio_user_types_rel_type_fk
				 references acs_rel_types (rel_type)
				 constraint dotfolio_user_types_rel_type_nn
				 not null,
    group_id			 integer
    				 constraint dotfolio_user_types_group_id_fk
				 references profiled_groups (group_id)
				 constraint dotfolio_user_types_group_id_nn
				 not null,
    segment_id			 integer
    				 constraint dotfolio_user_types_segment_fk
                                 references rel_segments (segment_id)
                                 constraint dotfolio_user_types_segment_nn
                                 not null
);

create view dotfolio_users
as
    select acs_rels.rel_id,
           dotfolio_user_profile_rels.id,
           users.user_id,
           users.username,
           persons.first_names,
           persons.last_name,
           parties.email,
           dotfolio_user_types.type,
           dotfolio_user_types.pretty_name as pretty_type,
           dotfolio_user_types.rel_type,
           dotfolio_user_types.group_id,
           dotfolio_user_types.segment_id
    from dotfolio_user_profile_rels,
         dotfolio_user_types,
         acs_rels,
         parties,
         users,
         persons
    where dotfolio_user_profile_rels.rel_id = acs_rels.rel_id
    and acs_rels.object_id_one = dotfolio_user_types.group_id
    and acs_rels.object_id_two = parties.party_id
    and parties.party_id = users.user_id
    and users.user_id = persons.person_id;


-- create users, then create user groups.
\i user-profile-provider-create.sql
\i users-init.sql
\i users-package-create.sql

-- create administrators (eg dotFOLIO Staff)
\i admins-create.sql

-- create advisers
\i advisers-create.sql

-- create owner
\i owners-create.sql

-- create guest
\i guests-create.sql
