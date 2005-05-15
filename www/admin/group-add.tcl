ad_page_contract {

    Maps the specified adviser to a newly created group with the given
    group name.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} {
    group_name:notnull,trim
    adviser_id:integer,notnull
}

db_transaction {
    # Create group with given group_name.
    set group_id [group::new -group_name $group_name group]

    # Add adviser to group.
    group::add_member -group_id $group_id -user_id $adviser_id

    # Use group_id from above and insert with adviser_id into
    # dotfolio_group_adviser_map.
    db_dml insert_group_adviser_ids {}
}

ad_returnredirect "groups"
