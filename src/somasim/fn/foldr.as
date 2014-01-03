package somasim.fn
{
	/**
	 * Applies a binary function to members of a list, from the last to first element in order.
	 * 
	 * For example, foldr(add, 0, [1, 2, 3]) is equivalent to performing
	 * add(1, add(2, add(3, 0)))
	 * 
	 * @param fn	Binary function that gets applied to list values
	 * @param init	Initial value used for the first iteration
	 * @param seq	Array or Vector being folded
	 */
	public function foldr (fn :Function, init :*, seq :*) :*
	{
		var result :* = init;
		for (var i :int = seq.length - 1; i >= 0; i--) {
			result = fn(seq[i], result);
		}
		return result;
	}
}