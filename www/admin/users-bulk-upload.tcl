#
#  Copyright (C) 2005 Nick Carroll
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

    Allows for bulk upload of users from a CSV file.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-01-02
    @version $Id$

}


#Pages in this directory are only runnable by dotfolio-wide admins.
dotfolio::require_admin

set context_bar [list [list users [_ dotfolio.users]] [_ dotfolio.bulk_upload]]

ad_return_template
