ad_page_contract {

    Displays a list of groups.  Each group must have at least one 
    adviser assigned to it.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} -properties {
    context_bar:onevalue
}

set context_bar [_ dotfolio.groups]

db_multirow -extend {extra_form_part} groups select_groups {} {
    set extra_form_part "<a href=\"[export_vars -url -base group-del {group_id}]\">#dotfolio.delete#</a>"
}

template::list::create \
    -name groups \
    -multirow groups \
    -no_data [_ dotfolio.no_groups_created] \
    -elements {
	group_name {
	    label "#dotfolio.group_name#"
	    display_template {
		@groups.group_name;noquote@
	    }
	}
	adviser {
	    label "#dotfolio.adviser_role_pretty_name#"
	    display_template {
		@groups.adviser;noquote@
	    }
	}
	extra_form_part {
	    display_template {
		@groups.extra_form_part;noquote@
	    }
	}
    }

set new_group_form_part_name "<p align=\"top\"><form name=\"new_group\" action=\"group-add\"><input name=\"group_name\" type=\"text\" size=\"20\">"

set new_group_form_part_adviser [dotfolio::user::html_list_of_advisers]
set new_group_form_part_button "<input type=\"submit\" value=\"#dotfolio.create_group#\"></form></p>"

template::multirow append groups $new_group_form_part_name \
    $new_group_form_part_adviser "" $new_group_form_part_button

ad_return_template
