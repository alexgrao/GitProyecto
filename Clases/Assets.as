package 
{
	import flash.display.Bitmap;
	import starling.text.BitmapFont;
	import starling.text.TextField;
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

			[Embed(source = "../media/graphics/HUD_2Player.png")]
			public static const HUD2Player:Class;
			
			[Embed(source = "../media/graphics/Fondo_SOL.png")]
			public static const FondoSol:Class;
			
			[Embed(source="../media/graphics/fondo_LLUVIA.png")]
			public static const FondoLluvia:Class;
			
			[Embed(source = "../media/graphics/FlechaJugadorRoja.png")]
			public static const FlechaJugadorRoja:Class;
			
			//fuentes
			
			[Embed(source = "../media/fonts/font.png")]
			public static const FontTexture:Class;
			
			[Embed(source="../media/fonts/font.fnt", mimeType="application/octet-stream")]
			public static const FontXml:Class;
			
			[Embed(source = "../media/fonts/embedded/Mucho_Power.ttf", fontFamily = "MyFontName", embedAsCFF = "false")]
			public static const MyFont:Class;
			
			[Embed(source = "../media/graphics/incicador.png")]
			public static const IndPosicion:Class;
			
			private static var gameTextures:Dictionary = new Dictionary();
			
			public static var myFont:BitmapFont;
			
			
			//EXPLOSION Animacion
			
			private static var AnimTextureAtlas:TextureAtlas;
			
			[Embed(source="../media/graphics/Animaciones.png")]
			public static const AtlasTextureAnim:Class;
			
			[Embed(source="../media/graphics/Animaciones.xml", mimeType = "Application/octet-stream")]
			public static const AtlasXMLAnim:Class;
			
			public static function getAtlas():TextureAtlas 
			{
				if (AnimTextureAtlas == null) {
					var texture:Texture = getTexture("AtlasTextureAnim");
					var xml:XML = XML(new AtlasXMLAnim());
					AnimTextureAtlas = new TextureAtlas(texture, xml);
				}
				return AnimTextureAtlas;
			}
			
			public static function getFont():BitmapFont
			{
				
				var fontTexture:Texture = Texture.fromBitmap(new FontTexture());
				var fontXml:XML = XML(new FontXml());
				
				var font:BitmapFont = new BitmapFont(fontTexture, fontXml);
				TextField.registerBitmapFont(font);
				
				return font;
			
			}
			
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