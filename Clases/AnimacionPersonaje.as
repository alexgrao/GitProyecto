package 
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author j
	 */
	public class AnimacionPersonaje extends Sprite 
	{
		
		public var ParadoArt:MovieClip;
		
		public function AnimacionPersonaje() 
		{
			super();
			ParadoArt = new MovieClip(Assets.getAtlas().getTextures("Modelo1PersonajeAnimacion_"), 20);

			Starling.juggler.add(ParadoArt);
			
			
			addChild(ParadoArt);
		}
		
	}

}