package somasim.pools
{
	/** Interface for objects managed by the object pool. */
	public interface IObjectPoolEntry
	{
		/** 
		 * This function is called after an object is returned to the pool,
		 * to release stored resources before reuse.
		 */
		function reset () :void;
	}
}