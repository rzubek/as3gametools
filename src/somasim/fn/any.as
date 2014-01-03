package somasim.fn
{
	/** Returns true if fn() returns true for any element of the sequence.
	 * Runs until it finds the first element that passes, then returns immediately.
	 * 
	 * @param 	fn			Unary function for testing sequence elements. It should return a boolean.
	 * @param	sequence	Source sequence
	 */
	public function any (fn :Function, sequence :*) :Boolean {
		for each (var element :* in sequence) {
			if (fn(element)) {
				return true;
			}
		}
		return false;
	}
}