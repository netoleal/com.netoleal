package com.netoleal.validators {
		
	import com.netoleal.interfaces.IIterator;
	import com.netoleal.interfaces.IValidation;
	import com.netoleal.iterators.AscendingArrayIterator;

	public class IsSetValidation implements IValidation {
		
		private var args:Array;
		
		function IsSetValidation() { }
		
		/**
		* Create validation parameters
		* 
		* @param	args
		*/
		public function create( args:Array ):void {
			this.args = args.concat( );
		}
		
		/**
		* Perform validation
		* 
		* @return
		*/
		public function validate( ):Boolean {
			var it:IIterator = new AscendingArrayIterator( this.args );
			var value:Object;
			
			while( it.hasNext( ) ){
				value = it.next( );
				
				if( value == null ){
					return false;
				}
			}
			
			return true;
		}
		
	}
}