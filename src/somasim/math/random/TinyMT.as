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
		public var s0 :uint;
		public var s1 :uint;
		public var s2 :uint;
		public var s3 :uint;

		// seed value
		public var rawseed :uint;
		// number of values produced since the last seeding
		public var gencount :uint;
		
		// initialization constants (in the MT reference implementation
		// they're specified by the user during initialization, but they don't change)
		private static const MAT1 :uint = 0x70707070;
		private static const MAT2 :uint = 0x07070707;
		private static const TMAT :uint = 0x55555555;

		// protected static const MIN_LOOP :int = 8;
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
		

		/** Initialize the random number generator with a uint seed */
		private final function init (seed :uint) :void {
			s0 = seed;
			s1 = MAT1;
			s2 = MAT2;
			s3 = TMAT;

			/*
			for (var i :int = 1; i < MIN_LOOP; i++) {
				this.status[i & 3] ^= i + 1812433253 * 
					(this.status[(i - 1) & 3] ^ (this.status[(i - 1) & 3] >>> 30));
			}
			*/
			
			// manually unrolled the loop for MIN_LOOP = 8,
			// so that we can convert status[] array into 
			// four simple variables s0..s3 for perf
			s1 ^= 1 + uint(0x6c078965) * (s0 ^ (s0 >>> 30));
			s2 ^= 2 + uint(0x6c078965) * (s1 ^ (s1 >>> 30));
			s3 ^= 3 + uint(0x6c078965) * (s2 ^ (s2 >>> 30));
			s0 ^= 4 + uint(0x6c078965) * (s3 ^ (s3 >>> 30));
			s1 ^= 5 + uint(0x6c078965) * (s0 ^ (s0 >>> 30));
			s2 ^= 6 + uint(0x6c078965) * (s1 ^ (s1 >>> 30));
			s3 ^= 7 + uint(0x6c078965) * (s2 ^ (s2 >>> 30));

			for (var i :int = 0; i < PRE_LOOP; i++) {
				nextState();
			}
		}

		/** Advances internal state */
		[Inline] private final function nextState () :void {
			var x :uint;
			var y :uint;
			
			y = s3;
			x = (s0 & 0x7fffffff) ^ s1 ^ s2;
			x ^= (x << 1);
			y ^= (y >>> 1) ^ x;
			s0 = s1;
			s1 = s2;
			s2 = x ^ (y << 10);
			s3 = y;
			s1 ^= -(y & 1) & MAT1;
			s2 ^= -(y & 1) & MAT2;
			
			gencount++;
		}
		
		/** Outputs an unsigned int from the current internal state */
		[Inline] private final function temper () :uint {
			var t0 :uint = s3;
			var t1 :uint = s0 ^ (s2 >>> 8);
			t0 ^= t1;
			t0 ^= -(t1 & 1) & TMAT;
			return t0;
		}
		
		/*
		public static function test () :void {
			var r :TinyMT = new TinyMT();
			r.init(1);
			
			trace("1000 outputs of genrand_int32()\n");
			for (var i :int = 0; i < 5000; i++) {
				trace(r.next());
			}
			
			trace("benchmark 10M random numbers... ");
			var ts :int = getTimer();
			for (i = 0; i < 10000000; i++) {
				r.next();
			}
			var delta :int = getTimer() - ts;
			trace(" ... done in " + (delta / 1000) + " seconds");
			
			// note: generates ~ 1.5M numbers / second on a 2013 core i7 laptop, in debug mode
		}
		*/
	}
}

