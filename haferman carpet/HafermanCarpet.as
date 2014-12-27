package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Haferman Carpet
	 * 
	 * 2014. 12. 25 (Merry Christmas!)
	 * 
	 * @author HyunJun Kim
	 */
	public class HafermanCarpet {
		
		private var filled : Boolean;		
		private var offsprings : Array;
		
		public function HafermanCarpet( filled : Boolean = true ) {
			
			offsprings = new Array( 9 );
			this.filled = filled;
		}		
		
		/**
		 * Recursively render Haferman Carpet and return result as a BitmapData
		 * 
		 * @param	iteration fractal level
		 * @return
		 */
		public function render( iteration : uint ) : BitmapData {
			
			var size : int = Math.pow( 3, iteration );
			
			var patch : Rectangle = new Rectangle ( 0, 0, size / 3, size / 3 );			
			var canvas : BitmapData = new BitmapData ( size, size, false, filled ? 0x000000 : 0xFFFFFF );
			
			if ( iteration > 0 ) {
				
				var destination : Point = new Point();
				
				for ( var i : int = 0; i < 9; i ++ ) {
					
					destination.x = patch.width * ( i % 3 );
					destination.y = patch.height * Math.floor( i / 3 );
					
					offsprings[ i ] = new HafermanCarpet( ( i % 2 == 1 ) || ! filled );
					var offspring:BitmapData = HafermanCarpet( offsprings[ i ] ).render( iteration - 1 );
					canvas.copyPixels( offspring, patch, destination );	
					offspring.dispose();
				}
			}
			
			return canvas;
		}		
	}

}