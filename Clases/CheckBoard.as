package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class CheckBoard extends Sprite
	{
		var n:Number;
		var m:Number;
		var v:Number = 0;
		var h:Number = 0;
		var box:Box;
		
		public function CheckBoard(filas:Number, columnas:Number) 
		{
			n = filas;
			m = columnas;
			crearBoxes();
		}
		
		private function crearBoxes():void
		{
			for (var i:Number = 0; i < n ; i++) {
				for (var j:Number = 0; j < m ; j++) {
					box = new Box();
					box.x = v;
					box.y = h;
					v = v + 20;
					addChild(box);
				}
				h = h + 20;
				v = 0;
			}
		}
	}

}