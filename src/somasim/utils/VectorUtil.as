package somasim.utils
{
	
	/**
	 * Class that contains static utility methods for manipulating and working
	 * with Vectors. This works exactly like ArrayUtil, except function signatures
	 * have been stripped of types, because ActionScript compiler's type inference
	 * doesn't work well on Vectors of unknown types.
	 */		
	public class VectorUtil
	{
		/**
		 *	Determines whether the specified vector contains the specified value.	
		 * 
		 * 	@param vec The vector that will be checked for the specified value.
		 *
		 *	@param value The object which will be searched for within the vector.
		 * 
		 * 	@return True if the vector contains the value, False if it does not.
		 */			
		public static function vectorContainsValue(vec:*, value:Object):Boolean
		{
			return (vec.indexOf(value) != -1);
		}	
		
		/**
		 *	Remove all instances of the specified value from the vector.
		 * 
		 * 	@param vec The vector from which the value will be removed.
		 *
		 *	@param value The object that will be removed from the vector.
		 */		
		public static function removeValueFromVector(vec:*, value:Object):void
		{
			var len:uint = vec.length;
			for(var i:Number = len - 1; i >= 0; i--) {
				if(vec[i] === value) {
					vec.splice(i, 1);
				}
			}					
		}

		/**
		 *	Creates a copy of the specified vector.
		 *
		 *	Note that the vector returned is a new vector but the items within the
		 *	vector are not copies of the items in the original vector (but rather 
		 *	references to the same items)
		 * 
		 * 	@param vec The vector that will be copies
		 *
		 *	@return A new vector which contains the same items as the vector passed in.
		 */			
		public static function copyVector(vec:*):*
		{	
			return vec.slice();
		}
		
		/**
		 *	Compares two vectors and returns a boolean indicating whether the vectors
		 *	contain the same values at the same indexes.
		 * 
		 * 	@param vec1 The first vector that will be compared to the second.
		 *
		 * 	@param vec2 The second vector that will be compared to the first.
		 *
		 *	@return True if the vectors contain the same values at the same indexes.
		 *			False if they do not.
		 */		
		public static function vectorsAreEqual(vec1:*, vec2:*):Boolean
		{
			if (vec1.length != vec2.length) {
				return false;
			}
			
			var len:Number = vec1.length;
			for(var i:Number = 0; i < len; i++) {
				if(vec1[i] !== vec2[i]) {
					return false;
				}
			}
			
			return true;
		}
	}
}
