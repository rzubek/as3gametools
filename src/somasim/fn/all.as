package somasim.fn
{
	/** If fn() returns true for all elements of the sequence, returns the last element
	 * that was tested; otherwise returns undefined.
	 * 
	 * @param 	fn			Unary function for testing sequence elements. It should return a boolean.
	 * @param	sequence	Source sequence
	 */
	public function all (fn :Function, sequence :*) :* {
		var element :*; 
		for each (element in sequence) {
			if (! fn(element)) {
				return undefined;
			}
		}
		return element;
	}
}