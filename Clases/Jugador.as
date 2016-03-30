package 
{
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Alejandro López Balderas
	 */
	public class Jugador extends Sprite
	{
		public var jugadorImagen:Image;
		public var _tablero:Tablero;
		var arrayDevuelveSuccionar:Array;
		var arrayDevuelveTirarBolas:Array;
		public var colorActualRetenido:int;
		var bolasActualesRetenidas:int;
		public var puntuacionActual:int;
		
		
		public function Jugador(tablero:Tablero) 
		{
			super();
			jugadorImagen = new Image(Assets.getTexture("FlechaJugador"));
			_tablero = tablero;
			colorActualRetenido = 0;
			bolasActualesRetenidas = 0;
			puntuacionActual = 0;
		}
		
		public function succionar(col:int):void
		{
			if (colorActualRetenido != 0) //si no es el primer succionar
			{
				if (colorActualRetenido == _tablero.comprobarPrimerColorColumna(col))
				{
					arrayDevuelveSuccionar = _tablero.eliminaUltsBolasColumna(col);
					bolasActualesRetenidas = bolasActualesRetenidas + arrayDevuelveSuccionar[1];
					trace(bolasActualesRetenidas);
				}
			}
			else {
					colorActualRetenido = _tablero.comprobarPrimerColorColumna(col);
					arrayDevuelveSuccionar = _tablero.eliminaUltsBolasColumna(col);
					bolasActualesRetenidas = arrayDevuelveSuccionar[1];
					trace(bolasActualesRetenidas);
			}
		}
		
		public function tirarBolas(col:int):Boolean
		{
			
			if(colorActualRetenido != 0){
				_tablero.insertaNBolas(colorActualRetenido, bolasActualesRetenidas, col);
				if (_tablero.comprobarSeguidasMismoColor(col, colorActualRetenido) >= 3)
				{
					arrayDevuelveTirarBolas = _tablero.eliminaSeguidos(col);
					puntuacionActual = puntuacionActual + (arrayDevuelveTirarBolas[0] * 10);
					bolasActualesRetenidas = 0;
					colorActualRetenido = 0;
					return true;
				}
				bolasActualesRetenidas = 0;
				colorActualRetenido = 0;
				return false;
			}
			return false;
			
		}
	}

}