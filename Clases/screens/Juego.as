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
		private var explosion:AnimacionExplosion;
		public static var _haExplotado:Boolean;
		
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
		
		
		private var chrono:Timer;
		private var chronoMensaje:TextField;
		private var chronoSecondsPassed:uint;
		
		var img:Image;
		
		var arrayDevuelveTirarBolas:Array;
		var arrayDevuelveSuccionar:Array;
		
		private var pantallaFinJuego:PantallaFinJuego;
		private var numeroBolasQueTengo:int;
		
		
		public function Juego(jugador_elegido:int) 
		{
			super();
			
			explosion = new AnimacionExplosion();
			_haExplotado = false;
			
			tablero = new Tablero();
			_jugador = new Jugador(tablero, jugador_elegido);
			_indicador = new Indicador();
			
			_jugadorElegido = jugador_elegido;
			
			inicioX = 530;
			finX = 810;
			inicioY = 25;
			finY = 5245;
			
			columna = 4;
			succionadasX = 200;
			
			numeroFilas = 13;
			numeroColumnas = 7;
			
			anchuraCelda = 40;
			alturaCelda = 40;
			
			puntuacionMensaje = new TextField(300, 300, _jugador.puntuacionActual.toString(), Assets.getFont().name , 72, 0xffffff, true);
			puntuacionMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			puntuacionMensaje.x = 100;
			puntuacionMensaje.y = 100;
			
			
			moveTimer.addEventListener(TimerEvent.TIMER,moveTimerHandler);
			moveTimer.start();
			
			timerAnimacion.addEventListener(TimerEvent.TIMER,animacionBorrar);
			
			booleanoPrimerTiempo = true;
			booleanoSegundoTiempo = true;
			booleanoTercerTiempo = true;
			booleanoCuartoTiempo = true;
			
			numeroBolasQueTengo = 0;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, playGame);
			addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
		}
		
		private function moveTimerHandler(e:TimerEvent):void 
		{
			trace("Entramos en juego.moveTimerHandler");
			tablero.añadirFilaRandom();
			pintarTablero();
			
			trace("salimos en juego.moveTimerHandler");
		}
		
		private function playGame(e:Event):void 
		{
			_jugador.jugadorImagen.x = comprobarPosicionXColumnaJugador(columna);
			
			_indicador.indImagen.x = comprobarPosicionXColumnaJugador(columna);
			_indicador.indImagen.y = comprobarPosicionYColumnaIndicador();
			
			if (_haExplotado == true ) {
				explota(tablero.filBomba, tablero.colBomba);
				_haExplotado = false;
			}
			
			comprobarExplosion();
			
			watchForEnd();
		}
		
		private function comprobarExplosion():void 
		{
			if (explosion.ExploArt.isPlaying == false) {
				explosion.ExploArt.stop();
				removeChild(explosion);
			}
		}
		
		private function checkKeysDown(e:KeyboardEvent):void
		{
			//trace("Entramos en juego.checkKeyDown");
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
				trace(arrayDevuelveSuccionar[1]);
				if (arrayDevuelveSuccionar[1] > 0 && (primerColorColumna == arrayDevuelveSuccionar[0])) {
					removeChild(numeroBolasMensaje);
					removeChild(_imagenBolaTengo);
					masBolasQueTengo(arrayDevuelveSuccionar[1], arrayDevuelveSuccionar[0]);
				}
				borrarImagenesDeColumna();
				tablero.imprime();
			}
			
			if (e.keyCode == 83)
			{
				if (_jugador.colorActualRetenido != 0) {
				arrayDevuelveTirarBolas = _jugador.tirarBolas(columna);
				numeroBolasQueTengo = 0;
				removeChild(_imagenBolaTengo);
				removeChild(numeroBolasMensaje);
					if (arrayDevuelveTirarBolas[1]) {
						chronoSecondsPassed = chronoSecondsPassed + (arrayDevuelveTirarBolas[0] * 20);// añadimos segundos si explotamos correspondiente bola
						puntuacionMensaje.text = _jugador.puntuacionActual.toString();
						pintarTablero();
						tablero.imprime();
						if (_jugador.puntuacionActual > 500 && _jugador.puntuacionActual < 1000 && booleanoPrimerTiempo) {
								booleanoPrimerTiempo = false;
								moveTimer.delay = 3000;
						}
						if (_jugador.puntuacionActual > 2000 && _jugador.puntuacionActual < 2500 && booleanoSegundoTiempo) {
								booleanoSegundoTiempo = false;
								moveTimer.delay = 2500;
						}
						if (_jugador.puntuacionActual > 2500 && _jugador.puntuacionActual < 3000 && booleanoTercerTiempo ) {
							booleanoTercerTiempo = false;	
							moveTimer.delay = 2000;
						}
						if (_jugador.puntuacionActual > 3000 && booleanoCuartoTiempo) {
							booleanoCuartoTiempo = false;	
							moveTimer.delay = 1500;
						}
						
					}
					else{
						pintarTablero();
					}
				}
			}
			//trace("Salimos en juego.checkKeyDown");
		}
		
		private function explota(fil:int, col:int):void 
		{
			trace("columna: " + col * anchuraCelda + inicioX);
			trace("fila: " + fil * alturaCelda + inicioY);
			
			explosion.x = (col - 1) * anchuraCelda + inicioX;
			explosion.y = (fil - 1) * alturaCelda + inicioY;
			
			explosion.ExploArt.play();
			addChild(explosion);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			_imagenFondo = new Image(Assets.getTexture("FondoLluvia"));
			_imagenFondo.x = (stage.stageWidth / 2) - (_imagenFondo.width /2);
			addChild(_imagenFondo);
			_hub = new Image(Assets.getTexture("HUD1Player"));
			_hub.x = (stage.stageWidth / 2) - (_hub.width /2);
			addChild(_hub);
			addChild(puntuacionMensaje);
			
			iniciarPlayer();
			iniciarIndicador();
			pintarTablero();
			iniciarReloj();
			
		}
		
		private function iniciarReloj():void 
		{
			chrono = new Timer(1000);
			chrono.addEventListener(TimerEvent.TIMER, updateChrono);
			chrono.start();
			chronoSecondsPassed = 120;
			chronoMensaje = new TextField(0,0, "2:00", Assets.getFont().name, 72, 0xffffff, true);
			chronoMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			chronoMensaje.x = 100;
			chronoMensaje.y = 200;
			
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
			//trace("Entramos y salimos en juego.pasoAimagen");
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
		
		private function comprobarPosicionXColumnaJugador(col:int):int
		{
			//trace("Entramos y salimos en juego.comprobarPosicionXColumnaJugador");
			return anchuraCelda * col + inicioX;
		}
		
		private function pintarTablero():void
		{
			trace("Entramos en juego.pintarTablero");
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
			trace("Salimos en juego.PintarTablero");
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
				var tweenPrueba:Tween = new Tween(imagenAeliminar, 0.75);
				tweenPrueba.animate("x", _jugador.jugadorImagen.x + _jugador.jugadorImagen.width / 2);
				tweenPrueba.animate("y", _jugador.jugadorImagen.y + _jugador.jugadorImagen.height / 2);
				tweenPrueba.animate("scaleX", 0);
				tweenPrueba.animate("scaleY", 0);
				Starling.juggler.add(tweenPrueba);
			}
		}
		
		private function masBolasQueTengo(numeroBolas:int,colorBolas:int):void
		{
			_imagenBolaTengo = pasoAImagen(colorBolas * 10);
			_imagenBolaTengo.x = 100;
			_imagenBolaTengo.y = 300;
			addChild(_imagenBolaTengo);
			numeroBolasQueTengo = numeroBolasQueTengo + numeroBolas;
			numeroBolasMensaje = new TextField(0, 0, "x" + numeroBolasQueTengo, Assets.getFont().name , 72, 0xffffff, true);
			numeroBolasMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			numeroBolasMensaje.x = 150;
			numeroBolasMensaje.y = 265;
			addChild(numeroBolasMensaje);
			
		}
		
		private function borrarImagenesDeColumna():void
		{
			trace("Entramos en juego.BorrarImagenesDeColumna");
			for (var i:int = 0; i < numeroFilas ; i++ ) {
				if (tablero._tablero[i][columna] == -1) {
						animacionBorrar(tablero._tableroImagenes[i][columna]);
				}
			}
			trace("Salimos en juego.borrarImagenesDeColumna");
		}	
	}

}