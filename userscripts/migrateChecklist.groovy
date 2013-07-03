import org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsDomainBinder;

import com.vividsolutions.jts.geom.PrecisionModel;
import species.CommonNames;
import species.Language;
//import species.participation.checklistUtilService
import species.participation.curation.*
import species.participation.*
import species.formatReader.SpreadsheetReader;
import species.utils.*;
import speciespage.*
import com.vividsolutions.jts.geom.*
import content.eml.Coverage
import content.eml.Document

def checklistUtilService = ctx.getBean("checklistUtilService");

//checklistUtilService.updateUncuratedVotesTable()

//checklistUtilService.updateLocation()

//checklistUtilService.changeCnName()

//checklistUtilService.mCn()
//
//def cl = Checklist.get(174)
//println  cl
////
//checklistUtilService.createObservationFromChecklist(cl)


//checklistUtilService.addFollow()
//checklistUtilService.addRefObseravtionToChecklist()


def correctRow(){
	def snVal = 'Aethopyga vigorsii'
	def observationService = ctx.getBean("observationService");
	def reco = observationService.getRecommendation([recoName:snVal, canName:snVal, commonName:null]).mainReco
	def row = new ChecklistRowData(key:'scientific_name', value:snVal, rowId:25, columnOrderId:2, reco:reco)
	def cl = Checklist.get(23).addToRow(row)
	if(!cl.save(flush:true)){
		cl.errors.allErrors.each { println  it }
	}
}

def deleteChecklist(id)  {
	try{
		Checklist.get(id).delete(flush:true)
	}catch (Exception e) {
		e.printStackTrace()
	}
}

def correctChecklist(deleteId, migrateId){
	def checklistUtilService = ctx.getBean("checklistUtilService");
	deleteChecklist(deleteId)
	checklistUtilService.migrateChecklist(migrateId)
}

//correctRow()
//correctChecklist(41, 1277 ) //Scientific Name
//correctChecklist(62, 1298) //scientific_names



 	
//checklistUtilService.migrateChecklistAsObs()
//checklistUtilService.migrateObservationFromChecklist()




def migrateObvLocation() {
	GeometryFactory geometryFactory = new GeometryFactory(new PrecisionModel(), 4326);
	Observation.withTransaction(){
	   Observation.findAllByTopologyIsNull().each{obv->
	        obv.topology = geometryFactory.createPoint(new Coordinate(obv.longitude, obv.latitude));
			obv.placeName = obv.placeName?:obv.reverseGeocodedName;
	        if(!obv.save(flush:true)) {
			    obv.errors.allErrors.each { println  it }
	        }
	   }
	}
	
	//or use
	//update observation set topology = ST_GeomFromText('SRID=4326;POINT(' || logitude ||  latitude)|| ')');
}
//migrateObvLocation();



def migrateDocLocation() {
	GeometryFactory geometryFactory = new GeometryFactory(new PrecisionModel(), 4326);
	Document.withTransaction(){
	   Coverage.findAllByTopologyIsNull().each{obv->
			obv.topology = geometryFactory.createPoint(new Coordinate(obv.longitude, obv.latitude));
			obv.placeName = obv.placeName?:obv.reverseGeocodedName;
			if(!obv.save(flush:true)) {
				obv.errors.allErrors.each { println  it }
			}
	   }
	}
	
	//or use
	//update observation set topology = ST_GeomFromText('SRID=4326;POINT(' || logitude ||  latitude)|| ')');
}


println "================ done "
migrateDocLocation();
