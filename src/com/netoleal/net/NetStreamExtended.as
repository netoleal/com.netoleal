package com.netoleal.net
{
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
	import flash.events.Event;
	import com.netoleal.events.NetStreamEvent;

	public class NetStreamExtended extends NetStream
	{
		
		private const STATUS_SWITCH:String = "NetStream.Play.Switch";
		private const STATUS_STOP:String = "NetStream.Play.Stop";
		private const STATUS_START:String = "NetStream.Play.Start";
		private const STATUS_BUFFER_FULL:String = "NetStream.Buffer.Full";
		private const STATUS_BUFFER_EMPTY:String = "NetStream.Buffer.Empty";		
		
		private var isPaused:Boolean = false;
		private var metaData:Object;
		
		public static var checkPolicyFile:Boolean = true;
		
		public function NetStreamExtended(connection:NetConnection)
		{
			super(connection);
			this.addEventListener( NetStatusEvent.NET_STATUS, this.handlerNetStatusEvent );
			
			//TraceUtils.consoleTrace( "checkPolicyFile: " + NetStreamExtended.checkPolicyFile );
			
			this.checkPolicyFile = NetStreamExtended.checkPolicyFile;
			
		}
		
		public override function play( ... rest ):void{
			
			this.checkPolicyFile = NetStreamExtended.checkPolicyFile;
			
			//TraceUtils.consoleTrace( "checkPolicyFile: " + NetStreamExtended.checkPolicyFile );
			
			super.play.apply( this, rest );
			
		}
		
		public override function pause( ):void {
			
			isPaused = true;
			super.pause( );
			this.dispatchEvent( new NetStreamEvent( NetStreamEvent.PAUSE ) );
			
		}
		
		public override function resume( ):void {
			
			isPaused = false;
			this.checkPolicyFile = NetStreamExtended.checkPolicyFile;
			super.resume( );
			this.dispatchEvent( new NetStreamEvent( NetStreamEvent.RESUME ) );
			
		}
		
		public override function togglePause( ):void {
			if( isPaused ){
				resume( );
			} else {
				pause( );
			}
		}
		
		public function onMetaData( info:Object ):void {
			
			this.metaData = info;
			this.dispatchEvent( new NetStreamEvent( NetStreamEvent.META_DATA ) );
			
		}
		
		public function getMetaData( ):Object{
			
			return this.metaData;
			
		}
		
		private function handlerNetStatusEvent( evt:NetStatusEvent ):void {
			
			switch( evt.info.code ){
				
				case STATUS_STOP:
					
					if( !isPaused ){
						this.dispatchEvent( new NetStreamEvent( NetStreamEvent.COMPLETE ) );
					}
					
				break;
				case STATUS_BUFFER_EMPTY:
					this.dispatchEvent( new NetStreamEvent( NetStreamEvent.BUFFER_EMPTY ) );
				break;
				case STATUS_BUFFER_FULL:
					this.dispatchEvent( new NetStreamEvent( NetStreamEvent.BUFFER_FULL ) );
				break;
				case STATUS_START:
					this.dispatchEvent( new NetStreamEvent( NetStreamEvent.START ) );
				break;
				
			}
			
		}
		
	}
	
}
