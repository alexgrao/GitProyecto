package screens 
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
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
	
	
	public class PantallaInicio extends Sprite
	{
		static public const MULTI:String = "multi";
		static public const INDIV:String = "indiv";
		
		//IMAGEN
		private var _imagenFondo:Image;
		private var _MultiHUD_principal:Image;
		private var _MultiHUD_MULTI:Image;
		private var _MultiHUD_IND:Image;
		private var _theBattleOfKukulkan:Image;
		private var _LoCa:Image;
		private var _textIND_NORMAL:Image;
		private var _textIND_BATALLA:Image;
		private var _textIND_ATRAS:Image;
		private var _textMULTI_NORMAL:Image;
		private var _textMULTI_BATALLA:Image;
		private var _textMULTI_ATRAS:Image;
		
		
		//Botones
		private var _textoIndividual:Button;
		private var _textoMulti:Button;
		
		
		private var _chrono:Timer;
		private var _chronoInicio:Timer;
		
		private var _partidaEmpezada:Boolean;
		
		//Pantallas
		private var seleccionModoI:seleccionModoIND;
		private var juego:seleccionModoMULTI;
		
		public function PantallaInicio(empezada:Boolean = false) 
		{
			super();
			
			_partidaEmpezada = empezada;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			dibujarInicio();
			if(!_partidaEmpezada){
				animacionInicio();
			}else{
				activacionListenerTouchInd();
				activacionListenerTouchMul();
			}
			
		}
		
		private function animacionInicio():void 
		{
			var animacion:Tween = new Tween(_theBattleOfKukulkan, 1.5);
			animacion.animate("alpha", 1);
			Starling.juggler.add(animacion);
			animacion.onComplete = esperaChrono;
		}
		
		private function esperaChrono():void 
		{
			_chronoInicio = new Timer(3000);
			_chronoInicio.addEventListener(TimerEvent.TIMER, animacionLOGO);
			_chronoInicio.start();
		}
		
		private function animacionLOGO(e:TimerEvent):void 
		{
			_chronoInicio.removeEventListener(TimerEvent.TIMER, animacionLOGO);
			
			var animacion:Tween = new Tween(_theBattleOfKukulkan, 2);
			animacion.animate("x", 40);
			animacion.animate("y", 30);
			animacion.animate("scaleX" , 0.7);
			animacion.animate("scaleY" , 0.7);
			Starling.juggler.add(animacion);
			
			animacionHUD();
		}
		
		private function animacionHUD():void 
		{
			var animacion:Tween = new Tween(_MultiHUD_principal, 2);
			animacion.animate("y", 0);
			Starling.juggler.add(animacion);
			animacion.onComplete = iniciarTexto;
		}
		
		private function clickJuegoMulti(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				removeEventListener(TouchEvent.TOUCH, clickJuegoInidivual);
				removeEventListener(TouchEvent.TOUCH, clickJuegoMulti);
				
				animacionFinal(_textoMulti, MULTI);
			}
		}
		
		private function clickJuegoInidivual(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				removeEventListener(TouchEvent.TOUCH, clickJuegoInidivual);
				removeEventListener(TouchEvent.TOUCH, clickJuegoMulti);
				
				animacionFinal(_textoIndividual, INDIV);
			}
		}
		
		private function animacionFinal(b:Button, s:String):void 
		{
			_textoIndividual.enabled = false;
			_textoMulti.enabled = false;
			
			var img:Image = new Image(b.overState);
			img.x = b.x;
			img.y = b.y;
			addChild(img);
			removeChild(b);
			
			var anim:Tween = new Tween(img, 1.7);
			anim.animate("x", stage.stageWidth / 2 - img.width*1.5/2);
			anim.animate("y", 10);
			anim.scaleTo(1.5);
			Starling.juggler.add(anim);
			
			if(s == MULTI){
				anim.onComplete = cambioPantalla2Player;
			}else {
				if (s == INDIV) {
					anim.onComplete = cambioPantalla1Player;
				}
			}
			
			if (s == MULTI) {
				var animFONDO:Tween = new Tween(_imagenFondo, 1.7);
				var animTBOK:Tween = new Tween(_theBattleOfKukulkan, 1.7);
				var animHUD_P:Tween = new Tween(_MultiHUD_principal, 1.7);
				var animHUD_M:Tween = new Tween(_MultiHUD_MULTI, 1.7);
				var animIND:Tween = new Tween(_textoIndividual, 1.7);
				var animMUL:Tween = new Tween(_textoMulti, 1.7);
				var animLOCA:Tween = new Tween(_LoCa, 1.7);
				var animTextMultiNormal:Tween = new Tween(_textMULTI_NORMAL, 1.7);
				var animTextMultiBatalla:Tween = new Tween(_textMULTI_BATALLA, 1.7);
				var animTextMultiAtras:Tween = new Tween(_textMULTI_ATRAS, 1.7);
				
				animFONDO.animate("x", _imagenFondo.x + 150);
				animTBOK.animate("x", _theBattleOfKukulkan.x + 1200);
				animHUD_P.animate("x", _MultiHUD_principal.x + 1200);
				animHUD_M.animate("x", _MultiHUD_MULTI.x + 1200);
				animIND.animate("x", _textoIndividual.x + 1200);
				animMUL.animate("x", _textoMulti.x + 1200);
				animLOCA.animate("x", _LoCa.x + 1200);
				animTextMultiNormal.animate("x", _textMULTI_NORMAL.x + 1200);
				animTextMultiBatalla.animate("x", _textMULTI_BATALLA.x + 1200);
				animTextMultiAtras.animate("x", _textMULTI_ATRAS.x + 1200);
				
				Starling.juggler.add(animFONDO);
				Starling.juggler.add(animHUD_P);
				Starling.juggler.add(animHUD_M);
				Starling.juggler.add(animIND);
				Starling.juggler.add(animMUL);
				Starling.juggler.add(animTBOK);
				Starling.juggler.add(animLOCA);
				Starling.juggler.add(animTextMultiNormal);
				Starling.juggler.add(animTextMultiBatalla);
				Starling.juggler.add(animTextMultiAtras);
			}else {
				if (s == INDIV) {
					var animFONDO:Tween = new Tween(_imagenFondo, 1.7);
					var animTBOK:Tween = new Tween(_theBattleOfKukulkan, 1.7);
					var animHUD_P:Tween = new Tween(_MultiHUD_principal, 1.7);
					var animHUD_I:Tween = new Tween(_MultiHUD_IND, 1.7);
					var animIND:Tween = new Tween(_textoIndividual, 1.7);
					var animMUL:Tween = new Tween(_textoMulti,1.7);
					var animLOCA:Tween = new Tween(_LoCa, 1.7);
					var animTextIndNormal:Tween = new Tween(_textIND_NORMAL, 1.7);
					var animTextIndBatalla:Tween = new Tween(_textIND_BATALLA, 1.7);
					var animTextIndAtras:Tween = new Tween(_textIND_ATRAS, 1.7);
					
					animFONDO.animate("x", _imagenFondo.x - 150);
					animTBOK.animate("x", _theBattleOfKukulkan.x - 1200);
					animHUD_P.animate("x", _MultiHUD_principal.x - 1200);
					animHUD_I.animate("x", _MultiHUD_IND.x - 1200);
					animIND.animate("x", _textoIndividual.x - 1200);
					animMUL.animate("x", _textoMulti.x - 1200);
					animLOCA.animate("x", _LoCa.x - 1200);
					animTextIndNormal.animate("x", _textIND_NORMAL.x - 1200);
					animTextIndBatalla.animate("x", _textIND_BATALLA.x - 1200);
					animTextIndAtras.animate("x", _textIND_ATRAS.x - 1200);
					
					Starling.juggler.add(animFONDO);
					Starling.juggler.add(animHUD_P);
					Starling.juggler.add(animHUD_I);
					Starling.juggler.add(animIND);
					Starling.juggler.add(animMUL);
					Starling.juggler.add(animTBOK);
					Starling.juggler.add(animLOCA);
					Starling.juggler.add(animTextIndNormal);
					Starling.juggler.add(animTextIndBatalla);
					Starling.juggler.add(animTextIndAtras);
				}
			}
			
		}
		
		private function cambioPantalla1Player():void 
		{
			removeChildren();
			
			_textoIndividual = null;
			_textoMulti = null;
			
			seleccionModoI = new seleccionModoIND();
			addChild(seleccionModoI);
		}
		
		private function cambioPantalla2Player():void 
		{
			removeChildren();
				
			_textoIndividual = null;
			_textoMulti = null;
				
			
			juego = new seleccionModoMULTI();
			addChild(juego);
		}
		
		private function dibujarInicio():void
		{
			_imagenFondo = new Image(Assets.getTexture("FondoPrincipal"));
			_imagenFondo.x = -300;
			_imagenFondo.y = -162.5;
			addChild(_imagenFondo);
			
			_MultiHUD_MULTI = new Image(Assets.getTexture("MultiHUD_MULTI"));
			_MultiHUD_MULTI.x = -1200;
			_MultiHUD_MULTI.y = 0;
			addChild(_MultiHUD_MULTI);
			
			_MultiHUD_IND = new Image(Assets.getTexture("MultiHUD_IND"));
			_MultiHUD_IND.x = 1200;
			_MultiHUD_IND.y = 0;
			addChild(_MultiHUD_IND);
			
			_theBattleOfKukulkan = new Image(Assets.getTexture("LOGO"));
			if(!_partidaEmpezada){
				_theBattleOfKukulkan.scaleX = 0.9;
				_theBattleOfKukulkan.scaleY = 0.9;
				_theBattleOfKukulkan.x = stage.stageWidth / 2 - _theBattleOfKukulkan.width / 2;
				_theBattleOfKukulkan.y = stage.stageHeight/2 - _theBattleOfKukulkan.height/2;
				_theBattleOfKukulkan.alpha = 0;
			}else {
				_theBattleOfKukulkan.scaleX = 0.7;
				_theBattleOfKukulkan.scaleY = 0.7;
				_theBattleOfKukulkan.x = 40;
				_theBattleOfKukulkan.y = 30;
			}
			addChild(_theBattleOfKukulkan);
			
			
			_MultiHUD_principal = new Image(Assets.getTexture("MultiHUD_principal"));
			_MultiHUD_principal.x = 0;
			if(!_partidaEmpezada){
				_MultiHUD_principal.y = 650;
			}else {
				_MultiHUD_principal.y = 0;
			}
			addChild(_MultiHUD_principal);
			
			_LoCa = new Image(Assets.getTexture("LoCa"));
			_LoCa.scaleX = 0.3;
			_LoCa.scaleY = 0.3;
			_LoCa.x = 920;
			_LoCa.y = 255;
			addChild(_LoCa);
			if(!_partidaEmpezada){
				_LoCa.alpha = 0;
			}
			
			_textIND_NORMAL = new Image(Assets.getAtlasTextoHUD().getTexture("textoNORMAL"));
			_textIND_NORMAL.scaleX = 0.9;
			_textIND_NORMAL.scaleY = 0.9;
			_textIND_NORMAL.x = 1270;
			_textIND_NORMAL.y = 418;
			addChild(_textIND_NORMAL);
			
			_textIND_BATALLA = new Image(Assets.getAtlasTextoHUD().getTexture("textoBATALLA"));
			_textIND_BATALLA.scaleX = 0.9;
			_textIND_BATALLA.scaleY = 0.9;
			_textIND_BATALLA.x = 1255;
			_textIND_BATALLA.y = 540;
			addChild(_textIND_BATALLA);
			
			_textIND_ATRAS = new Image(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_textIND_ATRAS.scaleX = 0.9;
			_textIND_ATRAS.scaleY = 0.9;
			_textIND_ATRAS.x = 2200;
			_textIND_ATRAS.y = 556;
			addChild(_textIND_ATRAS);
			
			_textMULTI_NORMAL = new Image(Assets.getAtlasTextoHUD().getTexture("textoNORMAL"));
			_textMULTI_NORMAL.scaleX = 0.9;
			_textMULTI_NORMAL.scaleY = 0.9;
			_textMULTI_NORMAL.x = -1135;
			_textMULTI_NORMAL.y = 410;
			addChild(_textMULTI_NORMAL);
			
			_textMULTI_BATALLA = new Image(Assets.getAtlasTextoHUD().getTexture("textoBATALLA"));
			_textMULTI_BATALLA.scaleX = 0.9;
			_textMULTI_BATALLA.scaleY = 0.9;
			_textMULTI_BATALLA.x = -1155;
			_textMULTI_BATALLA.y = 532;
			addChild(_textMULTI_BATALLA);
			
			_textMULTI_ATRAS = new Image(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_textMULTI_ATRAS.scaleX = 0.9;
			_textMULTI_ATRAS.scaleY = 0.9;
			_textMULTI_ATRAS.x = -200;
			_textMULTI_ATRAS.y = 556;
			addChild(_textMULTI_ATRAS);
			
			_textoIndividual = new Button(Assets.getAtlasTextoHUD().getTexture("textoINDIV"));
			_textoIndividual.overState = Assets.getAtlasTextoHUD().getTexture("textoINDIV_select");
			_textoIndividual.downState = Assets.getAtlasTextoHUD().getTexture("textoINDIV_select");
			_textoIndividual.x = 810;
			_textoIndividual.y = 420;
			addChild(_textoIndividual);
			if(!_partidaEmpezada){
				_textoIndividual.alpha = 0;
				_textoIndividual.enabled = false;
			}
			
			_textoMulti = new Button(Assets.getAtlasTextoHUD().getTexture("textoMULTI"));
			_textoMulti.overState = Assets.getAtlasTextoHUD().getTexture("textoMULTI_select");
			_textoMulti.downState = Assets.getAtlasTextoHUD().getTexture("textoMULTI_select");
			_textoMulti.x = 776;
			_textoMulti.y = 545;
			addChild(_textoMulti);
			if(!_partidaEmpezada){
				_textoMulti.alpha = 0;
				_textoMulti.enabled = false;
			}
		}
		
		private function iniciarTexto():void 
		{
			var animacionInd:Tween = new Tween(_textoIndividual, 1.5);
			var animacionMulti:Tween = new Tween(_textoMulti, 1.5);
			var animacionLoCa:Tween = new Tween(_LoCa, 1);
			
			animacionInd.animate("alpha", 1);
			animacionMulti.animate("alpha", 1);
			animacionLoCa.animate("alpha", 1);
			
			Starling.juggler.add(animacionInd);
			Starling.juggler.add(animacionMulti);
			Starling.juggler.add(animacionLoCa);
			
			animacionInd.onComplete = activacionListenerTouchInd;
			animacionMulti.onComplete = activacionListenerTouchMul;
		}
		
		private function activacionListenerTouchInd():void 
		{
			_textoIndividual.enabled = true;
			_textoIndividual.addEventListener(TouchEvent.TOUCH, clickJuegoInidivual);
		}
		
		private function activacionListenerTouchMul():void 
		{
			_textoMulti.enabled = true;
			_textoMulti.addEventListener(TouchEvent.TOUCH, clickJuegoMulti);
		}
	}

}