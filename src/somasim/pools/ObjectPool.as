package somasim.pools
{
	/**
	 * Manages allocating resources (either new or from the pool) and returning them for future reuse. 
	 */
	public class ObjectPool 
	{
		/** Local reference to the factory that returns objects of type IObjectPoolEntry */
		private var _factory :Function;
		
		/** Max number of items that can be allocated at the same time */
		private var _max :Number;
		
		/** Vector that holds all items currently in circulation */
		private var _used :Vector.<IObjectPoolEntry> = new Vector.<IObjectPoolEntry>();
		
		/** Vector that holds all items available for reuse */
		private var _free :Vector.<IObjectPoolEntry> = new Vector.<IObjectPoolEntry>();
		
		/** Allocates storage. Takes a factory, which is a nullary thunk that makes new instances. */
		public function initialize (factory :Function, max :Number = Number.POSITIVE_INFINITY) :void {
			_factory = factory;
			_max = max;
			_used = new Vector.<IObjectPoolEntry>();
			_free = new Vector.<IObjectPoolEntry>();
		}
		
		/** Releases storage */
		public function release () :void {
			_free.length = 0;
			_free = null;
			_used.length = 0;
			_used = null;
			_max = 0;
			_factory = null;
		}

		/** Returns a raw instance of the used vector. For testing only. */
		internal function get usedVector () :Vector.<IObjectPoolEntry> { 
			return _used;
		}

		/** Returns a raw instance of the free vector. For testing only. */
		internal function get freeVector () :Vector.<IObjectPoolEntry> { 
			return _free;
		}

		/** 
		 * Allocates (and potentially creates) a new instance, and returns it. 
		 * If max number have been reached, returns null. 
		 */
		public function alloc () :IObjectPoolEntry {
			if (_used.length >= _max) {
				return null;
			}
			
			var obj :IObjectPoolEntry = (_free.length > 0) ? _free.pop() : _factory();
			_used.push(obj);
			return obj;
		}
		
		/** Deallocates a currently used instance */
		public function free (instance :IObjectPoolEntry) :void {
			var index :int = _used.indexOf(instance);
			if (index < 0) {
				throw new Error("Attempted to free an unused object pool instance!");
			}
			
			instance.reset();
			_used.splice(index, 1);
			_free.push(instance);
		}		
		
		/** Flushes the pool of free instances, so that future allocs will generate new instances */
		public function flush () :void {
			_free.length = 0;
		}
	}

}