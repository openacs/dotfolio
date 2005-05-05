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
<property name="title">#dotfolio.users#</property>
<property name="context_bar">@context_bar;noquote@</property>

[<small>
  <a href="user-add?referer=@referer@"><small>#dotfolio.create_a_new_user#</small></a> 
  |
  <a href="users-search"><small>#dotfolio.search_users#</small></a>
  |
  <a href="users-bulk-upload"><small>#dotfolio.bulk_upload#</small></a>
</small>]

<p></p>

<p>@control_bar;noquote@</p>

<include src="users-chunk-small" type=@type@ referer="@referer@?type=@type@">
