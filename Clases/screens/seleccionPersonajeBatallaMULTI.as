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
	public class seleccionPersonajeBatallaMULTI extends Sprite 
	{
		//Constantes
		private const JUGADOR_AZUL = 1;
		private const JUGADOR_ROJO = 2;
		static public const BLANCO:int = 1;
		static public const NEGRO:int = 2;
		
		//Seleccion de personaje
		private var personajeIzqSeleccionado:int;
		private var personajeDerSeleccionado:int;
		
		//TEXTO
		private var _personajeAzul:TextField;
		private var _personajeRojo:TextField;
		
		//botones
		private var _atras:Button;
		private var _GO:Button;

		//TextFields
		private var _textJugadorIzq:TextField;
		private var _textjugadorDer:TextField;
		
		//imegenes
		private var _imagenFondo:Image;
		private var _multiHUD_BATALLA:Image;
		private var _multiHUD_MULTI:Image;
		private var _imgTITULO_BATALLA:Image;
		private var _imgTextNORMAL:Image;
		private var _imgTextATRAS:Image;
		private var _imgTITULO_MULTI:Image;

		private var _personajeSelectIzqBLANCO:Image;
		private var _personajeSelectIzqNEGRO:Image;
		private var _personajeSelectDerBLANCO:Image;
		private var _personajeSelectDerNEGRO:Image;
		
		//Personajes
		private var _personajeIzqBLANCO:AnimacionPersonaje;
		private var _personajeIzqNEGRO:AnimacionPersonaje;
		private var _personajeDerBLANCO:AnimacionPersonaje;
		private var _personajeDerNEGRO:AnimacionPersonaje;
		
		//pantallas
		private var pantallaSeleccionMUL:seleccionModoMULTI;
		
		public function seleccionPersonajeBatallaMULTI() 
		{
			super();
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			personajeIzqSeleccionado = 0; // ninguno seleccionado
			personajeDerSeleccionado = 0; // ninguno seleccionado
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			dibujarPantalla();
			
			animacionInicio();
			
		}
		
		private function animacionInicio():void 
		{			
			var animP1I:Tween = new Tween(_personajeIzqBLANCO, 1);
			animP1I.animate("alpha", 1);
			Starling.juggler.add(animP1I);
			
			var animP1D:Tween = new Tween(_personajeIzqNEGRO, 1);
			animP1D.animate("alpha", 1);
			Starling.juggler.add(animP1D);
			
			var animP2I:Tween = new Tween(_personajeDerBLANCO, 1);
			animP2I.animate("alpha", 1);
			Starling.juggler.add(animP2I);
			
			var animP2D:Tween = new Tween(_personajeDerNEGRO, 1);
			animP2D.animate("alpha", 1);
			Starling.juggler.add(animP2D);
			
			animP2D.onComplete = activaListeners;
		}
		
		private function activaListeners():void 
		{
			_personajeIzqNEGRO.addEventListener(TouchEvent.TOUCH, seleccionarPersonajeIzqNEGRO);
			_personajeIzqBLANCO.addEventListener(TouchEvent.TOUCH, seleccionarPersonajeIzqBLANCO);
			
			_personajeDerNEGRO.addEventListener(TouchEvent.TOUCH, seleccionarPersonajeDerNEGRO);
			_personajeDerBLANCO.addEventListener(TouchEvent.TOUCH, seleccionarPersonajeDerBLANCO);
			
			_atras.addEventListener(TouchEvent.TOUCH, atras);
		}
		
		private function atras(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch) {
				removeEventListener(TouchEvent.TOUCH, seleccionarPersonajeIzqNEGRO);
				removeEventListener(TouchEvent.TOUCH, seleccionarPersonajeIzqBLANCO);
				removeEventListener(TouchEvent.TOUCH, seleccionarPersonajeDerNEGRO);
				removeEventListener(TouchEvent.TOUCH, seleccionarPersonajeDerBLANCO);
				removeEventListener(TouchEvent.TOUCH, atras);
				
				
				animacionAtras();
			}
		}
		
		private function animacionAtras():void 
		{
			_atras.enabled = false;
			_personajeSelectIzqNEGRO.visible = false;
			_personajeSelectDerNEGRO.visible = false;
			_personajeSelectIzqBLANCO.visible = false;
			_personajeSelectDerBLANCO.visible = false;
			
			
			var animFONDO:Tween = new Tween(_imagenFondo, 1.7);
			var animP_I_B:Tween = new Tween(_personajeIzqBLANCO, 1.7);
			var animP_I_N:Tween = new Tween(_personajeIzqNEGRO, 1.7);
			var animP_D_B:Tween = new Tween(_personajeDerBLANCO, 1.7);
			var animP_D_N:Tween = new Tween(_personajeDerNEGRO, 1.7);
			var animTitulo_BATALLA:Tween = new Tween(_imgTITULO_BATALLA, 1.7);
			var animHUD_BATALLA:Tween = new Tween(_multiHUD_BATALLA, 1.7);
			var animHUD_MULTI:Tween = new Tween(_multiHUD_MULTI, 1.7);
			var animtextoJugadorIzq:Tween = new Tween(_textJugadorIzq, 1.7);
			var animtextoJugadorDer:Tween = new Tween(_textjugadorDer, 1.7);
			var animAtras_Modo:Tween = new Tween(_imgTextATRAS, 1.7);
			var animNORMAL:Tween = new Tween(_imgTextNORMAL, 1.7);
			var animATRAS:Tween = new Tween(_atras, 1.7);
			var animGO:Tween = new Tween(_GO, 1.7);
			var animTextTITULO_MODO:Tween = new Tween(_imgTITULO_MULTI, 1.7);
			
			animFONDO.animate("x", _imagenFondo.x - 150);
			animP_I_B.animate("x", _personajeIzqBLANCO.x - 1200);
			animP_I_N.animate("x", _personajeIzqNEGRO.x - 1200);
			animP_D_B.animate("x", _personajeDerBLANCO.x - 1200);
			animP_D_N.animate("x", _personajeDerNEGRO.x - 1200);
			animTitulo_BATALLA.animate("x", 45);
			animTitulo_BATALLA.animate("y", 532);
			animTitulo_BATALLA.scaleTo(0.9);
			animHUD_BATALLA.animate("x", _multiHUD_BATALLA.x - 1200);
			animHUD_MULTI.animate("x", _multiHUD_MULTI.x - 1200);
			animtextoJugadorIzq.animate("x", _textJugadorIzq.x - 1200);
			animtextoJugadorDer.animate("x", _textjugadorDer.x - 1200);
			animAtras_Modo.animate("x", _imgTextATRAS.x - 1200);
			animNORMAL.animate("x", _imgTextNORMAL.x - 1200);
			animATRAS.animate("x", _atras.x - 1200);
			animGO.animate("x", _GO.x - 1200);
			animTextTITULO_MODO.animate("x", _imgTITULO_MULTI.x - 1200);
			
			Starling.juggler.add(animFONDO);
			Starling.juggler.add(animHUD_BATALLA);
			Starling.juggler.add(animHUD_MULTI);
			Starling.juggler.add(animAtras_Modo);
			Starling.juggler.add(animNORMAL);
			Starling.juggler.add(animP_I_B);
			Starling.juggler.add(animP_I_N);
			Starling.juggler.add(animP_D_B);
			Starling.juggler.add(animP_D_N);
			Starling.juggler.add(animTitulo_BATALLA);
			Starling.juggler.add(animtextoJugadorIzq);
			Starling.juggler.add(animtextoJugadorDer);
			Starling.juggler.add(animATRAS);
			Starling.juggler.add(animGO);
			Starling.juggler.add(animTextTITULO_MODO);
			
			animTextTITULO_MODO.onComplete = cambioPantallaAtras;
		}
		
		private function cambioPantallaAtras():void 
		{
			removeChildren();
			
			_atras = null;
			_GO = null;
			
			pantallaSeleccionMUL = new seleccionModoMULTI();
			addChild(pantallaSeleccionMUL);
		}
		
		private function seleccionarPersonajeDerNEGRO(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				if (personajeDerSeleccionado == NEGRO) {
					_personajeSelectDerNEGRO.visible = false;
					personajeDerSeleccionado = 0;
				}else {
					_personajeSelectDerBLANCO.visible = false;
					_personajeSelectDerNEGRO.visible = true;
					personajeDerSeleccionado = NEGRO;
				}
			}
			
			comprobarSeleccionados();
		}
		
		private function seleccionarPersonajeDerBLANCO(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				if (personajeDerSeleccionado == BLANCO) {
					_personajeSelectDerBLANCO.visible = false;
					personajeDerSeleccionado = 0;
				}else {
					_personajeSelectDerNEGRO.visible = false;
					_personajeSelectDerBLANCO.visible = true;
					personajeDerSeleccionado = BLANCO;
				}
			}
			
			comprobarSeleccionados();
			
		}
		
		private function seleccionarPersonajeIzqNEGRO(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				if (personajeIzqSeleccionado == NEGRO) {
					_personajeSelectIzqNEGRO.visible = false;
					personajeIzqSeleccionado = 0;
				}else {
					_personajeSelectIzqBLANCO.visible = false;
					_personajeSelectIzqNEGRO.visible = true;
					personajeIzqSeleccionado = NEGRO;
				}
			}
			
			comprobarSeleccionados();
			
		}
		
		private function seleccionarPersonajeIzqBLANCO(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				if (personajeIzqSeleccionado == BLANCO) {
					_personajeSelectIzqBLANCO.visible = false;
					personajeIzqSeleccionado = 0;
				}else {
					_personajeSelectIzqNEGRO.visible = false;
					_personajeSelectIzqBLANCO.visible = true;
					personajeIzqSeleccionado = BLANCO;
				}
			}
			
			comprobarSeleccionados();
			
		}
		
		private function comprobarSeleccionados():void 
		{
			if ((personajeDerSeleccionado != 0) && (personajeIzqSeleccionado != 0)) {
				_GO.enabled = true;
				
				_GO.addEventListener(TouchEvent.TOUCH, empezarJuego);
			}else {
				_GO.enabled = false;
				
				removeEventListener(TouchEvent.TOUCH, empezarJuego);
			}
		}
		
		private function empezarJuego(e:TouchEvent):void 
		{
			
		}
		
		private function dibujarPantalla():void 
		{
			_imagenFondo = new Image(Assets.getTexture("FondoPrincipal"));
			_imagenFondo.x = 0;
			_imagenFondo.y = -162.5;
			addChild(_imagenFondo);
			
			_multiHUD_BATALLA = new Image(Assets.getTexture("MultiHUD_BATALLA_MULTI"));
			addChild(_multiHUD_BATALLA);
			
			_multiHUD_MULTI = new Image(Assets.getTexture("MultiHUD_MULTI"));
			_multiHUD_MULTI.x = 1200;
			addChild(_multiHUD_MULTI);
			
			_atras = new Button(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_atras.overState = Assets.getAtlasTextoHUD().getTexture("textoATRAS_select");
			_atras.downState = Assets.getAtlasTextoHUD().getTexture("textoATRAS_select");
			_atras.scaleX = 0.9;
			_atras.scaleY = 0.9;
			_atras.x = 1000;
			_atras.y = 556;
			addChild(_atras);
			
			_GO = new Button(Assets.getAtlasTextoHUD().getTexture("GO!"));
			_GO.overState = Assets.getAtlasTextoHUD().getTexture("GO!_select");
			_GO.downState = Assets.getAtlasTextoHUD().getTexture("GO!_select");
			_GO.x = 640;
			_GO.y = 565;
			_GO.scaleX = 0.6;
			_GO.scaleY = 0.6;
			_GO.enabled = false;
			addChild(_GO);
			
			
			
			_imgTextNORMAL = new Image(Assets.getAtlasTextoHUD().getTexture("textoNORMAL"));
			_imgTextNORMAL.scaleX = 0.9;
			_imgTextNORMAL.scaleY = 0.9;
			_imgTextNORMAL.x = 1265;
			_imgTextNORMAL.y = 410;
			addChild(_imgTextNORMAL);
			
			_imgTITULO_BATALLA = new Image(Assets.getAtlasTextoHUD().getTexture("textoBATALLA_select"));	
			_imgTITULO_BATALLA.scaleX = 1.2;
			_imgTITULO_BATALLA.scaleY = 1.2;
			_imgTITULO_BATALLA.x = stage.stageWidth/2 - _imgTITULO_BATALLA.width / 2;
			_imgTITULO_BATALLA.y = 10;
			addChild(_imgTITULO_BATALLA);
			
			_imgTITULO_MULTI = new Image(Assets.getAtlasTextoHUD().getTexture("textoMULTI_select"));
			_imgTITULO_MULTI.scaleX = 1.5;
			_imgTITULO_MULTI.scaleY = 1.5;
			_imgTITULO_MULTI.x = (stage.stageWidth / 2 - _imgTITULO_MULTI.width / 2) + 1200;
			_imgTITULO_MULTI.y =  10;
			addChild(_imgTITULO_MULTI);
			
			_imgTextATRAS = new Image(Assets.getAtlasTextoHUD().getTexture("textoATRAS"));
			_imgTextATRAS.scaleX = 0.9;
			_imgTextATRAS.scaleY = 0.9;
			_imgTextATRAS.x = 2200;
			_imgTextATRAS.y = 556;
			addChild(_imgTextATRAS);
			
			_textJugadorIzq = new TextField(0, 0, "Izquierda: ", Assets.getFont().name, 30, 0xffffff, true);
			_textJugadorIzq.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textJugadorIzq.x = 30;
			_textJugadorIzq.y = 340;
			addChild(_textJugadorIzq);
			
			_textjugadorDer = new TextField(0, 0, "Derecha: ", Assets.getFont().name, 30, 0xffffff, true);
			_textjugadorDer.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_textjugadorDer.x = 40;
			_textjugadorDer.y = 515;
			addChild(_textjugadorDer);
			
			
			_personajeSelectIzqBLANCO =  new Image(Assets.getTexture("selectPersonaje"));
			_personajeSelectIzqBLANCO.x = 300;
			_personajeSelectIzqBLANCO.y = 312;
			_personajeSelectIzqBLANCO.width -= 10;
			_personajeSelectIzqBLANCO.height += 5;
			_personajeSelectIzqBLANCO.alpha = 0.8;
			addChild(_personajeSelectIzqBLANCO);
			_personajeSelectIzqBLANCO.visible = false;
						
			_personajeIzqBLANCO = new AnimacionPersonaje(AnimacionPersonaje.BLANCO);
			_personajeIzqBLANCO.x = 300;
			_personajeIzqBLANCO.y = 305;
			_personajeIzqBLANCO.scaleX = 0.8;
			_personajeIzqBLANCO.scaleY = 0.8;
			_personajeIzqBLANCO.alpha = 0;
			addChild(_personajeIzqBLANCO);
			
			
			_personajeSelectIzqNEGRO =  new Image(Assets.getTexture("selectPersonaje"));
			_personajeSelectIzqNEGRO.x = 400;
			_personajeSelectIzqNEGRO.y = 312;
			_personajeSelectIzqNEGRO.width -= 10;
			_personajeSelectIzqNEGRO.height += 5;
			_personajeSelectIzqNEGRO.alpha = 0.8;
			addChild(_personajeSelectIzqNEGRO);
			_personajeSelectIzqNEGRO.visible = false;
			
			_personajeIzqNEGRO = new AnimacionPersonaje(AnimacionPersonaje.NEGRO);
			_personajeIzqNEGRO.x = 400;
			_personajeIzqNEGRO.y = 305;
			_personajeIzqNEGRO.scaleX = 0.8;
			_personajeIzqNEGRO.scaleY = 0.8;
			_personajeIzqNEGRO.alpha = 0;
			addChild(_personajeIzqNEGRO);
			
			
			_personajeSelectDerBLANCO =  new Image(Assets.getTexture("selectPersonaje"));
			_personajeSelectDerBLANCO.x = 300;
			_personajeSelectDerBLANCO.y = 485;
			_personajeSelectDerBLANCO.width -= 10;
			_personajeSelectDerBLANCO.height += 5;
			_personajeSelectDerBLANCO.alpha = 0.8;
			addChild(_personajeSelectDerBLANCO);
			_personajeSelectDerBLANCO.visible = false;
			
			_personajeDerBLANCO = new AnimacionPersonaje(AnimacionPersonaje.BLANCO);
			_personajeDerBLANCO.x = 300;
			_personajeDerBLANCO.y = 478;
			_personajeDerBLANCO.scaleX = 0.8;
			_personajeDerBLANCO.scaleY = 0.8;
			_personajeDerBLANCO.alpha = 0;
			addChild(_personajeDerBLANCO);
			
			
			_personajeSelectDerNEGRO =  new Image(Assets.getTexture("selectPersonaje"));
			_personajeSelectDerNEGRO.x = 400;
			_personajeSelectDerNEGRO.y = 485;
			_personajeSelectDerNEGRO.width -= 10;
			_personajeSelectDerNEGRO.height += 5;
			_personajeSelectDerNEGRO.alpha = 0.8;
			addChild(_personajeSelectDerNEGRO);
			_personajeSelectDerNEGRO.visible = false;
			
			
			_personajeDerNEGRO = new AnimacionPersonaje(AnimacionPersonaje.NEGRO);
			_personajeDerNEGRO.x = 400;
			_personajeDerNEGRO.y = 478;
			_personajeDerNEGRO.scaleX = 0.8;
			_personajeDerNEGRO.scaleY = 0.8;
			_personajeDerNEGRO.alpha = 0;
			addChild(_personajeDerNEGRO);


		}
	}

}