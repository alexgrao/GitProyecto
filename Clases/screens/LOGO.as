package screens 
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Jesús Bachiller Cabal
	 */
	public class LOGO extends Sprite 
	{
		private var _fondo:Image;
		private var _LoCa:Image;
		
		private var _chronoLOGO:Timer;
		private var _pantallaIni:PantallaInicio;
		
		
		public function LOGO()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			dibujaPantalla();
			animacionInicio();
		}
		
		private function dibujaPantalla():void 
		{
			_fondo = new Image(Assets.getTexture("FondoPrincipal"));
			_fondo.x = -300;
			_fondo.y = -162.5;
			addChild(_fondo);
			
			_LoCa = new Image(Assets.getTexture("LoCa"));
			_LoCa.pivotX = _LoCa.width / 2;
			_LoCa.pivotY = _LoCa.height / 2;
			_LoCa.x = stage.stageWidth / 2;
			_LoCa.y = stage.stageHeight / 2;
			addChild(_LoCa);
			_LoCa.alpha = 0;
			
		}
		
		private function animacionInicio():void 
		{
			var anim:Tween = new Tween(_LoCa, 2);
			anim.animate("alpha", 1);
			Starling.juggler.add(anim);
			
			anim.onComplete = espera;
		}
		
		private function espera():void 
		{
			_chronoLOGO = new Timer(4000);
			_chronoLOGO.addEventListener(TimerEvent.TIMER, animacionFinal);
			_chronoLOGO.start();
		}
		
		private function animacionFinal(e:TimerEvent):void 
		{
			_chronoLOGO.removeEventListener(TimerEvent.TIMER, animacionFinal);
			
			var anim:Tween = new Tween(_LoCa, 3);
			anim.animate("alpha", 0);
			
			Starling.juggler.add(anim);
			
			anim.onComplete = cambioPantalla;
		}
		
		private function cambioPantalla():void 
		{
			_fondo = null;
			_LoCa = null;
			
			_pantallaIni = new PantallaInicio();
			addChild(_pantallaIni);
		}
		
	}

}