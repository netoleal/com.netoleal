package com.netoleal.utils
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public function applyTextFormat( textField:TextField, format:TextFormat ):void
	{
		textField.defaultTextFormat = format;
		textField.setTextFormat( format );
	}
}