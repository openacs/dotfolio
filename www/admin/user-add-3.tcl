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
    Sends email confirmation to user after they've been created

    @Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-01
    @version $Id$
} -query {
    email
    message
    {referer "[dotfolio::get_admin_url]/users"}
}

set admin_user_id [ad_verify_and_get_user_id]
set admin_email [db_string select_admin_email {}]

set msg_subst_values [list system_name [ad_system_name] \
                           system_url [ad_parameter SystemUrl]]
set email_subject [_ dotlrn.user_add_confirm_email_subject $msg_subst_values]
if [catch {ns_sendmail "$email" "$admin_email" "$email_subject" "$message"} \
    errmsg] {
    set quotehtml_errmsg [ad_quotehtml $errmsg]
    ad_return_error "[_ dotfolio.error_sending_email]" \
                    "[_ dotfolio.system_was_unable]"
    ad_script_abort
}

ad_returnredirect $referer