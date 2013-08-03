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
		
	}
}