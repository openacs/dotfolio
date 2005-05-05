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

    Displays admin page for editing a dotFOLIO user's properties.

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

db_1row select_user_info {}

set options [dotfolio::get_user_types_as_options -ignore_guest "true"]

ad_form -name edit_user -export {referer user_id} -form {

    # Use the user's username for their dotfolio id.
    {id:text(hidden)
	{value $username}
    }

    {type:text(select)
	{label "[_ dotfolio.user_type]"}
	{options $options}
    }

} -on_submit {

    db_transaction {
	# remove the user
	dotfolio::user_remove -user_id $user_id

	# add the user
	dotfolio::user_add -id $id -type $type -user_id $user_id
    }

} -after_submit {
    ad_returnredirect $referer
    ad_script_abort
}

set context_bar [list [list users [_ dotfolio.users]] [_ dotfolio.edit]]

ad_return_template
