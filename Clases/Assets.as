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
		[Embed(source = "../media/graphics/SeleccionPersonaje.png")]
		public static const selectPersonaje:Class;
		
		//LOGO
		[Embed(source = "../media/graphics/Logo_PRINCIPAL.png")]
		public static const LOGO:Class;
		
		[Embed(source = "../media/graphics/LoCa_logo.png")]
		public static const LoCa:Class;
		
		//TextoImagenes
		
		private static var TextosHUDTextureAtlas:TextureAtlas;
		
		[Embed(source = "../media/graphics/spriteTextos.png")]
		public static const AtlasTextureTextosHUD:Class;
		
		[Embed(source = "../media/graphics/SpriteTexto.xml", mimeType = "application/octet-stream")]
		public static const AtlasXMLTextosHUD:Class;
		
		
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
		
		//HUDs
		[Embed(source = "../media/graphics/MultiHUD_principal.png")]
		public static const MultiHUD_principal:Class;
		
		[Embed(source = "../media/graphics/MultiHUD_Multi.png")]
		public static const MultiHUD_MULTI:Class;
		
		[Embed(source = "../media/graphics/MultiHUD_Ind.png")]
		public static const MultiHUD_IND:Class
		
		[Embed(source = "../media/graphics/MultiHUD_Normalmulti.png")]
		public static const MultiHUD_NORMAL_MULTI:Class;
		
		[Embed(source = "../media/graphics/MultiHUD_batallamulti.png")]
		public static const MultiHUD_BATALLA_MULTI:Class;
		
		[Embed(source = "../media/graphics/MultiHUD_Norm_Ind.png")]
		public static const MultiHUD_NORMAL_IND:Class;
		
		[Embed(source = "../media/graphics/MultiHUD_Batalla_Ind.png")]
		public static const MultiHUD_BATALLA_IND:Class;
		
		[Embed(source = "../media/graphics/HUD_1Player.png")]
		public static const HUD1Player:Class;

		[Embed(source = "../media/graphics/HUD_2Player.png")]
		public static const HUD2Player:Class;
		
		[Embed(source = "../media/graphics/hud_Principal.png")]
		public static const HUDPrincipal:Class;
		
		[Embed(source = "../media/graphics/hud_EleccionPersonajes.png")]
		public static const HUDseleccionPersonaje1PLAYER:Class;
		
		//fondos
		[Embed(source = "../media/graphics/Fondo_SOL.jpg")]
		public static const FondoSol:Class;
		
		[Embed(source="../media/graphics/fondo_LLUVIA.jpg")]
		public static const FondoLluvia:Class;
		
		[Embed(source = "../media/graphics/Fondo_PRINCIPAL.jpg")]
		public static const FondoPrincipal:Class;
		
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
		
		public static var gameTexturesArray:Array = new Array();
		
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
		
		public static function getAtlasTextoHUD():TextureAtlas
		{
			if (TextosHUDTextureAtlas == null) {
				var texture:Texture = getTexture("AtlasTextureTextosHUD");
				var xml:XML = XML(new AtlasXMLTextosHUD());
				TextosHUDTextureAtlas = new TextureAtlas(texture, xml);
			}
			return TextosHUDTextureAtlas;
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
	
		public static function createArrayTextures():void
		{
			var textura:Texture;
			textura = getAtlasBolas().getTexture("bola_Amarilla");//0
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Amarilla_puntos");//1
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Amarilla_tiempo");//2
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Azul");//3
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Azul_puntos");//4
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Azul_tiempo");//5
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Bomba");//6
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Negra");//7
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Negra_puntos");//8
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Negra_tiempo");//9
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Roja");//10
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Roja_puntos");//11
			gameTexturesArray.push(textura);
			textura = getAtlasBolas().getTexture("bola_Roja_tiempo");//12
			gameTexturesArray.push(textura);
			
		}
	}
}