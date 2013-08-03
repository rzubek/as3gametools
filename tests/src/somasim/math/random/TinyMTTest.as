package somasim.math.random
{
	import org.flexunit.asserts.assertEquals;

	public class TinyMTTest
	{		
		[Test]
		public function testFirstRun () :void {
			var r :TinyMT = new TinyMT();
			r.setSeed(1);

			assertEquals(2966261233, r.next());
			
			// note: generates ~ 1.5M numbers / second on a 2013 core i7 laptop, in debug mode
		}
	}
}