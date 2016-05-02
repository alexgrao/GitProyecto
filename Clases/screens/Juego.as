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
		private var numExplosionesBombas:int;
		private var hayExplosionBomba:Boolean;
		
		private var numExplosionesBolas:int;
		private var hayExplosionBolas :Boolean;
		
		
		var tablero:Tablero;
		var _jugador:Jugador;
		var _indicador:Indicador;
		
		var _jugadorElegido:int;
		
		var _imagenFondo:Image; 
		var _hub:Image;
		var _imagenBolaTengo:Image;
		
		public static var inicioX:int;
		public static var inicioY:int;
		public static var finX:int;
		public static var finY:int;
		var succionadasX:int;
		
		public static var anchuraCelda:int;
		public static var alturaCelda:int;
		var numeroFilas:int;
		var numeroColumnas:int;
		
		public static var columna:int;
		var filasTotales:int;
		
		var puntuacionMensaje:TextField;
		var numeroBolasMensaje:TextField;
		
		
		private var moveTimer:Timer = new Timer(4000);
		private var timerAnimacion:Timer = new Timer(250);
		var booleanoPrimerTiempo:Boolean;
		var booleanoSegundoTiempo:Boolean;
		var booleanoTercerTiempo:Boolean;
		var booleanoCuartoTiempo:Boolean;
		var booleanoQuintoTiempo:Boolean;
		var booleanoSextoTiempo:Boolean;
		var booleanoSeptimoTiempo:Boolean;
		var booleanoOctavoTiempo:Boolean;
		
		
		private var chrono:Timer;
		private var chronoMensaje:TextField;
		private var chronoSecondsPassed:uint;
		
		var img:Image;
		
		var arrayDevuelveTirarBolas:Array;
		var arrayDevuelveSuccionar:Array;
		
		private var pantallaFinJuego:PantallaFinJuego;
		private var numeroBolasQueTengo:int;
		private var colorBolasTengo:int;
		private var bolasConNormalesQueTengo:int;
		private var bolasConTiempoQueTengo:int;
		private var bolasConPuntosQueTengo:int;
		private var estaHaciendoAnimacion:Boolean;
		private var heCanceladoAñadirFila:Boolean;
		
		
		public function Juego(jugador_elegido:int) 
		{
			super();
			
			numExplosionesBombas = 0;
			hayExplosionBomba = false;
			
			numExplosionesBolas = 0;
			hayExplosionBolas = false;
			
			estaHaciendoAnimacion = false;
			heCanceladoAñadirFila = false;
			
			tablero = new Tablero();
			_jugador = new Jugador(tablero, jugador_elegido);
			_indicador = new Indicador();
			Assets.createArrayTextures();
			
			_jugadorElegido = jugador_elegido;
			
			inicioX = 530;
			finX = 810;
			inicioY = 25;
			finY = 5245;
			
			columna = 3;
			succionadasX = 200;
			
			numeroFilas = 13;
			numeroColumnas = 7;
			
			anchuraCelda = 40;
			alturaCelda = 40;
			
			puntuacionMensaje = new TextField(300, 300, _jugador.puntuacionActual.toString(), Assets.getFont().name , 28, 0xffffff, true);
			puntuacionMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			puntuacionMensaje.x = 330;
			puntuacionMensaje.y = 365;
			
			
			numeroBolasMensaje = new TextField(0, 0, " ", Assets.getFont().name , 28, 0xffffff, true);
			numeroBolasMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			
			
			moveTimer.addEventListener(TimerEvent.TIMER,moveTimerHandler);
			moveTimer.start();
			
			timerAnimacion.addEventListener(TimerEvent.TIMER,animacionBorrar);
			
			booleanoPrimerTiempo = true;
			booleanoSegundoTiempo = true;
			booleanoTercerTiempo = true;
			booleanoCuartoTiempo = true;
			booleanoQuintoTiempo = true;
			booleanoSextoTiempo = true;
			booleanoSeptimoTiempo = true;
			booleanoOctavoTiempo = true;
			
			numeroBolasQueTengo = 0;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, playGame);
			addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
		}
		
		private function moveTimerHandler(e:TimerEvent):void 
		{
			if(estaHaciendoAnimacion == false){
				tablero.añadirFilaRandom();
				pintarTablero();
			}
			else {
				heCanceladoAñadirFila = true;
			}
		}
		
		private function playGame(e:Event):void 
		{
			_jugador.jugadorImagen.x = comprobarPosicionXColumnaJugador(columna) - 15;
			if (columna == 3) {
				_jugador.jugadorImagen.y = 556;
			}else {
				if (columna == 2 || columna == 4) {
				_jugador.jugadorImagen.y = 553;
				}else {
					if (columna == 1 || columna == 5) {
					_jugador.jugadorImagen.y = 550;
					}else {
						_jugador.jugadorImagen.y = 548;
					}
				}
			}
			
			_indicador.indImagen.x = comprobarPosicionXColumnaJugador(columna);
			_indicador.indImagen.y = comprobarPosicionYColumnaIndicador();
			
			if (hayExplosionBomba) {
				estaHaciendoAnimacion = true;
				explotaBombas();
				hayExplosionBomba = false;
			}
			
			if (hayExplosionBolas) {
				estaHaciendoAnimacion = true;
				explotaBolas();
				hayExplosionBolas = false;
			}
			
			watchForEnd();
		}
		
		private function explotaBolas():void 
		{
			numExplosionesBolas = Tablero.ArrayExploBolas.length;
			
			while (numExplosionesBolas != 0) 
			{
				hacerExplosionBolas(Tablero.ArrayExploBolas[numExplosionesBolas - 1][0], Tablero.ArrayExploBolas[numExplosionesBolas - 1][1]);
				Tablero.ArrayExploBolas.pop();
				numExplosionesBolas--;
			}
			estaHaciendoAnimacion = false;
			
			if (heCanceladoAñadirFila) {
				tablero.añadirFilaRandom();
				heCanceladoAñadirFila = false;
			}
		}
		
		private function hacerExplosionBolas(fil:int, col:int):void 
		{
			Tablero.ArrayExploBolas[numExplosionesBolas - 1][2].x = (col - 1) * anchuraCelda + inicioX + 20;
			Tablero.ArrayExploBolas[numExplosionesBolas - 1][2].y = (fil - 1) * alturaCelda + inicioY + 20;
			
			Tablero.ArrayExploBolas[numExplosionesBolas - 1][2].ExploArt.play();
			addChild(Tablero.ArrayExploBolas[numExplosionesBolas - 1][2]);
		}
		
		private function explotaBombas():void 
		{
			numExplosionesBombas = Tablero.ArrayExplosiones.length;
			
			while (numExplosionesBombas != 0) {
				hacerExplosionBomba(Tablero.ArrayExplosiones[numExplosionesBombas - 1][0], Tablero.ArrayExplosiones[numExplosionesBombas - 1][1]);
				Tablero.ArrayExplosiones.pop();
				numExplosionesBombas--;
			}
		}
		
		private function checkKeysDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 37) 
			{
				if (columna > 0) columna--;
			}
			
			if (e.keyCode == 39) 
			{
				if (columna < 6) columna++;
				
			}
			
			if (e.keyCode == 65)
			{
				var primerColorColumna:int = tablero.comprobarPrimerColorColumna(columna);
				arrayDevuelveSuccionar = _jugador.succionar(columna);
				bolasConNormalesQueTengo = _jugador.bolasActualesNormalesRetenidas;
				bolasConPuntosQueTengo = _jugador.bolasActualesPuntosRetenidas;
				bolasConTiempoQueTengo = _jugador.bolasActualesTiempoRetenidas;
				trace(arrayDevuelveSuccionar[1]);
				if (arrayDevuelveSuccionar[1] > 0 && (primerColorColumna == arrayDevuelveSuccionar[0])) {
					borrarImagen(_imagenBolaTengo);
					masBolasQueTengo(arrayDevuelveSuccionar[1], arrayDevuelveSuccionar[0]);
				}
				borrarImagenesDeColumna();
			}
			
			if (e.keyCode == 83)
			{
				var columnaCopia:int = columna;
				if (_jugador.colorActualRetenido != 0) {
				tirar(columnaCopia);
				}
			}
		}
		
		private function hacerExplosionBomba(fil:int, col:int):void 
		{
			Tablero.ArrayExplosiones[numExplosionesBombas - 1][2].x = (col - 1) * anchuraCelda + inicioX;
			Tablero.ArrayExplosiones[numExplosionesBombas - 1][2].y = (fil - 1) * alturaCelda + inicioY;
			
			Tablero.ArrayExplosiones[numExplosionesBombas - 1][2].ExploArt.play();
			addChild(Tablero.ArrayExplosiones[numExplosionesBombas - 1][2]);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			_imagenFondo = new Image(Assets.getTexture("FondoSol"));
			_imagenFondo.x = (stage.stageWidth / 2) - (_imagenFondo.width /2);
			addChild(_imagenFondo);
			_hub = new Image(Assets.getTexture("HUD1Player"));
			_hub.x = (stage.stageWidth / 2) - (_hub.width /2);
			addChild(_hub);
			addChild(puntuacionMensaje);
			addChild(numeroBolasMensaje);
			
			iniciarPlayer();
			iniciarIndicador();
			pintarTableroPorPrimeraVez();
			iniciarReloj();
			
		}
		
		private function iniciarReloj():void 
		{
			chrono = new Timer(1000);
			chrono.addEventListener(TimerEvent.TIMER, updateChrono);
			chrono.start();
			chronoSecondsPassed = 120;
			chronoMensaje = new TextField(0,0, "2:00", Assets.getFont().name, 28, 0xffffff, true);
			chronoMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			chronoMensaje.x = 330;
			chronoMensaje.y = 493;
			
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
		
		private function iniciarPlayer():void 
		{
			//trace("Entramos en juego.iniciaPlayer");
			_jugador.jugadorImagen.y = 550;
			_jugador.jugadorImagen.width = anchuraCelda + anchuraCelda/2;
			_jugador.jugadorImagen.height = alturaCelda * 2;
			addChild(_jugador.jugadorImagen);
			//trace("Salimos en juego.iniciaPlayer");
		}
		
		private function iniciarIndicador():void 
		{
			_indicador.indImagen.width = anchuraCelda;
			_indicador.indImagen.height = alturaCelda;
		
			addChild(_indicador.indImagen);
		}
		
		private function comprobarPosicionYColumnaIndicador():int
		{
			return  alturaCelda * (comprobarUltimaFilaDeColumna(columna) + 1) + inicioY;
		}
		
		private function comprobarUltimaFilaDeColumna(columna:int):int
		{
			return tablero.BuscaUltimoEnColumna(columna);
		}
		
		private function pasoAImagen(tipoBola:int):Image
		{
			if (Math.floor(tipoBola / 10) == 1) {
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.gameTexturesArray[11]);
					
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.gameTexturesArray[12]);
					
					return img;
				}
				
				img = new Image(Assets.gameTexturesArray[10]);
				return img;
				
			}
			if (Math.floor(tipoBola / 10) == 2) {
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.gameTexturesArray[4]);
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.gameTexturesArray[5]);
					return img;
				}
				
				img = new Image(Assets.gameTexturesArray[3]);
				return img;
				
			}
			if (Math.floor(tipoBola / 10) == 3) {
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.gameTexturesArray[1]);
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.gameTexturesArray[2]);
					return img;
				}
				
				img = new Image(Assets.gameTexturesArray[0]);
				return img;
			}
			if (Math.floor(tipoBola / 10) == 4) {
				
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.gameTexturesArray[8]);
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.gameTexturesArray[9]);
					return img;
				}
				
				img = new Image(Assets.gameTexturesArray[7]);
				return img;
			}
			if (tipoBola == 0) {
				img = new Image(Assets.gameTexturesArray[6]);
				return img;
			}
			return null;
		}
		
		/*private function pasoAImagen(tipoBola:int):Image
		{
			if (Math.floor(tipoBola / 10) == 1) {
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.getAtlasBolas().getTexture("bola_Roja_puntos"));
					
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.getAtlasBolas().getTexture("bola_Roja_tiempo"));
					
					return img;
				}
				
				img = new Image(Assets.getAtlasBolas().getTexture("bola_Roja"));
				return img;
				
			}
			if (Math.floor(tipoBola / 10) == 2) {
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.getAtlasBolas().getTexture("bola_Azul_puntos"));
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.getAtlasBolas().getTexture("bola_Azul_tiempo"));
					return img;
				}
				
				img = new Image(Assets.getAtlasBolas().getTexture("bola_Azul"));
				return img;
				
			}
			if (Math.floor(tipoBola / 10) == 3) {
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.getAtlasBolas().getTexture("bola_Amarilla_puntos"));
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.getAtlasBolas().getTexture("bola_Amarilla_tiempo"));
					return img;
				}
				
				img = new Image(Assets.getAtlasBolas().getTexture("bola_Amarilla"));
				return img;
			}
			if (Math.floor(tipoBola / 10) == 4) {
				
				if (tipoBola % 10 == 1) {
					img = new Image(Assets.getAtlasBolas().getTexture("bola_Negra_puntos"));
					return img;
				}
				if (tipoBola % 10 == 2) {
					img = new Image(Assets.getAtlasBolas().getTexture("bola_Negra_tiempo"));
					return img;
				}
				
				img = new Image(Assets.getAtlasBolas().getTexture("bola_Negra"));
				return img;
			}
			if (tipoBola == 0) {
				img = new Image(Assets.getAtlasBolas().getTexture("bola_Bomba"));
				return img;
			}
			return null;
		}
		*/
		private function comprobarPosicionXColumnaJugador(col:int):int
		{
			//trace("Entramos y salimos en juego.comprobarPosicionXColumnaJugador");
			return anchuraCelda * col + inicioX;
		}
		
		private function pintarTableroPorPrimeraVez():void
		{
			for (var i:int = 0; i < numeroColumnas ;i++ ) {
					for (var j:int = 0; j < numeroFilas; j++ ) {
						var imagenBola:Image = pasoAImagen(tablero._tablero[j][i]);
						if (imagenBola != null) {
							imagenBola.width = anchuraCelda;
							imagenBola.height = alturaCelda;
							imagenBola.x = anchuraCelda * i + inicioX;
							imagenBola.y = alturaCelda * j + inicioY;
							tablero._tableroImagenes[j][i] = imagenBola;
							addChild(imagenBola);
						}
					}
			}
		}
		
		private function pintarTablero():void
		{
			var imagenBolaMolde:Image;
			for (var i:int = 0; i < numeroColumnas ;i++ ) {
					for (var j:int = 0; j < numeroFilas; j++ ) {
						var imagenBola:Image = pasoAImagen(tablero._tablero[j][i]);
						if (imagenBola != null) {
							imagenBola.width = anchuraCelda;
							imagenBola.height = alturaCelda;
							imagenBola.x = anchuraCelda * i + inicioX;
							imagenBola.y = alturaCelda * j + inicioY;
							imagenBolaMolde = tablero._tableroImagenes[j][i];
							borrarImagen(imagenBolaMolde);
							tablero._tableroImagenes[j][i] = imagenBola;
							addChild(imagenBola);
						}
						else {
						imagenBolaMolde = tablero._tableroImagenes[j][i];
						borrarImagen(imagenBolaMolde);	
						}
					}
			}
		}
		
		private function watchForEnd():void
		{
			if (chronoSecondsPassed == 0 || tablero.compruebaUltimaFila()) //Si el crono llega a 0 o hay bola en la ultima fila
			{ // faltarán añadir finales
					chrono.removeEventListener(TimerEvent.TIMER, updateChrono);
					this.removeEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
					moveTimer.removeEventListener(TimerEvent.TIMER,moveTimerHandler);
					this.removeEventListener(Event.ENTER_FRAME, playGame);
					
					removeChildren();
					
					pantallaFinJuego = new PantallaFinJuego(_jugador.puntuacionActual.toString());
					addChild(pantallaFinJuego);
					
			}
		}
		
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
		
		private function borrarImagen(imagenRecibida:Image):void 
		{
			if(imagenRecibida != null){
				imagenRecibida.texture.dispose();
				removeChild(imagenRecibida, true);
			}
		}
		
		private function tirar(col:int) 
		{
			var bolasAtirar:int = 1;
			for (var i:int = 0; i < numeroFilas ; i++)
			{
				if (tablero._tablero[i][col] == -1) 
				{
					if (bolasAtirar <= numeroBolasQueTengo) {
							animacionTirar(i, col, bolasAtirar);
							bolasAtirar++;
					}
					else break;
				}
			}
			numeroBolasQueTengo = 0;
		}
		
		private function animacionTirar(fil:int, col:int, numeroBolaTirada:int)
		{
			estaHaciendoAnimacion = true;
			if(bolasConNormalesQueTengo > 0){
				var imagenTirar:Image;
				imagenTirar = pasoAImagen(10 * _jugador.colorActualRetenido);
				tablero._tableroImagenes[fil][col] = imagenTirar;
				imagenTirar.x = _jugador.jugadorImagen.x + _jugador.jugadorImagen.width / 2;
				imagenTirar.y = _jugador.jugadorImagen.y + _jugador.jugadorImagen.height / 2;
				imagenTirar.scaleX = 0;
				imagenTirar.scaleY = 0;
				addChild(imagenTirar);
				
				var tweenPrueba2:Tween = new Tween(imagenTirar, 0.3);
				tweenPrueba2.animate("x", anchuraCelda * col + inicioX);
				tweenPrueba2.animate("y", alturaCelda * fil + inicioY - 4);
				tweenPrueba2.animate("scaleX", 1);
				tweenPrueba2.animate("scaleY", 1);
				Starling.juggler.add(tweenPrueba2);
				tweenPrueba2.onComplete = borrarImagen;
				tweenPrueba2.onCompleteArgs = [imagenTirar];
				bolasConNormalesQueTengo--;
			}
			else{
				if(bolasConPuntosQueTengo > 0){
					var imagenTirar:Image;
					imagenTirar = pasoAImagen((10 * _jugador.colorActualRetenido) + 1);
					tablero._tableroImagenes[fil][col] = imagenTirar;
					imagenTirar.x = _jugador.jugadorImagen.x + _jugador.jugadorImagen.width / 2;
					imagenTirar.y = _jugador.jugadorImagen.y + _jugador.jugadorImagen.height / 2;
					imagenTirar.scaleX = 0;
					imagenTirar.scaleY = 0;
					addChild(imagenTirar);
			
					var tweenPrueba2:Tween = new Tween(imagenTirar, 0.3);
					tweenPrueba2.animate("x", anchuraCelda * col + inicioX);
					tweenPrueba2.animate("y", alturaCelda * fil + inicioY - 4);
					tweenPrueba2.animate("scaleX", 1);
					tweenPrueba2.animate("scaleY", 1);
					Starling.juggler.add(tweenPrueba2);
					tweenPrueba2.onComplete = borrarImagen;
					tweenPrueba2.onCompleteArgs = [imagenTirar];
					bolasConPuntosQueTengo--;
				}
				else{
					if(bolasConTiempoQueTengo > 0){
						var imagenTirar:Image;
						imagenTirar = pasoAImagen((10 * _jugador.colorActualRetenido) + 2);
						tablero._tableroImagenes[fil][col] = imagenTirar;
						imagenTirar.x = _jugador.jugadorImagen.x + _jugador.jugadorImagen.width / 2;
						imagenTirar.y = _jugador.jugadorImagen.y + _jugador.jugadorImagen.height / 2;
						imagenTirar.scaleX = 0;
						imagenTirar.scaleY = 0;
						addChild(imagenTirar);
						
						var tweenPrueba2:Tween = new Tween(imagenTirar, 0.3);
						tweenPrueba2.animate("x", anchuraCelda * col + inicioX);
						tweenPrueba2.animate("y", alturaCelda * fil + inicioY - 4);
						tweenPrueba2.animate("scaleX", 1);
						tweenPrueba2.animate("scaleY", 1);
						Starling.juggler.add(tweenPrueba2);
						tweenPrueba2.onComplete = borrarImagen;
						tweenPrueba2.onCompleteArgs = [imagenTirar];
						bolasConTiempoQueTengo--;
					}
				}
			}
			if(tweenPrueba2!=null){
				if (numeroBolaTirada == numeroBolasQueTengo) 
				{
					tweenPrueba2.onComplete = accionTirar;
					tweenPrueba2.onCompleteArgs = [col];
				}
				if (numeroBolaTirada < numeroBolasQueTengo && fil == 12) {
					tweenPrueba2.onComplete = accionTirar;
					tweenPrueba2.onCompleteArgs = [col];
				}
			}
		}
		
		private function accionTirar(col:int):void
		{
			estaHaciendoAnimacion = false;
			
			if (heCanceladoAñadirFila) {
				tablero.añadirFilaRandom();
				heCanceladoAñadirFila = false;
			}
			
			arrayDevuelveTirarBolas = _jugador.tirarBolas(col);
			borrarImagen(_imagenBolaTengo);
			numeroBolasMensaje.text = " ";
			
			if (arrayDevuelveTirarBolas[1]) {
				
				chronoSecondsPassed = chronoSecondsPassed + (arrayDevuelveTirarBolas[0] * 20);// añadimos segundos si explotamos correspondiente bola
				puntuacionMensaje.text = _jugador.puntuacionActual.toString();
				pintarTablero();
				tablero.imprime();
				
				if (_jugador.puntuacionActual > 250 && _jugador.puntuacionActual < 750 && booleanoPrimerTiempo) {
								booleanoPrimerTiempo = false;
								moveTimer.delay = 3250;
						}
						if (_jugador.puntuacionActual > 750 && _jugador.puntuacionActual < 1250 && booleanoSegundoTiempo) {
								booleanoSegundoTiempo = false;
								moveTimer.delay = 3000;
						}
						if (_jugador.puntuacionActual > 1250 && _jugador.puntuacionActual < 1750 && booleanoTercerTiempo) {
								booleanoTercerTiempo = false;
								moveTimer.delay = 2750;
						}
						if (_jugador.puntuacionActual > 1750 && _jugador.puntuacionActual < 2250 && booleanoCuartoTiempo) {
								booleanoCuartoTiempo = false;
								moveTimer.delay = 2500;
						}
						if (_jugador.puntuacionActual > 2250 && _jugador.puntuacionActual < 2500 && booleanoQuintoTiempo) {
								booleanoQuintoTiempo = false;
								moveTimer.delay = 2225;
						}
						if (_jugador.puntuacionActual > 2500 && _jugador.puntuacionActual < 3250 && booleanoSextoTiempo ) {
							booleanoSextoTiempo = false;	
							moveTimer.delay = 2000;
						}
						if (_jugador.puntuacionActual > 3250 && _jugador.puntuacionActual < 3750  && booleanoSeptimoTiempo) {
							booleanoSeptimoTiempo = false;	
							moveTimer.delay = 1750;
						}
						if (_jugador.puntuacionActual > 3750 && booleanoOctavoTiempo) {
							booleanoOctavoTiempo = false;	
							moveTimer.delay = 1500;
						}
				
			}
			else {
				pintarTablero();
			}
			
			if (Tablero.ArrayExploBolas.length != 0) {
				hayExplosionBolas = true;
			}
			
			if(Tablero.ArrayExplosiones.length != 0){
				hayExplosionBomba = true;
			}
			
		}
		
		private function masBolasQueTengo(numeroBolas:int,colorBolas:int):void
		{
			_imagenBolaTengo = pasoAImagen(colorBolas * 10);
			_imagenBolaTengo.x = 862;
			_imagenBolaTengo.y = 494;
			_imagenBolaTengo.scaleX = 0.75;
			_imagenBolaTengo.scaleY = 0.75;
			addChild(_imagenBolaTengo);
			
			numeroBolasQueTengo = numeroBolasQueTengo + numeroBolas;
			numeroBolasMensaje.text = "x" + numeroBolasQueTengo;
			numeroBolasMensaje.x = 902;
			numeroBolasMensaje.y = 494;
			
		}
		
		private function borrarImagenesDeColumna():void
		{
			for (var i:int = 0; i < numeroFilas ; i++ ) {
				if (tablero._tablero[i][columna] == -1) {
						animacionBorrar(tablero._tableroImagenes[i][columna]);
				}
			}
		}	
	}

}