--
-- packages/dotfolio/sql/dotfolio-create.sql
--
-- @author Nick Carroll (nick.c@rroll.net)
-- @creation-date 2005-03-21
-- @cvs-id $Id$
--
--

create function inline_0 ()
returns integer as '
begin
    PERFORM acs_object_type__create_type (
    ''dotfolio'',                  -- object_type
    ''dotFOLIO'',                  -- pretty_name
    ''dotFOLIOs'',                 -- pretty_plural
    ''acs_object'',                -- supertype
    ''dotfolios'',                 -- table_name
    ''dotfolio_id'',               -- id_column
    null,                          -- package_name
    ''f'',                         -- abstract_p
    null,                          -- type_extension_table
    ''dotfolio__name''             -- name_method
    );

    return 0;
end;' language 'plpgsql';

select inline_0 ();
drop function inline_0 ();


create table dotfolios (
    dotfolio_id    integer 
                   constraint dotfolios_dotfolio_id_fk
                   references acs_objects(object_id) 
                   constraint dotfolios_dotfolio_id_pk
                   primary key,
    owner_id       integer
                   constraint dotfolios_owner_id_fk
                   references users(user_id)
                   constraint dotfolios_owner_id_nn
                   not null
		   constraint dotfolios_owner_id_un
		   unique,
    node_id        integer
                   constraint dotfolios_node_id_fk
                   references site_nodes(node_id)
                   constraint dotfolios_url_nn
                   not null,
    package_id     integer
                   constraint dotfolios_package_id_fk
                   references apm_packages(package_id)
                   constraint dotfolios_package_id_nn
                   not null,
    name           varchar(128)
                   constraint dotfolios_name_nn
                   not null
);

select define_function_args('dotfolio__new','dotfolio_id,owner_id,node_id,package_id,name,creation_date;now,creation_user,creation_ip,context_id');

create function dotfolio__new (integer,integer,integer,integer,varchar,timestamptz,integer,varchar,integer)
returns integer as '
declare
    p_dotfolio_id                alias for $1;        -- default null
    p_owner_id                   alias for $2;
    p_node_id                    alias for $3;
    p_package_id                 alias for $4;
    p_name                       alias for $5;
    p_creation_date              alias for $6;        -- default now()
    p_creation_user              alias for $7;        -- default null
    p_creation_ip                alias for $8;        -- default null
    p_context_id                 alias for $9;        -- default null
    v_dotfolio_id                dotfolios.dotfolio_id%TYPE;
begin

    v_dotfolio_id := acs_object__new (
        p_dotfolio_id,
        ''dotfolio'',
        p_creation_date,
        p_creation_user,
        p_creation_ip,
        p_context_id
    );

    insert into dotfolios
      (dotfolio_id, owner_id, node_id, package_id, name)
    values
      (v_dotfolio_id, p_owner_id, p_node_id, p_package_id, p_name);

    PERFORM acs_permission__grant_permission(
          v_dotfolio_id,
          p_creation_user,
          ''admin''
    );

--    PERFORM acs_permission__grant_permission(
--          v_dotfolio_id,
--          p_owner_id,
--          ''owner''
--    );

    return v_dotfolio_id;

end;' language 'plpgsql';


select define_function_args('dotfolio__del','dotfolio_id');

create function dotfolio__del (integer)
returns integer as '
declare
    p_dotfolio_id                alias for $1;
begin
    delete from acs_permissions
           where object_id = p_dotfolio_id;

    delete from dotfolios
           where dotfolio_id = p_dotfolio_id;

    raise NOTICE ''Deleting dotfolio...'';
    PERFORM acs_object__delete(p_dotfolio_id);

    return 0;

end;' language 'plpgsql';


select define_function_args('dotfolio__name','dotfolio_id');

create function dotfolio__name (integer)
returns varchar as '
declare
    p_dotfolio_id      alias for $1;
    v_dotfolio_name    dotfolios.name%TYPE;
begin
    select name into v_dotfolio_name
        from dotfolios
        where dotfolio_id = p_dotfolio_id;

    return v_dotfolio_name;
end;
' language 'plpgsql';


select define_function_args('dotfolio__has_p','user_id');

create function dotfolio__has_p (integer) returns bool as '
declare
    p_user_id          alias for $1;
    v_has_p            integer;
begin
    select count(owner_id) into v_has_p
        from dotfolios
        where owner_id = p_user_id;

    if v_has_p <> 0 then
        return ''t'';
    else
        return ''f'';
    end if;
end;
' language 'plpgsql';


\i users-create.sql
\i dotfolio-identification-create.sql
