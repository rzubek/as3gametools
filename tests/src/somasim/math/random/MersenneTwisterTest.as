package somasim.math.random
{
	import flash.utils.getTimer;
	
	import org.flexunit.asserts.assertEquals;

	public class MersenneTwisterTest
	{		
		[Test]
		public function testFirstRun () :void {
			var r :MersenneTwister = new MersenneTwister();
			r.setSeed(1);
			
			assertEquals(3582630607, r.next());
		}
		
		//[Test] // uncomment to enable
		public function perfTest () :void {
			var r :MersenneTwister = new MersenneTwister();
			r.setSeed(1);
			
			var start :int = getTimer();
			var n :uint = 0;
			for (var i :int = 0; i < 10000000; i++) {
				n = r.next();
			}
			var end :int = getTimer();
			
			var dt :Number = (end - start) / 1000;
			var velocity :Number = i / dt;
			
			trace("MersenneTwister generated ", velocity, " numbers/second");
			
			// note: generates ~ 1.4M numbers / second on a 2013 core i7 laptop, in debug mode
		}

	}
}