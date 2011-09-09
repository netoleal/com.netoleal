package com.netoleal.geom
{
	import flash.geom.Point;
	
	public class Triangle
	{
		
		private var A:Object;
		private var B:Object;
		private var C:Object;
		
		public function Triangle( 	vertexAX:Number, vertexAY:Number, 
									vertexBX:Number, vertexBY:Number,
									vertexCX:Number, vertexCY:Number ){
					
			this.A = { x: vertexAX, y: vertexAY };
			this.B = { x: vertexBX, y: vertexBY };
			this.C = { x: vertexCX, y: vertexCY };
								
		}
		
		/*
		public function isPointInMe( pointX:Number, pointY:Number ):Boolean {
			
			var p:Object = { x: pointX, y: pointY };
			
			var result:Boolean = false;
			
			var y1:Number = ( C.y - B.y ) / ( C.x - B.x ) * ( p.x - B.x );
			var y2:Number = ( C.y - A.y ) / ( C.x - A.x ) * ( p.x - A.x );
			var y3:Number = ( A.y - B.y ) / ( A.x - B.x ) * ( p.x - B.x );
			
			if( ( ( y1 > C.y ) && ( y1 > A.y ) && ( y1 > B.y ) ) || ( ( y1 < C.y ) && ( y1 < A.y ) && ( y1 < B.y ) ) ){
				if( ( ( p.y - y2 ) * ( p.y - y3 ) ) >= 0 ) result = true;
			}else if( ( ( y2 > C.y ) && ( y2 > A.y ) && ( y2 > B.y ) ) || ( ( y2 < C.y ) && ( y2 < A.y ) && ( y2 < B.y ) ) ){
				if( ( ( p.y - y1 ) * ( p.y - y3 ) ) >= 0 ) result = true;
			}else{
				if( ( ( p.y - y1 ) * ( p.y - y2 ) ) >= 0 ) result = true;
			}
			
			return result; 
			
		}
		*/
		
		public function isPointInMe( pointX:Number, pointY:Number ):Boolean{
		
			var p:Point = new Point( pointX, pointY );
			var pTriA:Object = A;
			var pTriB:Object = B;
			var pTriC:Object = C;
			
			var oneOverDenom:Number = (1 /(((pTriA.y - pTriC.y) * (pTriB.x - pTriC.x)) + ((pTriB.y - pTriC.y) * (pTriC.x - pTriA.x))));
			var b1:Number = (oneOverDenom *(((p.y - pTriC.y) * (pTriB.x - pTriC.x)) + ((pTriB.y - pTriC.y) * (pTriC.x - p.x))));
			var b2:Number = (oneOverDenom * (((p.y - pTriA.y) * (pTriC.x - pTriA.x)) + ((pTriC.y - pTriA.y) * (pTriA.x - p.x))));
			var b3:Number = (oneOverDenom * (((p.y - pTriB.y) * (pTriA.x - pTriB.x)) + ((pTriA.y - pTriB.y) * (pTriB.x - p.x))));
			
			return ((b1 > 0) && (b2 > 0) && (b3 > 0)); 
		}
			
	}
	
}