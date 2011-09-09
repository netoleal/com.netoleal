package com.netoleal.validators {

	import com.netoleal.interfaces.IValidation;

	public class ValidationWrapper {
		/**
		* Wrapper to validation
		* 
		* @param	args Array containing parameters to be passed to create method of validationType.
		* @param	validationType Type of validation.
		* @return
		*/
		public static function validate( args:Array, validationType:Class ):Boolean {
			var validation:IValidation = new validationType( );
			validation.create( args );
			return validation.validate( );
		}
	}
}