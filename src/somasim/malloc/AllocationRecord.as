package somasim.malloc
{
	/** A single heap allocation, with a start position and size. In debug mode,
	 * additional sentinels will be added before the start position, and after the
	 * end position, to check for accidental memory overwrites. */
	public class AllocationRecord {
		
		/** Start of the allocation record. 
		 * 
		 * <p> In debug mode, this is the first sentinel position. 
		 * In non-debug, this is the same as datastart. */ 
		public var start :uint;
		
		/** Length of the full allocation, including both sentinels (if present). */
		public var size :uint;
		
		/** Start of the data payload in this allocation record.
		 *  
		 * <p> In debug mode, this is right after the starting sentinel.
		 * In non-debug, this is the same as the start position. */
		public var datastart :uint;
		
		/** Length of the data segment, excluding sentinels (if present). */
		public var datasize :uint;
		
		public function AllocationRecord (start :uint, size :uint, sentinel :uint) :void {
			setSize(start, size, sentinel);
		}
		
		/** Only used by the allocator, to modify existing records (e.g. during merge) */
		internal function setSize (start :uint, size :uint, sentinel :uint) :void {
			this.start = start;
			this.size = size;
			this.datastart = start + sentinel;
			this.datasize = size - sentinel * 2; 
		}
		
		/** Returns the start position of the next node (if one exists) */
		public function get nextstart () :uint { 
			return start + size;
		}
	}
}