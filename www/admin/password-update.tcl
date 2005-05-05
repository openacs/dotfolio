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
    Update password for a specific user.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-01
    @version $Id$
} {
    {user_id:integer}
    {return_url ""}
    {password_old ""}
}

db_1row user_information {}

set context_bar [list [list users Users] [list "user.tcl?user_id=$user_id" "$first_names $last_name"] "[_ dotfolio.update_password]"]

set site_link [ad_site_home_link]

ad_return_template
