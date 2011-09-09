package com.netoleal.utils
{
	import flash.text.TextField;
	
	public final class TextWriter
	{
		public static function write( inputField:*, writeText:String, concatAmount:uint = 1, writeCursor:String = " _", clearBefore:Boolean = false, betweenLettersInterval:uint = 30 ):TextWriterInstance
		{
			return new TextWriterInstance( inputField, writeText, writeCursor, concatAmount, clearBefore, betweenLettersInterval );
		}
	}
}