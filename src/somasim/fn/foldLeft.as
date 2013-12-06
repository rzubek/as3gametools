package somasim.fn
{
	/**
	 * Applies a binary function to members of a list, from the first to last element in order.
	 * 
	 * For example, foldLeft(add, 0, [1, 2, 3]) is equivalent to performing
	 * add(3, add(2, add(1, 0)))
	 * 
	 * @param fn	Binary function that gets applied to list values
	 * @param init	Initial value used for the first iteration
	 * @param seq	Array or Vector being folded
	 */
	public function foldLeft (fn :Function, init :*, seq :*) :*
	{
		var result :* = init;
		for (var i :int = 0, len :int = seq.length; i < len; i++) {
			result = fn(seq[i], result);
		}
		return result;
	}
}