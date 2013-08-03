package somasim.math.random
{
	/** 
	 * ActionScript port of the Mersenne Twister, version MT19937-AR from 2002
	 * 
	 * <p> Original algorithm by Makoto Matsumoto and Takuji Nishimura,
	 * http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html
	 */
	public class MersenneTwister
	{		
		private static const UINT_TO_FLOAT_MUL :Number = 1 / 4294967296; // 1 / 2^32

		// array that stores the current state of the rng
		private var mt :Vector.<uint> = new Vector.<uint>(624, true);
		// mti = mt.length + 1 means the generator is not yet initialized
		private var mti :uint = 625; 
		// mag01[x] = x * MATRIX_A  for x = 0, 1 
		private var mag01 :Vector.<uint> = new <uint> [ 0x0, 0x9908b0df ];
		// seed value
		private var _seed :uint;
		// number of values produced since the last seeding
		private var _count :uint;
		
		/** @inheritDoc */
		public function setSeed (s :uint) :void {
			_seed = s;
			_count = 0;
			mt[0] = s & 0xffffffff;
			for (mti = 1; mti < 624; mti++) {
				mt[mti] = (1812433253 * (mt[mti-1] ^ (mt[mti-1] >>> 30)) + mti); 
			}
		}
		
		/** @inheritDoc */
		public function get seed () :uint { return _seed; }
		
		/** @inheritDoc */
		public function get count () :uint { return _count; }

		/** 
		 * Returns the next random number in the series, 
		 * as a uint in the half-open range [0, uint.MAX_VALUE + 1), i.e., [0, 2^32)
		 */
		public function next () :uint {
			return generate();
		}
		
		[Inline] private final function generate () :uint {
			var y :uint;
			
			if (mti >= 624) {
				if (mti == 625) { // if not seeded, complain
					throw new Error("Random number generator has not been seeded!");
				}
				// initialize on first use, or once we cycled through
				y = init();
			}
			
			y = mt[mti++];
			y ^= (y >>> 11);
			y ^= (y << 7) & 0x9d2c5680;
			y ^= (y << 15) & 0xefc60000;
			y ^= (y >>> 18);
			
			_count++;
			
			return y;
		}
		
		private final function init () :uint {
			var y :uint;
			var kk :int;
			for (kk = 0; kk < 227; kk++) {
				y = (mt[kk] & 0x80000000) | (mt[kk+1] & 0x7fffffff);
				mt[kk] = mt[kk+397] ^ (y >>> 1) ^ mag01[y & 0x1];
			}
			for (; kk < 623; kk++) {
				y = (mt[kk] & 0x80000000) | (mt[kk + 1] & 0x7fffffff);
				mt[kk] = mt[kk-227] ^ (y >>> 1) ^ mag01[y & 0x1];
			}
			y = (mt[623] & 0x80000000) | (mt[0] & 0x7fffffff);
			mt[623] = mt[396] ^ (y >>> 1) ^ mag01[y & 0x1];
			mti = 0;
			
			return y;
		}
	}
}
