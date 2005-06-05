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

ad_library {
    Procs to manage dotFOLIO Security

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-01
    @version $Id$
}

namespace eval dotfolio::security {

    ad_proc -private do_abort {} {
        Do an abort if security violation
    } {
        ad_returnredirect "not-allowed"
        return -code error
    }

    ad_proc -public admin_p {
        {-user_id ""}
    } {
        check if a user is admin for dotFOLIO
    } {
        return [permission::permission_p -party_id $user_id -object_id \
		    [dotfolio::get_package_id] -privilege admin]
    }

    ad_proc -public require_admin {
        {-user_id ""}
    } {
        Require that a user have admin privileges on all of dotfolio
    } {
        if {![admin_p -user_id $user_id]} {
            do_abort
        }
    }

    ad_proc -public user_p {
        {-user_id:required}
    } {
        Check if a user is a dotFOLIO user
    } {
        return [db_string select_count {}]
    }

    ad_proc -public get_user_types_as_options {
	{-ignore_guest "false"}
} {
	Returns the list of possible user types as a list of options

        @param ignore_guest True if guest should be ignored from the list of
        user types.  Set to false to include the guest user type.  The default
        is false.
    } {
	if { $ignore_guest } {
	    # Get list of users.  Note that query ignores guest user type.
	    # We do not want to revert admins, owners or advisers back to guest.
	    set unlocalized_list [db_list_of_lists select_user_types_as_options_without_guest {}]
	} else {
	    set unlocalized_list [db_list_of_lists select_user_types_as_options {}]
	}

        set localized_list [list]
        foreach type_pair $unlocalized_list {
            lappend localized_list [list [lang::util::localize [lindex $type_pair 0]] [lindex $type_pair 1]]
        }

        return $localized_list
    }

}