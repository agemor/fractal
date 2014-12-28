package  
{
	import flash.display.BitmapData;
	/**
	 * Mandelbrot Set
	 * 
	 * 2014. 12. 27
	 * 
	 * @author HyunJun Kim
	 */
	public class MandelbrotSet {
		
		public function MandelbrotSet() { }
		
		/**
		 * Render Mandelbrot Set
		 * 
		 * @param	accuracy Mandelbrot Set resolution
		 * @param	infinityLimit 
		 * @return
		 */
		public function render( accuracy : int, infinityLimit : int ) : BitmapData {
			
			var canvas : BitmapData = new BitmapData( 3 * accuracy, 2 * accuracy, false, 0xFFFFFF );
			canvas.lock();
			
			for ( var x : int = 0; x < canvas.width; x ++ ) {				
				for ( var y : int = 0; y < canvas.height; y ++ ) {					
					canvas.setPixel( x, y, divergent( x / accuracy - 2, y / accuracy - 1, infinityLimit ) *  0xFFFFFF );					
				}
			}
			
			canvas.unlock();			
			return canvas;
		}
		
		/**
		 * Check whether complex number a + bi diverges
		 * 
		 * @param	a
		 * @param	b
		 * @return	divergent speed. if 0, it is not divergent
		 */
		private function divergent( a:Number, b:Number, infinityLimit : int = 100 ) : Number {
			
			var x : Number = a;
			var y : Number = b;
			var t : Number = 0;
			
			for ( var i : int = 0; i < infinityLimit; i ++ ) {
				
				t = x;
				x = Math.pow( x, 2 ) - Math.pow ( y, 2 ) + a;
				y = 2 * t * y + b;
				
				if ( Math.pow( x, 2 ) + Math.pow( y, 2 ) > 4 ) {
					return i / infinityLimit;
				}
			}
			
			return 0;
		}
		
	}

}