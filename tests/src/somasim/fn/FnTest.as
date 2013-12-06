package somasim.fn
{
	import flexunit.framework.TestCase;
	
	import somasim.utils.ArrayUtil;
	
	public class FnTest extends TestCase
	{
		public function FnTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testMap () :void {
			var source :Array = [ 1, 2, 3, 4, 5 ];
			var doubled :Array = map(function (x :Number) :Number { return 2 * x }, source);
			assertTrue("map test", ArrayUtil.equals(doubled, [2, 4, 6, 8, 10]));
		}
		
		public function testFilter () :void {
			var source :Array = [ 1, 2, 3, 4, 5 ];
			var even :Array = filter(function (x :Number) :Boolean { return (x % 2) == 0; }, source);			
			assertTrue("filter test", ArrayUtil.equals(even, [2, 4]));
		}
		
		public function testFoldLeft () :void {
			var source :Array = [ "a", "b", "c" ];
			var result :String = foldLeft(function (s1 :String, s2 :String) :String { return s1 + s2; }, "_", source);
			assertEquals("foldLeftTest", "cba_", result);
			
			var nonresult :String = foldLeft(function (s1 :String, s2 :String) :String { return s1 + s2; }, "_", []);
			assertEquals("foldLeftTest", "_", nonresult);
		}
		
		public function testFoldRight () :void {
			var source :Array = [ "a", "b", "c" ];
			var result :String = foldRight(function (s1 :String, s2 :String) :String { return s1 + s2; }, "_", source);
			assertEquals("foldLeftTest", "abc_", result);

			var nonresult :String = foldRight(function (s1 :String, s2 :String) :String { return s1 + s2; }, "_", []);
			assertEquals("foldLeftTest", "_", nonresult);
		}

	}
}