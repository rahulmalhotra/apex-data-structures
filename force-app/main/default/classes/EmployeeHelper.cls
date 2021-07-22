/*
*	Author:- Rahul Malhotra
*	Description:- Helper class for Employee related computations
*	Created Date:- 14-07-2021
*	Last Modified:- 14-07-2021
*   Code Origin:- SFDC Stop (https://www.sfdcstop.com)
*/
public with sharing class EmployeeHelper {

    /* 
    *   Author:- Rahul Malhotra
    *   Description:- This helper class is used to compare two Ids.
    *   It's used to find the lowest common ancestor of binary tree
    */
    public class IdCompare extends Comparator {
        public override Boolean compare(Object o1, Object o2) {
            return (Id) o1 == (Id) o2;
        }
    }

    /*
    *  Author:- Rahul Malhotra
    *  Description:- This helper method is used to get the Lead Manager of two employees given the employee id of both the employees
    */    
    public Id getLeadManager(Id firstEmployeeId, Id secondEmployeeId) {

        // * Defining lead manager id and initializing a binary tree
        Id leadManagerId;
        BinaryTree tree = new BinaryTree();

        // * Finding the topmost employee of the hierarchy
        Employee__c topEmployee = [SELECT Id FROM Employee__c WHERE Manager__c = null];

        // * Proceed ahead if top employee is not NULL
        if(topEmployee!=NULL) {

            // * Storing the top employee id
            Id topEmployeeId = topEmployee.Id;

            // * Storing all the employees along with the child employees in the employees map
            Map<Id, Employee__c> employeesMap = new Map<Id, Employee__c>([SELECT Id, (SELECT Id FROM Employees__r) FROM Employee__c]);

            /* 
            *   Initializing a set of ids to store the tree elements, 
            *   a queue of ids as idQueue and creating an instance of IdCompare class
            */
            Set<Id> treeElements = new Set<Id>();
            List<Id> idQueue = new List<Id>();
            IdCompare idCompare = new IdCompare();

            // * Adding the top employee id to the idQueue
            idQueue.add(topEmployeeId);

            // * Inserting topEmployeeId in the tree
            tree.insertData(topEmployeeId, NULL, idCompare);

            // * Looping while idQueue is not empty
            while(!idQueue.isEmpty()) {

                // * Getting the id of employee in the front of queue
                Id currentEmployeeId = idQueue.get(0);
                idQueue.remove(0);

                // * Used to prevent duplicacy in tree
                if(!treeElements.contains(currentEmployeeId)) {

                    // * Adding current employee id to tree elements
                    treeElements.add(currentEmployeeId);

                    // * If the current employee record has child records
                    if(employeesMap.containsKey(currentEmployeeId)) {

                        // * Getting the child records and inserting them in the tree
                        List<Employee__c> childEmployees = employeesMap.get(currentEmployeeId).Employees__r;
                        if(childEmployees!=NULL && !childEmployees.isEmpty()) {
                            for(Employee__c childEmployee : childEmployees) {
                                idQueue.add(childEmployee.Id);
                                tree.insertData(childEmployee.Id, currentEmployeeId, idCompare);
                            }
                        }
                    }
                }
            }

            // * Finding the lead manager in the binary tree using the first employee id and second employee id
            BinaryTree.Node lowestCommonAncestorNode = tree.lowestCommonAncestor(firstEmployeeId, secondEmployeeId, new IdCompare());

            if(lowestCommonAncestorNode!=NULL) {
                // * Storing the lead manager id
                leadManagerId = (Id) lowestCommonAncestorNode.getData();
            }
        }

        // * Returning the lead manager id
        return leadManagerId;
    }
}
