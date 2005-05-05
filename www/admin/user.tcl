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
    One user view by a dotFOLIO admin.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-01
    @version $Id$
} {
    user_id:integer,notnull
} -properties {
    context_bar:onevalue
    return_url:onevalue
    export_edit_vars:onevalue
    first_names:onevalue
    last_name:onevalue
    email:onevalue
    screen_name:onevalue
    last_visit:onevalue
    user_id:onevalue
}

#Pages in this directory are only runnable by dotfolio-wide admins.
dotfolio::require_admin

set oacs_site_wide_admin_p [acs_user::site_wide_admin_p]

set return_url "[ad_parameter -package_id [ad_acs_kernel_id] CommunityMemberAdminURL]?user_id=$user_id"
set export_edit_vars "user_id=$user_id&return_url=$return_url"

set dotfolio_url [dotfolio::get_url]
set root_object_id [acs_magic_object security_context_root]
if {![db_0or1row select_user_info {}]} {
    ad_return_complaint 1 "<li>[_ dotfolio.couldnt_find_user_id [list user_id $user_id]]</li>"
    ad_script_abort
}
if {[empty_string_p $screen_name]} {
    set screen_name "&lt;[_ dotfolio.none_set_up]&gt;"
}
set registration_date [lc_time_fmt $registration_date "%q"]
if {![empty_string_p $last_visit]} {
    set last_visit [lc_time_fmt $last_visit "%q"]
}

set dotfolio_package_id [dotfolio::get_package_id]
set dotfolio_user_p 0
if {[db_0or1row select_dotfolio_user_info {}]} {
    set dotfolio_user_p 1
}

set portrait_p 0
if {[ad_parameter "show_portrait_p" dotfolio] && [db_0or1row select_portrait_info {}]} {
    set portrait_p 1
}

set change_state_links "\[<small>[join [ad_registration_finite_state_machine_admin_links $member_state $email_verified_p $user_id $return_url] " | "]</small>\]"

set site_wide_admin_p [permission::permission_p \
        -party_id $user_id \
			   -object_id [acs_magic_object "security_context_root"] \
        -privilege admin \
			   ]

set dotfolio_admin_p [dotfolio::admin_p]

set context_bar [list [list users [_ dotfolio.users]] "$first_names $last_name"]

set dual_approve_return_url [ns_urlencode [dotfolio::get_admin_url]/user-add-type?user_id=$user_id&referer=$return_url]

set approve_user_url "/acs-admin/users/member-state-change?user_id=$user_id&member_state=approved&return_url=$dual_approve_return_url"

set remove_user_url "\[<small><a href=\"[export_vars -base user-nuke {user_id}]\">[_ dotfolio.nuke]</a></small>\]"

set dual_approve_return_url [ns_urlencode [dotfolio::get_admin_url]/user-add-type?user_id=$user_id&referer=$return_url]

ad_return_template
