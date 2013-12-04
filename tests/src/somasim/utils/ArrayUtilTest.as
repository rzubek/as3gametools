package somasim.utils
{
	import flexunit.framework.TestCase;

	public class ArrayUtilTest extends TestCase
	{	
		private var v:Array;
		
	    public function ArrayUtilTest(methodName:String = null)
        {
            super(methodName);

			v = [0, 1, 2, "test", 4, [5.1, 5.2, 5.3], 6, 7, 7, 7, { foo: "bar" }];
        }
		
		public function testArraysAreEqual():void
		{
			var v2:Array = ArrayUtil.copy(v);
			
			assertTrue("ArrayUtil.equals(v, v2)", ArrayUtil.equals(v, v2));
			assertFalse("ArrayUtil.equals(v, new Array())", ArrayUtil.equals(v, new Array()));											
		}		
		
		public function testCopyArray():void
		{
			var v2:Array = ArrayUtil.copy(v);
			assertNotNull("v2 not null", v2);
			assertEquals("v.length == v2.length", v.length, v2.length);
			
			for(var i :uint = 0; i < v.length; i++) {
				assertEquals("v["+i+"] == v2["+i+"]", v[i], v2[i]);
			}			
		}		
		
		public function testRemoveValueFromArray():void
		{
			var v2:Array = ArrayUtil.copy(v);
			var len2:uint = v2.length;

			ArrayUtil.remove(v2, 4);
			
			assertEquals("v2.length == (len2 - 1)", (len2 - 1), v2.length);
			assertTrue("v2[4] != 4", v2[4] != 4);
			
			assertFalse("ArrayUtil.contains(v2, 4)", ArrayUtil.contains(v2, 4));			
			
			var v3:Array = ArrayUtil.copy(v);
			var len3:Number = v3.length;
			
			ArrayUtil.remove(v3, 7);	
			
			assertEquals("v3.length == (len3 - 3)", (len3 - 3), v3.length);
			assertFalse("ArrayUtil.contains(v3, 7)", ArrayUtil.contains(v3, 7));
									
			var v4:Array = ArrayUtil.copy(v);
			var len4:Number = v4.length;
			
			ArrayUtil.remove(v4, 12345);	
			
			assertEquals("len4 == v4.length", len4, v4.length);
				
		}

		public function testArrayContainsValue():void
		{
			assertTrue("ArrayUtil.contains(v, 1)", ArrayUtil.contains(v, 1));
			assertTrue("ArrayUtil.contains(v, 'test')", ArrayUtil.contains(v, "test"));

			assertFalse("ArrayUtil.contains(v, 10)", ArrayUtil.contains(v, 10));
			assertFalse("ArrayUtil.contains(v, {foo: 'bar'})", ArrayUtil.contains(v, {foo: "bar"}));
		}

	}
}