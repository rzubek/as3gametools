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
		 * Returns true if the vector vec contains the specified value.	
		 * 
		 * @param vec 		Vector to check
		 * @param value 	Value we're looking for
		 */			
		public static function contains (vec :*, value :Object) :Boolean
		{
			return (vec.indexOf(value) != -1);
		}	
		
		/**
		 * Removes all instances of the specified object from the vector.
		 * 
		 * @param vec 		Vector to remove from
		 * @param value 	Value to remove
		 */		
		public static function remove (vec :*, value :Object) :void
		{
			for (var i :int = vec.length - 1; i >= 0; i--) {
				if (vec[i] === value) {
					vec.splice(i, 1);
				}
			}					
		}

		/**
		 * Creates a shallow copy of the specified vector (new vector contains
		 * references to the same items as the original vector).
		 * 
		 * @param vec 		Vector to copy
		 */			
		public static function copy (vec :*) :*
		{	
			return vec.slice();
		}
		
		/**
		 * Returns true if both vectors have the same values at the same indexes, 
		 * using strict equality test.
		 */		
		public static function equals (vec1 :*, vec2 :*) :Boolean
		{
			if (vec1.length != vec2.length) {
				return false;
			}
			
			for (var i :uint = 0, len :uint = vec1.length; i < len; i++) {
				if (vec1[i] !== vec2[i]) {
					return false;
				}
			}
			
			return true;
		}
	}
}
