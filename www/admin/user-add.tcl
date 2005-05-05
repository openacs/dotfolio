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
    Adds a user to dotFOLIO.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-01
    @version $Id$
} {

    {type owner}
    {referer "[dotfolio::get_admin_url]/users"}

} -properties {
    context_bar:onevalue
}

set current_user_id [ad_maybe_redirect_for_registration]

#Pages in this directory are only runnable by dotfolio-wide admins.
dotfolio::require_admin
set context_bar [list [list users [_ dotfolio.users]] [_ dotfolio.add_user]]

# Export dotfolio-specific vars in the next_url
set next_url [export_vars -base user-add-2 {type referer}]
