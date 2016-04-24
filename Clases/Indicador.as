package
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author j
	 */
	public class Indicador extends Sprite
	{
		public var indImagen:Image;
		
		public function Indicador()
		{
			super();
			iniciaIndicador();
		}
		
		private function iniciaIndicador():void 
		{
			indImagen = new Image(Assets.getTexture("IndPosicion"));
	
		}
	
	}

}