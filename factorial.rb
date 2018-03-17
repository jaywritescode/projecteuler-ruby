def factorial(n)
  return 1 if n == 0
  1.upto(n).reduce do |acc, val|
    acc * val
  end
end
