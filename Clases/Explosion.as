package 
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import screens.Juego;
	
	/**
	 * ...
	 * @author j
	 */
	public class Explosion extends Sprite 
	{
		public var ExploArt:MovieClip;
		
		public function Explosion() 
		{
			super();
			ExploArt = new MovieClip(Assets.getAtlas().getTextures("Explosion_"), 18);
			
			ExploArt.loop = false;
			ExploArt.stop();
			
			ExploArt.scaleX = 4;
			ExploArt.scaleY = 4;
			
			Starling.juggler.add(ExploArt);
			
			addChild(ExploArt);
			
			//this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
	}

}