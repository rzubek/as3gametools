package somasim.utils
{
	import flexunit.framework.TestCase;
	
	public class BitwiseUtilTest extends TestCase
	{
		public function BitwiseUtilTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testReverseBits () :void {
			var input :uint  = 0x123489ab; // (binary 0001 0010 0011 0100 1000 1001 1010 1011)
			var output :uint = 0xd5912c48; // (binary 1101 0101 1001 0001 0010 1100 0100 1000)
			
			assertEquals("reverse bits", output, BitwiseUtil.reverseBits(input));
		}
		
		public function testShuffleAndUnshuffleBits () :void {
			var original :uint = 0x0f0f55aa; // (binary 0000 1111 0000 1111 0101 0101 1010 1010)
			var shuffled :uint = 0x11bb44ee; // (binary 0001 0001 1011 1011 0100 0100 1110 1110)
			
			var forward :uint = BitwiseUtil.shuffleBits(original);
			var backward :uint = BitwiseUtil.unshuffleBits(forward);
			
			assertEquals("shuffleBits", shuffled, forward);
			assertEquals("unshuffleBits", original, backward);
		}
	}
}