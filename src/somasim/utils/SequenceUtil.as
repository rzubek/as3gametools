package somasim.utils
{
	/**
	 * Utilities for operating on sequences, whether they're Arrays or Vectors.
	 */
	public class SequenceUtil
	{
		/** 
		 * Converts a sequence of elements into a sequence of tuples of given size. 
		 * For example, given the sequence [1, 2, 3, 4, 5] and size = 3,
		 * it returns [[1, 2, 3], [4, 5, null]].
		 * 
		 * @param 	seq		Sequence to be unzipped, either Array or Vector
		 * @param	size 	Width of each tuple
		 */
		public static function toTuples (seq :*, size :uint) :Array {
			var len :uint = seq.length;				// number of elements
			var tuples :uint = Math.ceil(len / size); // number of tuples
			var results :Array = [];
			
			for (var t :int = 0; t < tuples; t++) {
				var tuple :Array = [];
				for (var i :int = 0; i < size; i++) {
					var ie :int = t * size + i;
					var element :* = (ie < len) ? seq[ie] : null;
					tuple[tuple.length] = element;
				}
				results[results.length] = tuple;
			}
			
			return results;
		}
		
		/** 
		 * Converts a sequence of tuples like [ [ k1, v1 ], [ k2, v2 ], ... ] into 
		 * an Object like { k1: v1, k2: v2, ... }.
		 * 
		 * @param	seq 	Sequence with key-value tuples, to be converted into an object.
		 */
		public static function toObject (seq :*) :Object {
			var results :Object = {};
			for each (var tuple :* in seq) {
				var k :* = tuple[0];
				var v :* = tuple[1];
				results[k] = v;
			}
			return results;
		}
		
		/** Fills the target sequence with all elements from the source sequence, 
		 * appending each to the end in order, and returns a reference to the modified target sequence.
		 * 
		 * Useful for converting between vector and array types, for example:
		 * <pre>
		 *   var vec :Vector.<int> = fillFromSeq(new <int>[], someArrayOfIntegers);
		 * </pre>
		 */
		public static function fillFromSeq (target :*, source :*) :* {
			for each (var element :* in source) {
				target.push(element);
			}
			return target;
		}
		
		/** Fills the target sequence with the given value, and returns a reference to the modified target sequence.
		 * By default, if count is negative, the sequence will be filled from the given offset to the end.
		 * Alternatively, if count is positive, the sequence will be filled with the given number of elements.
		 * If autosize is true, the sequence will grow or shrink to fit the count. (Only meaningful if count is negative.)
		 * 
		 * <pre>
		 *   fillWithValue([0, 0, 0], 9);               // => [ 9, 9, 9 ]
		 *   fillWithValue([0, 0, 0], 9, 1);            // => [ 0, 9, 9 ]
		 *   fillWithValue([0, 0, 0], 9, 1, 1);         // => [ 0, 9, 0 ]
		 *   fillWithValue([0, 0, 0], 9, 1, 3);         // => [ 0, 9, 9 ] (without resize)
		 *   fillWithValue([0, 0, 0], 9, 1, 3, true);   // => [ 0, 9, 9, 9 ]
		 *   fillWithValue([0, 0, 0], 9, 1, 1, true);   // => [ 0, 9 ]
		 * </pre>
		 */
		public static function fillWithValue (target :*, value :*, offset :uint = 0, count :int = -1, autosize :Boolean = false) :* {
			if (count < 0) {
				// just fill to the end
				count = target.length - offset;
			} else if (! autosize) {
				// count specified, autosize disabled
				// fill count, or to the end, whichever comes first
				count = Math.min(target.length - offset, count);
			} else {
				// count specified, autosize enabled
				// resize the target!
				target.length = (offset + count);
			}
			
			for (var i :int = 0; i < count; i++) {
				var index :uint = offset + i;
				target[index] = value;
			}
			
			return target;
		}

	}
}