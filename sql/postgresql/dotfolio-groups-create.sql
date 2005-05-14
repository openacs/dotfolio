--
-- packages/dotfolio/sql/dotfolio-groups-create.sql
--
-- @author Nick Carroll (nick.c@rroll.net)
-- @creation-date 2005-03-21
-- @cvs-id $Id$
--
--

create table dotfolio_group_adviser_map (
    group_id		integer
			constraint dotfolio_group_adviser_map_group_fk
			references groups(group_id),
    adviser_id		integer
			constraint dotfolio_group_adviser_map_adviser_fk
			references users(user_id)
);
