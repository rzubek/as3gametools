package somasim.fn
{
	/** Returns true if fn() returns true for all elements of the sequence.
	 * 
	 * @param 	fn			Unary function for testing sequence elements. It should return a boolean.
	 * @param	sequence	Source sequence
	 */
	public function all (fn :Function, sequence :*) :Boolean {
		for each (var element :* in sequence) {
			if (! fn(element)) {
				return false;
			}
		}
		return true;
	}
}