package com.netoleal.validators {
		
	public class ValidationResult
	{
		public static const SUCCESS:String = "success";
		public static const FAILURE:String = "failure";
		
		private var _message:String;
		private var _type:String;
		private var _validationType:Class;
		
		public var phase:uint;
		
		/**
		* Constructor
		* 
		* @param	type Type of result. Use constants to set this parameter. ValidationResult.SUCCESS or ValidationResult.FAILURE
		* @param	message A message to be recorded with the result. Could be an error or success message or anything else.
		*/
		function ValidationResult( type:String, message:String = "", validationType:Class = null ) {
			this._message = message;
			this._type = type;
			this._validationType = validationType;
		}
		
		/**
		* Return if validation is SUCCESS
		* 
		* @return
		*/
		public function isValid( ):Boolean {
			return this._type == ValidationResult.SUCCESS;
		}
		
		public function get message( ):String {
			return this._message;
		}
		
		public function get type( ):String {
			return this._type;
		}
		
		public function get validationType( ):Class {
			return this._validationType;
		}
	}
}