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
<property name="title">#dotfolio.update_password#</property>
<property name="context_bar">@context_bar@</property>

<form method="post" action="password-update-2">
  <input type="hidden" name="user_id" value="@user_id@">
  <input type="hidden" name="return_url" value="@return_url@">

<table>
  <tr>
    <th>#dotfolio.new_password#</th>
    <td><input type="password" name="password_1" size="15"></td>
  </tr>

  <tr>
    <th>#dotfolio.confirm#</th>
    <td><input type="password" name="password_2" size="15"></td>
  </tr>
</table>

<br>
<br>

<center>
  <input type="submit" value="#dotfolio.update#">
</center>
</form>
