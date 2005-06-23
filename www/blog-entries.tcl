ad_page_contract {

    Display all blog entries for a specific owner_id.

    @author  Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-03-24
    @cvs-id  $Id$
} {
    owner_id
    url
    {orderby "entry_date,asc"}
}

set user_id [auth::require_login]

set dotfolioCSS [parameter::get_from_package_key -parameter "DotfolioCSS" \
                     -package_key "dotfolio"]

set elements {
    title {
	label {Title}
        link_url_col blog_entry_url
    }

    entry_date {
	label {Entry Date}
    }
}

# Maybe add category to listing too.

template::list::create \
    -name entries \
    -multirow entries \
    -elements $elements \
    -html {width "100%"} \
    -orderby {
	title {orderby {lower(be.title)}}
	entry_date {orderby entry_date}
    } \
    -filters {
	url {}
	owner_id {}
    }

set one_entry_url "blog/one-entry"
db_multirow -extend {blog_entry_url} entries entries {} {
    set blog_entry_url [export_vars -url -base $url$one_entry_url {entry_id}]
}

ad_return_template
