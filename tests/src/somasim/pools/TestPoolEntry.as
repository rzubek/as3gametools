package somasim.pools
{
	internal class TestPoolEntry implements IObjectPoolEntry
	{
		public var resetCount :uint = 0;
		
		public function TestPoolEntry()
		{
		}
		
		/** @inheritDoc */
		public function reset () :void {
			resetCount++;
		}
		
		/** Factory function */
		public static function factory () :TestPoolEntry {
			return new TestPoolEntry();
		}
	}
}