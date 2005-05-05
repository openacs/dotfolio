--
-- packages/dotfolio/sql/dotfolio-identification-create.sql
--
-- @author Nick Carroll (nick.c@rroll.net)
-- @creation-date 2005-04-25
-- @cvs-id $Id$
--
--


create function inline_0 ()
returns integer as '
begin
    PERFORM acs_object_type__create_type (
    ''ident-profile'',            	-- object_type
    ''Identification Profile'',   	-- pretty_name
    ''Identification Profiles'',  	-- pretty_plural
    ''acs_object'',               	-- supertype
    ''dotfolio_owner_identification'',	-- table_name
    ''owner_id'',               	-- id_column
    null,                      		-- package_name
    ''f'',                     		-- abstract_p
    null,                      		-- type_extension_table
    null 	             		-- name_method
    );

    return 0;
end;' language 'plpgsql';

select inline_0 ();

drop function inline_0 ();


create table dotfolio_owner_identification (
    ident_id		integer
			constraint dotfolio_ident_id_pk
			primary key,
    owner_id		integer
			constraint dotfolio_ident_owner_id_fk
			references dotfolios(owner_id),
    pref_name		varchar(64),
    tele_work		varchar(32),
    tele_home		varchar(32),
    mobile		varchar(32),
    im_msn		varchar(64),
    im_aim		varchar(64),
    interests		varchar(256),
    company		varchar(64),
    job_desc		varchar(256),
    goals		varchar(256),
    edu_level		varchar(256),
    university		varchar(64),
    main_skills		varchar(256)
);

select define_function_args('dotfolio_owner_identification__new','owner_id,pref_name,tele_work,tele_home,mobile,im_msn,im_aim,interests,company,job_desc,goals,edu_level,university,main_skills');

create function dotfolio_owner_identification__new (integer,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar)
returns integer as '
declare
    p_owner_id                  alias for $1;
    p_pref_name                 alias for $2;
    p_tele_work                 alias for $3;
    p_tele_home                 alias for $4;
    p_mobile                    alias for $5;
    p_im_msn                    alias for $6;
    p_im_aim                    alias for $7;
    p_interests                 alias for $8;
    p_company                   alias for $9;
    p_job_desc                  alias for $10;
    p_goals                     alias for $11;
    p_edu_level                 alias for $12;
    p_university                alias for $13;
    p_main_skills               alias for $14;
    v_profile_id                integer;
begin

    v_profile_id := acs_object__new (
        null,
	''ident-profile'',
        now(),
        p_owner_id,
        NULL,
        NULL
    );

    INSERT INTO dotfolio_owner_identification
      (ident_id, owner_id, pref_name, tele_work, tele_home, mobile, im_msn, im_aim, interests, company, job_desc, goals, edu_level, university, main_skills)
    VALUES
      (v_profile_id, p_owner_id, p_pref_name, p_tele_work, p_tele_home, p_mobile, p_im_msn, p_im_aim, p_interests, p_company, p_job_desc, p_goals, p_edu_level, p_university, p_main_skills);

    PERFORM acs_permission__grant_permission(
        v_profile_id,
        p_owner_id,
        ''admin''
    );

    return v_profile_id;

end;' language 'plpgsql';
