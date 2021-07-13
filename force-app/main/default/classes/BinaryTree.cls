/*
*	Author:- Rahul Malhotra
*	Description:- Binary Tree implementation in apex
*	Created Date:- 13-07-2021
*	Last Modified:- 13-07-2021
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

    }

    // * Root of binary tree
    Node root;

    // * Method to insert data in binary tree
    public void insertData(Object data) {

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
}