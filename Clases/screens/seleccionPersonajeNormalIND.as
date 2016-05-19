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
	
	/**
	 * ...
	 * @author j
	 */
	public class seleccionPersonajeNormalIND extends Sprite 
	{
		//Constantes
		private const JUGADOR_AZUL = 1;
		private const JUGADOR_ROJO = 2;
		
		//TEXTO
		private var _personajeAzul:TextField;
		private var _personajeRojo:TextField;
		
		//botones
		private var _atras:Button;

		
		//imegenes
		private var _imagenFondo:Image;
		private var _multiHUD_NORMAL:Image;
		private var _multiHUD_IND:Image;
		private var _imgTITULO_NORMAL:Image;
		private var _imgTextBATALLA:Image;
		private var _imgTextATRAS:Image;
		private var _imgTITULO_IND:Image;

		
		private var _personajeBlanco:AnimacionPersonaje;
		private var _personajeNegro:AnimacionPersonaje;
		
		//pantallas
		private var juego:Juego;
		private var pantallaSeleccionIND:seleccionModoIND;
		
		
		
		public function seleccionPersonajeNormalIND() 
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
			var animP1:Tween = new Tween(_personajeBlanco, 1);
			animP1.animate("alpha", 1);
			Starling.juggler.add(animP1);
			
			var animP2:Tween = new Tween(_personajeNegro, 1);
			animP2.animate("alpha", 1);
			Starling.juggler.add(animP2);
			
			animP2.onComplete = activaListeners;
		}
		
		private function activaListeners():void 
		{
			_personajeBlanco.addEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
			_personaje2.addEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
			_atras.addEventListener(TouchEvent.TOUCH, atras);
		}
		
		private function atras(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch) {
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
				removeEventListener(TouchEvent.TOUCH, atras);
				
				
				animacionAtras();
			}
		}
		
		private function animacionAtras():void 
		{
			_atras.enabled = false;
			
			var animFONDO:Tween = new Tween(_imagenFondo, 1.7);
			var animP1:Tween = new Tween(_personajeBlanco.ParadoArt, 1.7);
			var animP2:Tween = new Tween(_personajeNegro.ParadoArt, 1.7);
			var animTitulo_NORMAL:Tween = new Tween(_imgTITULO_NORMAL, 1.7);
			var animHUD_NORMAL:Tween = new Tween(_multiHUD_NORMAL, 1.7);
			var animHUD_IND:Tween = new Tween(_multiHUD_IND, 1.7);
			var animAtras_Modo:Tween = new Tween(_imgTextATRAS, 1.7);
			var animBATALLA:Tween = new Tween(_imgTextBATALLA, 1.7);
			var animATRAS:Tween = new Tween(_atras, 1.7);
			var animTextTITULO_MODO:Tween = new Tween(_imgTITULO_IND, 1.7);
			
			animFONDO.animate("x", _imagenFondo.x + 150);
			animP1.animate("x", _personajeBlanco.ParadoArt.x + 1200);
			animP2.animate("x", _personajeNegro.ParadoArt.x + 1200);
			animTitulo_NORMAL.animate("x", 70);
			animTitulo_NORMAL.animate("y", 418);
			animTitulo_NORMAL.scaleTo(0.9);
			animHUD_NORMAL.animate("x", _multiHUD_NORMAL.x + 1200);
			animHUD_IND.animate("x", _multiHUD_IND.x + 1200);
			animAtras_Modo.animate("x", _imgTextATRAS.x + 1200);
			animBATALLA.animate("x", _imgTextBATALLA.x + 1200);
			animATRAS.animate("x", _atras.x + 1200);
			animTextTITULO_MODO.animate("x", _imgTITULO_IND.x + 1200);
			
			Starling.juggler.add(animFONDO);
			Starling.juggler.add(animHUD_NORMAL);
			Starling.juggler.add(animHUD_IND);
			Starling.juggler.add(animAtras_Modo);
			Starling.juggler.add(animBATALLA);
			Starling.juggler.add(animP1);
			Starling.juggler.add(animP2);
			Starling.juggler.add(animTitulo_NORMAL);
			Starling.juggler.add(animATRAS);
			Starling.juggler.add(animTextTITULO_MODO);
			
			animFONDO.onComplete = cambioPantallaAtras;
		}
		
		private function cambioPantallaAtras():void 
		{
			removeChildren();
			
			_atras = null;
			
			pantallaSeleccionIND = new seleccionModoIND();
			addChild(pantallaSeleccionIND);
		}
		
		private function iniciaJuegoAzul(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch) {
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoAzul);
				removeEventListener(TouchEvent.TOUCH, iniciaJuegoRoja);
				removeEventListener(TouchEvent.TOUCH, atras);
				removeChildren();
				
				_personajeAzul = null;
				_personajeRojo = null;
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
				
				_personajeAzul = null;
				_personajeRojo = null;
				_atras = null;
				
				juego = new Juego(JUGADOR_ROJO);
				addChild(juego);
			}
		}
		
		private function dibujarPantalla():void 
		{
			_imagenFondo = new Image(Assets.getTexture("FondoPrincipal"));
			_imagenFondo.x = -600;
			_imagenFondo.y = -162.5;
			addChild(_imagenFondo);
			
			_multiHUD_NORMAL = new Image(Assets.getTexture("MultiHUD_NORMAL_IND"));
			addChild(_multiHUD_NORMAL);
			
			_multiHUD_IND = new Image(Assets.getTexture("MultiHUD_IND"));
			_multiHUD_IND.x = -1200;
			addChild(_multiHUD_IND);
			
			_atras = new Button(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_atras.overState = Assets.getAtlasTextoHUD().getTexture("textoATRAS_select");
			_atras.downState = Assets.getAtlasTextoHUD().getTexture("textoATRAS_select");
			_atras.scaleX = 0.9;
			_atras.scaleY = 0.9;
			_atras.x = 1000;
			_atras.y = 556;
			addChild(_atras);
			
			_imgTITULO_NORMAL = new Image(Assets.getAtlasTextoHUD().getTexture("textoNORMAL_select"));	
			_imgTITULO_NORMAL.scaleX = 1.2;
			_imgTITULO_NORMAL.scaleY = 1.2;
			_imgTITULO_NORMAL.x = stage.stageWidth/2 - _imgTITULO_NORMAL.width / 2;
			_imgTITULO_NORMAL.y = 10;
			addChild(_imgTITULO_NORMAL);
			
			_imgTextBATALLA = new Image(Assets.getAtlasTextoHUD().getTexture("textoBATALLA"));
			_imgTextBATALLA.scaleX = 0.9;
			_imgTextBATALLA.scaleY = 0.9;
			_imgTextBATALLA.x = -1145;
			_imgTextBATALLA.y =  540;
			addChild(_imgTextBATALLA);
			
			_imgTITULO_IND = new Image(Assets.getAtlasTextoHUD().getTexture("textoINDIV_select"));
			_imgTITULO_IND.scaleX = 1.5;
			_imgTITULO_IND.scaleY = 1.5;
			_imgTITULO_IND.x = (stage.stageWidth / 2 - _imgTITULO_IND.width / 2) - 1200;
			_imgTITULO_IND.y =  10;
			addChild(_imgTITULO_IND);
			
			_imgTextATRAS = new Image(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_imgTextATRAS.scaleX = 0.9;
			_imgTextATRAS.scaleY = 0.9;
			_imgTextATRAS.x = -200;
			_imgTextATRAS.y = 556;
			addChild(_imgTextATRAS);
						
			_personajeBlanco = new AnimacionPersonaje(AnimacionPersonaje.BLANCO);
			_personajeBlanco.x = 205;
			_personajeBlanco.y = 400;
			_personajeBlanco.alpha = 0;
			addChild(_personajeBlanco);
			
			_personajeNegro = new AnimacionPersonaje(AnimacionPersonaje.NEGRO);
			_personajeNegro.x = 875;
			_personajeNegro.y = 400;
			_personajeNegro.alpha = 0;
			addChild(_personajeNegro);

		}
		
	}

}