<%

#
#  Copyright (C) 2005 Nick Carroll
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
  @author Nick Carroll (nick.c@rroll.net)
  @version $Id$
-->

<master src="dotfolio-admin-master">
<property name="title">#dotfolio.bulk_upload#</property>
<property name="context_bar">@context_bar@</property>

#dotfolio.create_several_users_at_once#

<p>

#dotfolio.use_valid_email_address#

<p>

<div style="font-size: large; font-weight: bold;">#dotfolio.csv_file_format#</div>

<p style="text-indent: 1em">

  <strong>#dotfolio.first_line#</strong>

  <p style="text-indent: 2em">
    #dotfolio.first_line_of_file_must_be#

    <div style="text-indent: 3em; font-family: monospace">
      first_names,last_name,email,username,password,type
    </div>
  </p>

</p>

<p style="text-indent: 1em">

  <strong>#dotfolio.fields#</strong>

  <ul>
    <li><tt>first_names</tt> - <em>#dotfolio.required#</em>
    <li><tt>last_name</tt> - <em>#dotfolio.required#</em>
    <li><tt>email</tt> - <em>#dotfolio.required#</em>
    <li><tt>username</tt> - <em>#dotfolio.required#</em>
    <li><tt>password</tt> - <em>#dotfolio.optional_defaults_to_random_value#</em>
    <li><tt>type</tt> - <em>#dotfolio.required#</em> #dotfolio.must_have_values#
      <ul>
        <li>adviser</li>
        <li>owner</li>
        <li>admin</li>
	<li>guest</li>
      </ul>
  </ul>

</p>

<p style="text-indent: 1em">

  <strong>#dotfolio.example_file#</strong>

  <pre>
    first_names,last_name,email,username,password,type
    Joe,Student,joe@_somewhere_.net,joestue,4jfe3,student
    Albert,Einstein,al@_school_.edu,al,,adviser
    Systems,Hacker,syshacker@_company_.com,syshackr,,guest
  </pre>

</p>

<p style="text-indent: 1em">

  <div style="font-size: large; font-weight: bold;">#dotfolio.upload_formatted_csv#</div>

  <p style="padding-left: 1em">

    <FORM enctype=multipart/form-data method=post action=users-bulk-upload-2>
    <INPUT TYPE=file name=users_csv_file>
    <br>
    <br>
    <INPUT TYPE=submit value="#dotfolio.upload#">
    </FORM>
  </p>
</p>