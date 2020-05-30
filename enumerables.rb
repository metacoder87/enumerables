

require "byebug"

puts "My monkey patch for the Array Class"

class Array

# My Each
# Extend the Array class to include a method named my_each that takes a block, 
# calls the block on every element of the array, and returns the original array. 
# Do not use Enumerable's each method.

    def my_each(&prc)
        self.to_a.map do |ele|
            prc.call(ele)
        end
        return self
    end

# My Select
# Now extend the Array class to include my_select that takes a block and returns a 
# new array containing only elements that satisfy the block. Use your my_each method!

    def my_select(&prc)
        selected = []
        self.my_each do |ele|
            selected << ele if prc.call(ele)
        end
        return selected
    end

# My Reject
# Write my_reject to take a block and return a new array excluding elements 
# that satisfy the block.

    def my_reject(&prc)
        kept = []
        self.my_each do |ele|
            kept << ele if !prc.call(ele)
        end
        return kept
    end

# My Any
# Write my_any? to return true if any elements of the array satisfy the block.

    def my_any?(&prc)
        boo = false
        self.my_each { |ele| boo = true if prc.call(ele) }
        boo
    end
p "my-each test"
# my_each test
return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end

p return_value

p "my_select test"
# my_select test
a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

p "my_reject test"
# my_reject test
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

p "my_any? test"
# my_any? test
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false

