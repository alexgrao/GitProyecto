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
	 * @author j
	 */
	public class seleccionModoIND extends Sprite
	{
		//constantes
		static public const NORMAL:String = "normal";
		static public const BATALLA:String = "batalla";
				
		//imegenes
		private var _imagenFondo:Image;
		private var _multiHUD_IND:Image;
		private var _multiHUD_PRINCIPAL:Image;
		private var _multiHUD_BAT:Image;
		private var _multiHUD_NORMAL:Image;
		private var _imgTITULO_IND:Image;
		private var _imgBattleOfKukulkan:Image;
		private var _imgTextMulti:Image;
		private var _imgLoCa:Image;
		private var _textAtrasBATALLA:Image;
		private var _textAtrasNORMAL:Image;
		
		//BOTONES
		private var _textoNormal:Button;
		private var _textoBatalla:Button;
		private var _atras:Button;
		
		//Pantallas
		private var _seleccionBatalla:seleccionPersonajeBatallaIND;
		private var _seleccionNormal:seleccionPersonajeNormalIND;
		private var _pantallaInicio:PantallaInicio;
		
		public function seleccionModoIND()
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
			var animTitulo_IND:Tween = new Tween(_imgTITULO_IND, 1.7);
			var animHUD_PRINCIPAL:Tween = new Tween(_multiHUD_PRINCIPAL, 1.7);
			var animHUD_I:Tween = new Tween(_multiHUD_IND, 1.7);
			var animNORMAL:Tween = new Tween(_textoNormal, 1.7);
			var animBATALLA:Tween = new Tween(_textoBatalla, 1.7);
			var animATRAS:Tween = new Tween(_atras, 1.7);
			var animTextMulti:Tween = new Tween(_imgTextMulti, 1.7);
			var animLoCa:Tween = new Tween(_imgLoCa, 1.7);
			
			animFONDO.animate("x", _imagenFondo.x + 150);
			animTheBattleOfKukulkan.animate("x", _imgBattleOfKukulkan.x + 1200);
			animTitulo_IND.animate("x", 810);
			animTitulo_IND.animate("y", 420);
			animTitulo_IND.scaleTo(1);
			animHUD_PRINCIPAL.animate("x", _multiHUD_PRINCIPAL.x + 1200);
			animHUD_I.animate("x", _multiHUD_IND.x + 1200);
			animNORMAL.animate("x", _textoNormal.x + 1200);
			animBATALLA.animate("x", _textoBatalla.x + 1200);
			animATRAS.animate("x", _atras.x + 1200);
			animTextMulti.animate("x", _imgTextMulti.x + 1200);
			animLoCa.animate("x", _imgLoCa.x + 1200);
			
			Starling.juggler.add(animFONDO);
			Starling.juggler.add(animHUD_PRINCIPAL);
			Starling.juggler.add(animHUD_I);
			Starling.juggler.add(animNORMAL);
			Starling.juggler.add(animBATALLA);
			Starling.juggler.add(animTheBattleOfKukulkan);
			Starling.juggler.add(animTitulo_IND);
			Starling.juggler.add(animATRAS);
			Starling.juggler.add(animTextMulti);
			Starling.juggler.add(animLoCa);
			
			animATRAS.onComplete = cambioPantallaAtras;
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
				anim.onComplete = cambioPantallaBatallaIND;
			}else {
				if (s == NORMAL) {
					anim.onComplete = cambioPantallaNormalIND;
				}
			}
			
			if (s == BATALLA) {
				var animFONDO:Tween = new Tween(_imagenFondo, 1.7);
				var animTITULO:Tween = new Tween(_imgTITULO_IND, 1.7);
				var animHUD_B:Tween = new Tween(_multiHUD_BAT, 1.7);
				var animHUD_I:Tween = new Tween(_multiHUD_IND, 1.7);
				var animNORMAL:Tween = new Tween(_textoNormal, 1.7);
				var animBATALLA:Tween = new Tween(_textoBatalla, 1.7);
				var animAtrasMODE:Tween = new Tween(_atras, 1.7);
				var animAtrasBATALLA:Tween = new Tween(_textAtrasBATALLA, 1.7);
				
				animFONDO.animate("y", _imagenFondo.y - 162.5);
				animTITULO.animate("y", _imgTITULO_IND.y - 650);
				animHUD_B.animate("y", _multiHUD_BAT.y - 650);
				animHUD_I.animate("y", _multiHUD_IND.y - 650);
				animNORMAL.animate("y", _textoNormal.y - 650);
				animBATALLA.animate("y", _textoBatalla.y - 650);
				animAtrasMODE.animate("y", _atras.y - 650);
				animAtrasBATALLA.animate("y", _textAtrasBATALLA.y - 650);
				
				Starling.juggler.add(animFONDO);
				Starling.juggler.add(animHUD_B);
				Starling.juggler.add(animHUD_I);
				Starling.juggler.add(animNORMAL);
				Starling.juggler.add(animBATALLA);
				Starling.juggler.add(animTITULO);
				Starling.juggler.add(animAtrasMODE);
				Starling.juggler.add(animAtrasBATALLA);
				
			}else {
				if (s == NORMAL) {
					var animFONDO:Tween = new Tween(_imagenFondo, 1.7);
					var animTITULO:Tween = new Tween(_imgTITULO_IND, 1.7);
					var animHUD_N:Tween = new Tween(_multiHUD_NORMAL, 1.7);
					var animHUD_I:Tween = new Tween(_multiHUD_IND, 1.7);
					var animNORMAL:Tween = new Tween(_textoNormal, 1.7);
					var animBATALLA:Tween = new Tween(_textoBatalla, 1.7);
					var animAtrasMODE:Tween = new Tween(_atras, 1.7);
					var animAtrasNORMAL:Tween = new Tween(_textAtrasNORMAL, 1.7);
					
					animFONDO.animate("x", _imagenFondo.x - 150);
					animTITULO.animate("x", _imgTITULO_IND.x - 1200);
					animHUD_N.animate("x", _multiHUD_NORMAL.x - 1200);
					animHUD_I.animate("x", _multiHUD_IND.x - 1200);
					animNORMAL.animate("x", _textoNormal.x - 1200);
					animBATALLA.animate("x", _textoBatalla.x - 1200);
					animAtrasMODE.animate("x", _atras.x - 1200);
					animAtrasNORMAL.animate("x", _textAtrasNORMAL.x - 1200);
					
					Starling.juggler.add(animFONDO);
					Starling.juggler.add(animHUD_N);
					Starling.juggler.add(animHUD_I);
					Starling.juggler.add(animNORMAL);
					Starling.juggler.add(animBATALLA);
					Starling.juggler.add(animTITULO);
					Starling.juggler.add(animAtrasMODE);
					Starling.juggler.add(animAtrasNORMAL);
				}
			}
			
		}
		
		private function cambioPantallaBatallaIND():void 
		{
			removeChildren();
			
			_textoBatalla = null;
			_textoNormal = null;
			
			_seleccionBatalla = new seleccionPersonajeBatallaIND();
			addChild(_seleccionBatalla);
		}
		
		private function cambioPantallaNormalIND():void 
		{
			removeChildren();
			
			_textoBatalla = null;
			_textoNormal = null;
			
			_seleccionNormal = new seleccionPersonajeNormalIND();
			addChild(_seleccionNormal);
		}
		
		private function dibujarPantalla():void
		{
			_imagenFondo = new Image(Assets.getTexture("FondoPrincipal"));
			_imagenFondo.x = -450;
			_imagenFondo.y = -162.5;
			addChild(_imagenFondo);
			
			_multiHUD_IND = new Image(Assets.getTexture("MultiHUD_IND"));
			addChild(_multiHUD_IND);
			
			_multiHUD_NORMAL = new Image(Assets.getTexture("MultiHUD_NORMAL_IND"));
			_multiHUD_NORMAL.x = 1200;
			addChild(_multiHUD_NORMAL);
			
			_multiHUD_BAT = new Image(Assets.getTexture("MultiHUD_BATALLA_IND"));
			_multiHUD_BAT.y = 650;
			addChild(_multiHUD_BAT);
			
			_multiHUD_PRINCIPAL = new Image(Assets.getTexture("MultiHUD_principal"));
			_multiHUD_PRINCIPAL.x = -1200;
			addChild(_multiHUD_PRINCIPAL);
			
			_imgBattleOfKukulkan = new Image(Assets.getTexture("LOGO"));
			_imgBattleOfKukulkan.x = -1160;
			_imgBattleOfKukulkan.y = 30;
			_imgBattleOfKukulkan.scaleX = 0.7;
			_imgBattleOfKukulkan.scaleY = 0.7;
			addChild(_imgBattleOfKukulkan);
			
			_imgTextMulti = new Image(Assets.getAtlasTextoHUD().getTexture("textoMULTI"));
			_imgTextMulti.x = -424;
			_imgTextMulti.y = 545;
			addChild(_imgTextMulti);
			
			_imgLoCa = new Image(Assets.getTexture("LoCa"));
			_imgLoCa.scaleX = 0.3;
			_imgLoCa.scaleY = 0.3;
			_imgLoCa.x = -280;
			_imgLoCa.y = 255;
			addChild(_imgLoCa);
			
			_imgTITULO_IND = new Image(Assets.getAtlasTextoHUD().getTexture("textoINDIV_select"));
			_imgTITULO_IND.scaleX = 1.5;
			_imgTITULO_IND.scaleY = 1.5;
			_imgTITULO_IND.x = stage.stageWidth / 2 - _imgTITULO_IND.width / 2;
			_imgTITULO_IND.y = 10;
			addChild(_imgTITULO_IND);
			
			_textAtrasBATALLA = new Image(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_textAtrasBATALLA.x = 995;
			_textAtrasBATALLA.y = 1201;
			addChild(_textAtrasBATALLA);
			
			_textAtrasNORMAL = new Image(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_textAtrasNORMAL.scaleX = 0.9;
			_textAtrasNORMAL.scaleX = 0.9;
			_textAtrasNORMAL.x = 2200;
			_textAtrasNORMAL.y = 556;
			addChild(_textAtrasNORMAL);
			
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
			_textoNormal.x = 70;
			_textoNormal.y = 418;
			addChild(_textoNormal);
			
			_textoBatalla = new Button(Assets.getAtlasTextoHUD().getTexture("textoBATALLA"));
			_textoBatalla.overState = Assets.getAtlasTextoHUD().getTexture("textoBATALLA_select");
			_textoBatalla.downState = Assets.getAtlasTextoHUD().getTexture("textoBATALLA_select");
			_textoBatalla.scaleX = 0.9;
			_textoBatalla.scaleY = 0.9;
			_textoBatalla.x = 55;
			_textoBatalla.y = 540;
			addChild(_textoBatalla);
		}
	
	}

}