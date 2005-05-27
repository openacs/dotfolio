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
    Procs for basic dotFOLIO

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-01
    @version $Id$
}

namespace eval dotfolio::user {

    ad_proc get_owner_id {
	{ -node_id "" }
    } {
	Returns the user_id for the owner of a dotfolio that is mounted
        at a node_id.

        @param node_id The node_id for a mounted dotfolio instance.
        This is optional as ad_conn node_id will be used by default.
	@return Returns the owner_id for a dotfolio node_id.
    } {
	if { [empty_string_p $node_id] } {
	    set node_id [ad_conn node_id]
	}

	db_1row select_owner_id {}
	return $owner_id
    }

    ad_proc get_owner_username {
        owner_id
    } {
        Gets the username for the given owner_id.

        @param owner_id The user ID of the dotfolio owner.
        @return Returnshe username for the dotfolio owner that 
        matches the given owner_id.  Otherwise returns the empty string.
    } {
        return [db_string select_username {} -default ""]
    }

    ad_proc owner_p {
        { -node_id "" }
        user_id
    } {
        Returns 1 if the specified user_id is the owner of a dotfolio mounted
        at a node_id.  Otherwise returns 0.

	@param node_id Optional.  Specify if you need to check that a user
        is the owner of a dotfolio mounted at a specific node_id.
	@param user_id A user's user_id.
    } {
        set owner_id [get_owner_id -node_id $node_id]

        return [expr [string equal $user_id $owner_id] ]
    }

    ad_proc portrait_p {
        owner_id
    } {
        Returns 1 if the dotfolio owner has a portrait, other returns 0.

	@param  owner_id The ID of the dotfolio owner.
	@return Returns 1 if the dotfolio owner has a portrait, 
                otherwise returns 0.
    } {
        if {![db_0or1row select_portrait {}] || \
             [empty_string_p $revision_id]} {

	    # The user doesn't have a portrait yet
	    return 0

	} else {
	    return 1
	}

	return 0
    }

    ad_proc html_list_of_advisers {} {

        Returns a list of advisers formatted for an HTML form
	SELECT control.

	@return Returns a list of advisers formatted for an HTML form
	SELECT control.  Otherwise if there are no advisers on record,
	then a link to the user admin page will be returned instead.
    } {
	set list_of_advisers "<SELECT NAME=\"adviser_id\">"
	append list_of_advisers "<OPTION SELECTED>#dotfolio.select_adviser#</OPTION>"

	db_foreach select_advisers {} {

	    append list_of_advisers "<OPTION VALUE=\"$adviser_id\">$adviser_name</OPTION>"

	} if_no_rows {
	    set list_of_advisers ""
	}

	# If no rows were returned, then return a link
	# to user admin instead.
	if { [empty_string_p $list_of_advisers] } {
	    set list_of_advisers "<a class=\"button\" href=\"/dotfolio/admin/users\">#dotfolio.create_adviser#</a>"
	} else {
	    append list_of_advisers "</SELECT>"
	}

	return $list_of_advisers
    }

    ad_proc adviser_p {
        user_id
    } {
        Returns 1 if the specified user_id is an adviser.
	Otherwise returns 0.

	@param user_id A user's user_id.
    } {
        return [db_0or1row adviser_p {}]
    }

    ad_proc dotfolio_url {
        -user_id
    } {
	Returns the url of the user's dotfolio.

	@param user_id A user's user_id.
	@return Returns the url of the user's dotfolio
    } {
        return [db_string dotfolio_url {} -default ""]
    }

    ad_proc get_user_id_from_username {
        -username
    } {
	Returns the user_id for the user with the specified username.
	Otherwise an empty string is returned.

	@param username The username for a user.
	@return Returns the user_id for the user that matches the given
	username.
    } {
        return [db_string select_user_id {} -default ""]
    }

}
