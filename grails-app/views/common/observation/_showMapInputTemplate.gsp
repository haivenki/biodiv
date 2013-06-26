<%@ page import="species.utils.Utils"%>
<div class="section">
	<h3>${locationHeading}</h3>
        <div style="margin-left:0px;">

                    <div id="map_area">
            <div class="map_search">
                <div id="geotagged_images" style="display:none">
                    <div class="title" style="display: none">Use location and date
                        from geo-tagged image:</div>
                    <div class="msg" style="display: none">Select image if
                        you want to use location and date information embedded in it</div>
                </div>
                <div id="current_location" class="section-item" style="display:none">
                    <div class="location_picker_button"><a href="#" onclick="return false;">Use current location</a></div>
                </div>
                <div  style="position:relative; text-align:center;width:100%">
                    <div class="address input-append control-group ${hasErrors(bean: observationInstance, field: 'placeName', 'error')}" style="z-index:3">
                            <input id="placeName" name="placeName" type="text" title="Find by place name"  class="input-block-level" style="width:94%"
                            class="section-item" value="${observationInstance?.placeName}"/>
                            <span class="add-on" style="vertical-align:middle;"><i class="icon-chevron-down"></i></span>
                            <div id="suggestions" style="display: block;white-space:normal;font-size:14px;text-align:left;z-index:3;"></div>
                    </div>
                    <div id="latlng" class="control-group ${hasErrors(bean: observationInstance, field: 'placeName', 'error')}" style="${(hasErrors(bean: observationInstance, field: 'topology', 'error'))?'':'display:none'}">
                            <div class="help-inline">
                                <g:hasErrors bean="${observationInstance}" field="placeName">
                                <g:renderErrors bean="${observationInstance}" as="list" field="placeName"/>
                                </g:hasErrors>
                            </div>
                    <input id='areas' type='hidden' name='areas' value='${observationInstance?.topology?Utils.GeometryAsWKT(observationInstance?.topology):params.areas}'></input>

                    <div class="input-prepend pull-left control-group  ${hasErrors(bean: observationInstance, field: 'topology', 'error')}" style="width:250px;">
                            <span class="add-on" style="vertical-align:middle;">Lat</span>
                            <!-- div class="location_picker_value" id="latitude"></div>
                            <input id="latitude_field" type="hidden" name="latitude"></input-->
                            <input class="degree_field" id="latitude_field" type="text" name="latitude" value="${params.latitude}"></input>
                            <input class="dms_field" id="latitude_deg_field" type="text" name="latitude_deg" placeholder="deg"></input>
                            <input class="dms_field" id="latitude_min_field" type="text" name="latitude_min" placeholder="min"></input>
                            <input class="dms_field" id="latitude_sec_field" type="text" name="latitude_sec" placeholder="sec"></input>
                            <input class="dms_field" id="latitude_direction_field" type="text" name="latitude_direction" placeholder="N/E"></input>
                            <div class="help-inline">
                                <g:hasErrors bean="${observationInstance}" field="topology">
                                	<g:message code="observation.suggest.location" />
                                </g:hasErrors>
			    </div>
                    </div>
                    <div class="input-prepend pull-left control-group ${hasErrors(bean: observationInstance, field: 'topology', 'error')}" style="width:240px;">
                            <span class="add-on" style="vertical-align:middle;">Long</span>
                            <!--div class="location_picker_value" id="longitude"></div>
                            <input id="longitude_field" type="hidden" name="longitude"></input-->
                            <input class="degree_field" id="longitude_field" type="text" name="longitude" style="width:193px;" value="${params.longitude}"></input>
                            <input class="dms_field" id="longitude_deg_field" type="text" name="longitude_deg" placeholder="deg"></input>
                            <input class="dms_field" id="longitude_min_field" type="text" name="longitude_min" placeholder="min"></input>
                            <input class="dms_field" id="longitude_sec_field" type="text" name="longitude_sec" placeholder="sec"></input>
                            <input class="dms_field" id="longitude_direction_field" type="text" name="longitude_direction" placeholder="N/E"></input>
                            <div class="help-inline">
                                <g:hasErrors bean="${observationInstance}" field="topology">
                                </g:hasErrors>
                            </div>
                    </div>
                    <div class="control-group">
                    <label class="pull-left" style="text-align:center; font-weight:normal;"> <g:checkBox id="use_dms" class="pull-left"
                        name="use_dms" value="${use_dms}" />
                        Use deg-min-sec </label>

                        <div class="pull-right">
			<%
                            def defaultAccuracy = (obvInfoFeeder?.locationAccuracy) ? obvInfoFeeder.locationAccuracy : "Approximate"
                            def isAccurateChecked = (defaultAccuracy == "Accurate")? "checked" : ""
                            def isApproxChecked = (defaultAccuracy == "Approximate")? "checked" : ""
                        %>
                         <!--label for="location_accuracy" class="control-label" style="padding:0px"><g:message
				code="observation.accuracy.label"
				default="Accuracy" /> </label-->
				
                            <input type="radio" name="location_accuracy" value="Accurate" ${isAccurateChecked} >Accurate 
                            <input type="radio" name="location_accuracy" value="Approximate" ${isApproxChecked} >Approximate
                            <input type="checkbox" class="input-block-level" name="geo_privacy" value="geo_privacy" />
           						Hide precise location


                        <div class="row control-group" style="display:none;" >
                            <label for="location_accuracy" class="control-label" style="padding:0px"><g:message
                                    code="observation.geocode.label"
                                    default="Geocode name" /> </label>
                            <div class="controls">                
                                <div class="location_picker_value"id="reverse_geocoded_name"></div>
                                <input id="reverse_geocoded_name_field" type="hidden"  class="input-block-level"
                                        name="reverse_geocoded_name" > </input>
                            </div>
                        </div>
                    </div>
                    </div>

            
            </div>
 
                        <div id="map_canvas"></div>
                    </div>
                </div>
            </div>
        </div>

    </div>
          
<r:script>
$(document).ready(function() {
    loadGoogleMapsAPI(function() {
    	initialize(document.getElementById("map_canvas"), true);
        $('.geotagged_image').each(function(index){
                update_geotagged_images_list($(this));		
        });
        //locate();
//        $("#map_canvas").resizable();
    });

    $(".address .add-on").click(function(){
        $("#latlng").toggle();
    })
});
</r:script>
          
