<!DOCTYPE html>
<%@page import="species.groups.UserGroup"%>
<%@page import="species.utils.Utils"%>
<%@page
	import="org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils"%>
<html  xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" 
      xmlns:fb="https://www.facebook.com/2008/fbml">
<head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb#">
    
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title><g:layoutTitle/></title>
<r:layoutResources />
<ckeditor:resources />

<g:layoutHead />

<g:set var="domain" value="${Utils.getDomain(request)}"/>
<g:if test="${domain.equals(grailsApplication.config.ibp.domain) }">
    <link rel="shortcut icon" href="/sites/default/files/ibp_favicon_2.png"
		type="image/x-icon" />
</g:if>
<g:else>
    <link rel="shortcut icon"
		href="/sites/all/themes/wg/images/favicon.png" type="image/x-icon" />
</g:else>

<script src="https://www.google.com/jsapi" type="text/javascript"></script>

<r:require modules="observations_list" />

<g:set var="userGroupInstance" value="${userGroupInstance}"/>
<g:if test="${userGroupInstance && userGroupInstance.theme}">
	<link rel="stylesheet" type="text/css"
		href="${resource(dir:'group-themes', file:userGroupInstance.theme + '.css')}" />
</g:if>

<g:if test="${params.action !='show'}">
    <meta name="description" content="Welcome to the India Biodiversity Portal (IBP) - A repository of information designed to harness and disseminate collective intelligence on the biodiversity of the Indian subcontinent.">
</g:if>


</head>
<body>
	<div id="loading" class="loading" style="display: none;">
		<span>Loading ...</span>
	</div>
	<div id="postToUGroup" class="overlay" style="display: none;">
        <i class="icon-plus"></i>
    </div>
	<div id="species_main_wrapper" style="clear: both;">
		<domain:showIBPHeader model="['userGroupInstance':userGroupInstance]" />

                <div class="container outer-wrapper">
                

			<div>
				<div style="padding: 10px 0px; margin-left: -20px">
					<g:layoutBody />
				</div>
			</div>
		</div>


		<domain:showIBPFooter />

	</div>
	<div id="feedback_button" onclick="location.href='/feedback_form';" style="left: -10px;z-index:1000;"></div>
	<r:layoutResources />
</body>
</html>
