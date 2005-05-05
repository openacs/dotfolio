ad_library {
    
    APM callbacks for the dotfolio package
    
    @author nick.c@rroll.net
    @creation-date 2005-04-04
    @cvs-id $Id$
}

namespace eval dotfolio::install {

    ad_proc -public after_install {
    } {
        Configure kernel to use usernames instead of email for logins.
	dotfolio relies on usernames to create portfolio spaces for users.
	
	@return 
    
	@error 
    } {
	parameter::set_from_package_key -package_key "acs-kernel" \
	                                -parameter "UseEmailForLoginP" \
	                                -value "0"
    }

}