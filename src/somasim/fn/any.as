package somasim.fn
{
	/** Returns the first element of sequence for which fn() returns true, or undefined.
	 * 
	 * @param 	fn			Unary function for testing sequence elements. It should return a boolean.
	 * @param	sequence	Source sequence
	 */
	public function any (fn :Function, sequence :*) :* {
		for each (var element :* in sequence) {
			if (fn(element)) {
				return element;
			}
		}
		return undefined;
	}
}