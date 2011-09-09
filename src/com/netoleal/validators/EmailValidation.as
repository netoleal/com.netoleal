package com.netoleal.validators {

	import com.netoleal.interfaces.IIterator;
	import com.netoleal.interfaces.IValidation;
	import com.netoleal.iterators.AscendingArrayIterator;

	// Thanks to Arthur Debert - http://www.stimuli.com.br/
	
	public class EmailValidation implements IValidation {
		
		private var emails:Array;
		
		public static const EMAIL_REGEX : RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
		
		function EmailValidation( ) { }
		
		/**
		* Create validation parameters
		* 
		* @param	args An array containing all emails to be validated
		*/
		public function create( args:Array ):void {
			this.emails = args.concat( );
		}
		
		/**
		* Perform validation
		* TODO: implement me
		* @return
		*/
		public function validate( ):Boolean {
			
			var it:IIterator = new AscendingArrayIterator( this.emails );
			var email:String;
			
			while( it.hasNext( ) ){
				email = it.next( );
				if( !checkEmail( email ) ){
					return false;
				}
			}
			
			return true;
		}
		
		public function checkEmail (email:String):Boolean {
			 return EMAIL_REGEX.test( email );
		}
		
	}
	
}
