ad_page_contract {

    Removes the given list of users to the specified group.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} {
    group_id:integer,notnull
    user_id:integer,multiple
} 

set count 0
# For each member in the list of user IDs, add that user to the group.
foreach user $user_id {
    group::remove_member -group_id $group_id -user_id $user
    incr count
}

ad_returnredirect -message "Removed $count users from group" [export_vars -url -base {group-members} {group_id}]
