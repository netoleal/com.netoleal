package com.netoleal.validators {

	import com.netoleal.interfaces.IIterator;
	import com.netoleal.interfaces.IValidation;
	import com.netoleal.iterators.AscendingArrayIterator;

	public class NumericValidation implements IValidation {
		
		private var numbers:Array;
		
		function NumericValidation()
		{
			
		}
		
		/**
		* Create validation parameters
		* 
		* @param	args An array containing all values to be validated as numbers
		*/
		public function create( args:Array ):void {
			this.numbers = args.concat( );
		}
		
		/**
		* Perform validation
		* 
		* @return
		*/
		public function validate( ):Boolean {
			var it:IIterator = new AscendingArrayIterator( this.numbers );
			var value:*;
			
			while( it.hasNext( ) ){
				value = it.next( );
				if( isNaN( value ) ){
					return false;
				}
			}
			
			return true;
		}
	}
}