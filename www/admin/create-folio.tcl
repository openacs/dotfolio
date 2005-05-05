ad_page_contract {
    Creates a dotfolio for the specified username.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-03-10
    @cvs-id $Id$
} {
    username:notnull
} -validate {
    username_notnull {
	if { ![exists_and_not_null username] } {
	    ad_complain
	}	
    }

    username_exists -requires { username_notnull } {
	if { [empty_string_p [acs_user::get_by_username \
				   -username $username]] } {
	    ad_complain
	}
    }
} -errors {
    username_notnull "#dotfolio.username_must_not_be_null#"
    username_exists "#dotfolio.username_does_not_exist#"
}

set message [_ dotfolio.error_creating_dotfolio]
set success_p [dotfolio::create_dotfolio_for_user -username $username]

if { $success_p } {
    set message [_ dotfolio.successfully_created_dotfolio]
}

ad_returnredirect \
    -message $message \
    "users"
