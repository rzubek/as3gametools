package somasim.utils
{
	import flexunit.framework.TestCase;
	
	public class SequenceUtilTest extends TestCase
	{
		public function SequenceUtilTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testToTuples () :void {
			var seq :Vector.<uint> = new <uint> [ 0, 1, 2, 3, 4 ];
			var tuples :Array = SequenceUtil.toTuples(seq, 3);
			
			assertEquals("tuples.length == 2", 2, tuples.length);
			assertEquals("tuples[0].length == 3", 3, tuples[0].length);
			assertEquals("tuples[1].length == 3", 3, tuples[1].length);
			assertEquals("tuples[0][0] == 0", 0, tuples[0][0]);
			assertEquals("tuples[0][1] == 1", 1, tuples[0][1]);
			assertEquals("tuples[0][2] == 2", 2, tuples[0][2]);
			assertEquals("tuples[1][0] == 3", 3, tuples[1][0]);
			assertEquals("tuples[1][1] == 4", 4, tuples[1][1]);
			assertEquals("tuples[1][2] == null", null, tuples[1][2]);
		}
		
		public function testToObject () :void {
			var seq :Array = [ [ 0, 1 ], [ 2, 3 ] ];
			var obj :Object = SequenceUtil.toObject(seq);
			
			assertEquals("obj['0'] == 1", 1, obj["0"]);
			assertEquals("obj['2'] == 3", 3, obj["2"]);
		}
	}
}