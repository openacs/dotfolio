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
<property name="title">#dotfolio.edit_user#</property>
<property name="">@context_bar@</property>

#dotfolio.youve_chosen_to_edit# <strong>@first_names@ @last_name@</strong>.

<ul>
  <li>Current user type is: @pretty_type@</li>
</ul>

<p></p>

<formtemplate id="edit_user"></formtemplate>
