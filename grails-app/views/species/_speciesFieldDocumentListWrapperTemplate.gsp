<%@page import="content.eml.DocSciName"%>
 




<ul class="sidebar_section pre-scrollable" style="clear:both; border:1px solid #CECECE;overflow-x:hidden;list-style:none; width:100%; margin-left:0px;">
<%
            def link = ""
            
            List result = speciesInstance.findRelatedDocuments()
            if(result){
                result.each { 
                        def documentId = it.id
                        String docTitle = it.title
                        String description = it.notes
                        %>
                       <li style="float: left; list-style: none; width:876px; border: 1px solid #CECECE; background-color: #FFF; border-radius:7px;">
                      <g:render template="/species/showSpeciesDocumentTemplate" model="[
        controller:'document', 
        documentInstance:it,
        docId:documentId,
        showFeatured:true, 
        showDetails:false, docTitle:docTitle, desc:description]"/></li>
                    <%
                    }
                    
                    
            }
                                
%>
 </ul>               

   
