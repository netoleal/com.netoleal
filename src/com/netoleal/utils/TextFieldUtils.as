package com.netoleal.utils
{
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class TextFieldUtils
	{
		
		public static function config( field:TextField, size:int = 0, color:int = 0x000000, autoSize:Boolean = false, 
										multiline:Boolean = false, wordWrap:Boolean = false, selectable:Boolean = false, 
										mouseEnabled:Boolean = false, embed:Boolean = true ):TextFormat
		{
			var fmt:TextFormat = field.defaultTextFormat || new TextFormat( );
			fmt.color = color;
			if( size != 0 ) fmt.size = size;
			
			applyTextFormat( field, fmt );
			
			if( autoSize ) field.autoSize = TextFieldAutoSize.LEFT;
			
			if( embed )
			{
				field.embedFonts = true;
				field.antiAliasType = AntiAliasType.ADVANCED;
			}
			
			field.mouseEnabled = mouseEnabled;
			field.multiline = multiline;
			field.wordWrap = wordWrap;
			field.selectable = selectable;
			
			return fmt; 
		}
		
		public static function resize( field:TextField, w:Number, h:Number = 0 ):void
		{
			field.width = w;
			if( h != 0 ) field.height = h;
		}
		
	}
	
}