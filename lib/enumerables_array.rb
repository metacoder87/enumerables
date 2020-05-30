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

