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
<property name="context_bar">@context_bar@</property>

@first_names@ @last_name@ #dotfolio.has_been_added_to# @system_name@.
#dotfolio.edit_message_and_hit_send#

<p></p>

<form method="post" action="user-add-3">
  @export_vars;noquote@
  #dotfolio.message#

  <p></p>

  <textarea name="message" rows="10" cols="70" wrap="hard">
  #dotfolio.registered_user_welcome_email_body#
  </textarea>

  <p></p>

  <input type="submit" value="#dotfolio.send_email#">
</form>
