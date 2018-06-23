<master>
<property name="title">@title@</property>
<property name="context">@context@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="@dotfolioCSS@" media="all"/>
</property>

<P>
<div class="visualClear"></div>

<table id="portal-columns">
  <tbody>
    <tr>
      <td id="portal-column-content">
        <div class="visualPadding">
          <div class="documentBorder">
            <if @admin_p;literal@ true>
            <div class="portletOptions">
              @options;noquote@
            </div>
	    </if>
            <div class="documentContent">
              <slave>
            </div>
          </div>
        </div>
      </td>
    </tr>
  </tbody>
</table>
