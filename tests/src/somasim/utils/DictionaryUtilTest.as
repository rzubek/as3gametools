package somasim.utils
{
	import com.adobe.utils.ArrayUtil;
	
	import flash.utils.Dictionary;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;

	public class DictionaryUtilTest {
		
	    private function makeDictionary () :Dictionary {
			var d :Dictionary = new Dictionary();
			d.keyA = "valueA";
			d["keyB"] = "valueB";
			d[1] = 2;
			return d;			
        }
		
		[Test]
		public function testGetKeys () :void {
			var d :Dictionary = makeDictionary();
			var keys :Array = DictionaryUtil.getKeys(d);
			assertEquals(3, keys.length);
			assertTrue(ArrayUtil.arrayContainsValue(keys, "keyA"));
			assertTrue(ArrayUtil.arrayContainsValue(keys, "keyB"));
			assertTrue(ArrayUtil.arrayContainsValue(keys, 1));
		}

		[Test]
		public function testGetValues():void {
			var d :Dictionary = makeDictionary();
			var values :Array = DictionaryUtil.getValues(d);
			assertEquals(3, values.length);
			assertTrue(ArrayUtil.arrayContainsValue(values, "valueA"));
			assertTrue(ArrayUtil.arrayContainsValue(values, "valueB"));
			assertTrue(ArrayUtil.arrayContainsValue(values, 2));
		}

		[Test]
		public function testClear():void {
			var d :Dictionary = makeDictionary();
			DictionaryUtil.clear(d);
			
			var keys :Array = DictionaryUtil.getKeys(d);
			assertEquals(0, keys.length);
		}
	}
}