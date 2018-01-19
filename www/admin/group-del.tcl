ad_page_contract {

    Deletes the group matching the specified group_id.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} {
    group_id:integer,notnull
}

set context [list [list groups "[_ dotfolio.groups]"] "[_ dotfolio.delete_group]"]

ad_form \
    -name del_group \
    -cancel_url "groups" \
    -export { group_id } \
    -form {
        {group_members:text(inform)  {label "[_ dotfolio.group_members]"}}
        {prompt:text(inform) {label "[_ dotfolio.confirm]"} {value "[_ dotfolio.continue_with_delete_group]"}}
    } \
    -on_request {
        set group_members [join [db_list get_member_names {}] "<br />"]
    } \
    -on_submit {
        db_transaction {
            # Delete entry from dotfolio_group_adviser_map.
            db_dml delete_group {}
            
            # Delete group.
            group::delete $group_id
        }
    } \
    -after_submit {
        ad_returnredirect "groups"
	ad_script_abort
    }
