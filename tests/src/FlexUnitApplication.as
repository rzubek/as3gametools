package
{
	import Array;
	
	import com.adobe.crypto.HMACMD5Test;
	import com.adobe.crypto.HMACSHA1Test;
	import com.adobe.crypto.MD5Test;
	import com.adobe.crypto.SHA1Test;
	import com.adobe.crypto.SHA224Test;
	import com.adobe.crypto.SHA256Test;
	import com.adobe.images.JPGEncoderTest;
	import com.adobe.images.PNGEncoderTest;
	import com.adobe.net.URITest;
	import com.adobe.utils.ArrayUtilTest;
	import com.adobe.utils.IntUtilTest;
	import com.adobe.utils.StringUtilTest;
	
	import flash.display.Sprite;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	import somasim.math.CRC32Test;
	import somasim.math.random.MersenneTwisterTest;
	import somasim.math.random.TinyMTTest;
	import somasim.pools.ObjectPoolTest;
	import somasim.utils.DictionaryUtilTest;
	
	public class FlexUnitApplication extends Sprite
	{
		public function FlexUnitApplication()
		{
			onCreationComplete();
		}
		
		private function onCreationComplete():void
		{
			var testRunner:FlexUnitTestRunnerUIAS=new FlexUnitTestRunnerUIAS();
			testRunner.portNumber=8765; 
			this.addChild(testRunner); 
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "AS3 Game Tools Unit Tests");
		}
		
		public function currentRunTestSuite():Array
		{
			var testsToRun:Array = new Array();
			testsToRun.push(com.adobe.crypto.SHA256Test);
			testsToRun.push(com.adobe.utils.StringUtilTest);
			testsToRun.push(somasim.pools.ObjectPoolTest);
			testsToRun.push(com.adobe.crypto.HMACSHA1Test);
			testsToRun.push(com.adobe.utils.ArrayUtilTest);
			testsToRun.push(com.adobe.utils.IntUtilTest);
			testsToRun.push(somasim.math.random.TinyMTTest);
			testsToRun.push(com.adobe.crypto.MD5Test);
			testsToRun.push(somasim.math.random.MersenneTwisterTest);
			testsToRun.push(com.adobe.net.URITest);
			testsToRun.push(com.adobe.images.PNGEncoderTest);
			testsToRun.push(com.adobe.crypto.HMACMD5Test);
			testsToRun.push(somasim.utils.DictionaryUtilTest);
			testsToRun.push(somasim.math.CRC32Test);
			testsToRun.push(com.adobe.crypto.SHA224Test);
			testsToRun.push(com.adobe.crypto.SHA1Test);
			testsToRun.push(com.adobe.images.JPGEncoderTest);
			return testsToRun;
		}
	}
}