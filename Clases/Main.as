package 
{
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import net.hires.debug.Stats;
	import screens.PantallaInicio;
	import starling.core.Starling;
	import flash.system.Capabilities;
	import starling.display.Stage;
	
	[SWF(frameRate = "60",width = "1200",height="720",backgroundColor = "0xffffff")]
	
	public class Main extends Sprite 
	{
		private var stats:Stats;
		private var myStarling:Starling;
		
		public function Main() 
	{
			stats = new Stats();
			this.addChild(stats);
			myStarling = new Starling(PantallaInicio, stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
		}
		
	}
	
}