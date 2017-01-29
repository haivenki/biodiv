<%@ page import="species.Synonyms"%>
<%@ page import="species.CommonNames"%>
<%@page import="species.participation.ActivityFeedService"%>
<%def nameRecords = fields.get(fieldFromName.nc)?.get(fieldFromName.trn).collect{if(it.value && !it.key.equals('hasContent') &&  !it.key.equals('isContributor') && it.value.containsKey('speciesFieldInstance')){ return it.value.speciesFieldInstance[0]}} %>
<g:if test="${nameRecords}">
<div class="sidebar_section" style="clear:both;">
    <a class="speciesFieldHeader"  data-toggle="collapse" href="#taxonRecordName">
        <h5><g:message code="showspeciesnames.taxon.record.name" /></h5>
    </a>

    <div id="taxonRecordName" class="speciesField collapse in">
        <table>
            <tr class="prop">
                <td><span class="grid_3 name">${fieldFromName.sn }</span></td><td> ${raw(speciesInstance.taxonConcept.italicisedForm)}</td>
            </tr>
            <g:each in="${nameRecords}">
            <g:if test="${it}">
            <tr class="prop">

                <g:if test="${it?.field?.subCategory?.equalsIgnoreCase(fieldFromName.references)}">
                <td><span class="grid_3 name">${it?.field?.subCategory} </span></td> <td class="linktext">${raw(it?.description)}</td>
                </g:if> 
                <g:elseif test="${it?.field?.subCategory?.equalsIgnoreCase(fieldFromName.gsn3)}">

                </g:elseif> 
                <g:elseif test="${it?.field?.subCategory?.equalsIgnoreCase(fieldFromName.sn3)}">

                </g:elseif> 
                <g:elseif test="${it?.field?.subCategory?.equalsIgnoreCase('year')}">
                <td><span class="grid_3 name">${it?.field?.subCategory} </span></td> <td> ${it?.description}</td>
                </g:elseif> 
                <g:else>
                <td><span class="grid_3 name">${it?.field?.subCategory} </span></td> <td> ${it?.description}</td>
                </g:else> 
            </tr>
            </g:if>
            </g:each>
        </table>
    </div>

    <comment:showCommentPopup model="['commentHolder':[objectType:ActivityFeedService.SPECIES_TAXON_RECORD_NAME, id:speciesInstance.id], 'rootHolder':speciesInstance]" />
</div>
<br/>
</g:if>

<!-- Synonyms -->
<%
//def synonyms = Synonyms.findAllByTaxonConcept(speciesInstance.taxonConcept) 
def synonyms = speciesInstance.taxonConcept.fetchSynonyms(); 
%>
<g:if test="${synonyms}">
<div class="sidebar_section">
    <a class="speciesFieldHeader"  data-toggle="collapse" href="#synonyms"> 
        <h5><g:message code="showspeciesnames.synonyms" /></h5>
    </a> 
    <ul id="synonyms" class="speciesField collapse in" style="list-style:none;overflow:hidden;margin-left:0px;padding:0px;">
            <g:each in="${synonyms}" var="synonym">
            <li>
            <div class="span3">
                <span class="synRel  ${isSpeciesContributor && synonym.isContributor() ?'selector':''}" data-type="select" data-name="relationship" data-original-title="Edit Synonym Relationship">
                    ${synonym?.relationship?.value()}</span> 
            </div>
            <div class="span8">
                <div class="edit_del_syn" style="display:none;">
                    <a class="pull-right btn btn-danger" title="Delete" style="display: block;">
                        <i class="icon-trash"></i>Delete
                    </a>
                    <a class="pull-right btn editSyn btn-primary" title="Edit" style="display: block;">
                        <i class="icon-edit"></i>Edit
                    </a>
                </div>                

                <% def s = synonym.findSpecies(); %>
                <g:if test="${s}">
                    <a href="${uGroup.createLink(controller:'species', action:'show', id:s.id)}"> 
                </g:if>
                <span class="syn_name" data-type="text" data-pk="${speciesInstance.id}" data-sid="${synonym.id}" data-url="${uGroup.createLink(controller:'species', action:'update') }" data-name="synonym" data-original-title="Edit synonym name" title="${g.message(code:'title.click.edit')}">  ${(synonym?.italicisedForm)?raw(synonym.italicisedForm):raw('<i>'+(synonym?.name)+'</i>')} </span>
                <g:if test="${s}">
                    </a>
                </g:if>
                <div class="syn_edit_wrap" style="display:none;">
                    <input type="text" class="synonym_value new" placeholder="${g.message(code:'placeholder.add.synonym')}" value="${synonym?.name}" />
                    <a class="validateSpeciesSubmit btn btn-primary btn-success disabled">validated</a>
                    <div class="editable-buttons" style="display:none;">                    
                        <button type="submit" class="btn btn-primary save_synonym" data-pk="${speciesInstance.id}" data-sid="${synonym.id}" > <i class="icon-ok icon-white"></i></button>
                        <button type="button" class="btn editable-cancel cancel_synonym"><i class="icon-remove"></i></button>
                    </div>
                </div>
            </div>    
            </li>
            </g:each>
            <g:if test="${isSpeciesContributor}">
            <li>
            <div class="span3">
                <span class="synRel add_selector ${isSpeciesContributor?'selector':''}" data-type="select" data-name="relationship" data-original-title="Edit Synonym Relationship"></span>
            </div>
            <div class="span8">
            <div class="syn_edit_wrap edit_del_syn" style="display:none;">                
                <input type="text" value="" class="synonym_value new" placeholder="${g.message(code:'placeholder.add.synonym')}" />
                <a class="validateSpeciesSubmit btn btn-primary"> Validate</a>
                <div class="editable-buttons" style="display:none;">                    
                    <button type="submit" class="btn btn-primary save_synonym" data-pk="${speciesInstance.id}" data-sid="" > <i class="icon-ok icon-white"></i></button>
                    <button type="button" class="btn editable-cancel cancel_synonym"><i class="icon-remove"></i></button>
                </div>
            </div>
            </div>
            </li>
            </g:if>  

    </ul>
    <comment:showCommentPopup model="['commentHolder':[objectType:ActivityFeedService.SPECIES_SYNONYMS, id:speciesInstance.id], 'rootHolder':speciesInstance]" />
