package screens 
{
	import starling.core.Starling;
	import flash.display.StageDisplayState;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	import Tablero;
	import Jugador;
	
	public class Juego extends Sprite
	{
		/*-------------------*/
		/*****CONSTANTES******/
		private const INICIO_X:int = 530;
		private const INICIO_Y:int = 25;
		
		private const ANCHURA_CELDA:int = 40;
		private const ALTURA_CELDA:int = 40;
		private const NUM_FILAS:int = 13;
		private const NUM_COLUMNAS:int = 7;
		
		/*-------------------*/
		/*****EXPLOSIONES*****/
		private var _numExplosionesBombas:int;
		private var _hayExplosionBomba:Boolean;
		
		private var _numExplosionesBolas:int;
		private var _hayExplosionBolas :Boolean;
		
		/*-------------------*/
		/********IMAGE********/
		private var _img:Image;
		
		private var _imagenFondo:Image; 
		private var _hub:Image;
		
		private var _imagenBolaTengo:Image;
		
		/*-------------------*/
		/******TEXTFIELD******/
		private var _puntuacionMensaje:TextField;
		private var _numeroBolasMensaje:TextField;
		
		/*-------------------*/
		/****ARRAY DEVULVE****/
		/*------- + ---------*/
		/********BOLAS********/
		private var _arrayDevuelveTirarBolas:Array;
		private var _arrayDevuelveSuccionar:Array;
		
		private var _numeroBolasQueTengo:int;
		private var _bolasConNormalesQueTengo:int;
		private var _bolasConTiempoQueTengo:int;
		private var _bolasConPuntosQueTengo:int;
		
		/*-------------------*/
		 /********TIME*********/
		private var _moveTimer:Timer = new Timer(4000);
		private var _chrono:Timer;
		private var _chronoMensaje:TextField;
		private var _chronoSecondsPassed:uint;
		
		/*-------------------*/
		private var _timerAnimacion:Timer = new Timer(250);
		
		private var _columna:int;
		
		private var _jugadorElegido:int;
		
		 /*-------------------*/
		 /*******BOOLEAN*******/
		private var _booleanoPrimerTiempo:Boolean;
		private var _booleanoSegundoTiempo:Boolean;
		private var _booleanoTercerTiempo:Boolean;
		private var _booleanoCuartoTiempo:Boolean;
		private var _booleanoQuintoTiempo:Boolean;
		private var _booleanoSextoTiempo:Boolean;
		private var _booleanoSeptimoTiempo:Boolean;
		private var _booleanoOctavoTiempo:Boolean;
		
		private var _estaHaciendoAnimacion:Boolean;
		private var _heCanceladoAñadirFila:Boolean;
		
		/*------------------------*/
		/*OBJECTOS DE OTRAS CLASES*/
		/********PROPIAS***********/
		private var _tablero:Tablero;
		private var _jugador:Jugador;
		private var _indicador:Indicador;
				
		private var _pantallaFinJuego:PantallaFinJuego;
		
		/* CONTRUCTOR DE LA CLASE */
		public function Juego(jugador_elegido:int) 
		{
			super();
			
			_numExplosionesBombas = 0;
			_hayExplosionBomba = false;
			
			_numExplosionesBolas = 0;
			_hayExplosionBolas = false;
			
			_estaHaciendoAnimacion = false;
			_heCanceladoAñadirFila = false;
			
			_tablero = new Tablero();
			_jugador = new Jugador(_tablero, jugador_elegido);
			_indicador = new Indicador();
			Assets.createArrayTextures();
			
			_jugadorElegido = jugador_elegido;
			
			_columna = 3;
			
			_numeroBolasQueTengo = 0;
			
			_puntuacionMensaje = new TextField(300, 300, _jugador.puntuacionActual.toString(), Assets.getFont().name , 28, 0xffffff, true);
			_puntuacionMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_puntuacionMensaje.x = 330;
			_puntuacionMensaje.y = 365;
			
			
			_numeroBolasMensaje = new TextField(0, 0, " ", Assets.getFont().name , 28, 0xffffff, true);
			_numeroBolasMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			
			
			_moveTimer.addEventListener(TimerEvent.TIMER,moveTimerHandler);
			_moveTimer.start();
			
			_timerAnimacion.addEventListener(TimerEvent.TIMER,animacionBorrar);
			
			_booleanoPrimerTiempo = true;
			_booleanoSegundoTiempo = true;
			_booleanoTercerTiempo = true;
			_booleanoCuartoTiempo = true;
			_booleanoQuintoTiempo = true;
			_booleanoSextoTiempo = true;
			_booleanoSeptimoTiempo = true;
			_booleanoOctavoTiempo = true;
			
			_numeroBolasQueTengo = 0;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, playGame);
			addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
		}
		
		/* Clase en la que cada vez que salte el event TimerEvent baja una fila en los tablero
		  */
		private function moveTimerHandler(e:TimerEvent):void 
		{
			if(_estaHaciendoAnimacion == false){
				_tablero.añadirFilaRandom();
				pintarTablero();
			}
			else {
				_heCanceladoAñadirFila = true;
			}
		}
		
		/* Funcion que se llama cada Frame. Mueve al personaje, el indicador, ...
		 * ...si hay alguna explosion inicia el proceso para llevarlas a cabo y ...
		 * ...comprueba si acaba el juego
		 */
		private function playGame(e:Event):void 
		{
			_jugador.jugadorImagen.x = comprobarPosicionXColumnaJugador(_columna);
			if (_columna == 3) {
				_jugador.jugadorImagen.y = 568;
			}else {
				if (_columna == 2 || _columna == 4) {
				_jugador.jugadorImagen.y = 565;
				}else {
					if (_columna == 1 || _columna == 5) {
					_jugador.jugadorImagen.y = 562;
					}else {
						_jugador.jugadorImagen.y = 558;
					}
				}
			}
			
			_indicador.indImagen.x = comprobarPosicionXColumnaJugador(_columna);
			_indicador.indImagen.y = comprobarPosicionYColumnaIndicador();
			
			if (_hayExplosionBomba) {
				_estaHaciendoAnimacion = true;
				explotaBombas();
				_hayExplosionBomba = false;
			}
			
			if (_hayExplosionBolas) {
				_estaHaciendoAnimacion = true;
				explotaBolas();
				_hayExplosionBolas = false;
			}
			
			watchForEnd();
		}
		
		/* hace todas las explosion de Bolas pendientes y si se cancelo en su momento ...
		 * ...bajar filas por las animaciones de subir bolas desde le personaje a su columna, se bajan
		 */
		private function explotaBolas():void 
		{
			_numExplosionesBolas = _tablero.ArrayExploBolas.length;
			
			while (_numExplosionesBolas != 0) 
			{
				hacerExplosionBolas(_tablero.ArrayExploBolas[_numExplosionesBolas - 1][0], _tablero.ArrayExploBolas[_numExplosionesBolas - 1][1]);
				_tablero.ArrayExploBolas.pop();
				_numExplosionesBolas--;
			}
			_estaHaciendoAnimacion = false;
			
			if (_heCanceladoAñadirFila) {
				_tablero.añadirFilaRandom();
				_heCanceladoAñadirFila = false;
			}
		}
		
		/* Acción visual de la explosión de bolas 
		  */
		private function hacerExplosionBolas(fil:int, col:int):void 
		{
			_tablero.ArrayExploBolas[_numExplosionesBolas - 1][2].x = (col - 1) * ANCHURA_CELDA + INICIO_X + 20;
			_tablero.ArrayExploBolas[_numExplosionesBolas - 1][2].y = (fil - 1) * ALTURA_CELDA + INICIO_Y + 20;
			
			_tablero.ArrayExploBolas[_numExplosionesBolas - 1][2].ExploArt.play();
			addChild(_tablero.ArrayExploBolas[_numExplosionesBolas - 1][2]);
		}
		
		/* hace todas las explosion de Bombas pendientes 
		 */
		private function explotaBombas():void 
		{
			_numExplosionesBombas = _tablero.ArrayExplosiones.length;
			
			while (_numExplosionesBombas != 0) {
				hacerExplosionBomba(_tablero.ArrayExplosiones[_numExplosionesBombas - 1][0], _tablero.ArrayExplosiones[_numExplosionesBombas - 1][1]);
				_tablero.ArrayExplosiones.pop();
				_numExplosionesBombas--;
			}
		}
		
		/* Clase que controla la entrada de teclado y hace que se mueva el personaje y ...
		 * ...tire o recoga bolas
		 */
		private function checkKeysDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 37) 
			{
				if (_columna > 0) _columna--;
			}
			
			if (e.keyCode == 39) 
			{
				if (_columna < 6) _columna++;
				
			}
			
			if (e.keyCode == 65)
			{
				var primerColorColumna:int = _tablero.comprobarPrimerColorColumna(_columna);
				if(primerColorColumna != -1){
					_arrayDevuelveSuccionar = _jugador.succionar(_columna);
					_bolasConNormalesQueTengo = _jugador.bolasActualesNormalesRetenidas;
					_bolasConPuntosQueTengo = _jugador.bolasActualesPuntosRetenidas;
					_bolasConTiempoQueTengo = _jugador.bolasActualesTiempoRetenidas;
					if (_arrayDevuelveSuccionar[1] > 0 && (primerColorColumna == _arrayDevuelveSuccionar[0])) {
						borrarImagen(_imagenBolaTengo);
						masBolasQueTengo(_arrayDevuelveSuccionar[1], _arrayDevuelveSuccionar[0]);
					}
					borrarImagenesDeColumna();
				}
			}
			
			if (e.keyCode == 83)
			{
				var columnaCopia:int = _columna;
				if (_jugador.colorActualRetenido != 0) {
				tirar(columnaCopia);
				}
			}
		}

		/* Acción visual de la explosión de bombas
		  */
		private function hacerExplosionBomba(fil:int, col:int):void 
		{
			_tablero.ArrayExplosiones[_numExplosionesBombas - 1][2].x = (col - 1) * ANCHURA_CELDA + INICIO_X;
			_tablero.ArrayExplosiones[_numExplosionesBombas - 1][2].y = (fil - 1) * ALTURA_CELDA + INICIO_Y;
			
			_tablero.ArrayExplosiones[_numExplosionesBombas - 1][2].ExploArt.play();
			addChild(_tablero.ArrayExplosiones[_numExplosionesBombas - 1][2]);
		}
		
		/* funcion que añade a la pantalla los objetos iniciales con los que se empieza*/
		private function onAddedToStage(e:Event):void 
		{
			if (_jugadorElegido == 1) {
				_imagenFondo = new Image(Assets.getTexture("FondoSol"));
			}else {
				_imagenFondo = new Image(Assets.getTexture("FondoLluvia"));
			}
			_imagenFondo.x = (stage.stageWidth / 2) - (_imagenFondo.width /2);
			addChild(_imagenFondo);
			_hub = new Image(Assets.getTexture("HUD1Player"));
			_hub.x = (stage.stageWidth / 2) - (_hub.width /2);
			addChild(_hub);
			addChild(_puntuacionMensaje);
			addChild(_numeroBolasMensaje);
			
			iniciarPlayer();
			iniciarIndicador();
			pintarTableroPorPrimeraVez();
			iniciarReloj();
			
		}
		
		/* Inicializacion del reloj del juego*/
		private function iniciarReloj():void 
		{
			_chrono = new Timer(1000);
			_chrono.addEventListener(TimerEvent.TIMER, updateChrono);
			_chrono.start();
			_chronoSecondsPassed = 120;
			_chronoMensaje = new TextField(0,0, "2:00", Assets.getFont().name, 28, 0xffffff, true);
			_chronoMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_chronoMensaje.x = 330;
			_chronoMensaje.y = 493;
			
			addChild(_chronoMensaje);
		}
		
		/* Actualización del reloj del juego cada segundo*/
		private function updateChrono(e:TimerEvent):void 
		{
			var seconds:uint;
			var minutes:uint;
			
			_chronoSecondsPassed -= 1;
			
			seconds = _chronoSecondsPassed % 60;
			minutes = _chronoSecondsPassed / 60;
			
			_chronoMensaje.text = minutes + ":" +  seconds;
			
		}
		
		/* Inicializacion del jugador del juego*/
		private function iniciarPlayer():void 
		{
			_jugador.jugadorImagen.y = 568;
			_jugador.jugadorImagen.scaleX = 0.5;
			_jugador.jugadorImagen.scaleY = 0.5;
			addChild(_jugador.jugadorImagen);
		}
		
		/* Inicializacion del indicador del juego*/
		private function iniciarIndicador():void 
		{
			_indicador.indImagen.width = ANCHURA_CELDA;
			_indicador.indImagen.height = ALTURA_CELDA;
		
			addChild(_indicador.indImagen);
		}
		
		/* Devuelve las coordenadas en Y del indicador*/
		private function comprobarPosicionYColumnaIndicador():int
		{
			return  ALTURA_CELDA * (comprobarUltimaFilaDeColumna(_columna) + 1) + INICIO_Y;
		}
		
		/* Devuelve la ultima fila donde hay bolas de la columan*/
		private function comprobarUltimaFilaDeColumna(columna:int):int
		{
			return _tablero.BuscaUltimoEnColumna(columna);
		}
		
		/* Devuelve la imagen del tipo de bola que le pasemos*/
		private function pasoAImagen(tipoBola:int):Image
		{
			if (Math.floor(tipoBola / 10) == 1) {
				if (tipoBola % 10 == 1) {
					_img = new Image(Assets.gameTexturesArray[11]);
					
					return _img;
				}
				if (tipoBola % 10 == 2) {
					_img = new Image(Assets.gameTexturesArray[12]);
					
					return _img;
				}
				
				_img = new Image(Assets.gameTexturesArray[10]);
				return _img;
				
			}
			if (Math.floor(tipoBola / 10) == 2) {
				if (tipoBola % 10 == 1) {
					_img = new Image(Assets.gameTexturesArray[4]);
					return _img;
				}
				if (tipoBola % 10 == 2) {
					_img = new Image(Assets.gameTexturesArray[5]);
					return _img;
				}
				
				_img = new Image(Assets.gameTexturesArray[3]);
				return _img;
				
			}
			if (Math.floor(tipoBola / 10) == 3) {
				if (tipoBola % 10 == 1) {
					_img = new Image(Assets.gameTexturesArray[1]);
					return _img;
				}
				if (tipoBola % 10 == 2) {
					_img = new Image(Assets.gameTexturesArray[2]);
					return _img;
				}
				
				_img = new Image(Assets.gameTexturesArray[0]);
				return _img;
			}
			if (Math.floor(tipoBola / 10) == 4) {
				
				if (tipoBola % 10 == 1) {
					_img = new Image(Assets.gameTexturesArray[8]);
					return _img;
				}
				if (tipoBola % 10 == 2) {
					_img = new Image(Assets.gameTexturesArray[9]);
					return _img;
				}
				
				_img = new Image(Assets.gameTexturesArray[7]);
				return _img;
			}
			if (tipoBola == 0) {
				_img = new Image(Assets.gameTexturesArray[6]);
				return _img;
			}
			return null;
		}
		
		/* Devuelve la X donde esta el juegador en funcion de la columna donde esté*/
		private function comprobarPosicionXColumnaJugador(col:int):int
		{
			return ANCHURA_CELDA * col + INICIO_X;
		}
		
		/* Pinta el tablero en pantalla*/
		private function pintarTableroPorPrimeraVez():void
		{
			for (var i:int = 0; i < NUM_COLUMNAS ;i++ ) {
					for (var j:int = 0; j < NUM_FILAS; j++ ) {
						var imagenBola:Image = pasoAImagen(_tablero._tablero[j][i]);
						if (imagenBola != null) {
							imagenBola.width = ANCHURA_CELDA;
							imagenBola.height = ALTURA_CELDA;
							imagenBola.x = ANCHURA_CELDA * i + INICIO_X;
							imagenBola.y = ALTURA_CELDA * j + INICIO_Y;
							_tablero._tableroImagenes[j][i] = imagenBola;
							addChild(imagenBola);
						}
					}
			}
		}
		
		/* Pinta el tablero en pantalla*/
		private function pintarTablero():void
		{
			var imagenBolaMolde:Image;
			for (var i:int = 0; i < NUM_COLUMNAS ;i++ ) {
					for (var j:int = 0; j < NUM_FILAS; j++ ) {
						var imagenBola:Image = pasoAImagen(_tablero._tablero[j][i]);
						if (imagenBola != null) {
							imagenBola.width = ANCHURA_CELDA;
							imagenBola.height = ALTURA_CELDA;
							imagenBola.x = ANCHURA_CELDA * i + INICIO_X;
							imagenBola.y = ALTURA_CELDA * j + INICIO_Y;
							imagenBolaMolde = _tablero._tableroImagenes[j][i];
							borrarImagen(imagenBolaMolde);
							_tablero._tableroImagenes[j][i] = imagenBola;
							addChild(imagenBola);
						}
						else {
						imagenBolaMolde = _tablero._tableroImagenes[j][i];
						borrarImagen(imagenBolaMolde);	
						}
					}
			}
		}
		
		/*Comprueba si el juego ha llegado a su fin*/
		private function watchForEnd():void
		{
			if (_chronoSecondsPassed == 0 || _tablero.compruebaUltimaFila()) //Si el crono llega a 0 o hay bola en la ultima fila
			{ // faltarán añadir finales
					_chrono.removeEventListener(TimerEvent.TIMER, updateChrono);
					this.removeEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
					_moveTimer.removeEventListener(TimerEvent.TIMER,moveTimerHandler);
					this.removeEventListener(Event.ENTER_FRAME, playGame);
					
					removeChildren();
					
					_pantallaFinJuego = new PantallaFinJuego(_jugador.puntuacionActual.toString());
					addChild(_pantallaFinJuego);
					
			}
		}
		
		/* Animacion de coger las bolas con Tween*/
		private function animacionBorrar(imagenAeliminar:Image):void
		{
			if(imagenAeliminar !=null){
				var tweenPrueba:Tween = new Tween(imagenAeliminar, 0.5);
				tweenPrueba.animate("x", _jugador.jugadorImagen.x + _jugador.jugadorImagen.width / 2);
				tweenPrueba.animate("y", _jugador.jugadorImagen.y + _jugador.jugadorImagen.height / 2);
				tweenPrueba.animate("scaleX", 0.5);
				tweenPrueba.animate("scaleY", 0.5);
				Starling.juggler.add(tweenPrueba);
				tweenPrueba.onComplete = borrarImagen;
				tweenPrueba.onCompleteArgs = [imagenAeliminar];
			}
		}
		
		/* Borra la imagen recibida*/
		private function borrarImagen(imagenRecibida:Image):void 
		{
			if(imagenRecibida != null){
				imagenRecibida.texture.dispose();
				removeChild(imagenRecibida, true);
			}
		}
		
		/* Clase que mediandte un for tira las bolas que tengamos...
		 * ...llamando a animaciónTirar con cada bola
		 */
		private function tirar(col:int) 
		{
			var bolasAtirar:int = 1;
			for (var i:int = 0; i < NUM_FILAS ; i++)
			{
				if (_tablero._tablero[i][col] == -1) 
				{
					if (bolasAtirar <= _numeroBolasQueTengo) {
							animacionTirar(i, col, bolasAtirar);
							bolasAtirar++;
					}
					else break;
				}
			}
			_numeroBolasQueTengo = 0;
		}
		
		/* Hace la animacion de tirar con Tween de cada bola que tengamos cogida y...
		 * ...si ha tirado todas la bolas llama a otra función que hace la acción...
		 * ...fisica de tirarlas en el tablero.
		 */
		private function animacionTirar(fil:int, col:int, numeroBolaTirada:int)
		{
			_estaHaciendoAnimacion = true;
			if(_bolasConNormalesQueTengo > 0){
				var imagenTirar:Image;
				imagenTirar = pasoAImagen(10 * _jugador.colorActualRetenido);
				_tablero._tableroImagenes[fil][col] = imagenTirar;
				imagenTirar.x = _jugador.jugadorImagen.x + _jugador.jugadorImagen.width / 2;
				imagenTirar.y = _jugador.jugadorImagen.y + _jugador.jugadorImagen.height / 2;
				imagenTirar.scaleX = 0;
				imagenTirar.scaleY = 0;
				addChild(imagenTirar);
				
				var tweenPrueba2:Tween = new Tween(imagenTirar, 0.3);
				tweenPrueba2.animate("x", ANCHURA_CELDA * col + INICIO_X);
				tweenPrueba2.animate("y", ALTURA_CELDA * fil + INICIO_Y - 4);
				tweenPrueba2.animate("scaleX", 1);
				tweenPrueba2.animate("scaleY", 1);
				Starling.juggler.add(tweenPrueba2);
				tweenPrueba2.onComplete = borrarImagen;
				tweenPrueba2.onCompleteArgs = [imagenTirar];
				_bolasConNormalesQueTengo--;
			}
			else{
				if(_bolasConPuntosQueTengo > 0){
					var imagenTirar:Image;
					imagenTirar = pasoAImagen((10 * _jugador.colorActualRetenido) + 1);
					_tablero._tableroImagenes[fil][col] = imagenTirar;
					imagenTirar.x = _jugador.jugadorImagen.x + _jugador.jugadorImagen.width / 2;
					imagenTirar.y = _jugador.jugadorImagen.y + _jugador.jugadorImagen.height / 2;
					imagenTirar.scaleX = 0;
					imagenTirar.scaleY = 0;
					addChild(imagenTirar);
			
					var tweenPrueba2:Tween = new Tween(imagenTirar, 0.3);
					tweenPrueba2.animate("x", ANCHURA_CELDA * col + INICIO_X);
					tweenPrueba2.animate("y", ALTURA_CELDA * fil + INICIO_Y - 4);
					tweenPrueba2.animate("scaleX", 1);
					tweenPrueba2.animate("scaleY", 1);
					Starling.juggler.add(tweenPrueba2);
					tweenPrueba2.onComplete = borrarImagen;
					tweenPrueba2.onCompleteArgs = [imagenTirar];
					_bolasConPuntosQueTengo--;
				}
				else{
					if(_bolasConTiempoQueTengo > 0){
						var imagenTirar:Image;
						imagenTirar = pasoAImagen((10 * _jugador.colorActualRetenido) + 2);
						_tablero._tableroImagenes[fil][col] = imagenTirar;
						imagenTirar.x = _jugador.jugadorImagen.x + _jugador.jugadorImagen.width / 2;
						imagenTirar.y = _jugador.jugadorImagen.y + _jugador.jugadorImagen.height / 2;
						imagenTirar.scaleX = 0;
						imagenTirar.scaleY = 0;
						addChild(imagenTirar);
						
						var tweenPrueba2:Tween = new Tween(imagenTirar, 0.3);
						tweenPrueba2.animate("x", ANCHURA_CELDA * col + INICIO_X);
						tweenPrueba2.animate("y", ALTURA_CELDA * fil + INICIO_Y - 4);
						tweenPrueba2.animate("scaleX", 1);
						tweenPrueba2.animate("scaleY", 1);
						Starling.juggler.add(tweenPrueba2);
						tweenPrueba2.onComplete = borrarImagen;
						tweenPrueba2.onCompleteArgs = [imagenTirar];
						_bolasConTiempoQueTengo--;
					}
				}
			}
			if(tweenPrueba2!=null){
				if (numeroBolaTirada == _numeroBolasQueTengo) 
				{
					tweenPrueba2.onComplete = accionTirar;
					tweenPrueba2.onCompleteArgs = [col];
				}
				if (numeroBolaTirada < _numeroBolasQueTengo && fil == 12) {
						tweenPrueba2.onComplete = accionTirar;
						tweenPrueba2.onCompleteArgs = [col];
				}
			}
			
		}
		
		/* Acción fisica sobre el tablero de tirar las bolas y activa los respectivos booleanos...
		 * ... que controlan las animaciones de la explosion de bolas y bombas
		 */
		private function accionTirar(col:int):void
		{
			_estaHaciendoAnimacion = false;
			
			if (_heCanceladoAñadirFila) {
				_tablero.añadirFilaRandom();
				_heCanceladoAñadirFila = false;
			}
			
			_arrayDevuelveTirarBolas = _jugador.tirarBolas(col);
			borrarImagen(_imagenBolaTengo);
			_numeroBolasMensaje.text = " ";
			
			if (_arrayDevuelveTirarBolas[1]) {
				
				_chronoSecondsPassed = _chronoSecondsPassed + (_arrayDevuelveTirarBolas[0] * 20);// añadimos segundos si explotamos correspondiente bola
				_puntuacionMensaje.text = _jugador.puntuacionActual.toString();
				pintarTablero();
				
				if (_jugador.puntuacionActual > 250 && _jugador.puntuacionActual < 750 && _booleanoPrimerTiempo) {
					_booleanoPrimerTiempo = false;
					_moveTimer.delay = 3250;
				}
				if (_jugador.puntuacionActual > 750 && _jugador.puntuacionActual < 1250 && _booleanoSegundoTiempo) {
					_booleanoSegundoTiempo = false;
					_moveTimer.delay = 3000;
				}
				if (_jugador.puntuacionActual > 1250 && _jugador.puntuacionActual < 1750 && _booleanoTercerTiempo) {
					_booleanoTercerTiempo = false;
					_moveTimer.delay = 2750;
				}
				if (_jugador.puntuacionActual > 1750 && _jugador.puntuacionActual < 2250 && _booleanoCuartoTiempo) {
					_booleanoCuartoTiempo = false;
					_moveTimer.delay = 2500;
				}
				if (_jugador.puntuacionActual > 2250 && _jugador.puntuacionActual < 2500 && _booleanoQuintoTiempo) {
					_booleanoQuintoTiempo = false;
					_moveTimer.delay = 2225;
				}
				if (_jugador.puntuacionActual > 2500 && _jugador.puntuacionActual < 3250 && _booleanoSextoTiempo ) {
					_booleanoSextoTiempo = false;	
					_moveTimer.delay = 2000;
				}
				if (_jugador.puntuacionActual > 3250 && _jugador.puntuacionActual < 3750  && _booleanoSeptimoTiempo) {
					_booleanoSeptimoTiempo = false;	
					_moveTimer.delay = 1750;
				}
				if (_jugador.puntuacionActual > 3750 && _booleanoOctavoTiempo) {
					_booleanoOctavoTiempo = false;	
					_moveTimer.delay = 1500;
				}
				
			}
			else {
				pintarTablero();
			}
			
			if (_tablero.ArrayExploBolas.length != 0) {
				_hayExplosionBolas = true;
			}
			
			if(_tablero.ArrayExplosiones.length != 0){
				_hayExplosionBomba = true;
			}
			
		}
		
		/* Muestra la bola del color que tenemos retenida y el numero de bolas de ese ...
		 * ...color que tenemos retenidas
		 */
		private function masBolasQueTengo(numeroBolas:int,colorBolas:int):void
		{
			_imagenBolaTengo = pasoAImagen(colorBolas * 10);
			_imagenBolaTengo.x = 862;
			_imagenBolaTengo.y = 494;
			_imagenBolaTengo.scaleX = 0.75;
			_imagenBolaTengo.scaleY = 0.75;
			addChild(_imagenBolaTengo);
			
			_numeroBolasQueTengo = _numeroBolasQueTengo + numeroBolas;
			_numeroBolasMensaje.text = "x" + _numeroBolasQueTengo;
			_numeroBolasMensaje.x = 902;
			_numeroBolasMensaje.y = 494;
			
		}
		
		/*Borra imgenes de la columna que le pasemos en funcion de como este el tablero*/
		private function borrarImagenesDeColumna():void
		{
			for (var i:int = 0; i < NUM_FILAS ; i++ ) {
				if (_tablero._tablero[i][_columna] == -1) {
						animacionBorrar(_tablero._tableroImagenes[i][_columna]);
				}
			}
		}	
	}

}