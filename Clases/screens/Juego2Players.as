package screens 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Jesús Bachiller Cabal
	 */
	
	 public class Juego2Players extends Sprite 
	{
		var _tableroIzq:Tablero;
		var _tableroDer:Tablero;
		
		private var _jugadorIzq:Jugador;
		private var _jugadorDer:Jugador;
		
		public static var anchuraCelda:int = 40;
		public static var alturaCelda:int = 40;
		public static var numeroFilas:int = 13;
		public static var numeroColumnas:int = 7;
		
		public static var inicioXIzq:int = 170;
		public static var inicioXDer:int = 750;
		
		public static var inicioY:int = 25;
		
		var img:Image;
		var _imagenBolaTengoIzq:Image
		var _imagenBolaTengoDer:Image;
		
		private var numeroBolasMensajeIzq:TextField;
		private var numeroBolasMensajeDer:TextField;
		private var puntuacionMensajeIzq:TextField;
		private var puntuacionMensajeDer:TextField;
		
		private var numeroBolasQueTengoIzq:int;
		private var numeroBolasQueTengoDer:int;
		
		private var arrayDevuelveTirarBolasIzq:Array;
		private var arrayDevuelveTirarBolasDer:Array;
		private var arrayDevuelveSuccionarIzq:Array;
		private var arrayDevuelveSuccionarDer:Array;
		
		
		public static var columnaIzq:int;
		public static var columnaDer:int;
		
		private var _hub:Image;
		
		private var moveTimer:Timer = new Timer(4000);
		
		private var chrono:Timer;
		private var chronoMensaje:TextField;
		private var chronoSecondsPassed:uint;
		
		private var pantallaFinJuego:PantallaFinJuego;
		
		
		public function Juego2Players() 
		{
			super();
			
			_tableroIzq = new Tablero();
			_tableroDer = new Tablero();
			
			_jugadorIzq = new Jugador(_tableroIzq, 1);
			_jugadorDer = new Jugador(_tableroDer, 1);
			
			columnaIzq = 4;
			columnaDer = 4;
						
			puntuacionMensajeIzq = new TextField(300, 300, _jugadorIzq.puntuacionActual.toString(), Assets.getFont().name , 30, 0xffffff, true);
			puntuacionMensajeIzq.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			puntuacionMensajeIzq.x = 23;
			puntuacionMensajeIzq.y = 433;
			
			puntuacionMensajeDer = new TextField(300, 300, _jugadorDer.puntuacionActual.toString(), Assets.getFont().name , 30, 0xffffff, true);
			puntuacionMensajeDer.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			puntuacionMensajeDer.x = 1050;
			puntuacionMensajeDer.y = 433;
			
			moveTimer.addEventListener(TimerEvent.TIMER ,moveTimerHandler);
			moveTimer.start();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, playGame);
			addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			
		}
		
		private function moveTimerHandler(e:TimerEvent):void 
		{
			_tableroIzq.añadirFilaRandom();
			pintarTablero(_tableroIzq, inicioXIzq);
			_tableroDer.añadirFilaRandom();
			pintarTablero(_tableroDer, inicioXDer);
		}
		
		
		private function checkKeysDown(e:KeyboardEvent):void 
		{
			trace(e.keyCode);
			//Movimiento
				//Izquierda
			if (e.keyCode == 68) 
			{
				if (columnaIzq > 0) columnaIzq--;
			}
			
			if (e.keyCode == 71) 
			{
				if (columnaIzq < 6) columnaIzq++;
				
			}
				//Derecha
			if (e.keyCode == 37) 
			{
				if (columnaDer > 0) columnaDer--;
			}
			
			if (e.keyCode == 39) 
			{
				if (columnaDer < 6) columnaDer++;
				
			}
			
			//Coger y soltar bolas
				//Izquierda
			if (e.keyCode == 65)
			{
				var primerColorColumna:int = _tableroIzq.comprobarPrimerColorColumna(columnaIzq);
				arrayDevuelveSuccionarIzq = _jugadorIzq.succionar(columnaIzq);
				trace(arrayDevuelveSuccionarIzq[1]);
				if (arrayDevuelveSuccionarIzq[1] > 0 && (primerColorColumna == arrayDevuelveSuccionarIzq[0])) {
					removeChild(numeroBolasMensajeIzq);
					removeChild(_imagenBolaTengoIzq);
					masBolasQueTengo(arrayDevuelveSuccionarIzq[1], arrayDevuelveSuccionarIzq[0],
									 numeroBolasMensajeIzq, _imagenBolaTengoIzq, numeroBolasQueTengoIzq,
									 30, 536);
				}
				borrarImagenesDeColumna(_tableroIzq, columnaIzq, _jugadorIzq);
				_tableroIzq.imprime();
			}
			
			if (e.keyCode == 83)
			{
				if (_jugadorIzq.colorActualRetenido != 0) {
				arrayDevuelveTirarBolasIzq = _jugadorIzq.tirarBolas(columnaIzq);
				numeroBolasQueTengoIzq = 0;
				removeChild(_imagenBolaTengoIzq);
				removeChild(numeroBolasMensajeIzq);
					if (arrayDevuelveTirarBolasIzq[1]) {
						chronoSecondsPassed = chronoSecondsPassed + (arrayDevuelveTirarBolasIzq[0] * 20);// añadimos segundos si explotamos correspondiente bola
						puntuacionMensajeIzq.text = _jugadorIzq.puntuacionActual.toString();
						pintarTablero(_tableroIzq, inicioXIzq);
						_tableroIzq.imprime();
						/*if (_jugadorIzq.puntuacionActual > 500 && _jugadorIzq.puntuacionActual < 1000 && booleanoPrimerTiempo) {
								booleanoPrimerTiempo = false;
								moveTimer.delay = 3000;
						}
						if (_jugadorIzq.puntuacionActual > 2000 && _jugadorIzq.puntuacionActual < 2500 && booleanoSegundoTiempo) {
								booleanoSegundoTiempo = false;
								moveTimer.delay = 2500;
						}
						if (_jugadorIzq.puntuacionActual > 2500 && _jugadorIzq.puntuacionActual < 3000 && booleanoTercerTiempo ) {
							booleanoTercerTiempo = false;	
							moveTimer.delay = 2000;
						}
						if (_jugadorIzq.puntuacionActual > 3000 && booleanoCuartoTiempo) {
							booleanoCuartoTiempo = false;	
							moveTimer.delay = 1500;
						}*/
						
					}
					else{
						pintarTablero(_tableroIzq, inicioXIzq);
					}
				}
			}
				//Derecha
			if (e.keyCode == 75)
			{
				var primerColorColumna:int = _tableroDer.comprobarPrimerColorColumna(columnaDer);
				arrayDevuelveSuccionarDer = _jugadorDer.succionar(columnaDer);
				trace(arrayDevuelveSuccionarDer[1]);
				if (arrayDevuelveSuccionarDer[1] > 0 && (primerColorColumna == arrayDevuelveSuccionarDer[0])) {
					removeChild(numeroBolasMensajeDer);
					removeChild(_imagenBolaTengoDer);
					masBolasQueTengo(arrayDevuelveSuccionarDer[1], arrayDevuelveSuccionarDer[0],
									 numeroBolasMensajeDer, _imagenBolaTengoDer, numeroBolasQueTengoDer,
									 1060, 536);
				}
				borrarImagenesDeColumna(_tableroDer, columnaDer, _jugadorDer);
				_tableroDer.imprime();
			}
			
			if (e.keyCode == 76)
			{
				if (_jugadorDer.colorActualRetenido != 0) {
				arrayDevuelveTirarBolasDer = _jugadorDer.tirarBolas(columnaDer);
				numeroBolasQueTengoDer = 0;
				removeChild(_imagenBolaTengoDer);
				removeChild(numeroBolasMensajeDer);
					if (arrayDevuelveTirarBolasDer[1]) {
						chronoSecondsPassed = chronoSecondsPassed + (arrayDevuelveTirarBolasDer[0] * 20);// añadimos segundos si explotamos correspondiente bola
						puntuacionMensajeDer.text = _jugadorDer.puntuacionActual.toString();
						pintarTablero(_tableroDer, inicioXDer);
						_tableroDer.imprime();
						/*if (_jugadorIzq.puntuacionActual > 500 && _jugadorIzq.puntuacionActual < 1000 && booleanoPrimerTiempo) {
								booleanoPrimerTiempo = false;
								moveTimer.delay = 3000;
						}
						if (_jugadorIzq.puntuacionActual > 2000 && _jugadorIzq.puntuacionActual < 2500 && booleanoSegundoTiempo) {
								booleanoSegundoTiempo = false;
								moveTimer.delay = 2500;
						}
						if (_jugadorIzq.puntuacionActual > 2500 && _jugadorIzq.puntuacionActual < 3000 && booleanoTercerTiempo ) {
							booleanoTercerTiempo = false;	
							moveTimer.delay = 2000;
						}
						if (_jugadorIzq.puntuacionActual > 3000 && booleanoCuartoTiempo) {
							booleanoCuartoTiempo = false;	
							moveTimer.delay = 1500;
						}*/
						
					}
					else{
						pintarTablero(_tableroDer, inicioXDer);
					}
				}
			}
		}
		
		private function playGame(e:Event):void 
		{
			_jugadorIzq.jugadorImagen.x = comprobarPosicionXColumnaJugador(columnaIzq, inicioXIzq) - 15;
			_jugadorDer.jugadorImagen.x = comprobarPosicionXColumnaJugador(columnaDer, inicioXDer) - 15;
		
			
			watchForEnd();
		}
		
		private function iniciarReloj():void 
		{
			chrono = new Timer(1000);
			chrono.addEventListener(TimerEvent.TIMER, updateChrono);
			chrono.start();
			chronoSecondsPassed = 120;
			chronoMensaje = new TextField(0,0, "2:00", Assets.getFont().name, 30, 0xffffff, true);
			chronoMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			chronoMensaje.x = 540;
			chronoMensaje.y = 333;
			addChild(chronoMensaje);
		}
		
		private function updateChrono(e:TimerEvent):void 
		{
			var seconds:uint;
			var minutes:uint;
			
			chronoSecondsPassed -= 1;
			
			seconds = chronoSecondsPassed % 60;
			minutes = chronoSecondsPassed / 60;
			
			chronoMensaje.text = minutes + ":" +  seconds;
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			_hub = new Image(Assets.getTexture("HUD2Player"));
			_hub.x = (stage.stageWidth / 2) - (_hub.width /2);
			addChild(_hub);
			
			addChild(puntuacionMensajeIzq);
			addChild(puntuacionMensajeDer);
			
			iniciarPlayer(_jugadorIzq);
			iniciarPlayer(_jugadorDer);
			
			//iniciarIndicador();
			
			pintarTablero(_tableroIzq, inicioXIzq);
			pintarTablero(_tableroDer, inicioXDer);
			
			iniciarReloj();
		}
		
		private function iniciarPlayer(jugador:Jugador):void 
		{
			jugador.jugadorImagen.y = 550;
			jugador.jugadorImagen.width = anchuraCelda + anchuraCelda/2;
			jugador.jugadorImagen.height = alturaCelda * 2;
			addChild(jugador.jugadorImagen);
		}
		
		private function pintarTablero(tablero:Tablero, inicioX:int):void
		{
			tablero.imprime();
			for (var i:int = 0; i < numeroColumnas ;i++ ) {
					for (var j:int = 0; j < numeroFilas; j++ ) {
						var imagenBola:Image = pasoAImagen(tablero._tablero[j][i]);
						if (imagenBola != null) {
							imagenBola.width = anchuraCelda;
							imagenBola.height = alturaCelda;
							imagenBola.x = anchuraCelda * i + inicioX;
							imagenBola.y = alturaCelda * j + inicioY;
							removeChild(tablero._tableroImagenes[j][i]);
							tablero._tableroImagenes[j][i] = imagenBola;
							addChild(imagenBola);
						}
						else{
						removeChild(tablero._tableroImagenes[j][i]);
						}
					}
			}
		}
		
		private function pasoAImagen(tipoBola:int):Image
		{
			if (Math.floor(tipoBola / 10) == 1) {
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.getTexture("BolaRojaPts"));
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.getTexture("BolaRojaTim"));
					return img;
				}
				
				img = new Image(Assets.getTexture("BolaRoja"));
				return img;
				
			}
			if (Math.floor(tipoBola / 10) == 2) {
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.getTexture("BolaAzulPts"));
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.getTexture("BolaAzulTim"));
					return img;
				}
				
				img = new Image(Assets.getTexture("BolaAzul"));
				return img;
				
			}
			if (Math.floor(tipoBola / 10) == 3) {
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.getTexture("BolaAmarillaPts"));
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.getTexture("BolaAmarillaTim"));
					return img;
				}
				
				img = new Image(Assets.getTexture("BolaAmarilla"));
				return img;
			}
			if (Math.floor(tipoBola / 10) == 4) {
				
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.getTexture("BolaNegraPts"));
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.getTexture("BolaNegraTim"));
					return img;
				}
				
				img = new Image(Assets.getTexture("BolaNegra"));
				return img;
			}
			if (tipoBola == 0) {
				img = new Image(Assets.getTexture("BolaBomba"));
				return img;
			}
			return null;
		}
		
		private function comprobarPosicionXColumnaJugador(col:int, inicioX:int):int
		{
			return anchuraCelda * col + inicioX;
		}
		
		private function masBolasQueTengo(numeroBolas:int, colorBolas:int, numeroBolasMensaje:TextField,
										   imagenBolaTengo:Image, numeroBolasQueTengo:int,
										   posImagenBolaX:int, posImagenBolaY:int):void
		{
			imagenBolaTengo = pasoAImagen(colorBolas * 10);
			imagenBolaTengo.x = posImagenBolaX; //100
			imagenBolaTengo.y = posImagenBolaY; //300
			imagenBolaTengo.scaleX *= 0.75;
			imagenBolaTengo.scaleY *= 0.75;
			addChild(imagenBolaTengo);
			
			numeroBolasQueTengo = numeroBolasQueTengo + numeroBolas;
			
			numeroBolasMensaje = new TextField(0, 0, "x" + numeroBolasQueTengo, Assets.getFont().name , 30, 0xffffff, true);
			numeroBolasMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			numeroBolasMensaje.scaleX *= 0.9;
			numeroBolasMensaje.scaleY *= 0.9;
			numeroBolasMensaje.x = posImagenBolaX + 40;
			numeroBolasMensaje.y = posImagenBolaY;
			addChild(numeroBolasMensaje);
			
		}
		
		private function borrarImagenesDeColumna(tablero:Tablero, columna:int, jugador:Jugador):void
		{
			for (var i:int = 0; i < numeroFilas ; i++ ) {
				if (tablero._tablero[i][columna] == -1) {
						animacionBorrar(tablero._tableroImagenes[i][columna], jugador);
				}
			}
		}
		
		private function animacionBorrar(imagenAeliminar:Image, jugador:Jugador):void
		{
			if(imagenAeliminar !=null){
				var tweenPrueba:Tween = new Tween(imagenAeliminar, 0.5);
				tweenPrueba.animate("x", jugador.jugadorImagen.x + jugador.jugadorImagen.width / 2);
				tweenPrueba.animate("y", jugador.jugadorImagen.y + jugador.jugadorImagen.height / 2);
				tweenPrueba.animate("scaleX", 0.5);
				tweenPrueba.animate("scaleY", 0.5);
				Starling.juggler.add(tweenPrueba);
				tweenPrueba.onComplete = borrarImagen;
				tweenPrueba.onCompleteArgs = [imagenAeliminar];
			}
		}
		
		private function borrarImagen(imagenRecibida:Image):void 
		{
			removeChild(imagenRecibida);
		}
		
		private function watchForEnd():void
		{
			if (chronoSecondsPassed == 0 || _tableroIzq.compruebaUltimaFila() || _tableroDer.compruebaUltimaFila()) //Si el crono llega a 0 o hay bola en la ultima fila
			{
					chrono.removeEventListener(TimerEvent.TIMER, updateChrono);
					this.removeEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
					moveTimer.removeEventListener(TimerEvent.TIMER,moveTimerHandler);
					this.removeEventListener(Event.ENTER_FRAME, playGame);
					
					removeChildren();
					
					pantallaFinJuego = new PantallaFinJuego(_jugadorIzq.puntuacionActual.toString());
					addChild(pantallaFinJuego);
					
			}
		}
	}

}