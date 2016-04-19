package screens 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	public class PantallaInicio extends Sprite
	{
		private var _textoInicio:TextField;
		private var _textoIndividual:TextField;
		private var _textoMulti:TextField;
		
		//Pantallas
		private var seleccionIndividual:seleccionPersonajeIndividual;
		private var juego:Juego2Players;
		private var juego2P
		
		public function PantallaInicio() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			trace("inicia pantalla inicio");
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			dibujarInicio();
			_textoIndividual.addEventListener(TouchEvent.TOUCH, clickJuegoInidivual);
			_textoMulti.addEventListener(TouchEvent.TOUCH, clickJuegoMulti);
		}
		
		private function clickJuegoMulti(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				removeEventListener(TouchEvent.TOUCH, clickJuegoInidivual);
				removeEventListener(TouchEvent.TOUCH, clickJuegoMulti);
				
				removeChildren();
				
				_textoInicio = null;
				_textoIndividual = null;
				_textoMulti = null;
				
				juego = new Juego2Players();
				addChild(juego);
			}
		}
		
		private function clickJuegoInidivual(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				removeEventListener(TouchEvent.TOUCH, clickJuegoInidivual);
				removeEventListener(TouchEvent.TOUCH, clickJuegoMulti);
				
				removeChildren();
				
				_textoInicio = null;
				_textoIndividual = null;
				_textoMulti = null;
				
				seleccionIndividual = new seleccionPersonajeIndividual();
				addChild(seleccionIndividual);
			}
		}
		
		private function dibujarInicio():void
		{
			_textoInicio = new TextField(0, 0, "Bienvenido", Assets.getFont().name, 24, 0xffffff, true);
			_textoInicio.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textoInicio.x = 100;
			_textoInicio.y = 100;
			addChild(_textoInicio);
			
			_textoIndividual = new TextField(0, 0, "Individual", Assets.getFont().name, 24, 0xffffff, true);
			_textoIndividual.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textoIndividual.x = 100;
			_textoIndividual.y = 200;
			addChild(_textoIndividual);
			
			_textoMulti = new TextField(0, 0, "Multijugador", Assets.getFont().name, 24, 0xffffff, true);

			_textoMulti.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textoMulti.x = 100;
			_textoMulti.y = 300;
			addChild(_textoMulti);
		}
		
	}

}