package screens 
{
	import starling.events.Event;
	import starling.text.TextFieldAutoSize;
	import starling.display.Sprite;
	import starling.text.TextField;
	/**
	 * ...
	 * @author Alejandro López Balderas
	 */
	public class PantallaFinJuego extends Sprite
	{
		var _puntuacionMensaje:TextField;
		var puntuacionFinal:String;
		
		public function PantallaFinJuego(puntEnd:String) 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			puntuacionFinal = puntEnd;
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			dibujarPantalla();
		}
		
		private function dibujarPantalla():void 
		{
			_puntuacionMensaje = new TextField(0, 0, "Tu puntuacion ha sido : " + puntuacionFinal, Assets.getFont().name, 72, 0xffffff, true);
			_puntuacionMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_puntuacionMensaje.x = 300;
			_puntuacionMensaje.y = 100;
			addChild(_puntuacionMensaje);
		}
		
	}

}