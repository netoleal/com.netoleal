package com.netoleal.validators
{
	import com.netoleal.interfaces.IValidation;

	public class CountLengthValidation implements IValidation
	{
		private var values:Array;
		
		public function CountLengthValidation()
		{
		}

		public function validate():Boolean
		{
			var n:uint = 0;
			var firstValue:*;
			var secondValue:uint;
			
			while( firstValue = this.values[ n++ ] ){
				
				secondValue = this.values[ n++ ];
				
				if( String( firstValue ).length != secondValue ) return false;
				
			}
			
			return true;
		}
		
		public function create(args:Array):void
		{
			values = args.concat( );
		}
		
	}
}