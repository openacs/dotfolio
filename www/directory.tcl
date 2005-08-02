ad_page_contract {
    Directory page lists all portfolios in the system.

    @author  Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-07-18
    @cvs-id  $Id$
} -query {
    {section All}
} -properties {
    control_bar:onevalue
}

set title [_ dotfolio.directory]
set context [_ dotfolio.directory]

set dimension_list {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}
foreach dimension $dimension_list {
    lappend dimensions [list $dimension $dimension {}]
}
lappend dimensions [list Other Other {}]
lappend dimensions [list All All {}]

set control_bar [dotfolio::dimensional -no_bars [list [list section {} $section $dimensions]]]


set elements {
    name {
        label {\#dotfolio.directory_listing_of_eportfolios\#}
        link_url_col url
    }
}

template::list::create \
    -name portfolios \
    -elements $elements \
    -no_data "#dotfolio.no_portfolios_in_section#"

set query "portfolios"

if { [string match Other $section] } {
    append query "_other"
} elseif { [string match All $section] } {
    append query "_all"
}

db_multirow portfolios $query {} {}

ad_return_template
