package com.netoleal.loading
{
	import flash.utils.Dictionary;
	
	public class FileCaching
	{
		
		private var cache:Dictionary;
		
		private static var _instance:FileCaching;
		
		public function FileCaching( enforcer:FileSingletonEnforcer ){
			
			cache = new Dictionary( );
			
		}
		
		public static function getInstance( ):FileCaching {
			if( _instance == null ) _instance = new FileCaching( new FileSingletonEnforcer( ) );
			return _instance;
		}
		
		public function addFile( identifier:Object, loadedObjectReference:Object ):void {
			cache[ identifier ] = loadedObjectReference;
		}
		
		public function isFileInCache( identifier:Object ):Boolean {
			return cache[ identifier ] != null
		}
		
		public function getFile( identifier:Object ):Object {
			return cache[ identifier ];
		}
		
		//Static wrapers
		
		public static function addFile( identifier:Object, loadedObjectReference:Object ):void {
			getInstance( ).addFile( identifier, loadedObjectReference );
		}
		
		public static function isFileInCache( identifier:Object ):Boolean {
			return getInstance( ).isFileInCache( identifier );
		}
		
		public static function getFile( identifier:Object ):Object {
			return getInstance( ).getFile( identifier );
		}
		
	}
	
}

class FileSingletonEnforcer { }