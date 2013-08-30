package somasim.math.random
{
	/** 
	 * Actionscript port of the TinyMT random number generator, a small-footprint
	 * variant of the Mersenne Twister.
	 * 
	 * <p> Original algorithm by Mutsuo Saito and Makoto Matsumoto.
	 * http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/TINYMT/index.html
	 */
	public class TinyMT
	{
		// state variables
		public var s :Vector.<uint> = new Vector.<uint>(4, true);

		// seed value
		public var rawseed :uint;
		// number of values produced since the last seeding
		public var gencount :uint;
		
		// initialization constants (in the MT reference implementation
		// they're specified by the user during initialization, but they don't change)
		public var MAT1 :uint = 0x70707070;
		public var MAT2 :uint = 0x07070707;
		public var TMAT :uint = 0x55555555;

		protected static const MIN_LOOP :int = 8;
		protected static const PRE_LOOP :int = 8;
		protected static const UINT_TO_FLOAT_MUL :Number = 1 / 4294967296; // 1 / 2^32
		

		/** Re-initializes the random number generator given the seed */
		public function setSeed (s :uint) :void {
			rawseed = s;
			gencount = 0;
			init(s);
		}
		
		/** Returns the current seed value */
		public function get seed () :uint { return rawseed; }

		/** Returns the number of values produced since the last time the RNG was initialized */
		public function get count () :uint { return gencount; }
		
		/** 
		 * Returns the next random number in the series, 
		 * as a uint in the half-open range [0, uint.MAX_VALUE + 1), i.e., [0, 2^32)
		 */
		public function next () :uint {
			nextState();
			return temper();
		}

		/** 
		 * Returns the next random number in the series,
		 * as a Number in the half-open range [0, 1).
		 */
		public function number () :Number {
			return next() * UINT_TO_FLOAT_MUL;
		}
		
		/**
		 * Returns an unsigned int in the specified half-open range [min, max).
		 */
		public function nextInRange (min :uint, max :uint) :uint {
			var p :uint = next();
			return p % (max - min) + min;
		}
		
		/** 
		 * Returns a floating-point Number in the specified half-open range [min, max).
		 */
		public function numberInRange (min :Number, max :Number) :Number {
			var p :Number = number();
			return p * (max - min) + min;
		}
		
		/**
		 * Returns a random element from an array or vector.
		 */
		public function element (container :*) :* {
			var len :uint = container.length;
			var index :uint = numberInRange(0, len);
			return container[index];
		}
		
		/** 
		 * Destructively shuffles the container using the Fisher-Yates algorithm. 
		 */
		public function shuffle (container :*) :void {
			for (var i :int = container.length - 1; i > 0; i--) {
				var j :int = nextInRange(0, i + 1);
				var tmp :* = container[i];
				container[i] = container[j];
				container[j] = tmp;
			}
		}
		
		/** Initialize the random number generator with a uint seed */
		private final function init (seed :uint) :void {
			s[0] = seed;
			s[1] = MAT1;
			s[2] = MAT2;
			s[3] = TMAT;

			for (var i :int = 1; i < MIN_LOOP; i++) {
				s[i & 3] ^= i + 1812433253 * (s[(i - 1) & 3] ^ (s[(i - 1) & 3] >>> 30));
			}
			
			for (var j :int = 0; j < PRE_LOOP; j++) {
				nextState();
			}
		}

		/** Advances internal state */
		[Inline] private final function nextState () :void {
			var x :uint;
			var y :uint;
			
			y = s[3];
			x = (s[0] & 0x7fffffff) ^ s[1] ^ s[2];
			x ^= (x << 1);
			y ^= (y >>> 1) ^ x;
			s[0] = s[1];
			s[1] = s[2];
			s[2] = x ^ (y << 10);
			s[3] = y;
			s[1] ^= -(y & 1) & MAT1;
			s[2] ^= -(y & 1) & MAT2;
			
			gencount++;
		}
		
		/** Outputs an unsigned int from the current internal state */
		[Inline] private final function temper () :uint {
			var t0 :uint = s[3];
			var t1 :uint = s[0] ^ (s[2] >>> 8);
			t0 ^= t1;
			t0 ^= -(t1 & 1) & TMAT;
			return t0;
		}
	}
}

