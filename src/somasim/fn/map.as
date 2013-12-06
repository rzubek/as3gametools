package somasim.fn
{
	/** 
	 * Maps a function over a sequence, such as an Array, a Vector of some type.
	 * Returns an Array of mapped elements. 
	 * 
	 * @param	fn			Unary function mapped over the sequence
	 * @param	sequence	Original sequence (Array or Vector of some type)
	 */
	public function map (fn :Function, sequence :*) :Array
	{
		var results :Array = [];
		for each (var element :* in sequence) {
			results[results.length] = fn(element);
		}
		return results;
	}
}