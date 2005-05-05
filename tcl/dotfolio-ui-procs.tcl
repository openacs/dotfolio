ad_library { 
    dotfolio procs
    
    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-03-22
    @cvs-id $Id$
}

namespace eval dotfolio::ui {

    ad_proc -public organiser_url {
	{-node_id {}}
    } {
	Returns the cop-ui URL for a given subsite.

	@param subsite_id the subsite for which to find the cop-ui url

	@return a url for the dotfolio-ui package
    } {
	if {[empty_string_p $node_id]} { 
	    set node_id [site_node::closest_ancestor_package -package_key acs-subsite -node_id [ad_conn node_id] -include_self -element node_id]
	}

	return [lindex [site_node::get_children -node_id $node_id -package_key dotfolio-ui -all] 0]
    }

}
