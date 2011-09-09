/**
* ...
* @author Default
* @version 0.1
*/

package com.netoleal.validators {
	
	import com.netoleal.interfaces.IValidation;

	public class MatchValueValidation implements IValidation {
		
		private var values:Array;
		
		public function MatchValueValidation() {
			
		}
		
		public function create( args:Array ):void {
			values = args.concat( );
		}
		
		public function validate( ):Boolean {
			
			var n:uint = 0;
			var firstValue:Object;
			var secondValue:Object;
			
			while( firstValue = this.values[ n++ ] ){
				
				secondValue = this.values[ n++ ];
				
				if( firstValue != secondValue ) return false;
				
			}
			
			return true;
		}
		
	}
	
}
