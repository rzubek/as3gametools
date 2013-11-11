package somasim.malloc
{
	import flash.utils.ByteArray;
	
	import avm2.intrinsics.memory.lf32;
	import avm2.intrinsics.memory.li32;
	import avm2.intrinsics.memory.li8;
	import avm2.intrinsics.memory.si32;
	
	/** 
	 * Reference to a sub-range of a managed heap. Use this object instead of creating
	 * a new ByteArray object.
	 * 
	 * <p> The particular position and length inside the heap may change over time, 
	 * as the byte array acquires additional data and grows, so they must not be cached elsewhere.
	 */
	public class ByteArrayUnmanaged {
		private var _bytes :ByteArray;
		private var _offset :uint;
		private var _length :uint;
		
		/** Allocates a range of at least the specified number of bytes (potentially larger),
		 * and initializes this reference. You MUST call dispose(), this byte array will not
		 * be garbage collected automatically. */
		public function ByteArrayUnmanaged (bytes :uint) {
			
			if (bytes < 4) { bytes = 4; } // allocate at least a word
			
			var mem :DomainMemoryManager = DomainMemoryManager.instance;
			_bytes = mem.heap;
			_offset = mem.allocate(bytes);
			_length = bytes;
		}
		
		/** Deallocates this managed byte range. You MUST call this function to free up the memory, 
		 * this byte array is not subject to garbage collection. */
		public function dispose () :void {
			DomainMemoryManager.instance.free(_offset);
			
			_bytes = null;
			_offset = _length = 0;
		}
		
		/** Appends bytes from the source byte array reference, starting at given offset, 
		 * and copying over given number of bytes. This will reallocate the current reference
		 * to a new, larger location in the heap. */
		public function appendBytes (source :ByteArrayUnmanaged, offset :uint = 0, length :uint = 0) :void {
			var end :uint = _length;
			resize(_length + length);
			
			// write data at the end
			overwriteBytesAt(end, source, offset, length);
		}
		
		/** Overwrites bytes in the reference, starting at specified offset, and of specified length.
		 * Writing past byte array bounds is neither detected nor prevented - proceed with caution! */
		public function overwriteBytesAt (targetOffset :uint, source :ByteArrayUnmanaged, offset :uint = 0, length :uint = 0) :void {
			var rawSourcePos :uint = offset + source._offset;
			_bytes.position = targetOffset + _offset;
			_bytes.writeBytes(source._bytes, rawSourcePos, length);
		}
		
		/** Given on offset in the byte array reference, returns its raw address in the domain memory heap. 
		 * Use this address with memory intrinsics, e.g. li32(), si32(), etc. */
		[Inline] public final function getHeapAddress (pos :uint) :uint {
			return _offset + pos;
		}
		
		/** Reference to the raw managed heap. */
		public function get heap () :ByteArray { return _bytes; }
		
		/** Returns the length of this byte array reference, in bytes. */
		public function get length () :uint { return _length; }

		/** Returns true if this byte array has been allocated, and not yet disposed. */
		public function get isValid () :Boolean { return _length != 0; }
		

		/** Helper function for reading an uint at given position inside the range. 
		 * Only used as a helper, please use fast memory intrinsics directly instead. */
		public function readUnsignedInt (pos :uint) :uint {
			return li32(_offset + pos);
		}
		
		/** Helper function for reading a byte at given position inside the range. 
		 * Only used as a helper, please use fast memory intrinsics directly instead. */
		public function readByte (pos :uint) :uint {
			return li8(_offset + pos);
		}
		
		/** Helper function for reading a float at given position inside the range. 
		 * Only used as a helper, please use fast memory intrinsics directly instead. */
		public function readFloat (pos :uint) :Number {
			return lf32(_offset + pos);
		}
		
		/** Grows this byte array reference to the new size, allocating new memory 
		 * and moving data over if necessary. */
		public function resize (size :uint, planned :Boolean = false) :void {
			if (_length == size) {
				return; // useless resize, ignore it
			}
			
			if (! planned) {
				// trace("RESIZE TO SIZE", size);
			}
			
			// allocate more memory (expensive!)
			var newOffset :uint = DomainMemoryManager.instance.reallocate(_offset, _length, size);
			_offset = newOffset;
			_length = size;
		}
		
		/** Unfortunately this internal test function has to be on this class, instead of inside
		 * unit tests, because trying to get memory intrinsics to work inside a FlexUnit class
		 * is proving to be... difficult. Until I can convince FlexUnit otherwise, this will have to do. */
		internal function _testReadWrite () :Boolean {
			// write using intrinsics and public api
			si32(42, getHeapAddress(0));
			// read using test function that wraps any heap access
			var result :uint = readUnsignedInt(0);
			// see if they compare
			return result == 42;
		}
	}
}