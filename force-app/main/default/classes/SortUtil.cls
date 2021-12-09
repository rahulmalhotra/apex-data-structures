/*
*	Author:- Rahul Malhotra
*	Description:- Utility class to sort list of sObjects
*	Created Date:- 04-12-2021
*	Last Modified:- 04-12-2021
*   Code Origin:- SFDC Stop (https://www.sfdcstop.com)
*/
public with sharing class SortUtil implements Comparable {

    public enum SortOrder { ASCENDING, DESCENDING }
    public enum Type { TYPE_STRING, TYPE_INTEGER, TYPE_DECIMAL }

    sObject record;
    SortOrder sortOrderValue;
    String fieldName;
    Type valueType;

    public SortUtil(sObject record, SortOrder sortOrderValue, String fieldName, Type valueType) {
        this.record = record;
        this.sortOrderValue = sortOrderValue;
        this.fieldName = fieldName;
        this.valueType = valueType;
    }

    public Integer compareTo(Object anotherObject) {
        sObject anotherRecord = ((SortUtil) anotherObject).record;
        if(valueType.equals(Type.TYPE_STRING)) {
            return compareStrings((String) record.get(fieldName), (String) anotherRecord.get(fieldName));
        } else if(valueType.equals(Type.TYPE_INTEGER)) {
            return compareIntegers((Integer) record.get(fieldName), (Integer) anotherRecord.get(fieldName));
        } else if(valueType.equals(Type.TYPE_DECIMAL)) {
            return compareDecimals((Decimal) record.get(fieldName), (Decimal) anotherRecord.get(fieldName));
        }
        return -1;
    }

    public Integer compareStrings(String sourceValue, String destinationValue) {
        if(sortOrderValue.equals(SortOrder.ASCENDING)) {
            if(sourceValue < destinationValue) {
                return -1;
            } else if(sourceValue.equals(destinationValue)) {
                return 0;
            } else {
                return 1;
            }
        } else {
            if(sourceValue < destinationValue) {
                return 1;
            } else if(sourceValue.equals(destinationValue)) {
                return 0;
            } else {
                return -1;
            }
        }
    }


    public Integer compareIntegers(Integer sourceValue, Integer destinationValue) {
        if(sortOrderValue.equals(SortOrder.ASCENDING)) {
            if(sourceValue < destinationValue) {
                return -1;
            } else if(sourceValue == destinationValue) {
                return 0;
            } else {
                return 1;
            }
        } else {
            if(sourceValue < destinationValue) {
                return 1;
            } else if(sourceValue == destinationValue) {
                return 0;
            } else {
                return -1;
            }
        }
    }

    public Integer compareDecimals(Decimal sourceValue, Decimal destinationValue) {
        if(sortOrderValue.equals(SortOrder.ASCENDING)) {
            if(sourceValue < destinationValue) {
                return -1;
            } else if(sourceValue == destinationValue) {
                return 0;
            } else {
                return 1;
            }
        } else {
            if(sourceValue < destinationValue) {
                return 1;
            } else if(sourceValue == destinationValue) {
                return 0;
            } else {
                return -1;
            }
        }
    }

    public static void sortRecords(List<sObject> records, SortOrder sortOrderValue, String fieldName, Type valueType) {
        List<SortUtil> sortUtils = new List<SortUtil>();
        for(sObject record : records) {
            sortUtils.add(new SortUtil(record, sortOrderValue, fieldName, valueType));
        }
        sortUtils.sort();
        records.clear();
        for(SortUtil sortUtil : sortUtils) {
            records.add(sortUtil.record);
        }
    }
}