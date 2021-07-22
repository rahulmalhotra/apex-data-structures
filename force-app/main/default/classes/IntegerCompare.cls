/* 
*   Author:- Rahul Malhotra
*   Description:- This helper class is used to compare two integers.
*   It's used in the creation of binary tree
*/
public class IntegerCompare extends Comparator {
    public override Boolean compare(Object o1, Object o2) {
        return (Integer) o1 == (Integer) o2;
    }
}