(defn existe [lis x]
 (reduce (fn [a b] (or a b)) (map (fn [y] (= x y)) lis))) 

(defn maxn [a b]
 (if (> a b)
  a
  b))

(defn maxlis [lis]
 (reduce maxn lis))

(defn base10 [x y]
  (* x (Math/pow 10 y)))

(defn dignum [digs]
  (let [dig_max (count digs)
        powers (reverse (range dig_max))]
      (reduce + (map base10 digs powers))))
