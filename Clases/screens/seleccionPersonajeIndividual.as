package screens 
{
	import flash.automation.MouseAutomationAction;
	import flash.events.MouseEvent;
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

	public class seleccionPersonajeIndividual extends Sprite
	{
		//Constantes
		private const JUGADOR_AZUL = 1;
		private const JUGADOR_ROJO = 2;
		
		//TEXTO
		private var _personajeAzul:TextField;
		private var _personajeRojo:TextField;
		private var _atras:TextField;
		
		//botones
		private var _botonAzul:Button;
		private var _botonRojo:Button;
		
		//imegenes
		private var _imagenFondo:Image;
		private var _HUD:Image;
		private var _imgTITULO:Image;
		
		private var personaje1:AnimacionPersonaje;
		private var personaje2:AnimacionPersonaje;
		
		//pantallas
		private var juego:Juego;
		private var pantallaInicio:PantallaInicio;
		
		
		
		public function seleccionPersonajeIndividual() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			dibujarPantalla();
			
			animacionInicio();
		}
		
		private function animacionInicio():void 
		{
			var animHUD:Tween = new Tween(_HUD, 1);
			animHUD.animate("alpha", 1);
			Starling.juggler.add(animHUD);
			
			var animP1:Tween = new Tween(personaje1, 1);
			animP1.animate("alpha", 1);
			Starling.juggler.add(animP1);
			
			var animP2:Tween = new Tween(personaje2, 1);
			animP2.animate("alpha", 1);
			Starling.juggler.add(animP2);
			
			var animATRAS:Tween = new Tween(_atras, 1);
			animATRAS.animate("alpha", 1);
			Starling.juggler.add(animATRAS);
			
			animATRAS.onComplete = activaListeners;
		}
		
		private function activaListeners():void 
		{
			personaje1.addEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
			personaje2.addEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
			_atras.addEventListener(TouchEvent.TOUCH, atras);
		}
		
		private function atras(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch) {
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
				removeEventListener(TouchEvent.TOUCH, atras);
				removeChildren();
				
				_botonAzul = null;
				_botonRojo = null;
				_personajeAzul = null;
				_personajeRojo = null;
				_atras = null;
				
				pantallaInicio = new PantallaInicio(true);
				addChild(pantallaInicio);
			}
		}
		
		private function iniciaJuegoAzul(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch) {
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
				removeEventListener(TouchEvent.TOUCH, atras);
				removeChildren();
				
				_botonAzul = null;
				_botonRojo = null;
				_personajeAzul = null;
				_personajeRojo = null;
				_atras = null;
				
				juego = new Juego(JUGADOR_AZUL);
				addChild(juego);
			}
		}
		
		private function iniciaJuegoRoja(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch) {
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
				removeEventListener(TouchEvent.TOUCH, atras);
				removeChildren();
				
				_botonAzul = null;
				_botonRojo = null;
				_personajeAzul = null;
				_personajeRojo = null;
				_atras = null;
				
				juego = new Juego(JUGADOR_ROJO);
				addChild(juego);
			}
		}
		
		private function dibujarPantalla():void 
		{
			_imagenFondo = new Image(Assets.getTexture("FondoPrincipal"));
			_imagenFondo.x = (stage.stageWidth / 2) - (_imagenFondo.width /2);
			addChild(_imagenFondo);
			
			_HUD = new Image(Assets.getTexture("HUDseleccionPersonaje1PLAYER"));
			addChild(_HUD);
			_HUD.alpha = 0;
			
			_atras = new TextField(0, 0, "Atras", Assets.getFont().name, 24, 0xffffff, true);
			_atras.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_atras.x = 1025;
			_atras.y = 585;
			_atras.alpha = 0;
			addChild(_atras);
			
			_imgTITULO = new Image(Assets.getTexture("textoIND_select"));	
			_imgTITULO.scaleX = 1.5;
			_imgTITULO.scaleY = 1.5;
			_imgTITULO.x = stage.stageWidth/2 - _imgTITULO.width / 2;
			_imgTITULO.y = 10
			addChild(_imgTITULO);
			
			
			personaje1 = new AnimacionPersonaje(AnimacionPersonaje.ROJO);
			personaje1.x = 225;
			personaje1.y = 380;
			personaje1.alpha = 0;
			addChild(personaje1);
			
			personaje2 = new AnimacionPersonaje(AnimacionPersonaje.AZUL);
			personaje2.x = 895;
			personaje2.y = 380;
			personaje2.alpha = 0;
			addChild(personaje2);

		}
		
		
	}

}