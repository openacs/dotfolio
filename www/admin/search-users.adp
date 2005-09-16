<master src="dotfolio-admin-master">
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

<center>
<if @is_request@ ne 0>
  <formtemplate id="search_users">
    <table cellspacing="2" cellpadding="2" border="0">
      <tr class="form-element">
        <td class="form-label">#dotfolio.search#</td>
        <td class="form-widget">
          <formwidget id="q"></formwidget>
          <div class="form-help-text">
            <img src="/shared/images/info.gif" width="12" height="9" alt="[i]" title="Help text" border="0">
            #dotfolio.search_help_text#
          </div>
        </td>
      </tr>
      <tr class="form-element">
        <td align="left" colspan="2">
          <input type="submit" name="formbutton:ok" value="       OK       " />
        </td>
      </tr>
    </table>
  </formtemplate>
</if>
<else>
  <table class="list" cellpadding="3" cellspacing="3">
    <tr class="list-header">
      <th class="list">#dotfolio.name#</th>
      <th class="list">#dotfolio.Username#</th>
      <th class="list">#dotfolio.user_type#</th>
    </tr>
  <if @users:rowcount@ eq 0>
    <tr class="list-odd last"><td colspan="3" align="center">#dotfolio.no_users_found#</td></tr>
  </if>
  <multiple name="users">
    <if @users.rownum@ lt @users:rowcount@>
      <if @users.rownum@ odd>
        <tr class="list-odd">
      </if>
      <else>
        <tr class="list-even">
      </else>
    </if>
    <else>
      <if @users.rownum@ odd>
        <tr class="list-odd last">
      </if>
      <else>
        <tr class="list-even last">
      </else>
    </else>
      <td>@users.last_name;noquote@, @users.first_names;noquote@ (<a href="mailto:@users.email@">@users.email@</a>)</td>
      <td>@users.username;noquote@</td>
      <td>@users.user_type;noquote@</td>
    </tr>
    </if>
  </multiple>
  </table>
</else>
</center>