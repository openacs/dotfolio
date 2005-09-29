<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">
<!-- packages/dotfolio/www/admin/group-members-rem.xql -->
<!-- @author Deds Castillo (deds@i-manila.com.ph) -->
<!-- @creation-date 2005-09-30 -->
<!-- @arch-tag: 49dcfa6d-9491-4908-bed3-9a41ac82b4ec -->
<!-- @cvs-id $Id$ -->

<queryset>

  <fullquery name="members">
    <querytext>
      select first_names, last_name, email
      from cc_users
      where user_id in ([join $user_id_list ,])
    </querytext>
  </fullquery>
  
</queryset>
