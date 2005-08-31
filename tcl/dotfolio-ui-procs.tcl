ad_library { 
    dotfolio procs
    
    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-03-22
    @cvs-id $Id$
}

namespace eval dotfolio::ui {

    ad_proc -private users_organiser_url {
	{-user_id:required}
    } {
	Returns the organise url for the specified user.  Assumes that the
	specified user has a dotfolio site.

	@param user_id The ID for a specific user.
	@return Returns the organiser url for the specified user.
    } {
	set dotfolio_url [dotfolio::user::dotfolio_url -user_id $user_id]
	append dotfolio_url "organise/"
	
	return $dotfolio_url
    }

    ad_proc -public organiser_url {
	{-node_id {}}
    } {
	Returns the organise URL for a given dotfolio site.

	@param node_id The dotfolio site for which to find the organise url.

	@return Returns the  url for the organise tab in the 
	dotfolio-ui package.
    } {
	if {[empty_string_p $node_id]} { 
	    set node_id [site_node::closest_ancestor_package -package_key acs-subsite -node_id [ad_conn node_id] -include_self -element node_id]
	}

	return [lindex [site_node::get_children -node_id $node_id -package_key dotfolio-ui -all] 0]
    }

    ad_proc -private created_rel_p {
	{-user_id:required}
	{-rel_id:required}
    } {
	Checks if the user associated with the user_id created the relation
	associated with the rel_id.

	@param user_id ID for a specific user.
	@param rel_id ID for a relation.

	@return Returns 1 if the user created the relation, otherwise 0.
    } {
        set creation_user_id [db_string creation_user {} -default ""]

	if { [string equal $user_id $creation_user_id] } {
	    return 1
	}
	return 0
    }

    ad_proc is_content_folder_p {
        -object_id
    } {
        Returns t if the object is a content folder.
	Otherwise returns f.

	@param object_id The ID of an object.
    } {
	if {[db_0or1row object_type {}] && \
		[string equal $object_type {content_folder}]} {

	    return 1
	}

	return 0
    }

}
