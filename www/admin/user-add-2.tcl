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
    Processes a new dotFOLIO user created by an admin.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-01
    @version $Id$
} -query {

    user_id
    password
    type
    {referer "[dotfolio::get_admin_url]/users"}

} -properties {
    context_bar:onevalue
    export_vars:onevalue
    system_name:onevalue
    system_url:onevalue
    first_names:onevalue
    last_name:onevalue
    email:onevalue
    id:onevalue
    password:onevalue
    administration_name:onevalue
}

# Get user info
acs_user::get -user_id $user_id -array user
# easier to work with scalar vars than array
foreach var_name [array names user] {
    set $var_name $user($var_name)
}

set dotfolio_user_p [dotfolio::user_p -user_id $user_id]

set redirect "user-add-2?[export_vars {user_id password referer type can_browse_p read_private_data_p add_membership_p}]"
# Don't redirect back to the user-add-type page if we've already been there
if {!$dotfolio_user_p} {
    set redirect "${redirect}"
    ad_returnredirect "user-add-type?[export_vars {user_id {referer $redirect}}]"
    ad_script_abort
}


set admin_user_id [ad_verify_and_get_user_id]
set administration_name [db_string select_admin_name {}]

set context_bar [list [_ dotfolio.add_user]]
set system_name [ad_system_name]
set system_url [ad_parameter -package_id [ad_acs_kernel_id] SystemURL ""]
set export_vars [export_vars -form {email referer type}]
