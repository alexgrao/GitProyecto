package 
{
	import starling.display.Image;
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
		
		private const JUGADOR_AZUL = 1;
		private const JUGADOR_ROJO = 2;
		
		
		public var jugadorImagen:Image;
		public var _tablero:Tablero;
		var arrayDevuelveSuccionar:Array;
		var arrayDevuelveTirarBolas:Array;
		public var colorActualRetenido:int;
		var bolasActualesRetenidas:int;
		public var puntuacionActual:int;
		
		
		public function Jugador(tablero:Tablero, jugadorElegido:int) 
		{
			super();
			iniciaJugador(jugadorElegido);
			_tablero = tablero;
			colorActualRetenido = 0;
			bolasActualesRetenidas = 0;
			puntuacionActual = 0;
		}
		
		private function iniciaJugador(jugadorElegido:int):void 
		{
			if (jugadorElegido == JUGADOR_AZUL)
			{
				jugadorImagen = new Image(Assets.getTexture("FlechaJugador"));
			}
			
			if (jugadorElegido == JUGADOR_ROJO)
			{
				jugadorImagen = new Image(Assets.getTexture("FlechaJugadorRoja"));
			}
		}
		
		public function succionar(col:int):void
		{
			//trace("Entramos en jugador.succionar");

			if (colorActualRetenido != 0) //si no es el primer succionar
			{
				if (colorActualRetenido == _tablero.comprobarPrimerColorColumna(col))
				{
					arrayDevuelveSuccionar = _tablero.eliminaUltsBolasColumna(col);
					bolasActualesRetenidas = bolasActualesRetenidas + arrayDevuelveSuccionar[1];
					//trace(bolasActualesRetenidas);
				}
			}
			else {
					colorActualRetenido = _tablero.comprobarPrimerColorColumna(col);
					arrayDevuelveSuccionar = _tablero.eliminaUltsBolasColumna(col);
					bolasActualesRetenidas = arrayDevuelveSuccionar[1];
					//trace(bolasActualesRetenidas);
			}
			//trace("Salimos en jugador.succionar");

		}
		
		public function tirarBolas(col:int):Boolean
		{
			//trace("Entramos en jugador.tirarBolas");

			if(colorActualRetenido != 0){
				_tablero.insertaNBolas(colorActualRetenido, bolasActualesRetenidas, col);
				if (_tablero.comprobarSeguidasMismoColor(col, colorActualRetenido) >= 3)
				{
					arrayDevuelveTirarBolas = _tablero.eliminaSeguidos(col);
					puntuacionActual = puntuacionActual + (arrayDevuelveTirarBolas[0] * puntPorBola);
					bolasActualesRetenidas = 0;
					colorActualRetenido = 0;
					//trace("Salimos 1º return en jugador.tirarBolas");

					return true;
				}
				bolasActualesRetenidas = 0;
				colorActualRetenido = 0;
				//trace("salimos 2º return en jugador.tirarBolas");

				return false;
			}
			//trace("Salimos 3º return en jugador.tirarBolas");

			return false;
			
		}
	}

}