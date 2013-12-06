package somasim.fn
{
	/** 
	 * Filters a sequence, such as an Array, a Vector of some type.
	 * Returns an Array of elements of the sequence for which fn returns true.
	 * 
	 * @param	fn			Unary function that filters the sequence. Must return a Boolean.
	 * @param	sequence	Original sequence (Array or Vector of some type)
	 */
	public function filter (fn :Function, sequence :*) :Array
	{
		var results :Array = [];
		for each (var element :* in sequence) {
			if (fn(element)) {
				results[results.length] = element;
			}
		}
		return results;
	}
}