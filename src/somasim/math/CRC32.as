package somasim.math
{
	import flash.utils.ByteArray;

	/** Implementation of the 32-bit Cyclic Redundancy Check, as defined in RFC1952 */
	public class CRC32
	{
		/** Table of CRCs of all 8-bit messages. */
		private static var _table :Vector.<uint> = new Vector.<uint>(256, true);
		
		/** Flag: has the table been computed? Initially false. */
		private static var _tableComputed :Boolean = false;
		
		/** Make the table for a fast CRC. */
		private static function makeTable () :void {
			var c :uint;
			for (var n :int = 0; n < 256; n++) {
				c = n;
				for (var k :uint = 0; k < 8; k++) {
					if (c & 1) {
						c = 0xedb88320 ^ (c >>> 1);
					} else {
						c = c >>> 1;
					}
				}
				_table[n] = c;
			}
			_tableComputed = true;
		}
		
		/** 
		 * Update a running crc with the bytes buf[0..len-1] and return
		 * the updated crc. The crc should be initialized to zero. Pre- and
		 * post-conditioning (one's complement) is performed within this
		 * function so it shouldn't be done by the caller. 
		 */
		private static function update (crc :uint, buf :ByteArray, len :int) :uint {
			if (!_tableComputed) { makeTable(); }

			var c :uint = ~crc;
			for (var n :int = 0; n < len; n++) {
				c = _table[(c ^ buf[n]) & 0xff] ^ (c >>> 8);
			}
			return ~c;
		}
		
		/** Return the CRC of the bytes buf[0..buf.len-1]. */
		public static function crc (buf :ByteArray) :uint {
			return update(0, buf, buf.length);
		}
		
		/** Returns the CRC of a UTF-8 encoded string. */
		public static function crcString (string :String) :uint {
			_tmpStringHolder.writeUTFBytes(string);
			var result :uint = crc(_tmpStringHolder);
			_tmpStringHolder.clear();
			
			return result;
		}

		/** Temporary byte array to speed up string calculations. */
		private static var _tmpStringHolder :ByteArray = new ByteArray();
	}
}