package somasim.fn
{
	/** 
	 * Maps a function over two sequences, such as an Array, a Vector of some type.
	 * Returns an Array of mapped elements, of the same length as the shorter sequence.
	 * 
	 * <p> For example, map2(fn, [1, 2], [3, 4, 5]) will produce [fn(1, 3), fn(2, 4)].
	 * 
	 * <p> This function operates over two sources, instead of arbitrary numbers of sources,
	 * as an optimization particularly for mobile platforms.
	 * 
	 * @param	fn		Binary function mapped over the sequence
	 * @param	s1		First source (Array or Vector of some type)
	 * @param	s2		Second source (Array or Vector of some type)
	 */
	public function map2 (fn :Function, s1 :*, s2 :*) :Array
	{
		var results :Array = [];
		var len :uint = (s1.length < s2.length) ? s1.length : s2.length;
		for (var i :int = 0; i < len; i++) {
			results[i] = fn(s1[i], s2[i]);
		}
		return results;
	}
}