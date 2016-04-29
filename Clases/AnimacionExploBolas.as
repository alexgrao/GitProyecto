package 
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Jesús Bachiller Cabal
	 */
	public class AnimacionExploBolas extends Sprite 
	{
		public var ExploArt:MovieClip;
		
		public function AnimacionExploBolas() 
		{
			super();
			ExploArt = new MovieClip(Assets.getAtlasAnim().getTextures("animacionExplosionBolas"), 25);
			
			ExploArt.loop = false;
			ExploArt.stop();
			
			ExploArt.scaleX = 2;
			ExploArt.scaleY = 2;
			
			Starling.juggler.add(ExploArt);
			
			addChild(ExploArt);
			
			this.addEventListener(Event.ENTER_FRAME, compruebaAnimacion)
		}
		
		private function compruebaAnimacion(e:Event):void 
		{
			if (ExploArt.isComplete) {
				ExploArt.stop();
				ExploArt.texture.dispose();
				removeChild(ExploArt,true);
			}
		
		}
	}

}