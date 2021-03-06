package species.trait;

import species.TaxonomyDefinition;
import species.Field;
import species.UtilsService;
import species.auth.SUser;
import species.License;

class Fact {

    Trait trait;
    TraitValue traitValue;
    String value;//default from value if trait type is range
    String toValue;
    Date fromDate;
    Date toDate;
    String attribution;
    SUser contributor;
    License license;
    TaxonomyDefinition pageTaxon;
    Long objectId;
    String objectType
    
    boolean isDeleted = false;

    static constraints = {
      trait nullable:false, unique:['objectType', 'objectId','traitValue']
      //attribution nullable:true
      //contributor nullable:true
      //license nullable:true
      traitValue nullable:true
      value nullable:true
      toValue nullable:true
      fromDate nullable:true
      toDate nullable:true
      objectId nullable:false
      objectType nullable:false
      pageTaxon nullable:true
    }

    static mapping = {
        description type:"text"
        attribution type:"text"
        id  generator:'org.hibernate.id.enhanced.SequenceStyleGenerator', params:[sequence_name: "fact_id_seq"] 
    }

    String getActivityDescription() {
        return trait.name +':'+ traitValue.value;
    }

    String getIcon() {
        if(this.traitValue) {
            return traitValue.mainImage()?.fileName
        } else if (trait.dataTypes == DataTypes.DATE) {
            return fromDate + (toDate ? ":" + toDate:'')
        }else {
            return value + (toValue ? ":" + toValue:'')
        }
    }
    @Override
    String toString() {
        return "<${this.class} : ${id} - (${objectType}:${objectId}, ${trait.name}, ${traitValue?traitValue.value:value}-${toValue})>";
    }
}
