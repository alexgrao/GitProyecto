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
	public class AnimacionExplosion extends Sprite 
	{
		public var ExploArt:MovieClip;
		
		public function AnimacionExplosion() 
		{
			super();
			ExploArt = new MovieClip(Assets.getAtlasAnim().getTextures("Explosion_"), 18);
			
			ExploArt.loop = false;
			ExploArt.stop();
			
			ExploArt.scaleX = 4;
			ExploArt.scaleY = 4;
			
			Starling.juggler.add(ExploArt);
			
			addChild(ExploArt);
			
			this.addEventListener(Event.ENTER_FRAME, compruebaAnimacion)
		}
		
		private function compruebaAnimacion(e:Event):void 
		{
			if (ExploArt.isComplete) {
				ExploArt.stop();
				ExploArt.texture.dispose();
				removeChild(ExploArt, true);
			}
		}
		
	}

}