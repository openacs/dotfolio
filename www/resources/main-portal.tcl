ad_page_contract {

    Simple portal page featuring a main portlet.

    @author  Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-03-24
    @cvs-id  $Id$
} {

}


if { ![info exists title] } {
    set title {}
}

if { ![info exists context] } {
    set context {}
}

if { ![info exists header_stuff] } {
    set header_stuff {}
}

if { ![info exists options] } {
    set options {}
}

set package_id [ad_conn package_id]

set admin_p [ad_permission_p $package_id admin]
