/*
*	Author:- Rahul Malhotra
*	Description:- Utility class consisting of some common methods
*	Created Date:- 08-08-2021
*	Last Modified:- 08-08-2021
*   Code Origin:- SFDC Stop (https://www.sfdcstop.com)
*/
public with sharing class ApexUtil {

    /*
    *   Description: This method is used to return a map of object api name and it's label
    */
    public static Map<String, String> getObjectAPINameToLabel() {

        // * Initializing Map
        Map<String, String> objectAPINameToLabelMap = new Map<String, String>();

        // * Getting all sObjects metadata
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe();

        // * Processing each sObject one by one
        for(String globalDescribeKey : globalDescribeMap.keySet()) {

            // * Getting the current sObject type
            Schema.SObjectType currentSObjectType = globalDescribeMap.get(globalDescribeKey);

            // * Getting the current sObject description result from sObject Type
            Schema.DescribeSObjectResult currentSObjectResult = currentSObjectType.getDescribe();

            // * Getting the API name and value of current sObject and adding it to the map
            objectAPINameToLabelMap.put(currentSObjectResult.getName(), currentSObjectResult.getLabel());
        }

        // * Returning the map
        return objectAPINameToLabelMap;
    }

    /*
    *   Description: This method is used to return all accessible fields for an sObject
    */
    public static Set<String> getSObjectFields(String sObjectName) {

        // * Initializing fieldNames set
        Set<String> fieldNames = new Set<String>();

        // * Getting metadata of all sObjects
        Map<String, Schema.SObjectType> sObjectMap = Schema.getGlobalDescribe();

        // * Getting the reference to current sObject
        Schema.SObjectType sObjectTypeInstance = sObjectMap.get(sObjectName);

        if(sObjectTypeInstance!=null) {

            // * Getting Fields for current sObject
            Map<String, Schema.SObjectField> fieldMap = sObjectTypeInstance.getDescribe().fields.getMap();

            // * Checking each field one by one, if it's accessible, adding it's name to fieldNames set
            for(Schema.SObjectField field: fieldMap.values()) {
                Schema.DescribeFieldResult fieldResult = field.getDescribe();
                if(fieldResult.isAccessible()) {
                    fieldNames.add(fieldResult.getName());
                }
            }
        }

        // * Returning the fieldNames set
        return fieldNames;
    }

    /*
    *   Description: This method is used to return SOQL query consisting of
    *   all fields for an object that are accessible by the current user
    */
    public static String getSOQL(String objectName) {

        // * Getting the field names using the object name
        Set<String> fieldNames = getSObjectFields(objectName);

        // * Forming the SOQL query
        String query = 'SELECT ';
        for(String fieldName : fieldNames) {
            query += fieldName + ', ';
        }

        // * Removing last , from the SOQL query string
        query = query.substring(0, query.lastIndexof(','));

        // * Adding the object name to the SOQL
        query += ' FROM ' + objectName;

        // * Returning the SOQL
        return query;
    }

    /*
    *   Description: This method is going to return the picklist field values and the associated label
    *   for an object and a field which are passed in as parameters
    */
    public static Map<String, String> getPicklistValuesMap(String objectAPIName, String fieldAPIName) {

        // * Initializing picklist field map to story value and label of picklist entries
        Map<String, String> picklistFieldMap = new Map<String, String>();

        // * Getting the field result for the current field
        Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe().get(objectAPIName)?.getDescribe()?.fields?.getMap()?.get(fieldAPIName)?.getDescribe();

        // * Checking if the field type is a picklist
        if(
            (fieldResult!=null) &&
            (fieldResult.getType() == Schema.DisplayType.Picklist)
        ) {

            // * Getting all picklist entries
            List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();

            // * Looping over all picklist entries one by one
            for(Schema.PicklistEntry picklistEntry : picklistEntries) {

                // * If the picklist entry is active, getting the label and value and putting those in map
                if(picklistEntry.isActive()) {
                    String picklistLabel = picklistEntry.getLabel();
                    String picklistValue = picklistEntry.getValue();
                    picklistFieldMap.put(picklistValue, picklistLabel);
                }
            }
        }

        // * Returning the picklist field map
        return picklistFieldMap;
    }

    /*
    *   Description: This method is going to return a map of record type name with it's id
    */
    public static Map<String, Id> getRecordTypeIdsByName(String objectAPIName) {

        // * Initializing map
        Map<String, Id> recordTypesMap = new Map<String, Id>();

        // * Getting the object result
        Schema.DescribeSObjectResult objectResult = Schema.getGlobalDescribe().get(objectAPIName)?.getDescribe();

        if(objectResult!=null) {

            // * Getting the record type infos list
            List<Schema.RecordTypeInfo> recordTypeInfos = objectResult.getRecordTypeInfos();

            // * Processing each record type one by one
            for(Schema.RecordTypeInfo recordTypeInfo : recordTypeInfos) {

                // * If the current record type is active and avaialable to the logged in user, adding it's name and id to the map
                if(recordTypeInfo.isActive() && recordTypeInfo.isAvailable()) {
                    recordTypesMap.put(recordTypeInfo.getName(), recordTypeInfo.getRecordTypeId());
                }
            }
        }

        // * Returning the record types map
        return recordTypesMap;
    }

}
