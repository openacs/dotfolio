<master>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/dotfolio-ui/dotfolio-grey.css" media="all"/>
</property>

<P>
<div class="visualClear"></div>

<table id="portal-columns">
  <tbody>
    <tr>
      <td id="portal-column-content">
        <div class="visualPadding">
          <div class="documentBorder">
            <if @admin_p@ eq "1">
            <div class="portletOptions">
              [<a href="admin/">#dotfolio.admin#</a>]
            </div>
	    </if>
            <div class="documentContent">
	      <center>
              <listtemplate name="portfolios"></listtemplate>
	      </center>
            </div>
          </div>
        </div>
      </td>
    </tr>
  </tbody>
</table>
