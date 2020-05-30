            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/enumerables


# ### Factors
#
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.

    def factors(num)
        (1..num).select { |i| num % i == 0 }
    end

# ### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).

    def substrings(string)
        subs = []
            (0...string.length).each do |start_i|
                (start_i...string.length).each do |end_i|
                    subs << string[start_i..end_i]
                end
            end
        subs
    end

    def subwords(word, dictionary)
        dictionary.select { |ele| word.include?(ele) }
    end

# ### Doubler
# Write a `doubler` method that takes an array of integers and returns an
# array with the original elements multiplied by two.

    def doubler(array)
        array.map { |num| num * 2 }
    end

class Array

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)

        def bubble_sort!(&prc)
            self.sort! { |a, b| prc ? prc.call(a, b) : a <=> b }
        end

        def bubble_sort
            sorted = self.dup
            sorted.bubble_sort!
        end

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

        def my_map(&block)
            self.collect { |ele| yield ele }
        end

    # My Select
    # Now extend the Array class to include my_select that takes a block and returns a 
    # new array containing only elements that satisfy the block. Use your my_each method!

        def my_select(&block)
            dub = self.dup
            dub.keep_if { |ele| yield ele }
        end

        def my_inject(memo = nil, &block)
            beginning = memo.nil? ? 1 : 0
            memo ||= self.first
                (beginning...length).each do |ele|
                    memo = yield(memo, self[ele])
                end
            memo
        end

    # My Reject
    # Write my_reject to take a block and return a new array excluding elements 
    # that satisfy the block.

        def my_reject(&prc)
            self.delete_if { |ele| prc.call(ele) }
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
            !self.map { |ele| prc.call(ele) }.include?(false)
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

    # My Rotate
    # Write a method my_rotate that returns a new array containing all the elements of
    # the original array in a rotated order. By default, the array should rotate by one 
    # element. If a negative value is given, the array is rotated in the opposite direction.

        def my_rotate(num = 1)
            arr = []
            self.each { |ele| arr << ele }
            while num > 0
                piv = arr.shift
                arr.push(piv)
                num -= 1
            end
            
            while num < 0
                piv = arr.pop
                arr.unshift(piv)
                num += 1
            end
            arr
        end

    # My Join
    # my_join returns a single string containing all the elements of the array, 
    # separated by the given string separator. If no separator is given, an empty 
    # string is used.

        def my_join(seperator = "")
            joynd = ""
            self.each_with_index { |ele| self[self.length-1] == ele ? joynd << ele : joynd << ele + seperator }
            joynd
        end

    # My Reverse
    # Write a method that returns a new array containing all 
    # the elements of the original array in reverse order.

        def my_reverse
            arr = []
            index = self.length - 1
            while index > -1
                arr << self[index]
                index -= 1
            end
        arr
        end

end

# ### Concatenate
#
# Create a method that takes in an `Array` of `String`s and uses `inject`
# to return the concatenation of the strings.
#
# ```ruby
# concatenate(["Yay ", "for ", "strings!"])
# # => "Yay for strings!"
# ```

    def concatenate(strings)
        strings.inject(:+)
    end
            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/enumerables