package screens 
{
	import flash.automation.MouseAutomationAction;
	import flash.events.MouseEvent;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;

	public class seleccionPersonajeBatallaIND extends Sprite
	{
		//Constantes
		private const JUGADOR_AZUL = 1;
		private const JUGADOR_ROJO = 2;
		
		//BOTON
		private var _atras:Button;
		
		//imegenes
		private var _imagenFondo:Image;
		private var _multiHUD_BATALLA:Image;
		private var _multiHUD_IND:Image;
		private var _imgTITULO_BATALLA:Image;
		private var _imgTITULO_IND:Image;
		private var _imgText_NORMAL:Image;
		private var _imgText_ATRAS:Image;
		
		private var personaje1:AnimacionPersonaje;
		private var personaje2:AnimacionPersonaje;
		
		//pantallas
		private var juego:Juego;
		private var _pantallaSeleccionModoIND:seleccionModoIND;
		
		
		
		public function seleccionPersonajeBatallaIND() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			dibujarPantalla();
			
			animacionInicio();
		}
		
		private function animacionInicio():void 
		{
			
			var animP1:Tween = new Tween(personaje1, 1);
			animP1.animate("alpha", 1);
			Starling.juggler.add(animP1);
			
			var animP2:Tween = new Tween(personaje2, 1);
			animP2.animate("alpha", 1);
			Starling.juggler.add(animP2);
			
			animP2.onComplete = activaListeners;
		}
		
		private function activaListeners():void 
		{
			//personaje1.addEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
			//personaje2.addEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
			_atras.addEventListener(TouchEvent.TOUCH, atras);
		}
		
		private function atras(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch) {
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
				removeEventListener(TouchEvent.TOUCH, atras);
				
				
				animacionATRAS();
			}
		}
		
		private function animacionATRAS():void 
		{
			_atras.enabled = false;
			
			var animFONDO:Tween = new Tween(_imagenFondo, 1.7);
			var animTitulo_BATALLA:Tween = new Tween(_imgTITULO_BATALLA, 1.7);
			var animTitulo_IND:Tween = new Tween(_imgTITULO_IND, 1.7);
			var animHUD_B:Tween = new Tween(_multiHUD_BATALLA, 1.7);
			var animHUD_I:Tween = new Tween(_multiHUD_IND, 1.7);
			var animP1:Tween = new Tween(personaje1.ParadoArt, 1.7);
			var animp2:Tween = new Tween(personaje2.ParadoArt, 1.7);
			var animATRAS:Tween = new Tween(_atras, 1.7);
			var animTextNormalMODE:Tween = new Tween(_imgText_NORMAL, 1.7);
			var animTextAtrasMODE:Tween = new Tween(_imgText_ATRAS, 1.7);

			
			animFONDO.animate("y", _imagenFondo.y + 162.5);
			animTitulo_BATALLA.animate("x", 30);
			animTitulo_BATALLA.animate("y", 547);
			animTitulo_BATALLA.scaleTo(1);
			animTitulo_IND.animate("y", _imgTITULO_IND.y + 650);
			animHUD_B.animate("y", _multiHUD_BATALLA.y + 650);
			animHUD_I.animate("y", _multiHUD_IND.y + 650);
			animP1.animate("y", personaje1.ParadoArt.y + 650);
			animp2.animate("y", personaje2.ParadoArt.y + 650);
			animATRAS.animate("y", _atras.y + 650);
			animTextNormalMODE.animate("y", _imgText_NORMAL.y + 650);
			animTextAtrasMODE.animate("y", _imgText_ATRAS.y + 650);
			
			
			Starling.juggler.add(animFONDO);
			Starling.juggler.add(animHUD_B);
			Starling.juggler.add(animHUD_I);
			Starling.juggler.add(animP1);
			Starling.juggler.add(animp2);
			Starling.juggler.add(animTitulo_BATALLA);
			Starling.juggler.add(animTitulo_IND);
			Starling.juggler.add(animATRAS);
			Starling.juggler.add(animTextNormalMODE);
			Starling.juggler.add(animTextAtrasMODE);
			
			animATRAS.onComplete = cambioPantallaAtras;
		}
		
		private function cambioPantallaAtras():void 
		{
			removeChildren();
				
			_atras = null;
			
			_pantallaSeleccionModoIND = new seleccionModoIND();
			addChild(_pantallaSeleccionModoIND);
		}
		
		private function iniciaJuegoAzul(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch) {
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
				removeEventListener(TouchEvent.TOUCH, atras);
				removeChildren();
				
				_atras = null;
				
				juego = new Juego(JUGADOR_AZUL);
				addChild(juego);
			}
		}
		
		private function iniciaJuegoRoja(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch) {
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
				removeEventListener(TouchEvent.TOUCH, atras);
				removeChildren();
				
				_atras = null;
				
				juego = new Juego(JUGADOR_ROJO);
				addChild(juego);
			}
		}
		
		private function dibujarPantalla():void 
		{
			_imagenFondo = new Image(Assets.getTexture("FondoPrincipal"));
			_imagenFondo.x = -450
			_imagenFondo.y = -325
			addChild(_imagenFondo);
			
			_multiHUD_BATALLA = new Image(Assets.getTexture("MultiHUD_BATALLA_IND"));
			addChild(_multiHUD_BATALLA);
			
			_multiHUD_IND = new Image(Assets.getTexture("MultiHUD_IND"));
			_multiHUD_IND.x = 0;
			_multiHUD_IND.y = -650;
			addChild(_multiHUD_IND);
			
			_atras = new Button(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_atras.overState = Assets.getAtlasTextoHUD().getTexture("textoATRAS_select");
			_atras.downState = Assets.getAtlasTextoHUD().getTexture("textoATRAS_select");
			_atras.x = 995;
			_atras.y = 551;
			addChild(_atras);
			
			_imgTITULO_BATALLA = new Image(Assets.getAtlasTextoHUD().getTexture("textoBATALLA_select"));	
			_imgTITULO_BATALLA.scaleX = 1.2;
			_imgTITULO_BATALLA.scaleY = 1.2;
			_imgTITULO_BATALLA.x = stage.stageWidth/2 - _imgTITULO_BATALLA.width / 2;
			_imgTITULO_BATALLA.y = 10
			addChild(_imgTITULO_BATALLA);
			
			_imgTITULO_IND = new Image(Assets.getAtlasTextoHUD().getTexture("textoINDIV_select"));	
			_imgTITULO_IND.scaleX = 1.5;
			_imgTITULO_IND.scaleY = 1.5;
			_imgTITULO_IND.x = stage.stageWidth/2 - _imgTITULO_IND.width / 2;
			_imgTITULO_IND.y = -640
			addChild(_imgTITULO_IND);
			
			_imgText_NORMAL = new Image(Assets.getAtlasTextoHUD().getTexture("textoNORMAL"));
			_imgText_NORMAL.scaleX = 0.9;
			_imgText_NORMAL.scaleY = 0.9;
			_imgText_NORMAL.x = 70;
			_imgText_NORMAL.y = -232;
			addChild(_imgText_NORMAL);
			
			_imgText_ATRAS = new Image(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_imgText_ATRAS.scaleX = 0.9;
			_imgText_ATRAS.scaleY = 0.9;
			_imgText_ATRAS.x = 1000;
			_imgText_ATRAS.y = -94;
			addChild(_imgText_ATRAS);
			
			personaje1 = new AnimacionPersonaje(AnimacionPersonaje.BLANCO);
			personaje1.x = 205;
			personaje1.y = 400;
			personaje1.alpha = 0;
			addChild(personaje1);
			
			personaje2 = new AnimacionPersonaje(AnimacionPersonaje.NEGRO);
			personaje2.x = 875;
			personaje2.y = 400;
			personaje2.alpha = 0;
			addChild(personaje2);

		}
		
		
	}

}