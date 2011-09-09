package com.netoleal.net
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XMLURLLoader extends URLLoader
	{
		private var xml:XML;
		
		public function XMLURLLoader(request:URLRequest=null)
		{
			super(request);
		}
		
		protected function geXML( ):XML
		{
			if( xml == null ) xml = new XML( this.data );
			return xml;
		}
		
	}
}