#
#  Copyright (C) 2001, 2002 WEG
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

    Displays main dotFOLIO admin page

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-01
    @version $Id$

} -query {
    user_id
    {referer "[dotfolio::get_admin_url]/users"}
} -properties {
    context_bar:onevalue
}

#Pages in this directory are only runnable by dotfolio-wide admins.
dotfolio::require_admin

set system_name [ad_system_name]
set system_url [ad_url]

db_1row select_user_info {}

ad_form -name add_user -export {referer user_id} -form {

    {id:text(hidden)
	{value $username}
    }

    {type:text(select)
	{label "[_ dotfolio.user_type]"}
	{options [dotfolio::get_user_types_as_options]}
    }

} -on_submit {

    set subject [_ dotfolio.subject_membership_has_been_approved]
    set message [_ dotfolio.message_membership_has_been_approved]
    set email_from [ad_parameter -package_id [ad_acs_kernel_id] SystemOwner]

    # Add the user as a dotfolio user.
    dotfolio::user_add -id $id -type $type -user_id $user_id

    # If the user is of type "owner", then create a dotfolio space for
    # the user.
    if { [string equal $type "owner"] } {
	dotfolio::create_dotfolio_for_user -username $username 
    }

    if [catch {ns_sendmail $email $email_from $subject $message} errmsg] {
        
        ns_log Error "[_ dotfolio.user_new_2_log_error]" $errmsg
        ad_return_error \
	    "[_ dotfolio.error_sending_email]" \
	    "[_ dotfolio.error_sending_email_to]"
    } else {

        set admin_subject "[_ dotfolio.email_was_just_sent]"
        set admin_message "[_ dotfolio.email_was_just_sent_msg]"

	if [catch {ns_sendmail $email_from $email_from $admin_subject $admin_message} errmsg] {
        
            ns_log Error "[_ dotfolio.user_new_2_log_error]" $errmsg
            ad_return_error \
		"[_ dotfolio.error_sending_email]" \
		"[_ dotfolio.error_sending_email_to]"
        }

    }

} -after_submit {
    ad_returnredirect $referer
    ad_script_abort
}

set context_bar [list [list users [_ dotfolio.users]] [_ dotfolio.new]]

ad_return_template
