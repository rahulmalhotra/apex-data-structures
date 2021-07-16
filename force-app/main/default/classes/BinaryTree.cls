/*
*	Author:- Rahul Malhotra
*	Description:- Binary Tree implementation in apex
*	Created Date:- 13-07-2021
*	Last Modified:- 14-07-2021
*   Code Origin:- SFDC Stop (https://www.sfdcstop.com)
*/
public class BinaryTree {

    // * Node class
    public class Node {

        Object data;
        Node left;
        Node right;

        public Node(Object data) {
            this.data = data;
            this.left = NULL;
            this.right = NULL;
        }

        public Object getData() {
            return data;
        }
    }

    // * Root of binary tree
    Node root;

    // * Method to insert data in binary tree
    private void insertData(Object data) {

        // * If root is NULL, create a new node and return
        if(root==NULL) {
            root = new Node(data);
            return;
        }

        // * Initializing a queue of nodes
        List<Node> nodesQueue = new List<Node>();

        // * Adding root node to the queue
        nodesQueue.add(root);

        // * Looping while queue is not empty
        while(!nodesQueue.isEmpty()) {

            // * Getting the current node and removing it from the queue
            Node current = nodesQueue.get(0);
            nodesQueue.remove(0);

            // * If the left child of current node is not null, add it to the queue
            if(current.left!=NULL) {
                nodesQueue.add(current.left);
            }
            // * Otherwise, create a new node and attach it as the left child
            else {
                current.left = new Node(data);
                return;
            }

            // * If the right child of current node is not null, add it to the queue
            if(current.right!=NULL) {
                nodesQueue.add(current.right);
            }
            // * Otherwise, create a new node and attach it to the right child
            else {
                current.right = new Node(data);
                return;
            }
        }

    }

    /*
    *  Author:- Rahul Malhotra
    *  Description:- This method is used to insert data inside a binary tree based on the parent node's data
    */
    public Node insertData(Object data, Object parentData, Comparator comparator) {

        // * If root node is NULL, create a new node, assign it as the root node and return that
        if(root==NULL) {
            root = new Node(data);
            return root;
        }

        // * Otherwise, call the recursive function using the root node
        return insertDataRecursive(root, data, parentData, comparator);
    }

    /*
    *  Author:- Rahul Malhotra
    *  Description:- This helper method is used to insert data inside a binary tree based on the parent node's data
    */
    private Node insertDataRecursive(Node current, Object data, Object parentData, Comparator comparator) {

        // * If current node's data is equal to parentData
        if(comparator.compare(current.data, parentData)) {

            // * If left child of current node is NULL, add a new node as the left child of the current node and return that
            if(current.left==NULL) {
                current.left = new Node(data);
                return current.left;
            } 
            
            // * Else if the right child of current node is NULL, add a new node as the right child of the current node and return that
            else if(current.right==NULL) {
                current.right = new Node(data);
                return current.right;
            } 
            
            // * Otherwise, return NULL as the current node already has two nodes and a new node cannot be inserted
            else {
                return NULL;
            }
        }

        // * If current node's data is not equal to parentData, check in the left and right subtrees

        // * If left subtree exists
        if(current.left!=NULL) {

            Node left = insertDataRecursive(current.left, data, parentData, comparator);

            // * If the node is inserted in the left subtree, return the value received from the left subtree
            if(left!=NULL) {
                return left;
            }
        }

        // * If right subtree exists
        if(current.right!=NULL) {

            Node right = insertDataRecursive(current.right, data, parentData, comparator);

            // * If the node is inserted in the right subtree, return the value received from the right subtree
            if(right!=NULL) {
                return right;
            }
        }

        // * Otherwise, return NULL as the node cannot be inserted
        return NULL;
    }

    /*
    *  Author:- Rahul Malhotra
    *  Description:- This method is used to create a binary tree
    */
    public void createBinaryTree(List<Object> elements) {

        // * Inserting elements in binary tree
        for(Object element : elements) {
            insertData(element);
        }
    }

    /*
    *  Author:- Rahul Malhotra
    *  Description:- This method is used to print binary tree level by level
    */    
    public void levelOrderPrint() {

        // * Checking if root is not NULL
        if(root!=NULL) {

            String result = '\n';

            // * Initializing a queue
            List<Node> nodesQueue = new List<Node>();

            // * Adding root node to the queue
            nodesQueue.add(root);

            // * Looping while queue is not empty
            while(!nodesQueue.isEmpty()) {

                // * Getting nodes at current level
                Integer nodesAtCurrentLevel = nodesQueue.size();

                // * Looping while nodes at current level is more than 0
                while(nodesAtCurrentLevel>0) {

                    // * Getting the current node and removing it from the queue
                    Node current = nodesQueue.get(0);
                    nodesQueue.remove(0);

                    // * Adding current node data to the result
                    result += current.data + ' ';

                    // * If left child of the current node is not NULL, add it to the queue
                    if(current.left!=NULL) {
                        nodesQueue.add(current.left);
                    }

                    // * If right child of the current node is not NULL, add it to the queue
                    if(current.right!=NULL) {
                        nodesQueue.add(current.right);
                    }

                    // * Decrementing nodes at current level by 1
                    nodesAtCurrentLevel--;
                }

                // * Adding a new line to the result for next level
                result += '\n';
            }

            // * Displaying the result
            System.debug(result);
        } 

        // * If root is NULL, display error message
        else {
            System.debug('Tree not found');
        }
    }

    /*
    *  Author:- Rahul Malhotra
    *  Description:- This method is used to find lowest common ancestor in a binary tree assuming that both object1 and object2 are present
    */    
    public Node lowestCommonAncestor(Object object1, Object object2, Comparator comparator) {
        return lowestCommonAncestor(root, object1, object2, comparator);
    }

    /*
    *  Author:- Rahul Malhotra
    *  Description:- This helper method is used to find lowest common ancestor in a binary tree starting from a particular node
    */    
    private Node lowestCommonAncestor(Node current, Object object1, Object object2, Comparator comparator) {        

        // * If the current node is NULL, return NULL
        if(current==NULL) {
            return NULL;
        }

        // * If current node's data is equal to one of object1 or object2, return the current node
        if(
            comparator.compare(current.data, object1) || 
            comparator.compare(current.data, object2)
        ) {
            return current;            
        }

        // * Otherwise, find object1 and object2 in left and right subtree
        Node left = lowestCommonAncestor(current.left, object1, object2, comparator);
        Node right = lowestCommonAncestor(current.right, object1, object2, comparator);

        /* 
        *   If one of object1 or object2 is present in the left subtree and one in right subtree, 
        *   return the current node as it's the lowest common ancestor
        */
        if(left!=NULL && right!=NULL) {
            return current;
        } 
        
        /* 
        *   Else if, both the object1 and object2 are present in the left subtree, 
        *   return the lowest common ancestor returned from the left subtree
        */
        else if(left!=NULL) {
            return left;
        }

        // * Else, return the lowest common ancestor returned from the right subtree
        return right;
    }
}