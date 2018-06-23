<%
#
#  Copyright (C) 2001, 2002 WEG
#
#  This file is part of dotFOLIO.
#
#  dotFOLIO is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation; either version 2 of the License, or (at your 
#  option) any later version.
#
#  dotFOLIO is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#
%>

<master src="dotfolio-admin-master">
<property name="title">@first_names@ @last_name@</property>
<property name="context_bar">@context_bar@</property>

<h3>#dotfolio.general_information#</h3>

<ul>

  <li>
    #dotfolio.name#
    @first_names@ @last_name@
  <if @oacs_site_wide_admin_p;literal@ true> 
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">#dotfolio.edit#</a> </small>]
  </if>
  </li>

  <li>
    #dotfolio.Username#:
    @username@
  </li>

  <li>
    #dotfolio.email#
    <a href="mailto:@email@">@email@</a>
  <if @oacs_site_wide_admin_p;literal@ true>
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">#dotfolio.edit#</a> </small>]
  </if> 
  </li>

  <li>
    #dotfolio.screen_name#:
    @screen_name;noquote@
  <if @oacs_site_wide_admin_p;literal@ true>
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">#dotfolio.edit#</a> </small>]
  </if>
  </li>

  <li>
    #dotfolio.user_id_1#:
    @user_id@
  </li>

  <li>
    #dotfolio.registration_date#:
    @registration_date@
  </li>

<if @last_visit@ not nil>
  <li>
    #dotfolio.last_visit#:
    @last_visit@
  </li>
</if>
<else>
  <li>
    #dotfolio.not_visited#: @remove_user_url;noquote@
  </li>
</else>

<if @portrait_p;literal@ true>
  <li>
    #dotfolio.portrait#: <a href="/shared/portrait?user_id=@user_id@">@portrait_title@</a>
  </li>
</if>

  <li>
    #dotfolio.member_state#
    @member_state@
  <if @oacs_site_wide_admin_p;literal@ true> 
    @change_state_links;noquote@
  </if>
  </li>

</ul>

<%
# Modify
%>

<h3>#dotfolio.dotfolio_info#</h3>

<if @dotfolio_user_p;literal@ true>

<ul>

  <li>
    #dotfolio.user_type#:
    <%= [lang::util::localize @pretty_type@] %>
    [<small> <a href="user-edit?@export_edit_vars@">#dotfolio.edit#</a> </small>]
  </li>

  <li>
    #dotfolio.id_1#:
    <if @id@ nil>#dotfolio.ltnone_set_upgt#</if><else>@id@</else>
  </li>

</ul>

</if>
<else>
<p>
<if @member_state@ eq "approved">
  <a href="user-add-type?user_id=@user_id@&referer=@return_url@">#dotfolio.add_to_dotfolio#</a>
</if>
<else>
#dotfolio.user_is_current#.
</else>
</p>
</else>

<h3>#dotfolio.administrative_actions#</h3>

<ul>
  <li><a href="password-update?@export_edit_vars@">#dotfolio.update_users_passwd#</a></li>
  <if @portrait_p;literal@ true>
    <li><a href="/user/portrait/index.tcl?@export_edit_vars@">#dotfolio.manage_users_portrait#</a></li>
  </if>
 <if @oacs_site_wide_admin_p@ true or @dotfolio_admin_p@ true>
  <li><a href="/acs-admin/users/become?user_id=@user_id@">#dotfolio.become_this_user#!</a></li>
 </if> 
</ul>
