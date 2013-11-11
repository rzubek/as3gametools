package somasim.malloc
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class ByteArrayUnmanagedTests
	{
		[BeforeClass]
		public static function prepare () :void {
			// clean up from other tests
			if (DomainMemoryManager.isInitialized) {
				DomainMemoryManager.instance.dispose();
			}
		}

		[Test]
		public function testReadingWriting () :void {
			
			var mem :DomainMemoryManager = new DomainMemoryManager(1024, true);

			var bytes :ByteArrayUnmanaged = new ByteArrayUnmanaged(10);
			assertTrue(bytes.isValid);
			assertEquals(10, bytes.length);
	
			assertTrue(bytes._testReadWrite());
			
			bytes.dispose();
			assertFalse(bytes.isValid);
			assertEquals(0, bytes.length);
			
			DomainMemoryManager.instance.dispose();
		}
	}
}