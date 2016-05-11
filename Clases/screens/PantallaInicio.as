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
		
		private var _imagenFondo:Image;
		private var _HUD:Image;
		private var _theBattleOfKukulkan:Image;
		private var _LoCa:Image;
		
		private var _textoIndividual:Button;
		private var _textoMulti:Button;
		
		
		private var _chrono:Timer;
		private var _chronoInicio:Timer;
		
		private var _partidaEmpezada:Boolean;
		
		//Pantallas
		private var seleccionIndividual:seleccionPersonajeIndividual;
		private var juego:Juego2Players;
		
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
			var animacion:Tween = new Tween(_HUD, 2);
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
			var img:Image = new Image(b.overState);
			img.x = b.x;
			img.y = b.y;
			addChild(img);
			removeChild(b);
			
			var anim:Tween = new Tween(img, 1.5);
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
			
			var animTBOK:Tween = new Tween(_theBattleOfKukulkan, 1.5);
			var animHUD:Tween = new Tween(_HUD, 1.5);
			var animIND:Tween = new Tween(_textoIndividual, 1.5);
			var animMUL:Tween = new Tween(_textoMulti, 1.5);
			var animLOCA:Tween = new Tween(_LoCa, 1.5);
			
			animTBOK.animate("y", _theBattleOfKukulkan.y + 650);
			animHUD.animate("y", _HUD.y + 650);
			animIND.animate("y", _textoIndividual.y + 650);
			animMUL.animate("y", _textoMulti.y + 650);
			animLOCA.animate("y", _LoCa.y + 650);
			
			Starling.juggler.add(animHUD);
			Starling.juggler.add(animIND);
			Starling.juggler.add(animMUL);
			Starling.juggler.add(animTBOK);
			Starling.juggler.add(animLOCA);
		}
		
		private function cambioPantalla1Player():void 
		{
			removeChildren();
			
			_textoIndividual = null;
			_textoMulti = null;
			
			seleccionIndividual = new seleccionPersonajeIndividual();
			addChild(seleccionIndividual);
		}
		
		private function cambioPantalla2Player():void 
		{
			removeChildren();
				
			_textoIndividual = null;
			_textoMulti = null;
				
			
			juego = new Juego2Players();
			addChild(juego);
		}
		
		private function dibujarInicio():void
		{
			_imagenFondo = new Image(Assets.getTexture("FondoPrincipal"));
			_imagenFondo.x = 0;
			_imagenFondo.y = 0;
			addChild(_imagenFondo);
			
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
			
			
			_HUD = new Image(Assets.getTexture("HUDPrincipal"));
			_HUD.x = 0;
			if(!_partidaEmpezada){
				_HUD.y = 650;
			}else {
				_HUD.y = 0;
			}
			addChild(_HUD);
			
			_LoCa = new Image(Assets.getTexture("LoCa"));
			_LoCa.scaleX = 0.3;
			_LoCa.scaleY = 0.3;
			_LoCa.x = stage.stageWidth - _LoCa.width + 40
			_LoCa.y = 235;
			addChild(_LoCa);
			if(!_partidaEmpezada){
				_LoCa.alpha = 0;
			}
			
			_textoIndividual = new Button(Assets.getTexture("textoIND"));
			_textoIndividual.overState = Assets.getTexture("textoIND_select");
			_textoIndividual.downState = Assets.getTexture("textoIND_select");
			_textoIndividual.x = 780;
			_textoIndividual.y = 392;
			addChild(_textoIndividual);
			if(!_partidaEmpezada){
				_textoIndividual.alpha = 0;
				_textoIndividual.enabled = false;
			}
			
			_textoMulti = new Button(Assets.getTexture("textoMULTI"));
			_textoMulti.overState = Assets.getTexture("textoMULTI_select");
			_textoMulti.downState = Assets.getTexture("textoMULTI_select");
			_textoMulti.x = 755;
			_textoMulti.y = 505;
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