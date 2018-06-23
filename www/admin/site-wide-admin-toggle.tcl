#
#  Copyright (C) 2005 OpenACS
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

# dotfolio/www/admin/site-wide-admin-toggle.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Jan 12, 2002
    @version $Id$
} -query {
    user_id
    value
    {referer "users"}
}

#Pages in this directory are only runnable by dotfolio-wide admins.
dotfolio::require_admin

if { ![acs_user::site_wide_admin_p] } {
    ns_log notice "user has tried to site-wide-admin-toggle  without permission"
    ad_return_forbidden \
	"Permission Denied" \
	"<blockquote>
         You don't have permission to see this page.
         </blockquote>"
}

if {[string equal $value "grant"] == 1} {
    ad_permission_grant $user_id [acs_magic_object "security_context_root"] "admin"
} elseif {[string equal $value "revoke"] == 1} {
    ad_permission_revoke $user_id [acs_magic_object "security_context_root"] "admin"
}

#
# Flush all permission checks pertaining to this user.
#
permission::cache_flush -party_id $user_id
    
ad_returnredirect $referer
