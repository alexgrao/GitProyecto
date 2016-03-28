package 
{
	import starling.display.Image;
	/**
	 * ...
	 * @author Alejandro López Balderas
	 */
	public class Bola 
	{
		private var color:int; //1-Rojo, 2-Amarillo, 3-Verde, 4-Azul
		private var tipo:int; //1-Normal, 2-Tiempo+, 3-Puntos+, 4-Comodin...
		private var imagen:Image;
		
		public function Bola(Color:int,Tipo:int) 
		{
			color = Color;
			tipo = Tipo;
			switch(tipo) 
			{
				case 1: switch (color) 
				{
					case 1: imagen = new Image(Assets.getTexture("BolaRoja"));
					case 2: imagen = new Image(Assets.getTexture("BolaAmarilla"));
					case 3: imagen = new Image(Assets.getTexture("BolaVerde"));
					case 4: imagen = new Image(Assets.getTexture("BolaAzul"));
						
					break;
				}
				break;
			}
		}
		
		public function getColor():int
		{
			return color;
		}
		
		public function getTipo():int
		{
			return tipo;
		}
		
		public function getTipo():int
		{
			return tipo;
		}
		
		public function getImagen():Image
		{
			return imagen;
		}
	}

}