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
			//Indicador
			[Embed(source = "../media/graphics/incicador.png")]
			public static const IndPosicion:Class;
			
			//Bolas
			private static var BolasIndicTextureAtlas:TextureAtlas;
			
			[Embed(source = "../media/graphics/bolas.png")]
			public static const AtlasTextureBolasIndic:Class;
			
			[Embed(source="../media/graphics/bolas.xml", mimeType="application/octet-stream")]
			public static const AtlasXMLBolasIndic:Class;
			
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
			
			
			
			private static var gameTextures:Dictionary = new Dictionary();
			
			public static var myFont:BitmapFont;
			
			
			//EXPLOSION Animacion
			
			private static var AnimTextureAtlas:TextureAtlas;
			
			[Embed(source="../media/graphics/Animaciones.png")]
			public static const AtlasTextureAnim:Class;
			
			[Embed(source="../media/graphics/Animaciones.xml", mimeType = "Application/octet-stream")]
			public static const AtlasXMLAnim:Class;
			
			
			
			
			public static function getAtlasAnim():TextureAtlas 
			{
				if (AnimTextureAtlas == null) {
					var texture:Texture = getTexture("AtlasTextureAnim");
					var xml:XML = XML(new AtlasXMLAnim());
					AnimTextureAtlas = new TextureAtlas(texture, xml);
				}
				return AnimTextureAtlas;
			}
			
			public static function getAtlasBolas():TextureAtlas 
			{
				if (BolasIndicTextureAtlas == null) {
					var texture:Texture = getTexture("AtlasTextureBolasIndic");
					var xml:XML = XML(new AtlasXMLBolasIndic());
					BolasIndicTextureAtlas = new TextureAtlas(texture, xml);
				}
				return BolasIndicTextureAtlas;
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