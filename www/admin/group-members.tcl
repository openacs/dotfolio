ad_page_contract {

    Displays members for a given group ID.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} {
    group_id:integer,notnull
} -properties {
    context_bar:onevalue
} 

set context_bar "[_ dotfolio.group_members_curly]"

set group_name [db_string group_name {} -default ""]

db_multirow group_members group_members {}

template::list::create \
    -name group_members \
    -multirow group_members \
    -key user_id \
    -bulk_actions {
	"Remove" "group-members-rem" "Remove user from group"
    } \
    -bulk_action_method post -bulk_action_export_vars {
	user_id group_id
    } \
    -no_data {#dotfolio.no_members_added_to_group#} \
    -elements {
	name {
	    label #dotfolio.name#
	}
	pretty_type {
	    label #dotfolio.role_type#
	}
    }

db_multirow non_group_members non_group_members {}

template::list::create \
    -name non_group_members \
    -multirow non_group_members \
    -key user_id \
    -bulk_actions {
	"Add" "group-members-add" "Add user to group"
    } \
    -bulk_action_method post -bulk_action_export_vars {
	user_id group_id
    } \
    -no_data {#dotfolio.no_members_added_to_group#} \
    -elements {
	name {
	    label #dotfolio.name#
	}
	pretty_type {
	    label #dotfolio.role_type#
	}
    }

ad_return_template
