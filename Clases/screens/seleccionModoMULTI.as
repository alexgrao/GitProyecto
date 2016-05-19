package screens 
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Jesús Bachiller Cabal
	 */
	public class seleccionModoMULTI extends Sprite 
	{
		//constantes
		static public const NORMAL:String = "normal";
		static public const BATALLA:String = "batalla";
				
		//imegenes
		private var _imagenFondo:Image;
		private var _multiHUD_MULTI:Image;
		private var _multiHUD_PRINCIPAL:Image;
		private var _multiHUD_BAT:Image;
		private var _multiHUD_NORMAL:Image;
		private var _imgTITULO_MULTI:Image;
		private var _imgBattleOfKukulkan:Image;
		private var _imgTextINDIV:Image;
		private var _imgLoCa:Image;
		private var _textAtrasBATALLA:Image;
		private var _textGOBatalla:Image;
		private var _textAtrasNORMAL:Image;
		private var _textGONormal:Image;
		private var _textIZQUIERDANormal:TextField;
		private var _textDERECHANormal:TextField;
		private var _textIZQUIERDABatalla:TextField;
		private var _textDERECHABatalla:TextField;
		
		
		//BOTONES
		private var _textoNormal:Button;
		private var _textoBatalla:Button;
		private var _atras:Button;
		
		//Pantallas
		private var _pantallaInicio:PantallaInicio;
		private var _pantallaSeleccionNormal:seleccionPersonajeNormalMULTI;
		private var pantallaSeleccionBatalla:seleccionPersonajeBatallaMULTI;
		
		public function seleccionModoMULTI() 
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			dibujarPantalla();
			
			activaListeners();
		}
		
		private function dibujarPantalla():void 
		{
			_imagenFondo = new Image(Assets.getTexture("FondoPrincipal"));
			_imagenFondo.x = -150;
			_imagenFondo.y = -162.5;
			addChild(_imagenFondo);
			
			_multiHUD_MULTI = new Image(Assets.getTexture("MultiHUD_MULTI"));
			addChild(_multiHUD_MULTI);
			
			_multiHUD_NORMAL = new Image(Assets.getTexture("MultiHUD_NORMAL_MULTI"));
			_multiHUD_NORMAL.y = 650;
			addChild(_multiHUD_NORMAL);
			
			_multiHUD_BAT = new Image(Assets.getTexture("MultiHUD_BATALLA_MULTI"));
			_multiHUD_BAT.x = -1200;
			addChild(_multiHUD_BAT);
			
			_multiHUD_PRINCIPAL = new Image(Assets.getTexture("MultiHUD_principal"));
			_multiHUD_PRINCIPAL.x = 1200;
			addChild(_multiHUD_PRINCIPAL);
			
			_imgBattleOfKukulkan = new Image(Assets.getTexture("LOGO"));
			_imgBattleOfKukulkan.x = 1240;
			_imgBattleOfKukulkan.y = 30;
			_imgBattleOfKukulkan.scaleX = 0.7;
			_imgBattleOfKukulkan.scaleY = 0.7;
			addChild(_imgBattleOfKukulkan);
			
			_imgTextINDIV = new Image(Assets.getAtlasTextoHUD().getTexture("textoINDIV"));
			_imgTextINDIV.x = 2010;
			_imgTextINDIV.y = 420;
			addChild(_imgTextINDIV);
			
			_imgLoCa = new Image(Assets.getTexture("LoCa"));
			_imgLoCa.scaleX = 0.3;
			_imgLoCa.scaleY = 0.3;
			_imgLoCa.x = 2120;
			_imgLoCa.y = 255;
			addChild(_imgLoCa);
			
			_imgTITULO_MULTI = new Image(Assets.getAtlasTextoHUD().getTexture("textoMULTI_select"));
			_imgTITULO_MULTI.scaleX = 1.5;
			_imgTITULO_MULTI.scaleY = 1.5;
			_imgTITULO_MULTI.x = stage.stageWidth / 2 - _imgTITULO_MULTI.width / 2;
			_imgTITULO_MULTI.y = 10;
			addChild(_imgTITULO_MULTI);
			
			_textAtrasBATALLA = new Image(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_textAtrasBATALLA.x = -200;
			_textAtrasBATALLA.y = 556;
			addChild(_textAtrasBATALLA);
			
			_textAtrasNORMAL = new Image(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_textAtrasNORMAL.scaleX = 0.9;
			_textAtrasNORMAL.scaleX = 0.9;
			_textAtrasNORMAL.x = 1000;
			_textAtrasNORMAL.y = 1206;
			addChild(_textAtrasNORMAL);
			
			_textGONormal = new Image(Assets.getAtlasTextoHUD().getTexture("GO!"));
			_textGONormal.x = 640;
			_textGONormal.y = 1215;
			_textGONormal.scaleX = 0.6;
			_textGONormal.scaleY = 0.6;
			_textGONormal.alpha = 0.5;
			addChild(_textGONormal);
			
			_textGOBatalla = new Image(Assets.getAtlasTextoHUD().getTexture("GO!"));
			_textGOBatalla.x = -560;
			_textGOBatalla.y = 565;
			_textGOBatalla.scaleX = 0.6;
			_textGOBatalla.scaleY = 0.6;
			_textGOBatalla.alpha = 0.5;
			addChild(_textGOBatalla);
			
			_textIZQUIERDABatalla = new TextField(0, 0, "Izquierda: ", Assets.getFont().name, 30, 0xffffff, true);
			_textIZQUIERDABatalla.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textIZQUIERDABatalla.x = -1170;
			_textIZQUIERDABatalla.y = 340;
			addChild(_textIZQUIERDABatalla);
			
			_textDERECHABatalla = new TextField(0, 0, "Derecha: ", Assets.getFont().name, 30, 0xffffff, true);
			_textDERECHABatalla.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textDERECHABatalla.x = -1160;
			_textDERECHABatalla.y = 515;
			addChild(_textDERECHABatalla);
			
			
			_textIZQUIERDANormal = new TextField(0, 0, "Izquierda: ", Assets.getFont().name, 30, 0xffffff, true);
			_textIZQUIERDANormal.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textIZQUIERDANormal.x = 30;
			_textIZQUIERDANormal.y = 990;
			addChild(_textIZQUIERDANormal);
			
			_textDERECHANormal = new TextField(0, 0, "Derecha: ", Assets.getFont().name, 30, 0xffffff, true);
			_textDERECHANormal.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textDERECHANormal.x = 40;
			_textDERECHANormal.y = 1160;
			addChild(_textDERECHANormal);
			
			
			_atras = new Button(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_atras.overState = Assets.getAtlasTextoHUD().getTexture("textoATRAS_select");
			_atras.downState = Assets.getAtlasTextoHUD().getTexture("textoATRAS_select");
			_atras.scaleX = 0.9;
			_atras.scaleY = 0.9;
			_atras.x = 1000;
			_atras.y = 556;
			addChild(_atras);
			
			_textoNormal = new Button(Assets.getAtlasTextoHUD().getTexture("textoNORMAL"));
			_textoNormal.overState = Assets.getAtlasTextoHUD().getTexture("textoNORMAL_select");
			_textoNormal.downState = Assets.getAtlasTextoHUD().getTexture("textoNORMAL_select");
			_textoNormal.scaleX = 0.9;
			_textoNormal.scaleY = 0.9;
			_textoNormal.x = 65;
			_textoNormal.y = 410;
			addChild(_textoNormal);
			
			_textoBatalla = new Button(Assets.getAtlasTextoHUD().getTexture("textoBATALLA"));
			_textoBatalla.overState = Assets.getAtlasTextoHUD().getTexture("textoBATALLA_select");
			_textoBatalla.downState = Assets.getAtlasTextoHUD().getTexture("textoBATALLA_select");
			_textoBatalla.scaleX = 0.9;
			_textoBatalla.scaleY = 0.9;
			_textoBatalla.x = 45;
			_textoBatalla.y = 532;
			addChild(_textoBatalla);
		}
		
		private function activaListeners():void
		{
			_textoBatalla.enabled = true;
			_textoNormal.enabled = true;
			
			_textoBatalla.addEventListener(TouchEvent.TOUCH, batalla);
			_textoNormal.addEventListener(TouchEvent.TOUCH, normal);
			_atras.addEventListener(TouchEvent.TOUCH, atras);
		}
		
		private function atras(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				removeEventListener(TouchEvent.TOUCH, atras);
				removeEventListener(TouchEvent.TOUCH, normal);
				removeEventListener(TouchEvent.TOUCH, batalla);
				
				animacionAtras();
			}
		}
		
		private function animacionAtras():void 
		{
			_textoNormal.enabled = false;
			_textoBatalla.enabled = false;
			_atras.enabled = false;
			
			var animFONDO:Tween = new Tween(_imagenFondo, 1.7);
			var animTheBattleOfKukulkan:Tween = new Tween(_imgBattleOfKukulkan, 1.7);
			var animTitulo_MULTI:Tween = new Tween(_imgTITULO_MULTI, 1.7);
			var animHUD_PRINCIPAL:Tween = new Tween(_multiHUD_PRINCIPAL, 1.7);
			var animHUD_M:Tween = new Tween(_multiHUD_MULTI, 1.7);
			var animNORMAL:Tween = new Tween(_textoNormal, 1.7);
			var animBATALLA:Tween = new Tween(_textoBatalla, 1.7);
			var animATRAS:Tween = new Tween(_atras, 1.7);
			var animTextIndiv:Tween = new Tween(_imgTextINDIV, 1.7);
			var animLoCa:Tween = new Tween(_imgLoCa, 1.7);
			
			animFONDO.animate("x", _imagenFondo.x - 150);
			animTheBattleOfKukulkan.animate("x", _imgBattleOfKukulkan.x - 1200);
			animTitulo_MULTI.animate("x", 776);
			animTitulo_MULTI.animate("y", 545);
			animTitulo_MULTI.scaleTo(1);
			animHUD_PRINCIPAL.animate("x", _multiHUD_PRINCIPAL.x - 1200);
			animHUD_M.animate("x", _multiHUD_MULTI.x - 1200);
			animNORMAL.animate("x", _textoNormal.x - 1200);
			animBATALLA.animate("x", _textoBatalla.x - 1200);
			animATRAS.animate("x", _atras.x - 1200);
			animTextIndiv.animate("x", _imgTextINDIV.x - 1200);
			animLoCa.animate("x", _imgLoCa.x - 1200);
			
			Starling.juggler.add(animFONDO);
			Starling.juggler.add(animHUD_PRINCIPAL);
			Starling.juggler.add(animHUD_M);
			Starling.juggler.add(animNORMAL);
			Starling.juggler.add(animBATALLA);
			Starling.juggler.add(animTheBattleOfKukulkan);
			Starling.juggler.add(animTitulo_MULTI);
			Starling.juggler.add(animATRAS);
			Starling.juggler.add(animTextIndiv);
			Starling.juggler.add(animLoCa);
			
			animFONDO.onComplete = cambioPantallaAtras;
		}
		
		private function cambioPantallaAtras():void 
		{
			removeChildren();
				
			_textoBatalla = null;
			_textoNormal = null;
			_atras = null;
			
			_pantallaInicio = new PantallaInicio(true);
			addChild(_pantallaInicio);
		}
		
		private function normal(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				removeEventListener(TouchEvent.TOUCH, atras);
				removeEventListener(TouchEvent.TOUCH, normal);
				removeEventListener(TouchEvent.TOUCH, batalla);
				
				animacionFinal(_textoNormal, NORMAL);
			}
		}
		
		private function batalla(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				removeEventListener(TouchEvent.TOUCH, atras);
				removeEventListener(TouchEvent.TOUCH, normal);
				removeEventListener(TouchEvent.TOUCH, batalla);
				
				animacionFinal(_textoBatalla, BATALLA);
			}
		}
		
		private function animacionFinal(b:Button, s:String):void 
		{
			_textoNormal.enabled = false;
			_textoBatalla.enabled = false;
			_atras.enabled = false;
			
			var img:Image = new Image(b.overState);
			img.x = b.x;
			img.y = b.y;
			addChild(img);
			removeChild(b);
			
			var anim:Tween = new Tween(img, 1.7);
			anim.animate("x", stage.stageWidth / 2 - img.width*1.2/2);
			anim.animate("y", 10);
			anim.scaleTo(1.2);
			Starling.juggler.add(anim);
			
			if(s == BATALLA){
				anim.onComplete = cambioPantallaBatallaMULTI;
			}else {
				if (s == NORMAL) {
					anim.onComplete = cambioPantallaNormalMULTI;
				}
			}
			
			if (s == NORMAL) {
				var animFONDO:Tween = new Tween(_imagenFondo, 1.7);
				var animTITULO:Tween = new Tween(_imgTITULO_MULTI, 1.7);
				var animHUD_N:Tween = new Tween(_multiHUD_NORMAL, 1.7);
				var animHUD_M:Tween = new Tween(_multiHUD_MULTI, 1.7);
				var animNORMAL:Tween = new Tween(_textoNormal, 1.7);
				var animBATALLA:Tween = new Tween(_textoBatalla, 1.7);
				var animAtrasMODE:Tween = new Tween(_atras, 1.7);
				var animAtrasNORMAL:Tween = new Tween(_textAtrasNORMAL, 1.7);
				var animGONormal:Tween = new Tween(_textGONormal, 1.7);
				var animIZQUIERDANormal:Tween = new Tween(_textIZQUIERDANormal, 1.7);
				var animDERECHANormal:Tween = new Tween(_textDERECHANormal, 1.7);
				
				animFONDO.animate("y", _imagenFondo.y - 162.5);
				animTITULO.animate("y", _imgTITULO_MULTI.y - 650);
				animHUD_N.animate("y", _multiHUD_NORMAL.y - 650);
				animHUD_M.animate("y", _multiHUD_MULTI.y - 650);
				animNORMAL.animate("y", _textoNormal.y - 650);
				animBATALLA.animate("y", _textoBatalla.y - 650);
				animAtrasMODE.animate("y", _atras.y - 650);
				animAtrasNORMAL.animate("y", _textAtrasNORMAL.y - 650);
				animGONormal.animate("y", _textGONormal.y - 650);
				animIZQUIERDANormal.animate("y", _textIZQUIERDANormal.y - 650);
				animDERECHANormal.animate("y", _textDERECHANormal.y - 650);
				
				Starling.juggler.add(animFONDO);
				Starling.juggler.add(animHUD_N);
				Starling.juggler.add(animHUD_M);
				Starling.juggler.add(animNORMAL);
				Starling.juggler.add(animBATALLA);
				Starling.juggler.add(animTITULO);
				Starling.juggler.add(animAtrasMODE);
				Starling.juggler.add(animAtrasNORMAL);
				Starling.juggler.add(animGONormal);
				Starling.juggler.add(animIZQUIERDANormal);
				Starling.juggler.add(animDERECHANormal);
				
			}else {
				if (s == BATALLA) {
					var animFONDO:Tween = new Tween(_imagenFondo, 1.7);
					var animTITULO:Tween = new Tween(_imgTITULO_MULTI, 1.7);
					var animHUD_B:Tween = new Tween(_multiHUD_BAT, 1.7);
					var animHUD_M:Tween = new Tween(_multiHUD_MULTI, 1.7);
					var animNORMAL:Tween = new Tween(_textoNormal, 1.7);
					var animGOBatalla:Tween = new Tween(_textGOBatalla, 1.7);
					var animAtrasMODE:Tween = new Tween(_atras, 1.7);
					var animAtrasBATALLA:Tween = new Tween(_textAtrasBATALLA, 1.7);
					var animIZQUIERDABatalla:Tween = new Tween(_textIZQUIERDABatalla, 1.7);
					var animDERECHABatalla:Tween = new Tween(_textDERECHABatalla, 1.7);
					
					animFONDO.animate("x", _imagenFondo.x + 150);
					animTITULO.animate("x", _imgTITULO_MULTI.x + 1200);
					animHUD_B.animate("x", _multiHUD_BAT.x + 1200);
					animHUD_M.animate("x", _multiHUD_MULTI.x + 1200);
					animNORMAL.animate("x", _textoNormal.x + 1200);
					animGOBatalla.animate("x", _textGOBatalla.x + 1200);
					animAtrasMODE.animate("x", _atras.x + 1200);
					animAtrasBATALLA.animate("x", _textAtrasBATALLA.x + 1200);
					animIZQUIERDABatalla.animate("x", _textIZQUIERDABatalla.x + 1200);
					animDERECHABatalla.animate("x", _textDERECHABatalla.x + 1200);
					
					Starling.juggler.add(animFONDO);
					Starling.juggler.add(animHUD_B);
					Starling.juggler.add(animHUD_M);
					Starling.juggler.add(animNORMAL);
					//Starling.juggler.add(animBATALLA);
					Starling.juggler.add(animGOBatalla);
					Starling.juggler.add(animTITULO);
					Starling.juggler.add(animAtrasMODE);
					Starling.juggler.add(animAtrasBATALLA);
					Starling.juggler.add(animIZQUIERDABatalla);
					Starling.juggler.add(animDERECHABatalla);
				}
			}
			
		}
		
		private function cambioPantallaBatallaMULTI():void 
		{
			removeChildren();
			
			_textoBatalla = null;
			_textoNormal = null;
			
			pantallaSeleccionBatalla = new seleccionPersonajeBatallaMULTI();
			addChild(pantallaSeleccionBatalla);
		}
		
		private function cambioPantallaNormalMULTI():void 
		{
			removeChildren();
			
			_textoBatalla = null;
			_textoNormal = null;
			
			_pantallaSeleccionNormal = new seleccionPersonajeNormalMULTI();
			addChild(_pantallaSeleccionNormal);
		}
	}

}