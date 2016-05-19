package 
{
	import flash.net.NetGroupReplicationStrategy;
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
		
		static public const BLANCO:String = "blanco";
		static public const NEGRO:String = "negro";
		
		
		
		public function AnimacionPersonaje(s:String) 
		{
			super();
			
			if(s == BLANCO){
				ParadoArt = new MovieClip(Assets.getAtlasAnim().getTextures("Modelo1PersonajeAnimacion"), 20);
			}if (s == NEGRO) {
				ParadoArt = new MovieClip(Assets.getAtlasAnim().getTextures("Modelo2PersonajeAnimacion"), 22);
			}
			Starling.juggler.add(ParadoArt);
			
			
			addChild(ParadoArt);
		}
		
	}

}