package somasim.utils
{
	import flexunit.framework.TestCase;

	public class VectorUtilTest extends TestCase
	{	
		private var v:Vector.<uint>;
		
	    public function VectorUtilTest(methodName:String = null)
        {
            super(methodName);

			v = new <uint>[0, 1, 2, 3, 4, 5, 6, 7, 7, 7];
        }
		
		public function testVectorsAreEqual():void
		{
			var v2:Vector.<uint> = VectorUtil.copy(v);
			
			assertTrue("VectorUtil.equals(v, v2)", VectorUtil.equals(v, v2));
			assertFalse("VectorUtil.equals(v, new Vector.<uint>())", VectorUtil.equals(v, new Vector.<uint>()));											
		}		
		
		public function testCopyVector():void
		{
			var v2:Vector.<uint> = VectorUtil.copy(v);
			assertNotNull("v2 not null", v2);
			assertEquals("v.length == v2.length", v.length, v2.length);
			
			for(var i :uint = 0; i < v.length; i++) {
				assertEquals("v["+i+"] == v2["+i+"]", v[i], v2[i]);
			}			
		}		
		
		public function testRemoveValueFromVector():void
		{
			var v2:Vector.<uint> = VectorUtil.copy(v);
			var len2:uint = v2.length;

			VectorUtil.remove(v2, 4);
			
			assertEquals("v2.length == (len2 - 1)", (len2 - 1), v2.length);
			assertTrue("v2[4] != 4", v2[4] != 4);
			
			assertFalse("VectorUtil.contains(v2, 4)", VectorUtil.contains(v2, 4));			
			
			var v3:Vector.<uint> = VectorUtil.copy(v);
			var len3:Number = v3.length;
			
			VectorUtil.remove(v3, 7);	
			
			assertEquals("v3.length == (len3 - 3)", (len3 - 3), v3.length);
			assertFalse("VectorUtil.contains(v3, 7)", VectorUtil.contains(v3, 7));
									
			var v4:Vector.<uint> = VectorUtil.copy(v);
			var len4:Number = v4.length;
			
			VectorUtil.remove(v4, 12345);	
			
			assertEquals("len4 == v4.length", len4, v4.length);
				
		}

		public function testVectorContainsValue():void
		{
			assertTrue("VectorUtil.contains(v, 1)", VectorUtil.contains(v, 1));
			assertFalse("VectorUtil.contains(v, 10)", VectorUtil.contains(v, 10));
		}

	}
}