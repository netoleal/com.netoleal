/**
* ...
* @author Default
* @version 0.1
*/

package com.netoleal.common {
	
	import com.netoleal.events.ScrollerEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	[Event(name="scroll", type="com.netoleal.events.ScrollerEvent")]
	
	[Event(name="stopScrolling", type="com.netoleal.events.ScrollerEvent")]
	
	[Event(name="startScrolling", type="com.netoleal.events.ScrollerEvent")]

	public class Scroller extends EventDispatcher {
		
		private var _tracker:Sprite;
		private var _track:DisplayObject;
		private var _minusButton:DisplayObject;
		private var _plusButton:DisplayObject;
		
		private var _dragging:Boolean;
		private var _direction:uint;
		
		private var _yDif:Number;
		private var _xDif:Number;
		
		private const MIN:uint = 0;
		private const MAX:uint = 1;
		private const STEP:Number = 5;
		
		private var timer:Timer;
		private const delay:Number = 700;
		
		private var _stage:Stage;
		
		public function Scroller( stage:Stage, tracker:Sprite, track:DisplayObject, minusButton:DisplayObject = null, plusButton:DisplayObject = null, direction:uint = 0 ) {
			
			_track = track;
			_tracker = tracker;
			
			_minusButton = minusButton;
			_plusButton = plusButton;
			
			_direction = direction;
			
			_tracker.addEventListener( MouseEvent.MOUSE_DOWN, this.startDragging );
			_stage = stage;
			
			stage.addEventListener( MouseEvent.MOUSE_UP, this.stopDragging );
			
			if( _minusButton ) {			
				_minusButton.addEventListener( MouseEvent.MOUSE_DOWN, minusDown );
				_minusButton.addEventListener( MouseEvent.MOUSE_UP, minusUp );
			}
			
			if( _plusButton ) {
				_plusButton.addEventListener( MouseEvent.MOUSE_DOWN, plusDown );
				_plusButton.addEventListener( MouseEvent.MOUSE_UP, plusUp );
			}
			
			timer = new Timer( delay, 1 );
		}
		
		public function dispose( ):void
		{
			if( _minusButton ) {			
				_minusButton.removeEventListener( MouseEvent.MOUSE_DOWN, minusDown );
				_minusButton.removeEventListener( MouseEvent.MOUSE_UP, minusUp );
			}
			
			if( _plusButton ) {
				_plusButton.removeEventListener( MouseEvent.MOUSE_DOWN, plusDown );
				_plusButton.removeEventListener( MouseEvent.MOUSE_UP, plusUp );
			}
			
			_tracker.removeEventListener( MouseEvent.MOUSE_DOWN, this.startDragging );
			_stage.removeEventListener( MouseEvent.MOUSE_UP, this.stopDragging );
			
			_stage = null;
			
			_minusButton = null;
			_plusButton = null;
			_track = null;
			_tracker = null;
		}
		
		private function minusDown( evt:MouseEvent = null ):void {
			scrollUp( );
			stopTimer( );
			timer.addEventListener( TimerEvent.TIMER, this.startScrollingDown );
			timer.start( );
		}
		
		private function minusUp( evt:MouseEvent = null ):void {
			stopTimer( );
			stopScrolling( );
		}
		
		private function plusDown( evt:MouseEvent = null ):void {
			scrollDown( );
			stopTimer( );
			timer.addEventListener( TimerEvent.TIMER, this.startScrollingUp );
			timer.start( );
		}
		
		private function plusUp( evt:MouseEvent = null ):void {
			stopTimer( );
			stopScrolling( );
		}
		
		private function stopScrolling( ):void {
			_tracker.removeEventListener( Event.ENTER_FRAME, scrollDown );
			_tracker.removeEventListener( Event.ENTER_FRAME, scrollUp );
		}
		
		private function stopTimer( ):void {
			if( timer.running ) timer.stop( );
			
			timer.removeEventListener( TimerEvent.TIMER, this.startScrollingUp );
			timer.removeEventListener( TimerEvent.TIMER, this.startScrollingDown );
		}
		
		private function startScrollingDown( evt:TimerEvent = null ):void {
			_tracker.addEventListener( Event.ENTER_FRAME, this.scrollUp );
		}
		
		private function startScrollingUp( evt:TimerEvent = null ):void {
			_tracker.addEventListener( Event.ENTER_FRAME, this.scrollDown );
		}
		
		private function scrollUp( evt:Event = null ):void {
			if( _direction == ScrollerDirection.VERTICAL ) {
				
				setTrackerY( _tracker.y - STEP );
				
			} else if ( _direction == ScrollerDirection.HORIZONTAL ) {
				
				setTrackerX( _tracker.x - STEP );
				
			} else {
				throw new IllegalOperationError( "Illegal value for DIRECTION. Must be ScrollerDirection.VERTICAL or ScrollerDirection.HORIZONTAL" );
			}
		}
		
		private function scrollDown( evt:Event = null ):void {
			if( _direction == ScrollerDirection.VERTICAL ) {
				
				setTrackerY( _tracker.y + STEP );
				
			} else if ( _direction == ScrollerDirection.HORIZONTAL ) {
				
				setTrackerX( _tracker.x + STEP );
				
			} else {
				throw new IllegalOperationError( "Illegal value for DIRECTION. Must be ScrollerDirection.VERTICAL or ScrollerDirection.HORIZONTAL" );
			}
		}
		
		private function setTrackerY( value:Number ):void {
			_tracker.y = Math.max( _track.y, Math.min( _track.y + _track.height - _tracker.height, value  ) );
			this.dispatchEvent( new ScrollerEvent( ScrollerEvent.SCROLL ) );
		}
		
		private function setTrackerX( value:Number ):void {
			_tracker.x = Math.max( _track.x, Math.min( _track.x + _track.width - _tracker.width, value ) );
			this.dispatchEvent( new ScrollerEvent( ScrollerEvent.SCROLL ) );
		}
		
		private function startDragging( evt:MouseEvent = null ):void {
			_dragging = true;
			
			_yDif = _tracker.parent.mouseY - _tracker.y;
			_xDif = _tracker.parent.mouseX - _tracker.x;
			
			_stage.addEventListener( MouseEvent.MOUSE_MOVE, this.doDragging );
			this.dispatchEvent( new ScrollerEvent( ScrollerEvent.START_SCROLLING ) );
		}
		
		private function doDragging( evt:MouseEvent ):void {
			
			if( _direction == ScrollerDirection.VERTICAL ) {
				
				setTrackerY( _tracker.parent.mouseY - _yDif );
				
			} else if ( _direction == ScrollerDirection.HORIZONTAL ) {
				
				setTrackerX( _tracker.parent.mouseX - _xDif );
				
			} else {
				throw new IllegalOperationError( "Illegal value for DIRECTION. Must be ScrollerDirection.VERTICAL or ScrollerDirection.HORIZONTAL" );
			}
			
			evt.updateAfterEvent( );
			
		}
		
		public function get value( ):Number 
		{
			var result:Number;
			
			if( _direction == ScrollerDirection.VERTICAL ) 
			{
				result = ( ( _tracker.y - _track.y ) / ( _track.height - _tracker.height ) * ( MAX - MIN ) ) + MIN ;
				return isNaN( result )? 0: result;
			}
			else if ( _direction == ScrollerDirection.HORIZONTAL ) 
			{
				result = ( ( _tracker.x - _track.x ) / ( _track.width - _tracker.width ) * ( MAX - MIN ) ) + MIN ;
				return isNaN( result )? 0: result; 
			}
			else 
			{
				throw new IllegalOperationError( "Illegal value for DIRECTION. Must be ScrollerDirection.VERTICAL or ScrollerDirection.HORIZONTAL" );
			}
		}
		
		public function set value( v:Number ):void
		{
			var p:Number;
			var range:Number;
			
			v -= MIN;
			p = v / ( MAX - MIN );
			
			if( isNaN( v ) ) return;
			
			if( _direction == ScrollerDirection.VERTICAL ) 
			{
				range = _track.height - _tracker.height;
				_tracker.y = ( p * range ) + _track.y;
			}
			else if ( _direction == ScrollerDirection.HORIZONTAL )
			{
				range = _track.width - _tracker.width;
				_tracker.x = ( p * range ) + _track.x;
			}
			else 
			{
				throw new IllegalOperationError( "Illegal value for DIRECTION. Must be ScrollerDirection.VERTICAL or ScrollerDirection.HORIZONTAL" );
			}
			
			this.dispatchEvent( new ScrollerEvent( ScrollerEvent.SCROLL ) );
		}
		
		private function stopDragging( evt:MouseEvent = null ):void {
			_dragging = false;
			_stage.removeEventListener( MouseEvent.MOUSE_MOVE, this.doDragging );
			
			this.dispatchEvent( new ScrollerEvent( ScrollerEvent.STOP_SCROLLING ) );
		}
		
	}
	
}
