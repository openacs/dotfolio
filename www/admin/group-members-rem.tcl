ad_page_contract {

    Removes the given list of users to the specified group.

    @author Deds Castillo (deds@i-manila.com.ph)
    @creation-date 2005-09-30
    @arch-tag: c144d674-1dab-49d0-8fc4-3bb1cf24b533
    @cvs-id $Id$
} {
    group_id:integer,notnull
    user_id:integer,multiple
} 

set title "[_ dotfolio.remove_members]"
set context [list [list groups "[_ dotfolio.groups]"] $title]

set user_id_list [split $user_id]

template::list::create \
    -name members \
    -multirow members \
    -elements {
        first_names {
            label "[_ acs-kernel.First_Names]"
        }
        last_name {
            label "[_ acs-kernel.Last_Name]"
        }
        email {
            label "[_ acs-kernel.Email_Address]"
        }
    }

db_multirow members members {}

set group_name [group::get_element -group_id $group_id -element group_name]
set remove_url [export_vars -base group-members-rem-2 {group_id {user_id:multiple $user_id_list}}]
set cancel_url [export_vars -base group-members {group_id}]
