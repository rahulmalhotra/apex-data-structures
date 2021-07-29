// * List Syntax
// List<DataType> listName = new List<DataType>(); 

// * List of Integers
List<Integer> numbers = new List<Integer>{1,2,3,4,5};
System.debug(numbers);

// * List of Strings
List<String> names = new List<String>{'Richard', 'Gilfoyle', 'Dinesh', 'Jared', 'Monica'};
System.debug(names);

// * Adding elements to the list using add()
List<Integer> numbers = new List<Integer>();
numbers.add(1);
numbers.add(2);
numbers.add(3);
numbers.add(4);
numbers.add(5);
System.debug(numbers);

// * Accessing elements from the list
List<Integer> numbers = new List<Integer>{1,2,3,4,5};
System.debug(numbers);
System.debug('Element at index 3 = ' + numbers[3]);
System.debug('Element at index 3 using get() = ' + numbers.get(3));

// * Adding element at a particular index
List<Integer> numbers = new List<Integer>{1,2,3,4,5};
System.debug(numbers);
System.debug('Adding element "10" at index 3');
numbers.add(3, 10);
System.debug('Updated List = ' + numbers);

// * Removing element from the list
List<Integer> numbers = new List<Integer>{1,2,3,10,4,5};
System.debug(numbers);
System.debug('Removing element "10" from index 3');
numbers.remove(3);
System.debug('Updated List = ' + numbers);

// * Commonly used list methods:

// * clear()
List<Integer> numbers = new List<Integer>{1,2,3,4,5};
System.debug(numbers);
System.debug('Clearing list...');
numbers.clear();
System.debug('Updated list = ' + numbers);

// * isEmpty()
List<Integer> numbers = new List<Integer>();
System.debug('List Empty --> ' + numbers.isEmpty());
System.debug('Adding "1" to the list');
numbers.add(1);
System.debug('List Empty --> ' + numbers.isEmpty());

// * size()
List<Integer> numbers = new List<Integer>{1,2,3,4,5};
System.debug(numbers);
System.debug('Size of list = ' + numbers.size());

// * contains()
List<Integer> numbers = new List<Integer>{1,2,3,4,5};
System.debug(numbers);
System.debug('3 is present in the list --> ' + numbers.contains(3));
System.debug('Removing 3 from index 2');
numbers.remove(2);
System.debug(numbers);
System.debug('3 is present in the list --> ' + numbers.contains(3));

// * sort()
List<Integer> numbers = new List<Integer>{1,4,5,3,2};
System.debug(numbers);
System.debug('Sorting list...');
numbers.sort();
System.debug(numbers);
