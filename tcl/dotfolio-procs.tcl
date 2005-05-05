ad_library { 
    dotfolio procs
    
    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-03-22
    @cvs-id $Id$
}

namespace eval dotfolio {

    ad_proc -private packages_no_mem {
	-node_id
    } {
	return a list of packages for the subsite containing node_id

	@author Jeff Davis davis@xarg.net
	@creation-date 2004-05-07
	@see dotfolio::packages
    } {
	# need to strip nodes which have no mounted package...
	set packages [list]
	foreach package [site_node::get_children -all -node_id $node_id -element package_id] {
	    if {![empty_string_p $package]} {
		lappend packages $package
	    }
	}
	
	return $packages
    }

    ad_proc -public packages {
	-node_id
    } {
	Return a list of packages for the subsite containing node_id

	Memoized function.
	
	@author Jeff Davis davis@xarg.net
	@creation-date 2004-05-07
	@see dotfolio::packages_no_mem
    } {
	set subsite_node_id [site_node::closest_ancestor_package \
				 -package_key acs-subsite \
				 -node_id $node_id \
				 -include_self \
				 -element node_id]
	
	return [util_memoize [list dotfolio::packages_no_mem -node_id $subsite_node_id] 1200]
    }

    ad_proc -public create_dotfolio_for_user {
	{-username:required}
    } {
	Creates a dotfolio space for the a user with the specified username.

	@param username Must supply a valid username.  A dotfolio space is
	created with the given username.
	@return Returns 1 if the dotfolio space was successfully created,
	otherwise 0 is returned.
    } {
	set user_id [ad_conn user_id]
	set peeraddr [ad_conn peeraddr]

	set base_url "/$username"

	# Set success flag to fail by default.
	set success 0

	db_transaction {

	    # set the mount location for the blogger
	    set blog_url "$base_url/blog"
    
	    # set the mount location for file-storage
	    set files_url "$base_url/files"

	    # set the mount location for dotfolio-ui
	    set organise_url "$base_url/organise"

	    set out [apm::process_install_xml \
			 /packages/dotfolio/lib/install.xml \
			 [list base_url $base_url \
			      name $username \
			      blog_url $blog_url \
			      files_url $files_url \
			      organise_url $organise_url]]

	    set owner_id [acs_user::get_by_username -username $username]
	    set node_id [site_node::get_node_id -url $base_url]
	    array set node_info [site_node::get -node_id $node_id]
	    set package_id $node_info(package_id)

	    # create new folder
	    set folder_id [content::folder::new \
			       -name $package_id \
			       -label "dotFOLIO Folder" \
			       -package_id $package_id \
			       -context_id $package_id]

	    # register content types
	    content::folder::register_content_type \
		-folder_id $folder_id \
		-content_type "content_revision" \
		-include_subtypes "t"
    
	    # Get first names and last name of user for default
	    # welcome note.
	    db_1row get_users_names {}

	    # Create a default welcome note for user's portfolio.
	    set welcome_content_id [content::item::new \
	        -name "welcome" \
		-parent_id $folder_id \
		-title "$first_names $last_name" \
		-text [_ dotfolio.default_welcome_note] \
		-storage_type "text"]

	    db_dml set_live {}
    
	    # Add the owner as a member of their dotfolio.
	    set group_id [application_group::group_id_from_package_id \
			      -package_id $package_id]
	    group::add_member -group_id $group_id -user_id $owner_id \
		-rel_type "admin_rel"

	    # Give dotfolio owner admin permission for their blog.
	    array set blog_node_info [site_node::get -url $blog_url]
	    set blog_id $blog_node_info(object_id)
	    permission::grant -party_id $owner_id -object_id $blog_id \
		-privilege "admin"

	    # Give dotfolio owner write and delete permissions for their files.
	    array set files_node_info [site_node::get -url $files_url]
	    set files_id $files_node_info(object_id)
	    permission::grant -party_id $owner_id -object_id $files_id \
		-privilege "write"
	    permission::grant -party_id $owner_id -object_id $files_id \
		-privilege "delete"
    
	    db_exec_plsql create_dotfolio {}

	    # Set success flag to 1 to reflect successful creation of
	    # the user's dotfolio space.
	    set success 1
	}

	return $success
    }

    ad_proc -public get_folder_id {
	{-package_id ""}
    } {
	Return content repository folder_id for the
	specified dotfolio package_id.
    
	@param package_id If not speicifed use the current package_id from
	ad_conn. It there is no current connection or folder does not
	exist, returns empty string.

	@return 
    
	@error 
    } {

	if {$package_id eq ""} {
	    if  {[ad_conn -connected_p]} {
		set package_id [ad_conn package_id]
	    } else {
		return ""
	    }
	}
	return [db_string get_folder_id \
	    "select folder_id from cr_folders where package_id=:package_id" \
	    -default ""]
    }

    ad_proc -public package_key {} {
	returns the package key
    } {
	return dotfolio
    }

    ad_proc -public get_url {} {
	returns the root URL for dotFOLIO
    } {
	return "/[package_key]"
    }

    ad_proc -public get_admin_url {} {
	returns the root admin URL for dotFOLIO
    } {
	return "[get_url]/admin"
    }

    ad_proc -public get_node_id {} {
	return the root node id for dotFOLIO
    } {
	return [site_node::get_node_id -url [get_url]]
    }

    ad_proc -public get_package_id {} {
	return the package ID for dotFOLIO
    } {
        return [site_node::get_object_id -node_id [get_node_id]]
    }

    ad_proc -public get_rel_type_from_user_type {
	-type
    } {
	Returns the appropriate rel_type base on user type and access level.
    } {
	return "dotfolio_${type}_profile_rel"
    }

}
