#
#  Copyright (C) 2005 WEG
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

    Displays the admin users page.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} -query {
    {type "admin"}
} -properties {
    context_bar:onevalue
    control_bar:onevalue
    referer:onevalue
}

#Pages in this directory are only runnable by dotfolio-wide admins.
dotfolio::require_admin

set context_bar [_ dotfolio.users]
set referer "[dotfolio::get_admin_url]/users"

set dotfolio_roles [db_list_of_lists select_dotfolio_roles {}]

# The roles are stored as message keys in the database so we
# need to localize them on the fly here
set dotfolio_roles_localized [list]
foreach role_pair $dotfolio_roles {
    lappend dotfolio_roles_localized [list [lindex $role_pair 0] \
        [lang::util::localize [lindex $role_pair 1]]]
}

set control_bar [ad_dimensional [list \
    [list type "[_ dotfolio.user_type]:" $type $dotfolio_roles_localized]]]

ad_return_template