package com.netoleal.validators {

	import com.netoleal.interfaces.IValidation;
	import com.netoleal.validators.ValidationResult;
	import com.netoleal.validators.ValidationWrapper;

	public class ValidationGroup {
		
		private var validations:Array;
		
		private var className:String = "ValidationGroup";
		
		function ValidationGroup( )
		{
			this.validations = new Array();
		}
		
		/**
		* Add a validation to group
		* 
		* @param	args An array containing values to be passed to "create" method of "valdationType"
		* @param	validationType The type of Validation. Could be DateValidation, EmailValidation, NumericValidation etc.
		* @param	errorMessage A message to be returned in case of validation failure
		* 
		* @see com.netoleal.interfaces.IValidation
		* @see com.netoleal.validators.DateValidation
		* @see com.netoleal.validators.EmailValidation
		* @see com.netoleal.validators.NumericValidation
		* @see com.netoleal.validators.NumericRangeValidation
		* @see com.netoleal.validators.RestrictCharsValidation
		* @see com.netoleal.validators.IsNotEmptyValidation
		* @see com.netoleal.validators.IsSetValidation
		*/
		public function addValidation( args:Array, validationType:Class, errorMessage:String ):void {
			this.validations.push( [ args, validationType, errorMessage ] );
		}
		
		/**
		* Remove all validations
		*/
		public function clear( ):void {
			this.validations = new Array();
		}
		
		/**
		* Perform validation on group
		* 
		* @return
		*/
		public function validate( ):ValidationResult {
			
			var n:Number;
			var t:Number = this.validations.length;
			
			var args:Array;
			var type:Class;
			var message:String;
			
			var result:ValidationResult;
			
			for( n = 0; n < t; n ++ ){
				args	= this.validations[ n ][ 0 ];
				type	= this.validations[ n ][ 1 ];
				message	= this.validations[ n ][ 2 ];
				
				if( ! ValidationWrapper.validate( args, type ) ) 
				{
					result = new ValidationResult( ValidationResult.FAILURE, message, type );
					result.phase = n;
					
					return result;
				}
			}
						
			return new ValidationResult( ValidationResult.SUCCESS );
		}
		
	}
}