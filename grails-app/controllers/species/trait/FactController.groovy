package species.trait

import grails.converters.JSON;
import grails.converters.XML;

import species.Language;
import species.AbstractObjectController;
import grails.plugin.springsecurity.annotation.Secured
import species.participation.UploadLog;
import species.participation.ActivityFeed;
import grails.util.Holders;
import static org.springframework.http.HttpStatus.*;
import species.participation.Observation;
import species.TaxonomyDefinition;
import species.groups.CustomField;
import species.auth.SUser;
class FactController extends AbstractObjectController {

    def factService;
    def customFieldService

    static allowedMethods = [show:'GET', index:'GET', list:'GET', save: "POST", update: ["POST","PUT"], delete: ["POST", "DELETE"], flagDeleted: ["POST", "DELETE"]]
    static defaultAction = "list"

    def index = {
        redirect(action: "list", params: params)
    }

    def list() {
        //render (view:'list', model:['traitList' : traitService.listTraits(params)]);
        def model = [:];
        model['factInstanceList'] = factService.list(params);
        println "model============"+model
        model['obvListHtml'] = g.render(template:"/fact/factListTemplate", model:model);
        model = utilsService.getSuccessModel('', null, 200, model);

        withFormat {
            html {
                render(view:"list", model:model.model);

            }
            json {
                render model as JSON 
            }
            xml {
                render model as XML
            }
        }
    }

    def show() {
        render(view:'show', model:factService.show(params.id))
    }

    @Secured(['ROLE_ADMIN'])
    def save() {
        params.locale_language = utilsService.getCurrentLanguage(request);
        def result = factService.save(params)
        if(result.success){
            withFormat {
                html {
                    redirect(controller:'species', action: "facts")
                }
                json {
                    render result as JSON 
                }
                xml {
                    render result as XML
                }
            }
        } else {
            withFormat {
                html {
                    //flash.message = "${message(code: 'error')}";
                    render(controller:'species', view: "uploadFacts", model: [])
                }
                json {
                    result.remove('instance');
                    render result as JSON 
                }
                xml {
                    result.remove('instance');
                    render result as XML
                }
            }
        }
    }

    @Secured(['ROLE_USER'])
    def upload() {
        File contentRootDir = new File(Holders.config.speciesPortal.content.rootDir+File.separator+params.controller);          
        if(!contentRootDir.exists()) {
            contentRootDir.mkdir();
        }
        
        params.file = contentRootDir.getAbsolutePath()+File.separator+params.file;
        def r = factService.upload(params);
        redirect(action: "list")
    }

    def migrateCustomFields() {
        File contentRootDir = new File(Holders.config.speciesPortal.content.rootDir+File.separator+params.controller);          
        println "Loading 7";
        int noOfUpdatedFacts_7 = migrateCustomFieldsToFacts(contentRootDir.getAbsolutePath()+'/customfields_group/gp 7.tsv','7');
        println noOfUpdatedFacts_7;
        println "Loading 38";
        int noOfUpdatedFacts_38 = migrateCustomFieldsToFacts(contentRootDir.getAbsolutePath()+'/customfields_group/gp 38.tsv','38');
        println noOfUpdatedFacts_38;
        println "Loading 33";
        int noOfUpdatedFacts_33 = migrateCustomFieldsToFacts(contentRootDir.getAbsolutePath()+'/customfields_group/gp 33.tsv','33');
        println noOfUpdatedFacts_33;
        println "Loading 30";
        int noOfUpdatedFacts_30 = migrateCustomFieldsToFacts(contentRootDir.getAbsolutePath()+'/customfields_group/gp 30.tsv','30');
        println noOfUpdatedFacts_30;
        println "Loading 18";
        int noOfUpdatedFacts_18 = migrateCustomFieldsToFacts(contentRootDir.getAbsolutePath()+'/customfields_group/gp 18.tsv','18');
        println noOfUpdatedFacts_18;
        println "Loading 13";
        int noOfUpdatedFacts_13 = migrateCustomFieldsToFacts(contentRootDir.getAbsolutePath()+'/customfields_group/gp13.tsv','13');
        println noOfUpdatedFacts_13;

        render noOfUpdatedFacts_7+" "+noOfUpdatedFacts_38+" "+noOfUpdatedFacts_33+" "+noOfUpdatedFacts_30+" "+noOfUpdatedFacts_18+" "+noOfUpdatedFacts_13;
    } 

    private int migrateCustomFieldsToFacts(tsvFile,groupNo) {
        int i=0;
        String[] headers;
        String l;
        int noOfUpdatedFacts = 0;
        new File(tsvFile).withReader { l = it.readLine() }  
        headers = l.split('\t');
        i=0;
        Observation obv;
        (new File(tsvFile)).splitEachLine('\t') { line ->
            if(i==0) {
            i++;
            return;
        } else {
            List cfs = [];
            Map cf_traits = [:];
            Map cf_taxons = [:]
            obv = null;
            line.eachWithIndex { key, j ->
                if(headers[j] == 'observation_id') {
                    try{
                        if(key) {
                            obv = Observation.read(Long.parseLong(key));
                        }
                    } catch(Exception e) {
                        println e.getMessage();
                    }
                } else if(headers[j] =~ /cf_[0-9]+$/) {
                    cfs << headers[j];
                } else if(headers[j] =~ /cf_[0-9]+ trait|value$/) {
                    cf_traits[headers[j]] = key;
                } else if(headers[j] =~ /cf_[0-9]+ taxonID$/) {
                    cf_taxons[headers[j]] = key;
                }
            }
            if(obv) {
                cfs.each { cf ->
                    String tv_str = cf_traits[cf+' trait|value'];
                    if(tv_str) {
                        tv_str.split(',').each {v->
                        def tv = v.split("\\|");
                        def taxon,trait,traitValue;
                        if(cf_taxons[cf+' taxonID']) {
                            taxon = TaxonomyDefinition.read(Long.parseLong(cf_taxons[cf+' taxonID'])); 
                            def traits = Trait.executeQuery("select t from Trait t join t.taxon taxon where t.name=? and taxon = ?", [tv[0], taxon]);
                            if(traits) trait = traits[0];
                        } else {
                            trait = Trait.findByName(tv[0]);
                        }
                        traitValue = TraitValue.findByTraitAndValue(trait, tv[1]);
                        if(traitValue && trait) {
                            //TODO:do get contri and attr from activity feed
                            def contributor;
                            def authors = ActivityFeed.executeQuery("select author from ActivityFeed where activity_holder_id=:oid and activity_type='Custom field edited' order by last_updated desc limit 1",[oid:obv.id]);
                            if(authors) contributor = authors[0];
                            if(!contributor) contributor = SUser.findByEmail('admin@strandls.com');
                            Map m = ['attribution':contributor.name, 'contributor':contributor.email, 'license':'BY'];
                            m[trait.id+''] = traitValue.value
                            println '=================='
                            println m;
                            println '=================='
                            if(factService.updateFacts(m, obv)) {
                                //TODO delete customfield
                                customFieldService.delCf("update custom_fields_group_${groupNo} set ${cf}='' where observation_id=:oid",[oid:obv.id]);
                                noOfUpdatedFacts++;
                            }
                        }
                        }
                    }
                }
            }
        }
    }
    return noOfUpdatedFacts;
    }
}
