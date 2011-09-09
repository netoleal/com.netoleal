﻿/*** ...* @author Default* @version 0.1*/package com.netoleal.timeline {		import flash.display.MovieClip;	import flash.events.Event;	import flash.text.TextField;	public class TimelineDrivenMovieClip extends MovieClip {				private var _tf:uint = 0;		private var _hasEnterFrame:Boolean;		private var _factor:int = TimelineFactor.NEUTRAL;				private var _looping:Boolean;		private var _yoyo:Boolean;		private var _loopNextTargetFrame:uint;				public function TimelineDrivenMovieClip( ) {			this.stop( );			this.loopTimeline( );		}				public function animateTo( frameNumber:uint ):void {						this._tf = frameNumber;			this._factor = ( frameNumber > this.currentFrame )? TimelineFactor.ASC: TimelineFactor.DESC;			this.createEnterFrame( );		}				public function cancelLooping( ):void {			this._looping = false;			this._yoyo = false;		}				public function loopTimeline( yoyo:Boolean = false, fromFrame:uint = 1, toFrame:uint = 0 ):void {			this.gotoAndStop( fromFrame );						this._looping = true;			this._yoyo = yoyo;						this._loopNextTargetFrame = fromFrame;			if( toFrame == 0 ) toFrame = this.totalFrames;						this.animateTo( toFrame );		}				public function animateToEndAndStop( ):void {			this.removeEnterFrame( );			this.animateTo( this.totalFrames );		}				public function animateToBeginAndStop( ):void {			this.removeEnterFrame( );			this.animateTo( 1 );		}				public override function stop( ):void {			this.removeEnterFrame( );			super.stop( );		}				public override function play( ):void {			this.removeEnterFrame( );			super.play( );		}				public override function gotoAndPlay(frame:Object, scene:String=null):void {			this.removeEnterFrame( );			super.gotoAndPlay( frame, scene );		}				public override function gotoAndStop(frame:Object, scene:String=null):void {			this.removeEnterFrame( );			super.gotoAndStop( frame, scene );		}				private function createEnterFrame( ):void {			if( this._hasEnterFrame ) return;			this._hasEnterFrame = true;						this.addEventListener( Event.ENTER_FRAME, this.enterFrameHandler );		}				private function removeEnterFrame( ):void {			if( !this._hasEnterFrame ) return;						this._hasEnterFrame = false;			this._looping = false;			this._yoyo = false;						this.removeEventListener( Event.ENTER_FRAME, this.enterFrameHandler );		}				private function enterFrameHandler( evt:Event ):void {			if( this.currentFrame == this._tf ) {				if( !this._looping ){					this.removeEnterFrame( );				} else {					if( this._yoyo ){						this.loopTimeline( this._yoyo, this.currentFrame, this._loopNextTargetFrame );					} else {						this.loopTimeline( this._yoyo, this._loopNextTargetFrame, this.currentFrame );					}					return;				}			}						this.jumpFrames( this._factor );		}				private function jumpFrames( amount:int ):void {			super.gotoAndStop( this.currentFrame + amount );		}			}	}