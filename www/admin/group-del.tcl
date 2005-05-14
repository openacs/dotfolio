ad_page_contract {

    Deletes the group matching the specified group_id.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} {
    group_id:integer,notnull
}

db_transaction {
    # Delete entry from dotfolio_group_adviser_map.
    db_dml delete_group {}

    # Delete group.
    group::delete $group_id
}

ad_returnredirect "groups"
