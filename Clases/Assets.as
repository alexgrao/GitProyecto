package 
{
	import flash.display.Bitmap;
	import starling.textures.Texture;
	import flash.utils.Dictionary;
	import starling.textures.TextureAtlas;

	public class Assets 
	{
			//bolas Rojas
			[Embed(source = "../media/graphics/Bola_Roja.png")]
			public static const BolaRoja:Class;
			
			[Embed(source = "../media/graphics/bola_Roja_puntos.png")]
			public static const BolaRojaPts:Class;
			
			[Embed(source = "../media/graphics/bola_Roja_tiempo.png")]
			public static const BolaRojaTim:Class;
			
			//bolas Amarillas
			[Embed(source = "../media/graphics/Bola_Amarilla.png")]
			public static const BolaAmarilla:Class;
			
			[Embed(source = "../media/graphics/bola_Amarilla_puntos.png")]
			public static const BolaAmarillaPts:Class;
			
			[Embed(source = "../media/graphics/bola_Amarilla_tiempo.png")]
			public static const BolaAmarillaTim:Class;
			
			//Bolas Azules
			[Embed(source = "../media/graphics/Bola_Azul.png")]
			public static const BolaAzul:Class;
			
			[Embed(source = "../media/graphics/bola_Azul_puntos.png")]
			public static const BolaAzulPts:Class;
			
			[Embed(source = "../media/graphics/bola_Azul_tiempo.png")]
			public static const BolaAzulTim:Class;
			
			//Bolas Negras
			[Embed(source = "../media/graphics/Bola_Negra.png")]
			public static const BolaNegra:Class;
			
			[Embed(source = "../media/graphics/bola_Negra_puntos.png")]
			public static const BolaNegraPts:Class;
			
			[Embed(source = "../media/graphics/bola_Negra_tiempo.png")]
			public static const BolaNegraTim:Class;
			
			//Bomba
			[Embed(source = "../media/graphics/Bola_Bomba.png")]
			public static const BolaBomba:Class;
			
			//jugador
			[Embed(source = "../media/graphics/FlechaJugador.jpg")]
			public static const FlechaJugador:Class;
			
			//fondos
			[Embed(source = "../media/graphics/HUD_1Player.png")]
			public static const HUD1Player:Class;
			
			
			private static var gameTextures:Dictionary = new Dictionary();
			
			public static function getTexture(name:String):Texture
			{
				if (gameTextures[name] == undefined) 
				{
					var bitmap:Bitmap = new Assets[name]();
					gameTextures[name] = Texture.fromBitmap(bitmap);
				}
			
				return gameTextures[name];
		}
	}
}