import org.codehaus.groovy.grails.commons.ApplicationHolder;

import speciespage.SpeciesService;
import speciespage.SetupService;

//def s = ctx.getBean("setupService");
//s.uploadHabitats();
def speciesService = ctx.getBean("speciesService");

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ibp/1.0/mango";
//speciesService.uploadSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ibp/1.0/mango/MangoMangifera_indica_prabha2.xlsx", 0, 0, 1, 4);
//
//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ibp/1.0/grey_falcolin";
//speciesService.uploadSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ibp/1.0/grey_falcolin/GreyFrancolin.xlsx", 0, 0, 1, 4);
//
//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ibp/1.0/Rufous Woodpecker/images";
//speciesService.uploadNewSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ibp/1.0/Rufous Woodpecker/RufousWoodepecker.xlsm");	
//
//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ibp/1.0/Eurasian Curlew/png ec";
//speciesService.uploadNewSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ibp/1.0/Eurasian Curlew/EurasianCurlew.xlsm");

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/atree/1.0/Dung_beetle/images";
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/atree/1.0/Dung_beetle/Dung_beetle_Species_pages_IBP.xlsx", grailsApplication.config.speciesPortal.data.rootDir+"/mappings/dungbeetles_mapping.xlsx", 0, 0, 0, 0);

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ifp/1.0/images";
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ifp/1.0/Trees_descriptives.xlsx", grailsApplication.config.speciesPortal.data.rootDir+"/mappings/ifp_tree_mapping_v2.xlsx", 0, 0, 0, 2);
//
////grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/speciespages/images";
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/speciespages/Bats/WG_bats_account_01Nov11_sanjayMolur.xls", grailsApplication.config.speciesPortal.data.rootDir+"/mappings/WG_bats_account_01Nov11_sanjayMolurspecies_mapping_v2.xlsx", 0, 0, 0, 0);

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/careearth/1.0";
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/careearth/1.0/species accounts188.xlsx", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/careearth/1.0/speciesaccount188_mapping.xlsx", 0, 0, 0, 0);

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/keystone/1.0";
//String mappingFile = grailsApplication.config.speciesPortal.data.rootDir+"/keystone/1.0/keystone_mapping.xlsx";
//speciesService.uploadKeyStoneData("jdbc:mysql://localhost:3306/ezpz", "sravanthi", "sra123", mappingFile, 0, 0);

//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/zoooutreach/uploadready/primates.xlsx", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/zoooutreach/uploadready/primates_mappingfile.xls", 0, 0, 0, 0);
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/zoooutreach/uploadready/smallmammals.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/zoooutreach/uploadready/smallmammals_mappingfile.xls", 0, 0, 0, 0);

//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/abct/uploadready/abctrust_amphibians.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/abct/uploadready/abctrust_amphibians_mappingfile.xls", 0, 0, 0, 0);

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/abct/1.5/photos_bryo/";
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/abct/1.5/abctrust_mosses.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/abct/1.5/abctrust_mosses_mappingfile.xls", 0, 0, 0, 0);
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/abct/uploadready/abctrust_reptiles.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/abct/uploadready/abctrust_reptiles_mappingfile.xls", 0, 0, 0, 0);

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/sushantsanaye/uploadready/images";
//speciesService.uploadNewSimpleSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/sushantsanaye/uploadready/Indian_Reef_Fishes_SushantSanaye.xls");

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/ne_butterflies/1.5/NE_Butterflies_RG3";
//speciesService.uploadNewSimpleSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/ne_butterflies/1.5/Northeast Butterflies-RG3.xlsx");

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/ne_butterflies/1.5/NE_Butterflies_RG4";
//speciesService.uploadNewSimpleSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/ne_butterflies/1.5/Northeast Butterflies-RG4.xlsx");

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/indian_molluscs/uploadready/molluscs_images";
//speciesService.uploadNewSimpleSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/indian_molluscs/uploadready/indian_molluscs_asr_cr1.xls");
//
//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/indian_molluscs/uploadready/molluscs_images";
//speciesService.uploadNewSimpleSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/indian_molluscs/uploadready/indian_molluscs_asr_cr2.xls");
//
//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/indian_birds/uploadready/india_birds_cr1_images";
//speciesService.uploadNewSimpleSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/indian_birds/uploadready/india_birds_cr1.xls");

//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/zoooutreach/uploadready/aquaticplants.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/zoooutreach/uploadready/aquaticplants_mapping.xls", 0, 0, 0, 0);
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/zoooutreach/uploadready/fish_dk.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/zoooutreach/uploadready/fish_mapping.xls", 0, 0, 0, 0);

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+" /datarep/species/thomas/uploadready/images";
//speciesService.uploadNewSimpleSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/thomas/uploadready/MammalsspeciesPages.xlsx");

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/ne_butterflies/uploadready/NE_Butterflies_RG1";
//speciesService.uploadNewSimpleSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/ne_butterflies/uploadready/NortheastButterflies-RG1.xlsx");
//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/ne_butterflies/uploadready/NE_Butterflies_RG25";
//speciesService.uploadNewSimpleSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/chitra/ne_butterflies/uploadready/NortheastButterflies-RG25.xlsx");

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ranwa/uploadready/";
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ranwa/uploadready/plant_speciesimages.xlsx", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/ranwa/uploadready/plant_speciesimages_mapping.xlsx", 0, 0, 0, 0);

//grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/abct/uploadready/";
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/abct/uploadready/keralafloweringplants.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/abct/uploadready/keralafloweringplants_mappingfile.xls", 0, 0, 0, 0);
//speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/mcccollege/uploadready/Database_on_Diots_of_Western_Ghats_1.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/mcccollege/uploadready/Database_on_Diots_of_Western_Ghats_mappingfile.xls", 0, 0, 0, 0);
//
grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/rawdata/forest_plants_HTML/climbers_images";
speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/inprocess/climbers.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/inprocess/climbers_mapping.xlsx", 0, 0, 0, 0,1);

grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/rawdata/forest_plants_HTML/epi_saprophytes_images";
speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/inprocess/epi_saprophytes.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/inprocess/epi_saprophytes_mapping.xlsx", 0, 0, 0, 0,1);

grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/rawdata/forest_plants_HTML/herbs_images";
speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/inprocess/herbs.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/inprocess/herbs_mapping.xlsx", 0, 0, 0, 0,1);

grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/rawdata/forest_plants_HTML/shrubs_images";
speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/inprocess/shrubs.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/inprocess/shrubs_mapping.xlsx", 0, 0, 0, 0,1);

grailsApplication.config.speciesPortal.images.uploadDir = grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/rawdata/forest_plants_HTML/trees_images";
speciesService.uploadMappedSpreadsheet(grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/inprocess/trees.xls", grailsApplication.config.speciesPortal.data.rootDir+"/datarep/species/keystone/inprocess/trees_mapping.xlsx", 0, 0, 0, 0,1);
