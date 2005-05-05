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

<%
# TODO
# 1. Fix translations
# 2. Add Site-Wide Admin functionality.
%>

<center>
<table bgcolor="#cccccc" cellpadding="5" cellspacing="3" width="95%">
  <tr>
    <th align="left">#dotfolio.user#</th>
    <th align="left">#dotfolio.Username#</th>    
    <if @oacs_site_wide_admin_p@ true and @guest_p@ false>
    <th align="left">#dotfolio.has_dotfolio_space#</th>
    <th align="left">#dotfolio.site_wide_admin#</th>
    </if>
  </tr>

<if @users:rowcount@ gt 0>
<multiple name="users">

<if @users.rownum@ odd>
  <tr bgcolor="#eeeeee">
</if>
<else>
  <tr bgcolor="#d9e4f9">
</else>
  <td align="left">
    <a href="user?user_id=@users.user_id@">@users.last_name@, @users.first_names@</a> (<a href="mailto:@users.email@">@users.email@</a>)
  </td>
  <td align="left">@users.username@</td>

<if @oacs_site_wide_admin_p@ true and @guest_p@ false>

  <if @users.has_dotfolio_p@ true>
    <td align="center"><a href="@users.url@">#dotfolio.yes#</a></td>
  </if>
  <else>
    <td align="center"><a href="create-folio?username=@users.username@">#dotfolio.create#</a></td>
  </else>

 <td align="center">
  <if @user_id@ ne @users.user_id@>
    <if @users.site_wide_admin_p@ true>
      <b>#dotfolio.yes#</b> | <a href="site-wide-admin-toggle?user_id=@users.user_id@&value=revoke&referer=@referer@" title="#dotfolio.revoke_site_wide_admin#">#dotfolio.no#</a>
    </if>
    <else>
      <a href="site-wide-admin-toggle?user_id=@users.user_id@&value=grant&referer=@referer@" title="#dotfolio.grant_site_wide_admin#">#dotfolio.yes#</a> | <b>#dotfolio.no#</b>
    </else>
  </if>
      <else>#dotfolio.yes#</else>
    </td>
</if>
</tr>

</multiple>
</if>
<else>
  <tr bgcolor="#eeeeee">
    <td align="center" colspan="4"><i>#dotfolio.no_users#</i></td>
  </tr>
</else>

</table>
</center>
