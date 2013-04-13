def bmx_swaps(size)
  # Batcher's Merge-Exchange Sort, Knuth 5.2.2M
  t = Math.log2(size).ceil
  p = 1 << (t-1)
  swaps = []
  while p > 0
    q = 1 << (t-1)
    r = 0
    d = p
    while d > 0
      swaps << []
      (0 .. (size-d-1)).each {|i|
        if (i&p) == r
          swaps.last << [i,i+d].sort
        end
      }
      d = q-p
      q >>= 1
      r = p
    end
    p >>= 1
  end
  swaps
end

def swaps_to_pbm(swaps)
  max = swaps.flatten.max + 1
  pbm_raw = swaps.map {|batch| 
    batch.map {|b,e|
      ([0] * b) + ([1] * (e-b+1)) + ([0] * (max-e-1))
    }
  }
  row_sep = [[],
             [0] * max,
             [0] * max,
             (0...max).map {|i| i % 2},
             (0...max).map {|i| (i+1) % 2},
             (0...max).map {|i| i % 2},
             [0] * max,
             [0] * max,
             []].map {|row| row.join(' ') }.join("\n")
  pbm = pbm_raw.map {|batch| batch.map {|row| row.join(" ") }.join("\n") }.join(row_sep)
  "P1\n#{pbm.split("\n").first.split(" ").size} #{pbm.split("\n").size}\n#{pbm}\n"
end
