package com.netoleal.interfaces
{
	public interface IDisplayElement
	{
		function show( delay:Number = 0 ):void;
		function destroy( delay:Number = 0, callback:Function = null ):void;
		function hide( delay:Number = 0 ):void;
	}
}