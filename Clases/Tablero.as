package 
{
	import flash.display.Sprite;
	import flash.events.*;
	/**
	 * ...
	 * @author Jesús Bachiller Cabal
	 */
	public class Tablero extends Sprite
	{
			//ID DE BOLAS
		private const VACIO:int = -1; //No contiene ninguna bola
		private const BOMBA:int = 0; // id de la bomba
		
			/* PRIMER DIGITO: COLOR de la bola
			 * SEGUNDO DIGITO: TIPO de la bola*/
		private const ROJO_NORMAL:int = 10; //id de la bola roja normal
		private const AZUL_NORMAL:int = 20; //id de la bola azul normal
		private const AMARILLO_NORMAL:int = 30; //	...
		private const BLANCO_NORMAL:int = 40;	//		...
		
		private const ROJO_PUNTOSEXTRA:int = 11;
		private const AZUL_PUNTOSEXTRA:int = 21;
		private const AMARILLO_PUNTOSEXTRA:int = 31;
		private const BLANCO_PUNTOSEXTRA:int = 41;		
		
		private const ROJO_TIEMPOEXTRA:int = 12;
		private const AZUL_TIEMPOEXTRA:int = 22;
		private const AMARILLO_TIEMPOEXTRA:int = 32;
		private const BLANCO_TIEMPOEXTRA:int = 42;	
		
			//Filas del tablero
		private var _fila1:Array;
		private var _fila2:Array;
		private var _fila3:Array;
		private var _fila4:Array;
		private var _fila5:Array;
		private var _fila6:Array;
		private var _fila7:Array;
		private var _fila8:Array;
		private var _fila9:Array;
		private var _fila10:Array;
		private var _fila11:Array;
		private var _fila12:Array;
		private var _fila13:Array;
		private var _fila14:Array;
		private var _fila15:Array;
		private var _fila16:Array;
		
		public var _tablero:Array;
		
		private var _filaImagenes1:Array;
		private var _filaImagenes2:Array;
		private var _filaImagenes3:Array;
		private var _filaImagenes4:Array;
		private var _filaImagenes5:Array;
		private var _filaImagenes6:Array;
		private var _filaImagenes7:Array;
		private var _filaImagenes8:Array;
		private var _filaImagenes9:Array;
		private var _filaImagenes10:Array;
		private var _filaImagenes11:Array;
		private var _filaImagenes12:Array;
		private var _filaImagenes13:Array;
		private var _filaImagenes14:Array;
		private var _filaImagenes15:Array;
		private var _filaImagenes16:Array;
		
		public var _tableroImagenes:Array;
		
		public function Tablero() 
		{
			_fila1 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila2 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila3 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila4 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			//_fila1 = new Array(40, 0, 30, 20, 10, 40, 10);
			//_fila2 = new Array(40, 10, 30, 30, 40, 10, 10);
			//_fila3 = new Array(-1, 30, -1, 20, 20, 30, 10);
			//_fila4 = new Array(-1, -1, -1, 10, 20, 30, 30);
			_fila5 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila6 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila7 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila8 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila9 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila10 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila11 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila12 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			_fila13 = new Array(VACIO, VACIO, VACIO, VACIO, VACIO, VACIO, VACIO);
			
			_tablero = new Array(_fila1, _fila2, _fila3, _fila4, _fila5, _fila6, _fila7, _fila8, _fila9, _fila10, _fila11, _fila12, _fila13);
			
			_filaImagenes1 = new Array(null, null, null, null, null, null, null);
			_filaImagenes2 = new Array(null, null, null, null, null, null, null);
			_filaImagenes3 = new Array(null, null, null, null, null, null, null);
			_filaImagenes4 = new Array(null, null, null, null, null, null, null);
			_filaImagenes5 = new Array(null, null, null, null, null, null, null);
			_filaImagenes6 = new Array(null, null, null, null, null, null, null);
			_filaImagenes7 = new Array(null, null, null, null, null, null, null);
			_filaImagenes8 = new Array(null, null, null, null, null, null, null);
			_filaImagenes9 = new Array(null, null, null, null, null, null, null);
			_filaImagenes10 = new Array(null, null, null, null, null, null, null);
			_filaImagenes11 = new Array(null, null, null, null, null, null, null);
			_filaImagenes12 = new Array(null, null, null, null, null, null, null);
			_filaImagenes13 = new Array(null, null, null, null, null, null, null);
			
			_tableroImagenes = new Array(_filaImagenes1, _filaImagenes2, _filaImagenes3, _filaImagenes4, _filaImagenes5, _filaImagenes6, _filaImagenes7, _filaImagenes8, _filaImagenes9, _filaImagenes10, _filaImagenes11, _filaImagenes12, _filaImagenes13);
			
			iniciaTablero();
			//imprime();
			//eliminaSeguidos(1);
			//imprime();
			//equilibraTablero();
			
			imprime();
		}
		
		public function iniciaTablero():void 
		{
			//trace("Entramos en tablero.iniciaTablero");
			añadirFilaRandom();
			añadirFilaRandom();
			añadirFilaRandom();
			//trace("salimos en tablero.iniciaTablero");
		}
		
		public function añadirFilaRandom():void 
		{
			//trace("Entramos en tablero.añadirFilaRandom");
			bajarUnaFila();
			for (var col:int = 0; col < _fila1.length; col++ ) {
				var RANDOM_probabilidad:int = Math.floor(Math.random() * 101); //num radom entre 0 y 100(incluido el 100)
				var RANDOM_bola:int;
				if (RANDOM_probabilidad < 96) {
					RANDOM_bola = Math.floor(Math.random() * 4) + 1;
					if(RANDOM_bola == 1){
						_tablero[0][col] = ROJO_NORMAL;
					}
					if (RANDOM_bola == 2) {
						_tablero[0][col] = AZUL_NORMAL;
					}
					if(RANDOM_bola == 3){
						_tablero[0][col] = AMARILLO_NORMAL;
					}
					if (RANDOM_bola == 4) {
						_tablero[0][col] = BLANCO_NORMAL;
					}
					
				}else {
					if (RANDOM_probabilidad < 97) {
						_tablero[0][col] = BOMBA;
					}
					else {
						if (RANDOM_probabilidad < 99) {
							RANDOM_bola = Math.floor(Math.random() * 4) + 1;
							if(RANDOM_bola == 1){
								_tablero[0][col] = ROJO_PUNTOSEXTRA;
							}
							if (RANDOM_bola == 2) {
								_tablero[0][col] = AZUL_PUNTOSEXTRA;
							}
							if(RANDOM_bola == 3){
								_tablero[0][col] = AMARILLO_PUNTOSEXTRA;
							}
							if (RANDOM_bola == 4) {
								_tablero[0][col] = BLANCO_PUNTOSEXTRA;
							}
						}else {
							RANDOM_bola = Math.floor(Math.random() * 4) + 1;
							if(RANDOM_bola == 1){
								_tablero[0][col] = ROJO_TIEMPOEXTRA;
							}
							if (RANDOM_bola == 2) {
								_tablero[0][col] = AZUL_TIEMPOEXTRA;
							}
							if(RANDOM_bola == 3){
								_tablero[0][col] = AMARILLO_TIEMPOEXTRA;
							}
							if (RANDOM_bola == 4) {
								_tablero[0][col] = BLANCO_TIEMPOEXTRA;
							}
						}
					}
				}
				
			}
			//trace("Salimos en tablero.añadirFilaRandom");
			
		}
		
		private function bajarUnaFila():void 
		{
			//trace("Entramos en tablero.bajarUnaFila");
			for ( var i:int = _tablero.length-2; i > -1; i-- ) {
				for (var j:int = 0; j < _fila1.length; j++ ) {
					_tablero[i + 1][j] = _tablero[i][j];
				}
			}
			//trace("Salimos en tablero.bajarUnaFila");
		}
		
		public function eliminaUltsBolasColumna(colu:int):Array
		{
			//trace("Entramos en tablero.eliminaUltsBolasColumna");
			var bolasTotalesEliminadas:int = 0; //contador de las bolas que eliminamos
			var bolasConPuntosEliminadas:int = 0; //contador de bolas con puntos
			var bolasConTiempoEliminadas:int = 0; //"	  	 "	 "	  con tiempo
			var ultimaBola:int = -1; //numero de la bola que este en un principio en la culumna "colu"
			var ColorDeBolasEliminadas:int = 0; //sin color
			
			for (var fil:int = _tablero.length - 1; fil > -1; fil-- ) {
				if (_tablero[fil][colu] != BOMBA && _tablero[fil][colu] != VACIO) { //si no hay una bomba ni esta vacio
					if(ultimaBola == -1){ //se llega aqui la primera vez que encuentra una bola
						ultimaBola = _tablero[fil][colu];
						ColorDeBolasEliminadas = Math.floor(ultimaBola/10);
					}else {
						if (Math.floor(_tablero[fil][colu] / 10) != Math.floor(ultimaBola / 10)) {
							break;
						}
					}
					
					if (_tablero[fil][colu] % 10 == 1) { bolasConPuntosEliminadas++;}
					if (_tablero[fil][colu] % 10 == 2) { bolasConTiempoEliminadas++; }
					
					bolasTotalesEliminadas++;
					eliminaBola(fil, colu);
				}
				if (_tablero[fil][colu] == 0){
					break;
				}
			}
			var Eliminacion:Array = new Array(ColorDeBolasEliminadas, bolasTotalesEliminadas, bolasConPuntosEliminadas, bolasConTiempoEliminadas);
			//trace("Salimos en tablero.eliminaUltsBolasColumna");
			return Eliminacion;

		}
		
		public function insertaNBolas(colorBolas:int, numBolas:int, colu:int, tipoBolas:int):void 
		{
			//trace("Entramos en tablero.insertaNBolas");
			var filaUltimo:int = buscaUltimoEnColumna(colu);
			
			for (var i:int = 0; i < numBolas; i++ ) {
				if(i+filaUltimo < _tablero.length-1){
					_tablero[i + filaUltimo + 1][colu] = colorBolas * 10 + tipoBolas;
				}
			}
			//trace("Salimos en tablero.insertaNBolas");
		}
		
		private function buscaUltimoEnColumna(colu:int):int
		{
			//trace("Entramos en tablero.buscarUltimoEnColumna");
			var filaUltimo:int = -1;
			for (var fil:int = _tablero.length - 1; fil > -1; fil-- ) {
				if (_tablero[fil][colu] != -1) {
					filaUltimo = fil;
					break;
				}
			}
			//trace("Salimos en tablero.buscarUltimoEnColumna");

			return filaUltimo;
		}
		
		public function eliminaSeguidos(colu:int):Array 
		{
			//trace("Entramos en tablero.eliminaSeguidos");
			var filaUltimo:int = buscaUltimoEnColumna(colu);
			
			var colorQueElimina:int = Math.floor(_tablero[filaUltimo][colu] / 10);
			
			var datosEliminados:Array = eliminaYcompruebaLados(filaUltimo, colu, colorQueElimina);
			trace(datosEliminados);
			
			equilibraTablero();
			//trace("Salimos en tablero.eliminaSeguidos");

			return datosEliminados;
		}
		
		private function equilibraTablero():void 
		{
			trace("Entramos en tablero.equilibraTablero");
			var seSube:Boolean = false;
			
				/* De abajo a arriba
				 * De izquierda de derecha*/
			for (var i:int = _tablero.length - 1; i >= 0; i-- ) {
				for (var j:int = 0; j < _fila1.length; j++ ) {
					if ((i != 0) && (_tablero[i][j] != VACIO) && (_tablero[i - 1][j] == VACIO)) { // si es una bola y arriba no tiene nada
						//intercambio de filas
						intercambioBolasEnColumna(i-1, i, j);
						seSube = true;
					}
				}
				if (seSube) {
					i += 2;
					seSube = false;
				}
			}
			trace("Salimos en tablero.equilibraTablero");
		}
		
		private function intercambioBolasEnColumna(filSup:int, filInf:int, colu:int):void 
		{
			trace("Entramos en tablero.intercambioBolasEnColumna");
			var aux:int = _tablero[filSup][colu];
			_tablero[filSup][colu] = _tablero[filInf][colu];
			_tablero[filInf][colu] = aux;
			trace("Salimos en tablero.intercambioBolasEnColumna");
		}
		
		private function eliminaBola(filAct:int, colAct:int):void 
		{
			//trace("Entramos en tablero.eliminaBola");
			_tablero[filAct][colAct] = VACIO;
			//trace("Salimos en tablero.eliminaBola");
		}
		
		public function eliminaYcompruebaLados(filAct:int, coluAct:int, colorBola:int):Array 
		{
			//trace("Entramos en tablero.eliminaYCompruebaLados");
			var Ar_array:Array = new Array(0,0,0);
			var Ab_array:Array = new Array(0,0,0);
			var D_array:Array = new Array(0,0,0);
			var I_array:Array = new Array(0,0,0);
			
			var devolver:Array = new Array(0,0,0)
			
			var bolasTotalesEliminadas:int = 0; //contador de las bolas que eliminamos
			var bolasConPuntosEliminadas:int = 0; //contador de bolas conpuntos
			var bolasConTiempoEliminadas:int = 0; //"	  	 "	 "	  con tiempo
			
			var bolaQueEliminamos:int = _tablero[filAct][coluAct];
			
			
			if (bolaQueEliminamos == 0) {
				devolver[0] += explotaBomba(filAct, coluAct);
				return devolver;
			}else {
				if(Math.floor(bolaQueEliminamos / 10) != colorBola) {
					return devolver;
				}
			}
			
			if (bolaQueEliminamos % 10 == 1) {
				bolasConPuntosEliminadas++;
			}	else {
				if (bolaQueEliminamos % 10 == 2) {
					bolasConTiempoEliminadas++;
				}
			}
			
			eliminaBola(filAct, coluAct);
			bolasTotalesEliminadas++;
			
			if(filAct > 0){ Ar_array = eliminaYcompruebaLados(filAct - 1, coluAct, colorBola);}
			Ab_array = eliminaYcompruebaLados(filAct + 1, coluAct, colorBola);
			if(coluAct > 0){ I_array = eliminaYcompruebaLados(filAct, coluAct - 1, colorBola);}
			if(coluAct < _fila1.length-1){ D_array = eliminaYcompruebaLados(filAct, coluAct + 1, colorBola);}
			
			devolver[0] = Ar_array[0] + Ab_array[0] + D_array[0] + I_array[0] + bolasTotalesEliminadas;
			devolver[1] = Ar_array[1] + Ab_array[1] + D_array[1] + I_array[1] + bolasConPuntosEliminadas;
			devolver[2]	= Ar_array[2] + Ab_array[2] + D_array[2] + I_array[2] + bolasConTiempoEliminadas;
			
			//trace("Salimos en tablero.eliminaYCompruebaLados");
			
			return devolver;
		}
		
		private function explotaBomba(filAct:int, coluAct:int):int 
		{
			//trace("Entramos en tablero.explotaBomba");
			_tablero[filAct][coluAct] = VACIO;
			
			var numEliminados:int = 0;
			
			if(filAct != 0 && coluAct != 0){
				if((_tablero[filAct - 1][coluAct - 1] != -1)){
					if (_tablero[filAct - 1][coluAct - 1] == 0) {
						_tablero[filAct - 1][coluAct - 1] = VACIO;
						numEliminados += explotaBomba(filAct - 1, coluAct - 1);
					}else {
						_tablero[filAct - 1][coluAct - 1] = VACIO;
					}
					numEliminados++;
				}
			}
			
			if(coluAct != 0){
				if(_tablero[filAct][coluAct - 1] != -1){
					if (_tablero[filAct][coluAct - 1] == 0) {
						_tablero[filAct][coluAct-1] = VACIO;
						numEliminados += explotaBomba(filAct, coluAct - 1);
					}else {
						_tablero[filAct][coluAct-1] = VACIO;
					}
					numEliminados++;
				}
			}
			
			if(filAct != _tablero.length - 1 && coluAct != 0){
				if(_tablero[filAct + 1][coluAct - 1] != -1){
					if (_tablero[filAct + 1][coluAct - 1] == 0) {
						_tablero[filAct+1][coluAct-1] = VACIO;
						numEliminados += explotaBomba(filAct + 1, coluAct - 1);
					}else {
						_tablero[filAct+1][coluAct-1] = VACIO;
					}
					numEliminados++;
				}
			}
			
			if(filAct != 0){
				if(_tablero[filAct - 1][coluAct] != -1){
					if (_tablero[filAct - 1][coluAct] == 0) {
						_tablero[filAct-1][coluAct] = VACIO;
						numEliminados += explotaBomba(filAct - 1, coluAct);
					}else {
						_tablero[filAct-1][coluAct] = VACIO;
					}
					numEliminados++;
				}
			}
			
			if(filAct != _tablero.length){
				if(_tablero[filAct + 1][coluAct] != -1){
					if (_tablero[filAct + 1][coluAct] == 0) {
						_tablero[filAct+1][coluAct] = VACIO;
						numEliminados += explotaBomba(filAct + 1, coluAct);
					}else {
						_tablero[filAct+1][coluAct] = VACIO;
					}
					numEliminados++;
				}
			}
			
			if(filAct != 0 && coluAct != _fila1.length - 1){
				if(_tablero[filAct - 1][coluAct + 1] != -1){
					if (_tablero[filAct - 1][coluAct + 1] == 0) {
						_tablero[filAct-1][coluAct+1] = VACIO;
						numEliminados += explotaBomba(filAct - 1, coluAct + 1);
					}else {
						_tablero[filAct][coluAct+1] = VACIO;
					}
					numEliminados++;
				}
			}
			
			if(coluAct != _fila1.length - 1){
				if(_tablero[filAct][coluAct + 1] != -1){
					if (_tablero[filAct][coluAct + 1] == 0) {
						_tablero[filAct][coluAct+1] = VACIO;
						numEliminados += explotaBomba(filAct, coluAct + 1);
					}else {
						_tablero[filAct][coluAct+1] = VACIO;
					}
					numEliminados++;
				}
			}
			
			if(filAct != _tablero.length && coluAct != _fila1.length - 1){
				if(_tablero[filAct + 1][coluAct + 1] != -1){
					if (_tablero[filAct + 1][coluAct + 1] == 0) {
						_tablero[filAct+1][coluAct+1] = VACIO;
						numEliminados += explotaBomba(filAct + 1, coluAct + 1);
					}else {
						_tablero[filAct+1][coluAct+1] = VACIO;
					}
					numEliminados++;
				}
			}
			
			//trace("Salimos en tablero.explotaBomba");
			
			return numEliminados;
		}
		
		public function comprobarPrimerColorColumna(col:int):int
		{
			//trace("Entramos en tablero.comprobarPrimerColorColumna");
			var colorDevolver:int;
			for (var fil:int = _tablero.length - 1; fil > -1; fil-- ) {
				if (_tablero[fil][col] != BOMBA && _tablero[fil][col] != VACIO) {
						colorDevolver = Math.floor(_tablero[fil][col] / 10);
						break;
				}
			}
			//trace("Salimos en tablero.comprobarPrimerColorColumna");

			return colorDevolver;
		}
		
		public function comprobarSeguidasMismoColor(col:int,color:int):int
		{
			//trace("Entramos en tablero.comprobarSeguidasMismoColor");
			var bolasMismoColor:int = 0;
			for (var fil:int = _tablero.length - 1; fil > -1; fil-- ) {
				if (_tablero[fil][col] != BOMBA && _tablero[fil][col] != VACIO) {
						if (color == Math.floor(_tablero[fil][col] / 10)) {
						bolasMismoColor++;	
						}
						else{
							break;
						}
				}
			}
			
			//trace("Salimos en tablero.comprobarSeguidasMismoColor");

			return bolasMismoColor;
		}
		
		public function imprime():void 
		{
			trace("------");
			for (var i:int = 0; i < _tablero.length; i++) {
				trace(_tablero[i]);
			}
			trace("------");
		}
	}

}