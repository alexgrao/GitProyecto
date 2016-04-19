package screens 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
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
			if (e.keyCode == 68) 
			{
				if (columnaIzq > 0) columnaIzq--;
			}
			
			if (e.keyCode == 71) 
			{
				if (columnaIzq < 6) columnaIzq++;
				
			}
			if (e.keyCode == 37) 
			{
				if (columnaDer > 0) columnaDer--;
			}
			
			if (e.keyCode == 39) 
			{
				if (columnaDer < 6) columnaDer++;
				
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
		
		private function comprobarPosicionXColumnaJugador(col:int, inicioX:int):int
		{
			//trace("Entramos y salimos en juego.comprobarPosicionXColumnaJugador");
			return anchuraCelda * col + inicioX;
		}
		
		private function watchForEnd():void
		{
			if (chronoSecondsPassed == 0 || _tableroIzq.compruebaUltimaFila() || _tableroDer.compruebaUltimaFila()) //Si el crono llega a 0 o hay bola en la ultima fila
			{ // faltarán añadir finales
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