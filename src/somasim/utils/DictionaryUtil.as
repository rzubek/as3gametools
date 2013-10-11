package somasim.utils
{
	import flash.utils.Dictionary;
	
	public class DictionaryUtil
	{
		/** Returns an array of all keys in the dictionary */
		public static function getKeys (dict :Dictionary, outarray :Array = null) :Array {
			var keys :Array = (outarray != null) ? outarray : [];
			keys.length = 0;
			for (var key :* in dict) {
				keys.push(key);
			}
			return keys;
		}
		
		/** Returns an array of all values in the dictionary */
		public static function getValues (dict :Dictionary, outarray :Array = null) :Array {
			var values :Array = (outarray != null) ? outarray : [];
			values.length = 0;
			for each (var value :* in dict) {
				values.push(value);
			}
			return values;
		}
		
		/** Removes all data from a dictionary */
		public static function clear (dict :Dictionary) :void {
			var keys :Array = getKeys(dict);
			for each (var key :* in keys) {
				delete dict[key];
			}
		}
		
		/** Makes a shallow copy of the specified dictionary */
		public static function clone (dict :Dictionary, weakKeys :Boolean = false) :Dictionary {
			var result :Dictionary = new Dictionary(weakKeys);
			var keys :Array = getKeys(dict);
			for each (var key :* in keys) {
				result[key] = dict[key];
			}
			return result;
		}
		
		/** Returns false if the dictionary contains any keys, true if it's empty. */
		public static function isEmpty (dict :Dictionary) :Boolean {
			for (var key :* in dict) {
				return false;
			}
			return true;
		}
	}
}