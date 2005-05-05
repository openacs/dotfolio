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

namespace eval dotfolio {

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

    ad_proc -public user_add {
	{-type owner}
	{-id ""}
	{-user_id:required}
    } {
	Add a user as a dotfolio user.
    } {
	# Check if the user is already a dotfolio user
	if {[user_p -user_id $user_id]} {
	    return
	}

	# Set default ID to email address
	if {[empty_string_p $id]} {
	    set id [cc_email_from_party $user_id]
	}

	# set up extra vars
	set extra_vars [ns_set create]
	ns_set put $extra_vars user_id $user_id
	ns_set put $extra_vars id $id

	# Add the relation (no need for object_id_one or two).
	set rel_id [relation_add \
	    -extra_vars $extra_vars \
	    -member_state approved \
	    [get_rel_type_from_user_type -type $type] \
	    "" \
            $user_id \
        ]

	return $rel_id
    }

    ad_proc -public user_remove {
        {-user_id:required}
    } {
        Remove a user from the set of dotFOLIO users
    } {
        set rel_id [db_string select_rel_id {} -default ""]

        if {![empty_string_p $rel_id]} {
            relation_remove $rel_id
        }
    }
}