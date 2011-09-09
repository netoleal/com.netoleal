package com.netoleal.utils
{
	public function noCache( url:String, replacementString:String ):String
	{
		return url.replace( replacementString, Math.round( Math.random( ) * ( new Date( ).getTime( ) ) ) );
	}
}