</div>
<br/>
</g:if>
<g:elseif test="${isSpeciesContributor}">
<div class="sidebar_section emptyField" style="display:none;">
    <a class="speciesFieldHeader"  data-toggle="collapse" href="#synonyms"> 
        <h5><g:message code="showspeciesnames.synonyms" /></h5>
    </a> 
    <ul id="synonyms" class="speciesField collapse in" style="list-style:none;overflow:hidden;margin-left:0px;">
           <li>
            <div class="span3">
                <span class="synRel add_selector ${isSpeciesContributor?'selector':''}" data-type="select" data-name="relationship" data-original-title="Edit Synonym Relationship"></span>
            </div>
            <div class="span8">
                <input type="text" value="" class="synonym_value new" placeholder="${g.message(code:'placeholder.add.synonym')}" />
                <a class="validateSpeciesSubmit btn btn-primary"> Validate</a>
                <div class="editable-buttons" style="display:none;">
                    <button type="submit" class="btn btn-primary save_synonym" data-pk="${speciesInstance.id}" data-sid="" > <i class="icon-ok icon-white"></i></button>
                    <button type="button" class="btn editable-cancel cancel_synonym"><i class="icon-remove"></i></button>
                </div>
                <!-- span class="addField"  data-pk="${speciesInstance.id}" data-type="text"  data-url="${uGroup.createLink(controller:'species', action:'update') }" data-name="synonym" data-original-title="Add Synonym" data-placeholder="${g.message(code:'placeholder.add.synonym')}"></span -->
            </div>
            </li>

    </ul>
</div>
<br/>
</g:elseif>
<g:render template="/namelist/externalDbResultsTemplate" model="[]"/>
<g:render template="/namelist/dialogMsgTemplate" model="[]"/>
<asset:javascript src="biodiv/curation.js"/>
<asset:script>
$(document).ready(function(){

          $('.validateSpeciesSubmit').click(function() {    
            $('.validateSpeciesSubmit').removeClass('executing');
            var bClass = 'btn-success disabled';
            var bText = 'Validated';

            $(this).addClass('executing').addClass(bClass);
            $(this).html(bText);
            var params = {};
            params['page']= $(this).parent().find('.synonym_value').val();
            params['rank'] = 9;
            setRank=9;
            //Did u mean species 
            $.ajax({
                url:'/species/validate',
                data:params,
                method:'POST',
                dataType:'json',
                success:function(data) {
                    validateSpeciesSuccessHandler(data, true,true);
                }, error: function(xhr, status, error) {
                    handleError(xhr, status, error, this.success, function() {
                        var msg = $.parseJSON(xhr.responseText);
                        $(".alertMsg").html(msg.msg).removeClass('alert-success').addClass('alert-error');
                    });
                }
            });
            //get COL hierarchy 
            // get and autofill author contrib hierarchy           
         });

    $('#externalDbResults .close').click(function(){
        var validSubmit;
        $('.validateSpeciesSubmit').each(function(){ if($(this).hasClass('executing')){ validSubmit = $(this) } });
        validSubmit.parent().find('.editable-buttons').show();
        validSubmit.hide();
    });

    $('.synonym_value').change(function(){ 
        console.log("ddddddd"); 
        var validateSpeciesSubmit =$(this).parent().find('.validateSpeciesSubmit'); 
        validateSpeciesSubmit.removeClass('btn-success').removeClass('disabled').addClass('btn-primary');
        validateSpeciesSubmit.html('Validate Name');
    });

    $('.editSyn').click(function(){
        var that = $(this);
        that.parent().hide();
        that.parent().next().hide();
        var synEdit = that.parent().parent().find('.syn_edit_wrap');
        synEdit.find('.validateSpeciesSubmit').show();
        synEdit.find('.synonym_value').show();
           
        synEdit.show();

    });

    $('.cancel_synonym').click(function(){
        var synWrap = $(this).parent().parent().parent();
        $(this).parent().hide();
        $(this).parent().parent().find('.synonym_value').hide();
        synWrap.find('.edit_del_syn').show();
        synWrap.find('.syn_name').show();
        
    });



});   

