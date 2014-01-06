package somasim.utils
{
	import flash.utils.Dictionary;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class DictionaryUtilTest {
		
		private const TESTOBJ :Object = { foo: 1, bar: 2, baz: 3 };
		
	    private function makeDictionary () :Dictionary {
			var d :Dictionary = new Dictionary();
			d.keyA = "valueA";
			d["keyB"] = "valueB";
			d[1] = TESTOBJ;
			return d;			
        }
		
		[Test]
		public function testGetKeys () :void {
			var d :Dictionary = makeDictionary();
			var keys :Array = DictionaryUtil.getKeys(d);
			assertEquals(3, keys.length);
			assertTrue(ArrayUtil.contains(keys, "keyA"));
			assertTrue(ArrayUtil.contains(keys, "keyB"));
			assertTrue(ArrayUtil.contains(keys, 1));
		}

		[Test]
		public function testGetValues():void {
			var d :Dictionary = makeDictionary();
			var values :Array = DictionaryUtil.getValues(d);
			assertEquals(3, values.length);
			assertTrue(ArrayUtil.contains(values, "valueA"));
			assertTrue(ArrayUtil.contains(values, "valueB"));
			assertTrue(ArrayUtil.contains(values, TESTOBJ));
		}

		[Test]
		public function testClear():void {
			var d :Dictionary = makeDictionary();
			DictionaryUtil.clear(d);
			
			var keys :Array = DictionaryUtil.getKeys(d);
			assertEquals(0, keys.length);
		}
		
		[Test]
		public function testClone():void {
			var d :Dictionary = makeDictionary();
			var c :Dictionary = DictionaryUtil.clone(d);
			
			var cKeys :Array = DictionaryUtil.getKeys(c).sort();
			var dKeys :Array = DictionaryUtil.getKeys(d).sort();
			assertTrue(ArrayUtil.equals(cKeys, dKeys));
			for each (var key :* in cKeys) {
				assertTrue(d[key] === c[key]);
			}
		}
		
		[Test]
		public function testIsEmpty():void {
			assertFalse(DictionaryUtil.isEmpty(makeDictionary()));
			assertTrue(DictionaryUtil.isEmpty(new Dictionary()));
		}
		
		[Test]
		public function testToObject():void {
			var d :Dictionary = makeDictionary();
			var o :Object = DictionaryUtil.toObject(d);
			assertEquals("valueA", o.keyA);
			assertEquals("valueB", o["keyB"]);
			assertEquals(TESTOBJ, o["1"]);
		}

		[Test]
		public function testToDictionary():void {
			var o :Object = { keyA: "valueA", keyB: "valueB", 1: TESTOBJ };
			var d :Dictionary = DictionaryUtil.toDictionary(o);
			assertEquals("valueA", d["keyA"]);
			assertEquals("valueB", d["keyB"]);
			assertEquals(TESTOBJ, d["1"]);
		}
	}
}