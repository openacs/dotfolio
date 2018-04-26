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
	set packages {}
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

    ad_proc -private group_id_from_user_type {
	{-user_type:required}
    } {
	Retrieves the group_id for the specific user_type.  user_type can
	be one of the following: admin, adviser, owner, or guest.
	
	@param user_type The user_type that we would like the group_id for.
	@return Returns the group_id for the specified user_type.
    } {
	return [db_string get_group_id {} -default ""]
    }

    ad_proc -public create_dotfolio_for_user {
	{-username:required}
	{-owner_id ""}
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

	    set dotfolio_xml [parameter::get -parameter DotfolioXML -package_id [apm_package_id_from_key dotfolio]]
	    ns_log Notice "dotfolio:: $dotfolio_xml"
	    set out [apm::process_install_xml \
			 $dotfolio_xml \
			 [list base_url $base_url \
			      name $username \
			      blog_url $blog_url \
			      files_url $files_url \
			      organise_url $organise_url]]

	    if {$owner_id eq ""} {
		set owner_id [acs_user::get_by_username -username $username]
	    }

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
		-storage_type "text" \
		-is_live "1"]

	    # Add the owner as a member of their dotfolio.
	    set group_id [application_group::group_id_from_package_id \
			      -package_id $package_id]
	    group::add_member -group_id $group_id -user_id $owner_id \
		-rel_type "membership_rel"

	    # Grant the owner write permissions for their dotfolio.
	    permission::grant -party_id $owner_id \
		-object_id $package_id \
		-privilege "write"

	    # Give dotfolio owner admin permission for their blog.
	    array set blog_node_info [site_node::get -url $blog_url]
	    set blog_id $blog_node_info(object_id)
	    permission::grant -party_id $owner_id -object_id $blog_id \
		-privilege "admin"

	    set adviser_group_id [group_id_from_user_type -user_type "adviser"]

	    # Grant advisers permission to add comments to blog entries.
	    permission::grant -party_id $adviser_group_id -object_id $blog_id \
		-privilege "general_comments_create"

	    # Revoke permission for unregistered visitors to comment.
	    permission::revoke -party_id 0 -object_id $blog_id \
		-privilege "general_comments_create"

	    # Give dotfolio owner write and delete permissions for their files.
	    array set files_node_info [site_node::get -url $files_url]

	    # If the package_key is not file storage, the file storage
	    # was not mounted, which might be due to not using it in install.xml
	    if {$files_node_info(package_key) eq "file-storage"} {
		set files_id $files_node_info(object_id)
		permission::grant -party_id $owner_id -object_id $files_id \
		    -privilege "write"
		permission::grant -party_id $owner_id -object_id $files_id \
		    -privilege "delete"
	    }

	    # Do not let organiser node inherit permisisons.  Only the
	    # owner should have access to the organise tab.
	    set organise_node_id [site_node::get_node_id -url $organise_url]
	    array set organise_node_info \
		[site_node::get -node_id $organise_node_id]
	    set organise_id $organise_node_info(package_id)
	    permission::set_not_inherit -object_id $organise_id
	    permission::grant -party_id $owner_id -object_id $organise_id \
		-privilege "admin"

	    callback dotfolio::create_dotfolio -base_url $base_url -owner_id $owner_id
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

    ad_proc has_dotfolio_p {
        -user_id
    } {
        Returns t if the specified user has a dotfolio.
	Otherwise returns f.

	@param user_id A user's user_id.
    } {
        return [db_string has_dotfolio {} -default f]
    }

    ad_proc object_type_pretty_name {
        -object_id
    } {
	Returns the object type pretty name for the specified object.

	@param object_id The ID for a specific object.
    } {
        return [db_string pretty_name {} -default ""]
    }

    ad_proc dimensional {
        {-no_header:boolean}
        {-no_bars:boolean}
        {-link_all 0}
        {-names_in_cells_p 1}
        {-th_bgcolor ""}
        {-td_align "center"}
        {-extra_td_html ""}
        {-table_html_args "border=0 cellspacing=0 cellpadding=3 width=100%"}
	{-class_html ""}
        {-pre_html ""}
        {-post_html ""}
	{-extra_td_selected_p 0}
        option_list
        {url {}}
        {options_set ""}
        {optionstype url}
    } {
        An enhanced ad_dimensional. see that proc for usage details.  This proc
	was taken from new-portal.
    } {
        if {[empty_string_p $option_list]} {
            return
        }
	
        if {[empty_string_p $options_set]} {
            set options_set [ns_getform]
        }
	
        if {[empty_string_p $url]} {
            set url [ad_conn url]
        }
	
        set html "\n<table $table_html_args>\n"
	
        if {!$no_header_p} {
            foreach option $option_list {
                append html "<tr>    <th bgcolor=\"$th_bgcolor\">[lindex $option 1]</th>\n"
            }
        }
    
        append html "  <tr>\n"
	
        foreach option $option_list {
	    
            if {!$no_bars_p} {
                append html "\["
            }
	    
	    
	    if { $names_in_cells_p } {
		set pre_td_html "<td class=\"dimension-section\">"
		set pre_selected_td_html "<td class=\"dimension-section-selected\">"
		set post_html "$post_html</a></td>"
		set end_html ""
		set break_html ""
		set post_selected_html "$post_html"
	    } else {
		append html "    <td align=$td_align>"
		set td_html ""
		set pre_selected_td_html "<strong>"
		set post_selected_html "</strong>$post_html"
		set end_html ""
		set td_html ""
		post_html "$post_html</a>"
		if {!$no_bars_p} {
		    set break_html " | "
		} else {
		    append break_html " &nbsp; "
		}
	    }

            # find out what the current option value is.
            # check if a default is set otherwise the first value is used
            set option_key [lindex $option 0]
            set option_val [lindex $option 2]
            if {![empty_string_p $options_set]} {
                set options_set_val [ns_set get $options_set $option_key]
                if { ![empty_string_p $options_set_val] } {
                    set option_val $options_set_val
                }
            }
	    
            set first_p 1
            foreach option_value [lindex $option 3] {
                set thisoption_name [lindex $option_value 0]
                # We allow portal page names to have embedded message catalog keys
                # that we localize on the fly
                set thisoption_value [ad_quotehtml [lang::util::localize [lindex $option_value 1]]]
                set thisoption_link_p 1
                if {[llength $option_value] > 3} {
                    set thisoption_link_p [lindex $option_value 3]
                }

                if {$first_p} {
                    set first_p 0
		} else {
		    append html $break_html
                }
		
                if {([string equal $option_val $thisoption_name] == 1 && !$link_all) || !$thisoption_link_p} {
                    append html "${pre_selected_td_html}${pre_html}${thisoption_value}${post_selected_html}\n"
                } else {
                    append html "${pre_td_html}<a href=\"$url?[export_ns_set_vars url $option_key $options_set]&[ns_urlencode $option_key]=[ns_urlencode $thisoption_name]\">${pre_html}${thisoption_value}${post_html}\n"
                }
            }

            if {!$no_bars_p} {
                append html "\]"
            }
	    if {$extra_td_selected_p} {
		append html "${pre_selected_td_html}${pre_html}$extra_td_html${post_html}\n"
	    } else {
		append html "${pre_td_html}$extra_td_html${post_html}\n"
	    }
        }

        append html "  </tr>\n$end_html</table>\n"
    }

}
