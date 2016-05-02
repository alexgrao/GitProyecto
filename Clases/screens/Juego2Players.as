package screens 
{
	import flash.events.TimerEvent;
	import flash.system.ImageDecodingPolicy;
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
		/*-------------------*/
		/*****CONSTANTES******/
		private const ANCHURA_CELDA:int = 40;
		private const ALTURA_CELDA:int = 40;
		private const NUM_FILAS:int = 13;
		private const NUM_COLUMNAS:int = 7;
		
		private const INICIO_X_IZQ:int = 170;
		private const INICIO_X_DER:int = 750;
		private const INICIO_Y:int = 25;
		
		/*-------------------*/
		/*****EXPLOSIONES*****/
		private var _numExplosionesBombasIzq:int;
		private var _numExplosionesBombasDer:int;
		private var _hayExplosionBombaIzq:Boolean;
		private var _hayExplosionBombaDer:Boolean;
		
		private var _numExplosionesBolasIzq:int;
		private var _numExplosionesBolasDer:int;
		private var _hayExplosionBolasIzq:Boolean;
		private var _hayExplosionBolasDer:Boolean;
		
		/*-------------------*/
		/********IMAGE********/
		private var _img:Image;
		
		private var _imagenBolaTengoIzq:Image;
		private var _imagenBolaTengoDer:Image;
		
		private var _hub:Image;	
		
		/*-------------------*/
		/******TEXTFIELD******/
		private var _numeroBolasMensajeIzq:TextField;
		private var _numeroBolasMensajeDer:TextField;
		private var _puntuacionMensajeIzq:TextField;
		private var _puntuacionMensajeDer:TextField;
		
		/*------------------*/
		/*******OBJECT*******/
		private var _ObjNumeroBolasQueTengoIzq:Object;
		private var _ObjNumeroBolasQueTengoDer:Object;
		
		private var _ObjBolasConNormalesQueTengoIzq:Object;
		private var _ObjBolasConTiempoQueTengoIzq:Object;
		private var _ObjBolasConPuntosQueTengoIzq:Object;
		private var _ObjBolasConNormalesQueTengoDer:Object;
		private var _ObjBolasConTiempoQueTengoDer:Object;
		private var _ObjBolasConPuntosQueTengoDer:Object;
		
		/*-------------------*/
		/****ARRAY DEVULVE****/
		private var _arrayDevuelveTirarBolasIzq:Array;
		private var _arrayDevuelveTirarBolasDer:Array;
		private var _arrayDevuelveSuccionarIzq:Array;
		private var _arrayDevuelveSuccionarDer:Array;	
		
		 /*-------------------*/
		 /********TIME*********/
		private var _moveTimer:Timer = new Timer(4000);
		private var _chrono:Timer;
		private var _chronoMensaje:TextField;
		private var _chronoSecondsPassed:uint;
		
		/*-------------------*/
		
		private var _timerAnimacion:Timer = new Timer(250);
		
		private var _columnaIzq:int;
		private var _columnaDer:int;
		
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
		
		private var _tableroIzq:Tablero;
		private var _tableroDer:Tablero;
		
		private var _indicadorIzq:Indicador;
		private var _indicadorDer:Indicador;
		
		private var _jugadorIzq:Jugador;
		private var _jugadorDer:Jugador;
		
		private var _pantallaFinJuego:PantallaFinJuego;
		
		/* CONTRUCTOR DE LA CLASE */
		public function Juego2Players() 
		{
			super();
			
			_ObjNumeroBolasQueTengoIzq = { num:0 };
			_ObjNumeroBolasQueTengoDer = { num:0 };
			
			_ObjBolasConNormalesQueTengoDer = { numero:0 };
			_ObjBolasConNormalesQueTengoIzq = { numero:0 };
			_ObjBolasConPuntosQueTengoDer = { numero:0 };
			_ObjBolasConPuntosQueTengoIzq = { numero:0 };
			_ObjBolasConTiempoQueTengoDer = { numero:0 };
			_ObjBolasConTiempoQueTengoIzq = { numero:0 };
			
			_numExplosionesBombasIzq = 0;
			_numExplosionesBombasDer = 0;
			_hayExplosionBombaIzq = false;
			_hayExplosionBombaDer = false;
			
			_numExplosionesBolasIzq = 0;
			_numExplosionesBolasDer = 0;
			_hayExplosionBolasIzq = false;
			_hayExplosionBolasDer = false;
			
			_estaHaciendoAnimacion = false;
			_heCanceladoAñadirFila = false;
			
			
			_tableroIzq = new Tablero();
			_tableroDer = new Tablero();
			
			_jugadorIzq = new Jugador(_tableroIzq, 1);
			_jugadorDer = new Jugador(_tableroDer, 1);
			
			_indicadorIzq = new Indicador();
			_indicadorDer = new Indicador();
			
			Assets.createArrayTextures();
			
			_columnaIzq = 3;
			_columnaDer = 3;
						
			_puntuacionMensajeIzq = new TextField(300, 300, _jugadorIzq.puntuacionActual.toString(), Assets.getFont().name , 30, 0xffffff, true);
			_puntuacionMensajeIzq.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_puntuacionMensajeIzq.x = 23;
			_puntuacionMensajeIzq.y = 433;
			
			_puntuacionMensajeDer = new TextField(300, 300, _jugadorDer.puntuacionActual.toString(), Assets.getFont().name , 30, 0xffffff, true);
			_puntuacionMensajeDer.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_puntuacionMensajeDer.x = 1050;
			_puntuacionMensajeDer.y = 433;
			
			
			_numeroBolasMensajeIzq = new TextField(0, 0, " ", Assets.getFont().name , 28, 0xffffff, true);
			_numeroBolasMensajeIzq.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_numeroBolasMensajeIzq.scaleX *= 0.9;
			_numeroBolasMensajeIzq.scaleY *= 0.9;
			
			_numeroBolasMensajeDer = new TextField(0, 0, " ", Assets.getFont().name , 28, 0xffffff, true);
			_numeroBolasMensajeDer.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_numeroBolasMensajeDer.scaleX *= 0.9;
			_numeroBolasMensajeDer.scaleY *= 0.9;
			
			
			_moveTimer.addEventListener(TimerEvent.TIMER ,moveTimerHandler);
			_moveTimer.start();
			
			_timerAnimacion.addEventListener(TimerEvent.TIMER, animacionBorrar)
			
			_booleanoPrimerTiempo = true;
			_booleanoSegundoTiempo = true;
			_booleanoTercerTiempo = true;
			_booleanoCuartoTiempo = true;
			_booleanoQuintoTiempo = true;
			_booleanoSextoTiempo = true;
			_booleanoSeptimoTiempo = true;
			_booleanoOctavoTiempo = true;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, playGame);
			addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			
		}
		 
		/* Clase en la que cada vez que salte el event TimerEvent baja una fila en los tablero
		  */
		private function moveTimerHandler(e:TimerEvent):void 
		{
			if(_estaHaciendoAnimacion == false){
				_tableroIzq.añadirFilaRandom();
				pintarTablero(_tableroIzq, INICIO_X_IZQ);
				_tableroDer.añadirFilaRandom();
				pintarTablero(_tableroDer, INICIO_X_DER);
			}
			else {
				_heCanceladoAñadirFila = true;
			}
		}
		
		/* Clase que controla la entrada de teclado y hace que se muevan los personajes y ...
		 * ...tiren o recogan bolas
		 */
		private function checkKeysDown(e:KeyboardEvent):void 
		{
			//Movimiento
				//Izquierda
			if (e.keyCode == 68) 
			{
				if (_columnaIzq > 0) _columnaIzq--;
			}
			
			if (e.keyCode == 71) 
			{
				if (_columnaIzq < 6) _columnaIzq++;
				
			}
				//Derecha
			if (e.keyCode == 37) 
			{
				if (_columnaDer > 0) _columnaDer--;
			}
			
			if (e.keyCode == 39) 
			{
				if (_columnaDer < 6) _columnaDer++;
				
			}
			
			//Coger y soltar bolas
				//Izquierda
			if (e.keyCode == 65) //coger
			{
				var primerColorColumnaIzq:int = _tableroIzq.comprobarPrimerColorColumna(_columnaIzq);
				if(primerColorColumnaIzq != -1){
					_arrayDevuelveSuccionarIzq = _jugadorIzq.succionar(_columnaIzq);
					_ObjBolasConNormalesQueTengoIzq.numero = _jugadorIzq.bolasActualesNormalesRetenidas;
					_ObjBolasConPuntosQueTengoIzq.numero = _jugadorIzq.bolasActualesPuntosRetenidas;
					_ObjBolasConTiempoQueTengoIzq.numero = _jugadorIzq.bolasActualesTiempoRetenidas;
					if (_arrayDevuelveSuccionarIzq[1] > 0 && (primerColorColumnaIzq == _arrayDevuelveSuccionarIzq[0])) {
						borrarImagen(_imagenBolaTengoIzq);
						_imagenBolaTengoIzq = pasoAImagen(_arrayDevuelveSuccionarIzq[0] * 10);
						addChild(_imagenBolaTengoIzq);
						masBolasQueTengo(_arrayDevuelveSuccionarIzq[1],
										 _numeroBolasMensajeIzq, _imagenBolaTengoIzq, _ObjNumeroBolasQueTengoIzq,
										 30, 536);
					}
					borrarImagenesDeColumna(_tableroIzq, _columnaIzq, _jugadorIzq);
				}
			}
			
			if (e.keyCode == 83) //tirar
			{
				var columnaCopia:int = _columnaIzq;
				if (_jugadorIzq.colorActualRetenido != 0) {
					tirar(columnaCopia, _tableroIzq, _ObjNumeroBolasQueTengoIzq,
							_ObjBolasConNormalesQueTengoIzq, _ObjBolasConPuntosQueTengoIzq,
							_ObjBolasConTiempoQueTengoIzq, _jugadorIzq, _tableroIzq, _imagenBolaTengoIzq,
							_arrayDevuelveTirarBolasIzq, _numeroBolasMensajeIzq, _puntuacionMensajeIzq,
							INICIO_X_IZQ);
				}
			}
				//Derecha
			if (e.keyCode == 75) //coger
			{
				var primerColorColumnaDer:int = _tableroDer.comprobarPrimerColorColumna(_columnaDer);
				if(primerColorColumnaDer != -1){
					_arrayDevuelveSuccionarDer = _jugadorDer.succionar(_columnaDer);
					_ObjBolasConNormalesQueTengoDer.numero = _jugadorDer.bolasActualesNormalesRetenidas;
					_ObjBolasConPuntosQueTengoDer.numero = _jugadorDer.bolasActualesPuntosRetenidas;
					_ObjBolasConTiempoQueTengoDer.numero = _jugadorDer.bolasActualesTiempoRetenidas;
					if (_arrayDevuelveSuccionarDer[1] > 0 && (primerColorColumnaDer == _arrayDevuelveSuccionarDer[0])) {
						borrarImagen(_imagenBolaTengoDer);
						_imagenBolaTengoDer = pasoAImagen(_arrayDevuelveSuccionarDer[0] * 10);
						addChild(_imagenBolaTengoDer);
						masBolasQueTengo(_arrayDevuelveSuccionarDer[1],
										 _numeroBolasMensajeDer, _imagenBolaTengoDer, _ObjNumeroBolasQueTengoDer,
										 1060, 536);
					}
					borrarImagenesDeColumna(_tableroDer, _columnaDer, _jugadorDer);
				}
			}
			
			if (e.keyCode == 76) //tirar
			{
				var columnaCopia:int = _columnaDer;
				if (_jugadorDer.colorActualRetenido != 0) {
					tirar(columnaCopia, _tableroDer, _ObjNumeroBolasQueTengoDer,
							_ObjBolasConNormalesQueTengoDer, _ObjBolasConPuntosQueTengoDer,
							_ObjBolasConTiempoQueTengoDer, _jugadorDer, _tableroDer, _imagenBolaTengoDer,
							_arrayDevuelveTirarBolasDer, _numeroBolasMensajeDer, _puntuacionMensajeDer,
							INICIO_X_DER);
				}
			}
			
		}
		
		/* Clase que mediante un for tira las bolas que tengamos...
		 * ...llamando a animaciónTirar con cada bola
		 */
		private function tirar(col:int, tablero:Tablero, numeroBolasQueTengo:Object,
								bolasConNormalesQueTengo:Object, bolasConPuntosQueTengo:Object, bolasConTiempoQueTengo:Object,
								jugador:Jugador, tablero:Tablero, imagenBolaTengo:Image,
								arrayDevuelveTirarBolasIzq:Array, numeroBolasMensaje:TextField,
								puntuacionMensaje:TextField, inicioX:int) 
		{
			
			var bolasAtirar:int = 1;
			for (var i:int = 0; i < NUM_FILAS ; i++)
			{
				if (tablero._tablero[i][col] == -1) 
				{					
					if (bolasAtirar <= numeroBolasQueTengo.num) {
						animacionTirar(i, col, bolasAtirar, numeroBolasQueTengo,
										bolasConNormalesQueTengo, bolasConPuntosQueTengo,
										bolasConTiempoQueTengo,	jugador, tablero, imagenBolaTengo,
										arrayDevuelveTirarBolasIzq, numeroBolasMensaje, puntuacionMensaje,
										inicioX);
						bolasAtirar++;
					}
					else break;
				}
			}
			numeroBolasQueTengo.num = 0;
		}
		
		/* Hace la animacion de tirar con Tween de cada bola que tengamos cogida y...
		 * ...si ha tirado todas la bolas llama a otra función que hace la acción...
		 * ...fisica de tirarlas en el tablero.
		 */
		private function animacionTirar(fil:int, col:int, numeroBolaTirada:int, numeroBolasQueTengo:Object,
										bolasConNormalesQueTengo:Object, bolasConPuntosQueTengo:Object,
										bolasConTiempoQueTengo:Object,	jugador:Jugador, tablero:Tablero,
										imagenBolaTengo:Image, arrayDevuelveTirarBolas:Array,
										numeroBolasMensaje:TextField, puntuacionMensaje:TextField,
										inicioX:int)
		{
			_estaHaciendoAnimacion = true;
			if (bolasConNormalesQueTengo.numero > 0) {
				var imagenTirar:Image;
				imagenTirar = pasoAImagen(10 * jugador.colorActualRetenido);
				tablero._tableroImagenes[fil][col] = imagenTirar;
				imagenTirar.x = jugador.jugadorImagen.x + jugador.jugadorImagen.width / 2;
				imagenTirar.y = jugador.jugadorImagen.y + jugador.jugadorImagen.height / 2;
				imagenTirar.scaleX = 0;
				imagenTirar.scaleY = 0;
				addChild(imagenTirar);
				
				var tweenPrueba2:Tween = new Tween(imagenTirar, 0.3);
				tweenPrueba2.animate("x", ANCHURA_CELDA * col + inicioX);
				tweenPrueba2.animate("y", ALTURA_CELDA * fil + INICIO_Y - 4);
				tweenPrueba2.animate("scaleX", 1);
				tweenPrueba2.animate("scaleY", 1);
				Starling.juggler.add(tweenPrueba2);
				tweenPrueba2.onComplete = borrarImagen;
				tweenPrueba2.onCompleteArgs = [imagenTirar];
				bolasConNormalesQueTengo.numero--;
			}
			else {
				if(bolasConPuntosQueTengo.numero > 0){
					var imagenTirar:Image;
					imagenTirar = pasoAImagen((10 * jugador.colorActualRetenido) + 1);
					tablero._tableroImagenes[fil][col] = imagenTirar;
					imagenTirar.x = jugador.jugadorImagen.x + jugador.jugadorImagen.width / 2;
					imagenTirar.y = jugador.jugadorImagen.y + jugador.jugadorImagen.height / 2;
					imagenTirar.scaleX = 0;
					imagenTirar.scaleY = 0;
					addChild(imagenTirar);
			
					var tweenPrueba2:Tween = new Tween(imagenTirar, 0.3);
					tweenPrueba2.animate("x", ANCHURA_CELDA * col + inicioX);
					tweenPrueba2.animate("y", ALTURA_CELDA * fil + INICIO_Y - 4);
					tweenPrueba2.animate("scaleX", 1);
					tweenPrueba2.animate("scaleY", 1);
					Starling.juggler.add(tweenPrueba2);
					tweenPrueba2.onComplete = borrarImagen;
					tweenPrueba2.onCompleteArgs = [imagenTirar];
					bolasConPuntosQueTengo.numero--;
				}
				else{
					if(bolasConTiempoQueTengo.numero > 0){
						var imagenTirar:Image;
						imagenTirar = pasoAImagen((10 * jugador.colorActualRetenido) + 2);
						tablero._tableroImagenes[fil][col] = imagenTirar;
						imagenTirar.x = jugador.jugadorImagen.x + jugador.jugadorImagen.width / 2;
						imagenTirar.y = jugador.jugadorImagen.y + jugador.jugadorImagen.height / 2;
						imagenTirar.scaleX = 0;
						imagenTirar.scaleY = 0;
						addChild(imagenTirar);
						
						var tweenPrueba2:Tween = new Tween(imagenTirar, 0.3);
						tweenPrueba2.animate("x", ANCHURA_CELDA * col + inicioX);
						tweenPrueba2.animate("y", ALTURA_CELDA * fil + INICIO_Y - 4);
						tweenPrueba2.animate("scaleX", 1);
						tweenPrueba2.animate("scaleY", 1);
						Starling.juggler.add(tweenPrueba2);
						tweenPrueba2.onComplete = borrarImagen;
						tweenPrueba2.onCompleteArgs = [imagenTirar];
						bolasConTiempoQueTengo.numero--;
					}
				}
			}
			
			if (numeroBolaTirada == numeroBolasQueTengo.num) 
			{
				tweenPrueba2.onComplete = accionTirar;
				tweenPrueba2.onCompleteArgs = [col, tablero, jugador, imagenBolaTengo, arrayDevuelveTirarBolas,
												numeroBolasMensaje, puntuacionMensaje, inicioX];
			}
			if (numeroBolaTirada < numeroBolasQueTengo.num && fil == 12) {
					tweenPrueba2.onComplete = accionTirar;
					tweenPrueba2.onCompleteArgs = [col, tablero, jugador, imagenBolaTengo, arrayDevuelveTirarBolas,
													numeroBolasMensaje, puntuacionMensaje, inicioX];
			}
			
		}
		
		/* Acción fisica sobre el tablero de tirar las bolas y activa los respectivos booleanos...
		 * ... que controlan las animaciones de la explosion de bolas y bombas
		 */
		private function accionTirar(col:int, tablero:Tablero, jugador:Jugador, imagenBolaTengo:Image,
									arrayDevuelveTirarBolas:Array, numeroBolasMensaje:TextField,
									puntuacionMensaje:TextField, inicioX:int):void
		{
			_estaHaciendoAnimacion = false;
			
			if (_heCanceladoAñadirFila) {
				_tableroIzq.añadirFilaRandom();
				pintarTablero(_tableroIzq, INICIO_X_IZQ);
				_tableroDer.añadirFilaRandom();
				pintarTablero(_tableroDer, INICIO_X_DER);
				_heCanceladoAñadirFila = false;
			}
			
			arrayDevuelveTirarBolas = jugador.tirarBolas(col);
			borrarImagen(imagenBolaTengo);
			numeroBolasMensaje.text = " ";
			
			if (arrayDevuelveTirarBolas[1]) {
				
				_chronoSecondsPassed = _chronoSecondsPassed + (arrayDevuelveTirarBolas[0] * 20);// añadimos segundos si explotamos correspondiente bola
				puntuacionMensaje.text = jugador.puntuacionActual.toString();
				pintarTablero(tablero, inicioX);
				
				if (jugador.puntuacionActual > 250 && jugador.puntuacionActual < 750 && _booleanoPrimerTiempo) {
					_booleanoPrimerTiempo = false;
					_moveTimer.delay = 3250;
				}
				if (jugador.puntuacionActual > 750 && jugador.puntuacionActual < 1250 && _booleanoSegundoTiempo) {
					_booleanoSegundoTiempo = false;
					_moveTimer.delay = 3000;
				}
				if (jugador.puntuacionActual > 1250 && jugador.puntuacionActual < 1750 && _booleanoTercerTiempo) {
					_booleanoTercerTiempo = false;
					_moveTimer.delay = 2750;
				}
				if (jugador.puntuacionActual > 1750 && jugador.puntuacionActual < 2250 && _booleanoCuartoTiempo) {
					_booleanoCuartoTiempo = false;
					_moveTimer.delay = 2500;
				}
				if (jugador.puntuacionActual > 2250 && jugador.puntuacionActual < 2500 && _booleanoQuintoTiempo) {
					_booleanoQuintoTiempo = false;
					_moveTimer.delay = 2225;
				}
				if (jugador.puntuacionActual > 2500 && jugador.puntuacionActual < 3250 && _booleanoSextoTiempo ) {
					_booleanoSextoTiempo = false;	
					_moveTimer.delay = 2000;
				}
				if (jugador.puntuacionActual > 3250 && jugador.puntuacionActual < 3750  && _booleanoSeptimoTiempo) {
					_booleanoSeptimoTiempo = false;	
					_moveTimer.delay = 1750;
				}
				if (jugador.puntuacionActual > 3750 && _booleanoOctavoTiempo) {
					_booleanoOctavoTiempo = false;	
					_moveTimer.delay = 1500;
				}
				
			}
			else {
				pintarTablero(tablero, inicioX);
			}
			
			if (tablero.ArrayExploBolas.length != 0) {
				if(tablero == _tableroIzq){
					_hayExplosionBolasIzq = true;
				}else {
					_hayExplosionBolasDer = true;
				}
			}
			
			if (tablero.ArrayExplosiones.length != 0) {
				if(tablero == _tableroIzq){
					_hayExplosionBombaIzq = true;
				}else {
					_hayExplosionBombaDer = true;
				}
			}
			
		}
		
		/* Funcion que se llama cada Frame. mueve a los personaje, los indicadores, ...
		 * ...si hay alguna explosion inicia el proceso para llevarlas a cabo y ...
		 * ...comprueba si acaba el juego
		 */
		private function playGame(e:Event):void 
		{
			_jugadorIzq.jugadorImagen.x = comprobarPosicionXColumnaJugador(_columnaIzq, INICIO_X_IZQ) - 15;
			_jugadorDer.jugadorImagen.x = comprobarPosicionXColumnaJugador(_columnaDer, INICIO_X_DER) - 15;
		
			_indicadorIzq.indImagen.x = comprobarPosicionXColumnaJugador(_columnaIzq, INICIO_X_IZQ)
			_indicadorIzq.indImagen.y = comprobarPosicionYColumnaIndicador(_columnaIzq, _tableroIzq);
			
			_indicadorDer.indImagen.x = comprobarPosicionXColumnaJugador(_columnaDer, INICIO_X_DER)
			_indicadorDer.indImagen.y = comprobarPosicionYColumnaIndicador(_columnaDer, _tableroDer);
			
			if (_hayExplosionBombaIzq) {
				_estaHaciendoAnimacion = true;
				explotaBombas(_tableroIzq,
								_numExplosionesBombasIzq,
								INICIO_X_IZQ);
				_hayExplosionBombaIzq = false;
				_numExplosionesBombasIzq = 0;
			}
			
			if (_hayExplosionBombaDer) {
				_estaHaciendoAnimacion = true;
				explotaBombas(_tableroDer,
								_numExplosionesBombasDer,
								INICIO_X_DER);
				_hayExplosionBombaDer = false;
				_numExplosionesBombasDer = 0;
			}
			
			if (_hayExplosionBolasIzq) {
				_estaHaciendoAnimacion = true;
				explotaBolas(_tableroIzq,
								_numExplosionesBolasIzq,
								INICIO_X_IZQ);
				_hayExplosionBolasIzq = false;
				_numExplosionesBolasIzq = 0;
			}
			
			if (_hayExplosionBolasDer) {
				_estaHaciendoAnimacion = true;
				explotaBolas(_tableroDer,
								_numExplosionesBolasDer,
								INICIO_X_DER);
				_hayExplosionBolasDer = false;
				_numExplosionesBolasDer = 0;
			}
			
			watchForEnd();
		}
		
		/* hace todas las explosion de Bolas pendientes y si se cancelo en su momento ...
		 * ...bajar filas por las animaciones de subir bolas desde le personaje a su columna, se bajan
		 */
		private function explotaBolas(tablero:Tablero, numExplosionesBolas:int,
										inicioX:int):void 
		{
			numExplosionesBolas = tablero.ArrayExploBolas.length;
			
			while (numExplosionesBolas != 0) 
			{
				hacerExplosionBolas(tablero, numExplosionesBolas,
									tablero.ArrayExploBolas[numExplosionesBolas - 1][0],
									tablero.ArrayExploBolas[numExplosionesBolas - 1][1],
									inicioX);
				tablero.ArrayExploBolas.pop();
				numExplosionesBolas--;
			}
			_estaHaciendoAnimacion = false;
			
			if (_heCanceladoAñadirFila) {
				_tableroIzq.añadirFilaRandom();
				pintarTablero(_tableroIzq, INICIO_X_IZQ);
				_tableroDer.añadirFilaRandom();
				pintarTablero(_tableroDer, INICIO_X_DER);
			}
		}
		 
		/* Acción visual de la explosión de bolas 
		  */
		private function hacerExplosionBolas(tablero:Tablero, numExplosionesBolas:int,
											fil:int, col:int,
											inicioX:int):void 
		{
			tablero.ArrayExploBolas[numExplosionesBolas - 1][2].x = (col - 1) * ANCHURA_CELDA + inicioX + 20;
			tablero.ArrayExploBolas[numExplosionesBolas - 1][2].y = (fil - 1) * ALTURA_CELDA + INICIO_Y + 20;
			
			tablero.ArrayExploBolas[numExplosionesBolas - 1][2].ExploArt.play();
			addChild(tablero.ArrayExploBolas[numExplosionesBolas - 1][2]);
		}
		
		/* hace todas las explosion de Bombas pendientes 
		 */
		private function explotaBombas(tablero:Tablero, numExplosionesBombas:int,
										inicioX:int):void 
		{
			numExplosionesBombas = tablero.ArrayExplosiones.length;
			
			while (numExplosionesBombas != 0) {
				hacerExplosionBomba(tablero, numExplosionesBombas,
									tablero.ArrayExplosiones[numExplosionesBombas - 1][0],
									tablero.ArrayExplosiones[numExplosionesBombas - 1][1],
									inicioX);
				tablero.ArrayExplosiones.pop();
				numExplosionesBombas--;
			}
		}
		
		/* Acción visual de la explosión de bombas
		  */
		private function hacerExplosionBomba(tablero:Tablero, numExplosionesBombas:int,
											fil:int, col:int, inicioX:int):void 
		{
			tablero.ArrayExplosiones[numExplosionesBombas - 1][2].x = (col - 1) * ANCHURA_CELDA + inicioX;
			tablero.ArrayExplosiones[numExplosionesBombas - 1][2].y = (fil - 1) * ALTURA_CELDA + INICIO_Y;
			
			tablero.ArrayExplosiones[numExplosionesBombas - 1][2].ExploArt.play();
			addChild(tablero.ArrayExplosiones[numExplosionesBombas - 1][2]);
		}
		 
		/* Devuelve las coordenadas en Y del indicador*/
		private function comprobarPosicionYColumnaIndicador(columna:int, tablero:Tablero):int
		{
			return  ALTURA_CELDA * (comprobarUltimaFilaDeColumna(columna, tablero) + 1) + INICIO_Y;
		}
		
		/* Devuelve la ultima fila donde hay bolas de la columan*/
		private function comprobarUltimaFilaDeColumna(columna:int, tablero:Tablero):int
		{
			return tablero.BuscaUltimoEnColumna(columna);
		}
		
		/* Inicializacion del reloj del juego*/
		private function iniciarReloj():void 
		{
			_chrono = new Timer(1000);
			_chrono.addEventListener(TimerEvent.TIMER, updateChrono);
			_chrono.start();
			_chronoSecondsPassed = 120;
			_chronoMensaje = new TextField(0,0, "2:00", Assets.getFont().name, 30, 0xffffff, true);
			_chronoMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_chronoMensaje.x = 540;
			_chronoMensaje.y = 333;
			
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
		
		/* funcion que añade a la pantalla los objetos iniciales con los que se empieza*/
		private function onAddedToStage(e:Event):void 
		{
			_hub = new Image(Assets.getTexture("HUD2Player"));
			_hub.x = (stage.stageWidth / 2) - (_hub.width /2);
			addChild(_hub);
			
			addChild(_puntuacionMensajeIzq);
			addChild(_puntuacionMensajeDer);
			
			iniciarPlayer(_jugadorIzq);
			iniciarPlayer(_jugadorDer);
			
			
			iniciarIndicador(_indicadorIzq);
			iniciarIndicador(_indicadorDer);
			
			addChild(_numeroBolasMensajeIzq);
			addChild(_numeroBolasMensajeDer);
						
			//iniciarIndicador();
			
			pintarTablero(_tableroIzq, INICIO_X_IZQ);
			pintarTablero(_tableroDer, INICIO_X_DER);
			
			iniciarReloj();
		}
		
		/* Inicializacion del jugador del juego*/
		private function iniciarPlayer(jugador:Jugador):void 
		{
			jugador.jugadorImagen.y = 550;
			jugador.jugadorImagen.width = ANCHURA_CELDA + ANCHURA_CELDA/2;
			jugador.jugadorImagen.height = ALTURA_CELDA * 2;
			addChild(jugador.jugadorImagen);
		}
		
		/* Inicializacion del indicador del juego*/
		private function iniciarIndicador(indicador:Indicador):void 
		{
			indicador.indImagen.width = ANCHURA_CELDA;
			indicador.indImagen.height = ALTURA_CELDA;
		
			addChild(indicador.indImagen);
		}
		
		/* Pinta el tablero en pantalla*/
		private function pintarTablero(tablero:Tablero, inicioX:int):void
		{
			for (var i:int = 0; i < NUM_COLUMNAS ;i++ ) {
					for (var j:int = 0; j < NUM_FILAS; j++ ) {
						var imagenBola:Image = pasoAImagen(tablero._tablero[j][i]);
						if (imagenBola != null) {
							imagenBola.width = ANCHURA_CELDA;
							imagenBola.height = ALTURA_CELDA;
							imagenBola.x = ANCHURA_CELDA * i + inicioX;
							imagenBola.y = ALTURA_CELDA * j + INICIO_Y;
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
		private function comprobarPosicionXColumnaJugador(col:int, inicioX:int):int
		{
			return ANCHURA_CELDA * col + inicioX;
		}
		
		/* Muestra la bola del color que tenemos retenida y el numero de bolas de ese ...
		 * ...color que tenemos retenidas
		 */
		private function masBolasQueTengo(numeroBolas:int, numeroBolasMensaje:TextField,
										   imagenBolaTengo:Image, numeroBolasQueTengo:Object,
										   posImagenBolaX:int, posImagenBolaY:int):void
		{
			imagenBolaTengo.x = posImagenBolaX;
			imagenBolaTengo.y = posImagenBolaY;
			imagenBolaTengo.scaleX *= 0.75;
			imagenBolaTengo.scaleY *= 0.75;
			
			numeroBolasQueTengo.num = numeroBolasQueTengo.num + numeroBolas;
			
			numeroBolasMensaje.text = "x" + numeroBolasQueTengo.num;
			numeroBolasMensaje.x = posImagenBolaX + 40;
			numeroBolasMensaje.y = posImagenBolaY;
			
		}
		 /*Borra imgenes de la columna que le pasemos en funcion de como este el tablero*/
		private function borrarImagenesDeColumna(tablero:Tablero, columna:int, jugador:Jugador):void
		{
			for (var i:int = 0; i < NUM_FILAS ; i++ ) {
				if (tablero._tablero[i][columna] == -1) {
						animacionBorrar(tablero._tableroImagenes[i][columna], jugador);
				}
			}
		}
		
		/* Animacion de coger las bolas con Tween*/
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
		
		/* Borra la imagen recibida*/
		private function borrarImagen(imagenRecibida:Image):void 
		{
			if(imagenRecibida != null){
				imagenRecibida.texture.dispose();
				removeChild(imagenRecibida, true);
			}
		}
		
		/*Comprueba si el juego ha llegado a su fin*/
		private function watchForEnd():void
		{
			if (_chronoSecondsPassed == 0 || _tableroIzq.compruebaUltimaFila() || _tableroDer.compruebaUltimaFila()) //Si el crono llega a 0 o hay bola en la ultima fila
			{
					_chrono.removeEventListener(TimerEvent.TIMER, updateChrono);
					this.removeEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
					_moveTimer.removeEventListener(TimerEvent.TIMER,moveTimerHandler);
					this.removeEventListener(Event.ENTER_FRAME, playGame);
					
					removeChildren();
					
					_pantallaFinJuego = new PantallaFinJuego(_jugadorIzq.puntuacionActual.toString());
					addChild(_pantallaFinJuego);
					
			}
		}
	}

}