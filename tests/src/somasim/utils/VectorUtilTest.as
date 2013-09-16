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
		
		public function testArraysAreEqual():void
		{
			var v2:Vector.<uint> = VectorUtil.copyVector(v);
			
			assertTrue("VectorUtil.vectorsAreEqual(v, v2)",
						VectorUtil.vectorsAreEqual(v, v2));
											
			assertTrue("!VectorUtil.vectorsAreEqual(arr, new Vector.<uint>())",
						!VectorUtil.vectorsAreEqual(v, new Vector.<uint>()));											
		}		
		
		public function testCopyVector():void
		{
			var len:uint = v.length;
			var v2:Vector.<uint> = VectorUtil.copyVector(v);

			var len2:uint = v2.length;
			assertTrue("len2 == v.length", len2 == v.length);
			
			for(var i:uint = 0; i < len2; i++)
			{
				assertTrue("v["+i+"] == v2["+i+"]", v[i] == v2[i]);
			}
			
			VectorUtil.removeValueFromVector(v2, 1);
			
			assertTrue("v.length == len", v.length == len);
		}		
		
		public function testRemoveValueFromVector():void
		{
			var v2:Vector.<uint> = VectorUtil.copyVector(v);
			var len2:Number = v2.length;
			
			VectorUtil.removeValueFromVector(v2, 4);
			
			assertNotNull("v2 is null", v2);
			assertTrue("(len2 - 1) == v2.length", (len2 - 1) == v2.length);
			assertTrue("v2[4] != 4", v2[4] != 4);
			
			assertTrue("!VectorUtil.vectorContainsValue(v2, 4)",
						!VectorUtil.vectorContainsValue(v2, 4));			
			
			var v3:Vector.<uint> = VectorUtil.copyVector(v);
			var len3:Number = v3.length;
			
			VectorUtil.removeValueFromVector(v3, 7);	
			
			assertTrue("v3.length == (len3 - 3)", v3.length == (len3 - 3));
			assertTrue("!VectorUtil.vectorContainsValue(v3, 7)",
						!VectorUtil.vectorContainsValue(v3, 7));
									
			var v4:Vector.<uint> = VectorUtil.copyVector(v);
			var len4:Number = v4.length;
			
			VectorUtil.removeValueFromVector(v4, 12345);	
			
			assertTrue("len4 == v4.length", len4 == v4.length);
				
		}

		public function testVectorContainsValue():void
		{
			assertTrue("VectorUtil.vectorContainsValue(v, 1)",
						VectorUtil.vectorContainsValue(v, 1));
										
			assertTrue("!VectorUtil.vectorContainsValue(v, 10)", 
						!VectorUtil.vectorContainsValue(v, 10));
		}

	}
}