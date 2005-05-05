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
    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2004-01-02
    @version $Id$
} -query {
    {section ""}
} -properties {
    user_id:onevalue
}

set oacs_site_wide_admin_p [acs_user::site_wide_admin_p]
set user_id [ad_conn user_id]

if {![exists_and_not_null referer]} {
    set referer "[dotfolio::get_admin_url]/users"
}

set guest_p "false"
if { [string equal $type "guest"] } {
    set guest_p "true"
}

ad_return_template
