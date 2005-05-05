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
    Filters out non-dotfolio users, and redirects to relevant pages.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-01
    @version $Id$
}

if { [dotfolio::user_p -user_id [ad_conn user_id]] } {
    # Already a user
    ad_returnredirect .
    ad_script_abort
}

if { [dotfolio::admin_p] } {
    set return_url [export_vars -base "[dotfolio::get_admin_url]/user-add-type" { { user_id {[ad_conn user_id]} } { referer "[dotfolio::get_url]/"} }]
    set self_approve_url [export_vars -base "[apm_package_url_from_key "acs-admin"]users/member-state-change" { { user_id {[ad_conn user_id]} } { member_state approved} return_url }]
    ad_returnredirect $self_approve_url
    ad_script_abort
}