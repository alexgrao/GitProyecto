package 
{
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import screens.seleccionPersonajeIndividual;
	/**
	 * ...
	 * @author Alejandro López Balderas
	 */
	public class Jugador extends Sprite
	{		
		
		//CONSTANTES
		private const puntPorBola = 10;
		private const puntPorBolaPunt = 50;
		
		private const JUGADOR_AZUL = 1;
		private const JUGADOR_ROJO = 2;
		
		
		public var jugadorImagen:AnimacionPersonaje;
		public var _tablero:Tablero;
		var arrayDevuelveSuccionar:Array;
		var arrayDevuelveTirarBolas:Array;
		public var colorActualRetenido:int;
		public var bolasActualesNormalesRetenidas:int;
		public var bolasActualesPuntosRetenidas:int;
		public var bolasActualesTiempoRetenidas:int;
		public var puntuacionActual:int;
		
		
		public function Jugador(tablero:Tablero, jugadorElegido:int) 
		{
			super();
			
			iniciaJugador(jugadorElegido);
			_tablero = tablero;
			colorActualRetenido = 0;
			bolasActualesNormalesRetenidas = 0;
			bolasActualesPuntosRetenidas = 0;
			bolasActualesTiempoRetenidas = 0;
			puntuacionActual = 0;
		}
		
		private function iniciaJugador(jugadorElegido:int):void 
		{
			if (jugadorElegido == JUGADOR_AZUL)
			{
				jugadorImagen = new AnimacionPersonaje();
			}
			
			if (jugadorElegido == JUGADOR_ROJO)
			{
				jugadorImagen = new AnimacionPersonaje();
			}
		}
		
		public function succionar(col:int):Array
		{
			if (colorActualRetenido != 0) //si no es el primer succionar
			{
				if (colorActualRetenido == _tablero.comprobarPrimerColorColumna(col))
				{
					arrayDevuelveSuccionar = _tablero.eliminaUltsBolasColumna(col);
					bolasActualesNormalesRetenidas = bolasActualesNormalesRetenidas + arrayDevuelveSuccionar[1] - arrayDevuelveSuccionar[2] - arrayDevuelveSuccionar[3];
					bolasActualesPuntosRetenidas = bolasActualesPuntosRetenidas + arrayDevuelveSuccionar[2];
					bolasActualesTiempoRetenidas = bolasActualesTiempoRetenidas + arrayDevuelveSuccionar[3];
				}
			}
			else {
					colorActualRetenido = _tablero.comprobarPrimerColorColumna(col);
					arrayDevuelveSuccionar = _tablero.eliminaUltsBolasColumna(col);
					bolasActualesNormalesRetenidas = arrayDevuelveSuccionar[1] - arrayDevuelveSuccionar[2] - arrayDevuelveSuccionar[3];
					bolasActualesPuntosRetenidas = arrayDevuelveSuccionar[2];
					bolasActualesTiempoRetenidas = arrayDevuelveSuccionar[3];
			}
			return arrayDevuelveSuccionar;

		}
		
		public function tirarBolas(col:int):Array
		{
			var devolverEnTirarBolas:Array = new Array(2);
			devolverEnTirarBolas[0] = 0;
			devolverEnTirarBolas[1] = false;
			if (colorActualRetenido != 0) {
				_tablero.insertaNBolas(colorActualRetenido, bolasActualesNormalesRetenidas, col, 0);//insertamos bolas normales
				_tablero.insertaNBolas(colorActualRetenido, bolasActualesPuntosRetenidas, col , 1);//insertamos bolas con puntos
				_tablero.insertaNBolas(colorActualRetenido, bolasActualesTiempoRetenidas, col , 2);//insertamos bolas con tiempo
				if (_tablero.comprobarSeguidasMismoColor(col, colorActualRetenido) >= 3)
				{
					arrayDevuelveTirarBolas = _tablero.eliminaSeguidos(col);
					puntuacionActual = puntuacionActual + ((arrayDevuelveTirarBolas[0]-arrayDevuelveTirarBolas[1]-arrayDevuelveTirarBolas[2])  * puntPorBola) + (arrayDevuelveTirarBolas[1] * puntPorBolaPunt);
					devolverEnTirarBolas[0] = arrayDevuelveTirarBolas[2];
					devolverEnTirarBolas[1] = true;
					bolasActualesNormalesRetenidas = 0;
					bolasActualesPuntosRetenidas = 0;
					bolasActualesTiempoRetenidas = 0;
					colorActualRetenido = 0;
					return devolverEnTirarBolas;
				}
				bolasActualesNormalesRetenidas = 0;
				bolasActualesPuntosRetenidas = 0;
				bolasActualesTiempoRetenidas = 0;
				colorActualRetenido = 0;
				return devolverEnTirarBolas
			}
			return devolverEnTirarBolas;
			
		}
	}

}