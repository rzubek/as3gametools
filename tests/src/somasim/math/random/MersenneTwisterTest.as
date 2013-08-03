package somasim.math.random
{
	import org.flexunit.asserts.assertEquals;

	public class MersenneTwisterTest
	{		
		[Test]
		public function testFirstRun () :void {
			var r :MersenneTwister = new MersenneTwister();
			r.setSeed(1);
			
			assertEquals(3582630607, r.next());
		}
		
	}
}