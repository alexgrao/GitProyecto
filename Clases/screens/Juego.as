package screens 
{
	import flash.display.StageDisplayState;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
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
		
		var tablero:Tablero;
		var _jugador:Jugador;
		
		var _jugadorElegido:int;
		
		var _imagenFondo:Image;
		var _hub:Image;
		
		var inicioX:int;
		var inicioY:int;
		var finX:int;
		var finY:int;
		var succionadasX:int;
		
		var anchuraCelda:int;
		var alturaCelda:int;
		var numeroFilas:int;
		var numeroColumnas:int;
		
		var columna:int;
		var filasTotales:int;
		
		var puntuacionMensaje:TextField;
		
		private var moveTimer:Timer = new Timer(5000);
		
		var img:Image;
		
		var arrayDevuelveSuccionar:Array;
		
		public function Juego(jugador_elegido:int) 
		{
			super();
			tablero = new Tablero();
			_jugador = new Jugador(tablero, jugador_elegido);
			
			_jugadorElegido = jugador_elegido;
			
			inicioX = 180;
			finX = 460;
			inicioY = 25;
			finY = 5245;
			
			columna = 4;
			succionadasX = 200;
			
			numeroFilas = 13;
			numeroColumnas = 7;
			
			anchuraCelda = 40;
			alturaCelda = 40;
			
			puntuacionMensaje = new TextField(0, 0, _jugador.puntuacionActual.toString(), "Arial", 32, 0x000000, true);
			puntuacionMensaje.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			puntuacionMensaje.x = 100;
			puntuacionMensaje.y = 100;
			
			
			moveTimer.addEventListener(TimerEvent.TIMER,moveTimerHandler);
			moveTimer.start();
			
			_imagenFondo = new Image(Assets.getTexture("FondoSol"));
			addChild(_imagenFondo);
			_hub = new Image(Assets.getTexture("HUD1Player"));
			addChild(_hub);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, playGame);
			addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			//addEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
			addChild(puntuacionMensaje);
		}
		
		private function moveTimerHandler(e:TimerEvent):void 
		{
			//trace("Entramos en juego.moveTimerHandler");

			tablero.añadirFilaRandom();
			pintarTablero();
			
			//trace("salimos en juego.moveTimerHandler");
		}
		
		private function playGame(e:Event):void 
		{
			//trace("Entramos en juego.playGame");
			//pintarTablero();
			_jugador.jugadorImagen.x = comprobarPosicionXColumnaJugador(columna);
			//movePlayer();
			//trace("Salimos en juego.playGame");
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
				_jugador.succionar(columna);
				borrarImagenesDeColumna();
				//tablero.imprime();
			}
			
			if (e.keyCode == 83)
			{
				if(_jugador.colorActualRetenido != 0){
					if (_jugador.tirarBolas(columna)) {
						puntuacionMensaje.text = _jugador.puntuacionActual.toString();
						pintarTablero();
						//tablero.imprime();
					}
					else{
						pintarTablero();
					}
				}
			}
			//trace("Salimos en juego.checkKeyDown");
		}
		
		private function onAddedToStage(e:Event):void 
		{
			//trace("Entramos en juego.onAddedToStage");
			trace("empezamos juego");
			//pintarJugador();//cada frame
			//pintarBackground();
			iniciarPlayer();
			//iniciarTablero();
			pintarTablero();//
			//trace("Salimos en juego.onAddedToStage");
		}
		
		private function iniciarPlayer():void 
		{
			//trace("Entramos en juego.iniciaPlayer");
			_jugador.jugadorImagen.x = comprobarPosicionXColumnaJugador(columna);
			_jugador.jugadorImagen.y = 550;
			_jugador.jugadorImagen.width = anchuraCelda;
			_jugador.jugadorImagen.height = alturaCelda;
			addChild(_jugador.jugadorImagen);
			//trace("Salimos en juego.iniciaPlayer");
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
		
		/*private function iniciarTablero():void
		{
			tablero.imprime();
			for (var i:int = 6; i >= 0 ;i--) {
					for (var j:int = 12; j >= 0; j-- ) {
						var bola:int = tablero._tablero[j][i];
							bolas.push(bola);
					}
			}
		}*/
		
		private function comprobarPosicionXColumnaJugador(col:int):int
		{
			//trace("Entramos y salimos en juego.comprobarPosicionXColumnaJugador");
			return anchuraCelda * col + inicioX;
		}
		
		private function pintarTablero():void
		{
			//trace("Entramos en juego.pintarTablero");
			//tablero.imprime();
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
			//trace("Salimos en juego.PintarTablero");
		}
		
		private function borrarImagenesDeColumna():void
		{
			//trace("Entramos en juego.BorrarImagenesDeColumna");
			for (var i:int = 0; i < numeroFilas ; i++ ) {
				if (tablero._tablero[i][columna] == -1) {
						removeChild(tablero._tableroImagenes[i][columna]);
				}
			}
			//trace("Salimos en juego.borrarImagenesDeColumna");
		}	
	}

}