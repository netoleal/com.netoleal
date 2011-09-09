package com.netoleal.events
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class EventDispatcherExtended extends EventDispatcher
	{
		private var _listeners:Object;
		
		public function EventDispatcherExtended(target:IEventDispatcher=null)
		{
			super(target);
			_listeners = new Object( );
		}
		
		public override function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true ):void {
			
			super.addEventListener( type, listener, useCapture, priority, useWeakReference );
			if( ! hasListenerType( type ) ) {
				_listeners[ type ] = new Array( );
				
			}
			_listeners[ type ].push( listener );
			
		}
		
		public override function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			super.removeEventListener( type, listener, useCapture );
			
			if( hasListenerType( type ) ){
				for( var n:uint = 0; n < _listeners[ type ].length; n++ ){
					if( _listeners[ type ][ n ] == listener ){
						_listeners[ type ].splice( n, 1 );
					}
				}
				
				if( _listeners[ type ].length == 0 ) delete _listeners[ type ];
			}
		}
		
		public function removeAllEventListeners( type:String = "" ):void {
			if( type != "" ){
				this.removeListenersFromType( type );
			} else {
				for( var stype:String in _listeners ){
					this.removeListenersFromType( stype );
				}
			}
			
			this._listeners = new Object( );
		}
		
		private function removeListenersFromType( type:String ):void {
			
			if( hasListenerType( type ) ){
				var n:uint = 0;
				var listener:*;
								
				while( listener = _listeners[ type ][ n++ ] ) {
					super.removeEventListener( type, listener );
				}
				
				delete _listeners[ type ];
			}
		}
		
		private function hasListenerType( type:String ):Boolean {
			return _listeners[ type ] != null && _listeners[ type ] != undefined;
		}
		
	}
}