package com.netoleal.utils
{
	public class XMLUtils
	{
		public static function getNodePath( node:*, sep:String = "/" ):String
		{
			var aNames:Array = [ node.name( ) ];
			
			while( node.parent( ) != null && node.parent( ).parent( ) != null )
			{
				node = node.parent( );
				aNames.push( node.name( ) );
			}
			
			return aNames.reverse( ).join( sep );
		}
		
		public static function nodeHasChilds( node:XML ):Boolean
		{
			var nodeChildren:XMLList = node.children( );
				 
			if( nodeChildren.length( ) > 0 )
			{
				if( nodeChildren.length( ) == 1 && ( nodeChildren[ 0 ] as XML ).nodeKind( ) == "text" )
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			else
			{
				return false;
			}
		}
		
		public static function toObject( xml:XML, startObject:Object = null ):Object
		{
			if( startObject == null ) startObject = new Object( );
			
			var node:XML;
			var children:XMLList = xml.children( );
			var attr:XMLList = xml.attributes( );
			var nodeChildren:XMLList;
			
			for each( node in children )
			{
				nodeChildren = node.children( );
				 
				if( nodeChildren.length( ) > 0 )
				{
					if( nodeChildren.length( ) == 1 && ( nodeChildren[ 0 ] as XML ).nodeKind( ) == "text" )
					{
						startObject[ node.name( ) ] = String( node.text( ) );
					}
					else
					{
						startObject[ node.name( ) ] = toObject( node );
					}
				}
				else
				{
					startObject[ node.name( ) ] = String( node.text( ) );
				}
			}
			
			for each( node in attr )
			{
				startObject[ node.name( ) ] = node.text( );
			}
			
			return startObject;
		}
	}
}