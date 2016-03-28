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
		private var _textoJugar:TextField;
		private var juego:Juego;
		
		public function PantallaInicio() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			dibujarInicio();
			_textoJugar.addEventListener(TouchEvent.TOUCH, clickJuego);
		}
		
		private function clickJuego(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				removeEventListener(TouchEvent.TOUCH, clickJuego);
				removeChildren();
				
				_textoInicio = null;
				_textoJugar = null;
				
				juego = new Juego();
				addChild(juego);
			}
		}
		
		private function dibujarInicio():void
		{
			_textoInicio = new TextField(0, 0, "Bienvenido", "Arial", 24, 0x111111, true);
			_textoInicio.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textoInicio.x = stage.stageWidth / 2 - _textoInicio.width / 2;
			_textoInicio.y = stage.stageHeight / 4;
			addChild(_textoInicio);
			
			_textoJugar = new TextField(0, 0, "Jugar", "Arial", 24, 0x111111, true);
			_textoJugar.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textoJugar.x = stage.stageWidth / 2 - _textoInicio.width / 2;
			_textoJugar.y = stage.stageHeight / 2;
			addChild(_textoJugar);
		}
		
	}

}