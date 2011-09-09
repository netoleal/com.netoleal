package com.netoleal.loading
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.display.Loader;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class BatchPreloaderElement extends EventDispatcher
	{
		private var dispatcherObject:EventDispatcher;
		private var loaderObject:Object;
		private var urlReq:URLRequest;
		private var context:LoaderContext;
		
		private var bl:Number;
		private var bt:Number;
		
		public function BatchPreloaderElement( dispatcher:EventDispatcher, url:URLRequest, loader:Object = null, context:LoaderContext = null )
		{
			super( this );
			
			this.dispatcherObject = dispatcher;
			this.loaderObject = loader || dispatcher;
			this.urlReq = url;
			this.context = context || new LoaderContext( false, ApplicationDomain.currentDomain );
			
			this.dispatcherObject.addEventListener( Event.COMPLETE, eventHandler );
			this.dispatcherObject.addEventListener( ProgressEvent.PROGRESS, eventHandler );
			this.dispatcherObject.addEventListener( IOErrorEvent.IO_ERROR, eventHandler );
			this.dispatcherObject.addEventListener( Event.OPEN, eventHandler );
			this.dispatcherObject.addEventListener( Event.INIT, eventHandler );
			this.dispatcherObject.addEventListener( HTTPStatusEvent.HTTP_STATUS, eventHandler );
			
		}
		
		public function clearListeners( ):void {
			
			this.dispatcherObject.removeEventListener( Event.COMPLETE, eventHandler );
			this.dispatcherObject.removeEventListener( ProgressEvent.PROGRESS, eventHandler );
			this.dispatcherObject.removeEventListener( IOErrorEvent.IO_ERROR, eventHandler );
			this.dispatcherObject.removeEventListener( Event.OPEN, eventHandler );
			this.dispatcherObject.removeEventListener( Event.INIT, eventHandler );
			this.dispatcherObject.removeEventListener( HTTPStatusEvent.HTTP_STATUS, eventHandler );
			
		}
		
		private function eventHandler( evt:Event ):void {
			
			switch( evt.type ){
				case Event.COMPLETE:
				
					this.bl = this.bt;
					this.dispatchEvent( new Event( Event.COMPLETE ) );
				
				break;
				case ProgressEvent.PROGRESS:
					
					this.bl = ( evt as ProgressEvent ).bytesLoaded;
					this.bt = ( evt as ProgressEvent ).bytesTotal;
					
					this.dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, bl, bt ) );
					
				break;
				case IOErrorEvent.IO_ERROR:
					
					this.dispatchEvent( new IOErrorEvent( IOErrorEvent.IO_ERROR ) );
					
				break;
				case HTTPStatusEvent.HTTP_STATUS:
				
					this.dispatchEvent( new HTTPStatusEvent( HTTPStatusEvent.HTTP_STATUS ) );
					
				break;
				default:
				
					this.dispatchEvent( evt.clone( ) );
					
				break;
			}
			
		}
		
		public function getBytesLoaded( ):Number {
			return this.bl;
		}
		
		public function getBytesTotal( ):Number {
			return this.bt;
		}
		
		public function load( ):void {
			
			this.bl = 0;
			this.bt = 0;
			
			try {
				this.loaderObject.close( );
			} catch( e:Error ){
				
			}
			
			try {
				
				if( this.loaderObject is Loader ) {
					
					//var context:LoaderContext = new LoaderContext( false, ApplicationDomain.currentDomain );
					( this.loaderObject as Loader ).load( urlReq, this.context );
					
				} else {
					this.loaderObject.load( urlReq );
				}
				
			} catch( e:Error ){
				
				throw( new Error( "BatchPreloaderElement ERROR :: the provided loader object has not 'load' method" ) );
				
			}
			
		}
		
		public function getURL( ):URLRequest {
			return this.urlReq;
		}
		
		public function getDispatcherObject( ):EventDispatcher {
			return this.dispatcherObject;
		}
		
		public function getLoaderObject( ):Object {
			return this.loaderObject;
		}
		
	}
	
}