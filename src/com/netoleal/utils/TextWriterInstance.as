package com.netoleal.utils
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class TextWriterInstance
	{
		private var timer:Timer;
		private var field:*;
		private var cursor:String;
		private var cAmount:uint;
		private var text:String;
		
		private var clearing:Boolean = false;
		
		public function TextWriterInstance( inputField:*, writeText:String, writeCursor:String = " _", concatAmount:uint = 1, clearBefore:Boolean = false, betweenLettersInterval:uint = 30 )
		{
			field = inputField;
			cursor = writeCursor;
			cAmount = concatAmount;
			text = writeText;
			
			timer = new Timer( betweenLettersInterval );
			timer.addEventListener( TimerEvent.TIMER, timerHandler );
			
			clearing = clearBefore;
			
			if( !clearBefore )
			{
				field.text = "";
			}
			
			timer.start( );
		}
		
		private function timerHandler( evt:TimerEvent ):void
		{
			if( clearing )
			{
				removeLastsChars( );
			}
			else
			{
				concatChars( );
			}
		}
		
		private function removeLastsChars( ):void
		{
			field.text = field.text.substr( 0, field.text.length - cAmount );
			
			if( field.text == "" )
			{
				clearing = false;
			}
		}
		
		private function concatChars( ):void
		{
			var s:uint = Math.max( 0, field.text.length - cursor.length );
			field.text = text.substr( 0, s + cAmount ) + cursor;
			
			if( s == text.length )
			{
				dispose( );
			}
		}
		
		public function stop( ):void
		{
			if( timer && timer.running ) timer.stop( );
		}
		
		public function resume( ):void
		{
			if( !timer.running ) timer.start( );	
		}
		
		public function isActive( ):Boolean
		{
			return timer != null;
		}
		
		public function dispose( ):void
		{
			stop( );
			
			timer.removeEventListener( TimerEvent.TIMER, timerHandler );
			timer = null;
			field.text = text;
		}
	}
}