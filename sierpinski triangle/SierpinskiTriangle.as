package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Sierpinski Triangle
	 * 
	 * 2014. 12. 27
	 * 
	 * @author HyunJun Kim
	 */
	public class SierpinskiTriangle {
		
		private const TRIANGLE_COMPOSITION : Array = [ [ 0.5 , 0 ], [ 0, 1 ], [ 1, 1 ] ];
		
		private var offsprings : Array;
		private var triangleUnit : BitmapData;
		
		public function SierpinskiTriangle() {
			offsprings = new Array( 3 );
			triangleUnit = new BitmapData( 2, 2, false, 0x000000 );
		}
		
		/**
		 * Recursively render Sierpinski Triangle and return result as a BitmapData
		 * 
		 * @param	iteration fractal level
		 * @return
		 */
		public function render( iteration : uint ) : BitmapData {
			
			var size:int = Math.pow( 2, iteration ) * 2;
			
			var patch : Rectangle = new Rectangle( 0, 0, size / 2, size / 2 );
			var canvas : BitmapData = new BitmapData( size, size, true, 0xFFFFFF);
			
			var destination : Point = new Point();
				
			for ( var i : int = 0; i < 3; i ++ ) {
				
				destination.x = TRIANGLE_COMPOSITION[ i ][ 0 ] * patch.width;
				destination.y = TRIANGLE_COMPOSITION[ i ][ 1 ] * patch.height;
				
				var offspring : BitmapData;
				
				if ( iteration > 1 ) {
					
					offsprings[ i ] = new SierpinskiTriangle();
					offspring = SierpinskiTriangle( offsprings[ i ] ).render( iteration - 1 );
					canvas.copyPixels( offspring, patch, destination );
					offspring.dispose();
					
				} else {					
					canvas.copyPixels( triangleUnit, patch, destination );
					
				}
			}			
			
			return canvas;
		}
	}

}