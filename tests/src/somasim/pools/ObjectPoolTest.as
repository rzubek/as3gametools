package somasim.pools
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;

	public class ObjectPoolTest
	{
		[Test]
		public function testInitialization () :void {
			var pool :ObjectPool = new ObjectPool();
			pool.initialize(TestPoolEntry.factory);
			
			assertEquals(0, pool.usedVector.length);
			assertEquals(0, pool.freeVector.length);
		}

		[Test]
		public function testRelease () :void {
			var pool :ObjectPool = new ObjectPool();
			pool.initialize(TestPoolEntry.factory);
			pool.release();
			
			assertNull(pool.usedVector);
			assertNull(pool.freeVector);
		}

		[Test]
		public function testAllocFree () :void {
			var pool :ObjectPool = new ObjectPool();
			pool.initialize(TestPoolEntry.factory);
			
			// allocate the first entry, make sure it's in the used pool
			var first :TestPoolEntry = pool.alloc() as TestPoolEntry;
			assertEquals(0, first.resetCount);
			assertEquals(0, pool.freeVector.length);			
			assertEquals(1, pool.usedVector.length);			
			assertEquals(first, pool.usedVector[0]);

			// free it, make sure it returned to free pool
			pool.free(first);
			assertEquals(1, first.resetCount);
			assertEquals(1, pool.freeVector.length);			
			assertEquals(first, pool.freeVector[0]);
			assertEquals(0, pool.usedVector.length);			

			// alloc a new one, make sure it's the same one from the free pool
			var second :TestPoolEntry = pool.alloc() as TestPoolEntry;
			assertEquals(1, first.resetCount); // it's been allocated before
			assertEquals(0, pool.freeVector.length);			
			assertEquals(1, pool.usedVector.length);			
			assertEquals(second, pool.usedVector[0]);
			assertEquals(first, second);

			pool.release();
		}
		
		[Test]
		public function testPoolSizeLimit () :void {
			var pool :ObjectPool = new ObjectPool();
			pool.initialize(TestPoolEntry.factory, 1);
			
			var first :TestPoolEntry = pool.alloc() as TestPoolEntry;
			assertNotNull(first);
			var second :TestPoolEntry = pool.alloc() as TestPoolEntry;
			assertNull(second);
			assertEquals(1, pool.usedVector.length);
			assertEquals(0, pool.freeVector.length);
			
			pool.release();
		}
	}
}