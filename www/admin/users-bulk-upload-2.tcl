#
#  Copyright (C) 2005 Nick Carroll
#
#  This file is part of dotFOLIO.
#
#  dotFOLIO is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation; either version 2 of the License, or (at your 
#  option) any later version.
#
#  dotFOLIO is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_page_contract {
    Process the upload

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-05-27
    @version $Id$
}

# Pages in this directory are only runnable by dotfolio-wide admins.
dotfolio::require_admin

# get location of the file
set file_location [ns_queryget users_csv_file.tmpfile]

# Prepare stuff
set headers {first_names last_name email username}

set admin_user_id [ad_conn user_id]
set admin_email [db_string select_admin_email {
    select email
    from parties
    where party_id = :admin_user_id
}]

doc_body_append "[_ dotfolio.bulk_uploading]<p>"

set list_of_user_ids [list]
set list_of_addresses_and_passwords [list]

set fail_p 0

# Do the stuff
# We can't do this too generically, so we'll just do the CSV stuff right here
db_transaction {

    oacs_util::csv_foreach -file $file_location -array_name row {

        # First make sure the required data is there
        if { ![info exists row(first_names)] || ![info exists row(last_name)] || ![info exists row(email)] || ![info exists row(username)] || ![info exists row(type)] } {
            doc_body_append [_ dotfolio.csv_file_must_include]
            db_abort_transaction
            return
        }

        ns_log Debug "Bulk upload: Email = $row(email)"

        # Need to generate a random password if one was not supplied.
        if {![info exists row(password)] || [empty_string_p $row(password)]} {
            set password [ad_generate_random_string]
        } else {
            set password $row(password)
        }
 
        # Check if this user already exists based on username.
	# Note: Usernames must be unique in dotFOLIO.
        set user_id [dotfolio::user::get_user_id_from_username \
			 -username $row(username)]

        if {![empty_string_p $user_id]} {

            doc_body_append [_ dotfolio.user_username_already_exists \
				 [list user_username $row(username)]]

            lappend list_of_user_ids $user_id

        } else {

	    set user_id [db_nextval acs_object_id_seq]

            ns_log Debug "Bulk upload: user_id = $user_id"

	    auth::create_user \
		-user_id $user_id \
		-username $row(username) \
		-email $row(email) \
		-first_names $row(first_names) \
		-last_name $row(last_name) \
		-password $password
            
            lappend list_of_user_ids $user_id

            doc_body_append "[_ dotfolio.creating_user] $row(username)...."

            # Now we make them a dotFOLIO user
	    dotfolio::user_add -user_id $user_id -id $row(username) -type $row(type)

	    # If user is an owner, then create a dotfolio site using their
	    # username.
	    if {$row(type) == "owner"} {
            doc_body_append "[_ dotfolio.creating_dotfolio_site] $row(username)...."
		dotfolio::create_dotfolio_for_user -username $row(username)
	    }

            doc_body_append [_ dotfolio.user_username_created \
				 [list user_username $row(username)]]

            set msg_subst_list [list system_name [ad_system_name] \
                                     system_url [ad_parameter -package_id [ad_acs_kernel_id] SystemURL] \
                                     user_email $row(email) \
                                     user_password $password]
            set message [_ dotfolio.user_add_confirm_email_body \
			     $msg_subst_list]
 
            set subject [_ dotfolio.user_add_confirm_email_subject \
			     $msg_subst_list]

	    # Send note to new user
	    if [catch {ns_sendmail "$row(email)" "$admin_email" "$subject" "$message"} errmsg] {
		doc_body_append "[_ dotfolio.emailing_this_user_failed]"
                set fail_p 1
	    } else {
		lappend list_of_addresses_and_passwords $row(email) $password
	    }
            
        }

        doc_body_append "<br>"
        
    }
} on_error {
    ns_log Error "The database choked while trying to create the last user in the list above! The transaction has been aborted, no users have been entered, and no e-mail notifications have been sent."
    doc_body_append [_ dotfolio.database_choked]
    ad_script_abort
}

if {$fail_p} {
    doc_body_append "<p>[_ dotfolio.some_of_the_emails_failed]<p>"
}

doc_body_append "<p>[_ dotfolio.return_to] <a href=\"users\">[_ dotfolio.user_management]</a>."
