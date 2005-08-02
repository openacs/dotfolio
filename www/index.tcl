ad_page_contract {


    @author  Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-03-24
    @cvs-id  $Id$
} {
    {orderby "name,asc"}
}

set package_id [ad_conn package_id]

set user_id [auth::require_login]

set admin_p [ad_permission_p $package_id admin]

# Redirect if user is not a dotfolio user.
if {![dotfolio::user_p -user_id $user_id]} {
    ad_returnredirect "index-not-a-user"
    ad_script_abort
}

set root_object_id [acs_magic_object security_context_root]

# Determine the type of dotfolio user.
set type_adviser_p [dotfolio::user::type_adviser_p -user_id $user_id]
set type_admin_p [dotfolio::user::type_admin_p -user_id $user_id]

# If user is not adviser then do some redirection.
if {!$type_adviser_p && !$type_admin_p} {

    # If user has a dotfolio, then redirect to the location of the dotfolio.
    # Otherwise redirect user back to index with message.
    if {[dotfolio::has_dotfolio_p -user_id $user_id]} {
	ad_returnredirect [dotfolio::user::dotfolio_url -user_id $user_id]
    } else {
	# TODO - user must be guest so display dotfolios that
	# guest has access to.
	ad_returnredirect -message "You do not have the permissions to access dotfolio." /
    }
}

set elements {
    name {
	label {\#dotfolio.name\#}
        link_url_col dotfolio_url
    }

    email {
	label {\#dotfolio.email\#}
	display_template {(<a href="mailto:@portfolios.email@">@portfolios.email@</a>)}
    }

    blog_entries {
	label {\#dotfolio.num_of_blog_entries\#}
        link_url_col blog_entries_url
    }
}

template::list::create \
    -name portfolios \
    -multirow portfolios \
    -elements $elements \
    -orderby {
	name {orderby {lower(name)}}
	blog_entries {orderby blog_entries}
    }

set one_entry_url "blog/one-entry"
db_multirow -extend {dotfolio_url blog_entries_url} portfolios portfolios {} {
    set dotfolio_url $url
    set blog_entries_url [export_vars -url -base {blog-entries} {owner_id url}]
}

set dotfolioCSS [parameter::get_from_package_key -parameter "DotfolioCSS" \
                     -package_key "dotfolio"]

ad_return_template
