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
    Search for users.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-09-16
    @version $Id$
}

set title [_ dotfolio.search_users]
set context_bar [list [_ dotfolio.user_search]]

ad_form -name fred -form {
    {query:text {label "hello"} {help_text "hello world this is help"} {html {size 30}}}
}

form create search_users

element create search_users q \
    -label "Search" \
    -help_text "Search for a user based on a name or email." \
    -html {size 40} \
    -datatype text \
    -widget text \
    -optional

set is_request [form is_request search_users]

if {[form is_valid search_users]} {
    set title [_ dotfolio.search_results]

    form get_values search_users q
    db_multirow users get_users {}
}

ad_return_template
