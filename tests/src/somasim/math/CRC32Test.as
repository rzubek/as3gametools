package somasim.math
{
	import org.flexunit.asserts.assertEquals;

	public class CRC32Test
	{
		[Test]
		public function testCRCString () :void {
			var str :String = "foobar";
			var crc :uint = CRC32.crcString(str);
			assertEquals(0x9ef61f95, crc);
		}
	}
}