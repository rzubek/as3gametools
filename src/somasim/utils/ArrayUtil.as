package somasim.utils
{
	/**
	 * Class that contains static utility methods for manipulating and working with Arrays.
	 */		
	public class ArrayUtil
	{
		/**
		 * Returns true if the array arr contains the specified value.	
		 * 
		 * @param arr 		Array to check
		 * @param value 	Value we're looking for
		 */			
		public static function contains (arr :Array, value :Object) :Boolean
		{
			return (arr.indexOf(value) != -1);
		}	
		
		/**
		 * Removes all instances of the specified object from the array.
		 * 
		 * @param arr 		Array to remove from
		 * @param value 	Value to remove
		 */		
		public static function remove (arr :Array, value :Object) :void
		{
			for (var i :int = arr.length - 1; i >= 0; i--) {
				if (arr[i] === value) {
					arr.splice(i, 1);
				}
			}					
		}

		/**
		 * Creates a shallow copy of the specified array (new array contains
		 * references to the same items as the original array).
		 * 
		 * @param arr 		Array to copy
		 */			
		public static function copy (arr :Array) :Array
		{	
			return arr.slice();
		}
		
		/**
		 * Returns true if both arrays have the same values at the same indexes, 
		 * using strict equality test.
		 */		
		public static function equals (arr1 :Array, arr2 :Array) :Boolean
		{
			if (arr1.length != arr2.length) {
				return false;
			}
			
			for (var i :uint = 0, len :uint = arr1.length; i < len; i++) {
				if (arr1[i] !== arr2[i]) {
					return false;
				}
			}
			
			return true;
		}
	}
}
