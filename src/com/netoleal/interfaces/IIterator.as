package com.netoleal.interfaces {
	public interface IIterator {
		
		function hasNext( ):Boolean;
		function next():*;
		function first( ):*;
		function last( ):*;
		function current( ):*;
		function index( ):Number;
		
	}
}