package 
{
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.geom.Rectangle;
	import net.hires.debug.Stats;
	import screens.PantallaInicio;
	import starling.core.Starling;
	import flash.system.Capabilities;
	import starling.display.Stage;
	
	[SWF(frameRate = "60",width = "1200",height="650",backgroundColor = "0xffffff")]
	
	public class Main extends Sprite 
	{
		private var stats:Stats;
		private var myStarling:Starling;
		private var rectangleViewPort:Rectangle;
		
		public function Main() 
	{
			stats = new Stats();
			this.addChild(stats);
			rectangleViewPort = new Rectangle(0,0,1200,650)
			myStarling = new Starling(PantallaInicio, stage, rectangleViewPort);
			myStarling.antiAliasing = 1;
			myStarling.start();
		}
		
	}
	
}