

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

# My All
# Write my_all? to return true only if all elements satisfy the block.

    def my_all?(&prc)
        boo = true
        self.my_each { |ele| boo = false if prc.call(ele) == false }
        boo
    end

# My Flatten
# my_flatten should return all elements of the array into a new, one-dimensional 
# array. Hint: use recursion!

    def my_flatten
        return [self] if !self.is_a?(Array)
        flat = []
        self.each do |ele|
            if ele.is_a?(Integer) 
                flat << ele 
            else flat += ele.my_flatten
            end
        end
        flat
    end

# My Zip
# Write my_zip to take any number of arguments. It should return a new array 
# containing self.length elements. Each element of the new array should be an 
# array with a length of the input arguments + 1 and contain the merged elements 
# at that index. If the size of any argument is less than self, nil is returned 
# for that location.

    def my_zip(*arr)
        zipped = []
        self.my_each { |ele| zipped << [ele] }
            while zipped[0].length < arr.count + 1
                arr.my_each do |arra|
                    arra.each_with_index do |el, i|
                        zipped[i].to_a << el
                    end
                end
            end
        zipped.my_each { |sub| sub << nil while sub.length < self.length }
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

p "my_all? test"
# my_all? test
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

p "my_flatten test"
# my_flatten test
p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

p "my_zip test"
# my_zip test
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
