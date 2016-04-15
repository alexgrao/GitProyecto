package screens 
{
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
			trace("inicia seleccionPersonajeIndividual");
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			dibujarPantalla();
			
			
			_botonAzul.addEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
			_botonRojo.addEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
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
				
				pantallaInicio = new PantallaInicio();
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
			_personajeAzul = new TextField(0, 0, "AZUL", Assets.getFont().name, 24, 0xfffffff, true);
			_personajeAzul.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_personajeAzul.x = 100;
			_personajeAzul.y = 100;
			addChild(_personajeAzul);
			
			_botonAzul = new Button(Assets.getTexture("FlechaJugador"));
			_botonAzul.width = 70;
			_botonAzul.height = 70;
			_botonAzul.x = 100;
			_botonAzul.y = 200;
			addChild(_botonAzul);
			
			_personajeRojo = new TextField(0, 0, "ROJO", Assets.getFont().name, 24, 0xffffff, true);
			_personajeRojo.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_personajeRojo.x = 300;
			_personajeRojo.y = 100;
			addChild(_personajeRojo);
			
			_botonRojo = new Button(Assets.getTexture("FlechaJugadorRoja"));
			_botonRojo.width = 70;
			_botonRojo.height = 70;
			_botonRojo.x = 300;
			_botonRojo.y = 200;
			addChild(_botonRojo);
			
			_atras = new TextField(0, 0, "Atras", Assets.getFont().name, 24, 0xffffff, true);
			_atras.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_atras.x = 400;
			_atras.y = 600;
			addChild(_atras);
			
		}
		
		
	}

}