package
{
	import Array;
	
	import flash.display.Sprite;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	import somasim.math.random.MersenneTwisterTests;
	import somasim.math.random.TinyMTTests;
	import somasim.pools.ObjectPoolTests;
	
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
			testsToRun.push(somasim.math.random.MersenneTwisterTests);
			testsToRun.push(somasim.math.random.TinyMTTests);
			testsToRun.push(somasim.pools.ObjectPoolTests);
			return testsToRun;
		}
	}
}