</asset:script>
<!-- Common Names -->
<%
Map names = new LinkedHashMap();
CommonNames.findAllByTaxonConceptAndIsDeleted(speciesInstance.taxonConcept, false).each() {
String languageName = it?.language?.name ?: "Others";

/*if(it?.language?.isDirty) {
languageName = "Others";	
}*/
if(!names.containsKey(languageName)) {
names.put(languageName, new ArrayList());
}
names.get(languageName).add(it)
};

names = names.sort();
names.each { key, list ->
list.sort();						
}

%>
<g:if test="${names}">
<div class="sidebar_section">
    <a class="speciesFieldHeader" data-toggle="collapse" href="#commonNames"><h5> <g:message code="showspeciesnames.common.names" /></h5></a> 
    <ul id="commonNames" class="speciesField collapse in" style="list-style:none;overflow:hidden;margin-left:0px;padding:0px;">
        <g:each in="${names}">
        <li>
        <div class="span3">
            <!-- TODO: language selector shd be seperated out -->
            <span class="lang ${isSpeciesContributor ? 'selector':''}" data-type="select" data-name="language" data-original-title="Edit common name language">
                ${it.key}</span>
        </div> 
        <div class="span8" style="display:table;">
            <g:each in="${it.value}"  status="i" var ="n">
                <div class="entry pull-left" style="display:table-row;">
                    <span class="common_name ${isSpeciesContributor ?'editField':''}" data-type="text" data-pk="${speciesInstance.id}" data-cid="${n.id}" data-url="${uGroup.createLink(controller:'species', action:'update') }" data-name="commonname" data-original-title="Edit common name" title="${g.message(code:'title.click.edit')}">${n.name}</span><g:if test="${i < it.value.size()-1}">,</g:if>
                </div>
            </g:each>
        </div>
        </li>
        </g:each>

        <g:if test="${isSpeciesContributor}">
            <li>
                <div class="span3">
                    <span class="lang add_selector ${isSpeciesContributor?'selector':''}" data-type="select" data-name="language" data-original-title="Edit common name language">
                        </span>
                </div> 
                <div class="span8" style="display:table;">
                    <div style="display:table-row;"> 
                        <span class="common_name ${isSpeciesContributor?'addField':''}" data-type="text" data-pk="${speciesInstance.id}" data-url="${uGroup.createLink(controller:'species', action:'update') }" data-name="commonname" data-original-title="Add Common Name" data-placeholder="${g.message(code:'placeholder.add.common')}">  
                            </span>
                    </div>
                </div>
            </li>
        </g:if>
    </ul>
    <comment:showCommentPopup model="['commentHolder':[objectType:ActivityFeedService.SPECIES_COMMON_NAMES, id:speciesInstance.id], 'rootHolder':speciesInstance]" />
</div>
<br/>
</g:if>
<g:elseif test="${isSpeciesContributor}">
<div class="sidebar_section emptyField" style="display:none;">
    <a class="speciesFieldHeader" data-toggle="collapse" href="#commonNames"><h5> <g:message code="showspeciesnames.common.names" /></h5></a> 
    <ul id="commonNames" class="speciesField collapse in" style="list-style:none;overflow:hidden;margin-left:0px;">
        <li>
        <div class="span3">
            <span class="lang add_selector ${isSpeciesContributor?'selector':''}" data-type="select" data-name="language" data-original-title="Edit common name language">
                </span>
        </div> 
        <div class="span8" style="display:table;">
            <div style="display:table-row;"> 
                <span class="addField" data-type="text" data-pk="${speciesInstance.id}" data-url="${uGroup.createLink(controller:'species', action:'update') }" data-name="commonname" data-original-title="Add Common Name" data-placeholder="${g.message(code:'placeholder.add.common')}">  
                    </span>
            </div>
        </div>
        </li>
    </ul>
</div>
</g:elseif>
<!-- Common Names End-->

