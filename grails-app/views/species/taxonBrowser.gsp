<%@page import="species.TaxonomyDefinition.TaxonomyRank"%>
<%@ page import="species.Species"%>
<%@ page import="species.Classification"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="layout" content="main" />

<g:set var="entityName"
	value="${message(code: 'species.label', default: 'Species')}" />
<title>Taxonomy Browser</title>

<r:require modules="species_show"/>

</head>
<body>
    <div class="span12">
        <s:showSubmenuTemplate model="['entityName':'Taxonomy Browser']"/>

            <div class="taxonomyBrowser sidebar_section" style="position: relative;" data-name="classification" data-speciesid="${speciesInstance?.id}">
                <h5>Classifications</h5>	

                <div id="taxaHierarchy">

                    <%
                    def classifications = [];
                    Classification.list().each {
                    classifications.add([null, it, null]);
                    }
                    classifications = classifications.sort {return it[1].name};
                    %>

                    <g:render template="/common/taxonBrowserTemplate" model="['classifications':classifications, 'expandAll':false]"/>
                </div>
            </div>
            <a id="inviteCurators" class="btn btn-primary" href="#inviteCuratorsDialog" role="button" data-toggle="modal" data-invitetype='curator'><i
                class="icon-envelope"></i> <g:message code="userGroup.members.label"
                default="Invite Curators" /> </a>
            <a id="inviteContributors" class="btn btn-primary" href="#inviteContributorsDialog" role="button" data-toggle="modal" data-invitetype='contributor'><i
                class="icon-envelope"></i> <g:message code="userGroup.members.label"
                default="Invite Contributors" /> </a>

            <div class="modal hide fade" id="inviteCuratorsDialog" tabindex='-1'
                role="dialog" aria-labelledby="inviteCuratorsModalLabel"
                aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="inviteCuratorsModalLabel">Invite curators</h3>
                </div>
                <div class="modal-body">
                    <p>Send an invitation to add curator</p>
                    <div>
                        <div class="inviteMsg_status"></div>
                        <form method="post"
                            style="background-color: #F2F2F2;">
                            <sUser:selectUsers model="['id':'curator']" />
                            <input type="hidden" name="userIds" />
                            <input type="hidden" name="invitetype" value="curator" />
                            <textarea class="inviteMsg comment-textbox" placeholder="Please write a note to invite curator."></textarea>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">Close</a>
                    <a href="#" class="inviteButton btn btn-primary">Invite</a>
                </div>
            </div>


            <div class="modal hide fade" id="inviteContributorsDialog" tabindex='-1'
                role="dialog" aria-labelledby="inviteContributorsModalLabel"
                aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="inviteContributorsModalLabel">Invite contributors</h3>
                </div>
                <div class="modal-body">
                    <p>Send an invitation to add contributors</p>
                    <div>
                        <div class="inviteMsg_status"></div>
                        <form method="post"
                            style="background-color: #F2F2F2;">
                            <sUser:selectUsers model="['id':'contributor']" />
                            <input type="hidden" name="userIds" />
                            <input type="hidden" name="invitetype" value="contributor" />
                            <textarea class="inviteMsg comment-textbox" placeholder="Please write a note to invite contributor."></textarea>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">Close</a>
                    <a href="#" class="inviteButton btn btn-primary">Invite</a>
                </div>
            </div>

        </div>
        <g:javascript>
        var taxonRanks = [];
            <g:each in="${TaxonomyRank.list()}" var="t">
            taxonRanks.push({value:"${t.ordinal()}", text:"${t.value()}"});
            </g:each>

            </g:javascript>	

        <r:script>
        $(document).ready(function() {
            var taxonBrowser = $('.taxonomyBrowser').taxonhierarchy({
                expandAll:false
            });	
        });
        </r:script>
    </body>
</html>
