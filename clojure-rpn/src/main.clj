(ns main
  (:require [clojure.string :as str]))

(defn parse-token [word]
  (cond
    (= word "+") :sum
    (= word "-") :sub
    (= word "*") :mul
    (= word "/") :div
    :else (try
            (Integer/parseInt word)
	    (catch Exception e (println (str "Input " word " ignored!")) nil))))

(defn exec-token [stack token]
  (if (number? token)
    (conj stack token)
    (let [len (count stack)]
      (if (> len 1)
        (let [a (nth stack (- len 1))
	      b (nth stack (- len 2))
	      stack1 (pop (pop stack))]
          (conj stack1
            (case token
              :sum (+ a b)
	      :sub (- a b)
	      :mul (* a b)
	      :div (/ a b))))
        (do
	  (println (str "Not enough numbers in the stack to apply " token))
	  stack)))))

(defn calc-step [stack]
  (print "=>")
  (flush)
  (if-let [line (read-line)]
    (let [words (str/split line #" ")
          tokens (filter some? (map parse-token words))
          new-stack (reduce exec-token stack tokens)]
      (println new-stack)
      new-stack)
    (System/exit 0)))


(defn run [opts]
  (println "Welcome to Clojure RPN")
  (loop [stack []]
    (recur (calc-step stack))))