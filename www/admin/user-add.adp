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

<!--
  @author Nick Carroll (ncarroll@ee.usyd.edu.au)
  @version $Id$
-->

<master src="dotfolio-admin-master">
<property name="title">#dotfolio.add_a_user#</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="focus">register.email</property>

<h3>#dotfolio.add_a_new_user#</h3>


<include src="/packages/acs-subsite/lib/user-new" next_url="@next_url;noquote@" self_register_p="0"/>
