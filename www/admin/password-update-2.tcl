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

    Updates the user's password if password_1 matches password_2.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-01
    @version $Id$

} {

    user_id:integer,notnull
    password_1:notnull
    password_2:notnull
    {return_url ""}

} -validate {

    confirm_password -requires {password_2:notnull} {
        if {[empty_string_p $password_2]} {
            ad_complain "[_ dotfolio.need_to_confirm]"
        }
    }
    new_password_match -requires {password_1:notnull password_2:notnull confirm_password} {
	if {![string equal $password_1 $password_2]} {
	    ad_complain "[_ dotfolio.passwords_dont_match]"
	}
    }

}

ad_change_password $user_id $password_1

set system_owner [ad_system_owner]
set system_name [ad_system_name]

set subject "[_ dotfolio.your_password_on_syst]"
set change_password_url "[ad_url]/user/password-update?[export_vars {user_id {password_old $password_1}}]"
set message "[_ dotfolio.password_url]"

set email [db_string select_user_email {}]

# Send email                                                                    
if [catch {ns_sendmail $email $system_owner $subject $message} errmsg] {
    ns_log Error "[_ dotfolio.error_sending_email_to]" $errmsg
        ad_return_error \
        "[_ dotfolio.error_sending_email]" \
        "[_ dotfolio.error_sending_email_2]"
} else {

    set system_name [ad_system_name]
    set email_from [ad_system_owner]
    set admin_subject "[_ dotfolio.email_was_just_sent]"
    set admin_message "[_ dotfolio.email_was_just_sent_msg]"

    if [catch {ns_sendmail $system_owner $system_owner $admin_subject $admin_message} errmsg] {

        ns_log Error "[_ dotfolio.error_sending_email_to]" $errmsg
        ad_return_error \
	    "[_ dotfolio.error_sending_email]" \
	    "[_ dotfolio.error_sending_email_2]"
    }
}

if {[empty_string_p $return_url]} {
    set return_url "user?user_id=$user_id"
}

ad_returnredirect $return_url
