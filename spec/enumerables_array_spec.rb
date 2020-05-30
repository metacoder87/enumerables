            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/enumerables


require "rspec"
require "enumerables_array"

describe "#factors" do
  it "returns factors of 10 in order" do
    expect(factors(10)).to eq([1, 2, 5, 10])
  end

  it "returns just two factors for primes" do
    expect(factors(13)).to eq([1, 13])
  end
end

describe "#substrings" do
  it "should take a `String`" do
    expect { substrings("string") }.not_to raise_error
  end

  it "should return an array containing each of its substrings" do
    expect(substrings("cat")).to eq(["c", "ca", "cat", "a", "at", "t"])
  end
end

describe "#subwords" do
  it "can find a simple word" do
    words = subwords("asdfcatqwer", ["cat", "car"])
    expect(words).to eq(["cat"])
  end

  it "doesn't find spurious words" do
    words = subwords("batcabtarbrat", ["cat", "car"])
    expect(words).to be_empty
  end

  it "can find words within words" do
  #note that the method should NOT return duplicate words
    dictionary = ["bears", "ear", "a", "army"]
    words = subwords("erbearsweatmyajs", dictionary)

    expect(words).to eq(["bears", "ear", "a"])
  end
end

describe "#doubler" do
  let(:array) { [1, 2, 3] }

  it "doubles the elements of the array" do
    expect(doubler(array)).to eq([2, 4, 6])
  end

  it "does not modify the original array" do
    duped_array = array.dup

    doubler(array)

    expect(array).to eq(duped_array)
  end
end

describe Array do
  describe "#bubble_sort!" do
    let(:array) { [1, 2, 3, 4, 5].shuffle }

    it "works with an empty array" do
      expect([].bubble_sort!).to eq([])
    end

    it "works with an array of one item" do
      expect([1].bubble_sort!).to eq([1])
    end

    it "sorts numbers" do
      expect(array.bubble_sort!).to eq(array.sort)
    end

    it "modifies the original array" do
      duped_array = array.dup
      array.bubble_sort!
      expect(duped_array).not_to eq(array)
    end

    it "will use a block if given" do
      sorted = array.bubble_sort! do |num1, num2|
        # order numbers based on descending sort of their squares
        num2**2 <=> num1**2
      end

      expect(sorted).to eq([5, 4, 3, 2, 1])
    end
  end

  describe "#bubble_sort" do
    let(:array) { [1, 2, 3, 4, 5].shuffle }

    it "delegates to #bubble_sort!" do
      expect_any_instance_of(Array).to receive(:bubble_sort!)

      array.bubble_sort
    end

    it "does not modify the original array" do
      duped_array = array.dup
      array.bubble_sort
      expect(duped_array).to eq(array)
    end
  end

  describe "#my_each" do
    let(:arr) { [1, 2, 3] }
    it "calls the block passed to it" do
      expect do |block|
        ["test array"].my_each(&block)
      end.to yield_control.once
    end

    it "yields each element to the block" do
      expect do |block|
        ["el1", "el2"].my_each(&block)
      end.to yield_successive_args("el1", "el2")
    end

    it "does NOT call the built-in #each method" do
      original_array = ["original array"]
      expect(original_array).not_to receive(:each)
      original_array.my_each {}
    end

    it "is chainable and returns the original array" do
      original_array = ["original array"]
      expect(original_array.my_each {}).to eq(original_array)
    end

    it "should return the values of the array" do
      expect(arr.my_each { |num| puts num }.my_each { |num| puts num}).to eq(arr)
    end
  end

  describe "#my_map" do
    it "calls the block passed to it" do
      expect do |block|
        ["test array"].my_map(&block)
      end.to yield_control.once
    end

    it "yields each element to the block" do
      expect do |block|
        ["el1", "el2"].my_map(&block)
      end.to yield_successive_args("el1", "el2")
    end

    it "runs the block for each element" do
      expect([1, 2, 3].my_map { |el| el * el }).to eq([1, 4, 9])
      expect([-1, 0, 1].my_map { |el| el.odd? }).to eq([true, false, true])
    end

    it "does NOT call the built in built-in #map method" do
      original_array = ["original array"]
      expect(original_array).not_to receive(:map)
      original_array.my_map {}
    end

    it "is chainable and returns a new array" do
      original_array = ["original array"]
      expect(original_array.my_map {}).not_to eq(original_array)
    end
  end

  describe "#my_select" do
    it "calls the block passed to it" do
      expect do |block|
        ["test element"].my_select(&block)
      end.to yield_control
    end

    it "yields each element to the block" do
      test_array = ["el1", "el2", "el3"]
      expect do |block|
        test_array.my_select(&block)
      end.to yield_successive_args("el1", "el2", "el3")
    end

    it "returns an array of filtered down items" do
      test_array = [1, 2, 3, 4, 5]
      expect(test_array.my_select(&:odd?)).to eq([1, 3, 5])
      expect(test_array.my_select { |el| el < 3 }).to eq([1, 2])
    end

    it "does NOT call the built-in #select method" do
      test_array = ["el1", "el2", "el3"]
      expect(test_array).not_to receive(:select)
      test_array.my_select {}
    end

    it "selects elements based on the block" do
      a = [1, 2, 3]
      expect(a.my_select { |num| num > 1 }).to eq([2, 3])
      expect(a.my_select { |num| num == 4 }).to eq([])
    end
  end

  describe "#my_inject" do
    it "calls the block passed to it" do
      expect do |block|
        [1, 2].my_inject(&block)
      end.to yield_control.once
    end

    it "makes the first element the accumulator if no default is given" do
      expect do |block|
        ["el1", "el2", "el3"].my_inject(&block)
      end.to yield_successive_args(["el1", "el2"], [nil, "el3"])
    end

    it "yields the accumulator and each element to the block" do
      expect do |block|
        [1, 2, 3].my_inject(&block)
      end.to yield_successive_args([1, 2], [nil, 3])
    end

    it "does NOT call the built-in #inject method" do
      original_array = ["original array"]
      expect(original_array).not_to receive(:inject)
      original_array.my_inject {}
    end

    it "is chainable and returns a new array" do
      original_array = ["original array"]
      expect(original_array.my_inject {}).not_to eq(original_array)
    end
  end
end

describe "#concatenate" do
  let(:strings) { ["These ", "are ", "my ", "strings"] }

  it "returns the concatenation of the strings passed in" do
    expect(concatenate(strings)).to eq("These are my strings")
  end

  it "does not modify the original strings" do
    concatenate(strings)

    expect(strings).to eq(["These ", "are ", "my ", "strings"])
  end

  it "uses the Array#inject method" do
    expect(strings).to receive(:inject)

    concatenate(strings)
  end
end

describe "#my_reject" do
  let(:a) { [1, 2, 3] }
  it "calls the block passed to it" do
      expect do |block|
        ["test element"].my_reject(&block)
      end.to yield_control
    end

  it "selects elements based on the block" do
    expect(a.my_reject { |num| num > 1 }).to eq([1])
  end

  it "yields each element to the block" do
    expect(a.my_reject { |num| num == 4 }).to eq([1, 2, 3])
  end

  it "does NOT call the built-in #reject method" do
      original_array = ["original array"]
      expect(original_array).not_to receive(:reject)
      original_array.my_reject {}
    end

end

describe "#my_any?" do
  let(:arr) { [1, 2, 3] }
  it "calls the block passed to it" do
    expect do |block|
      ["test element"].my_any?(&block)
    end.to yield_control
  end

  it "returns a true if at least one item is true" do
    expect(arr.my_any? { |num| num > 1 }).to be(true)
  end

  it "returns false when no item is true" do
    expect(arr.my_any? { |num| num == 4 }).to be(false)
  end

  it "does NOT call the built-in #any? method" do
    expect(arr).not_to receive(:any?)
    arr.my_any? {}
  end
end

describe "#my_all?" do
  let(:arr) { [1, 2, 3] }
  it "calls the block passed to it" do
      expect do |block|
        ["test element"].my_all?(&block)
      end.to yield_control
    end

  it "returns true if all of the items are true" do
    expect(arr.my_all? { |num| num < 4 }).to be(true)
  end

  it "returns false if none of the items are true" do
    expect(arr.my_all? { |num| num > 1 }).to be(false)
  end

  it "does NOT call the built-in #all? method" do
      original_array = ["original array"]
      expect(original_array).not_to receive(:all?)
      original_array.my_all? {}
    end
end

describe "#my_flatten" do
  let(:arr) { [1, 2, 3, [4, [5, 6]], [[[7]], 8]] }
  it "should flatten an array of arrays" do
    expect(arr.my_flatten).to eq([1, 2, 3, 4, 5, 6, 7, 8])
  end

  it "does NOT call the built-in #flatten method" do
      expect(arr).not_to receive(:flatten)
    arr.my_flatten {}
  end
end

describe "#my_zip" do
  let(:a) { [ 4, 5, 6 ] }
  let(:b) { [ 7, 8, 9 ] }

  it "zips together multiple arrays" do
    expect([1, 2, 3].my_zip(a, b)).to eq([[1, 4, 7], [2, 5, 8], [3, 6, 9]])
    expect([1, 2].my_zip(a, b)).to eq([[1, 4, 7], [2, 5, 8]])
  end

  it "rounds out the spaces in the arrays with nil" do
    expect(a.my_zip([1,2], [8])).to eq([[4, 1, 8], [5, 2, nil], [6, nil, nil]])
  end

  it "zips as many arrays countless arrays" do
    c = [10, 11, 12]
    d = [13, 14, 15]
    expect([1, 2].my_zip(a, b, c, d)).to eq([[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]])
  end

  it "does NOT call the built-in #inject method" do
    original_array = ["original array"]
      expect(original_array).not_to receive(:zip)
    original_array.my_zip {}
  end
end

describe "#my_rotate" do
  let(:a) { [ "a", "b", "c", "d" ] }
  it "should rotate 1 if no number is provided" do
    expect(a.my_rotate).to eq(["b", "c", "d", "a"])
  end

  it "should rotate a number of times depending on the number specified" do
    expect(a.my_rotate(2)).to eq(["c", "d", "a", "b"])
  end

  it "should rotate in reverse if the number is negative" do
    expect(a.my_rotate(-3)).to eq(["b", "c", "d", "a"])
  end

  it "should rotate as many times as is specied" do
    expect(a.my_rotate(15)).to eq(["d", "a", "b", "c"])
  end

  it "does NOT call the built-in #rotate method" do
      original_array = ["original array"]
      expect(original_array).not_to receive(:rotate)
      original_array.my_rotate {}
    end
end

describe "#my_join" do
  let(:a) { [ "a", "b", "c", "d" ] }
  it "should join if no connector provided" do
    expect(a.my_join).to eq("abcd")
  end

  it "should join around a connector" do
    expect(a.my_join("$")).to eq("a$b$c$d")
  end

  it "does NOT call the built-in #inject method" do
    original_array = ["original array"]
      expect(original_array).not_to receive(:inject)
    original_array.my_inject {}
  end
end

describe "#my_reverse" do

  it "reverses an array of one item" do
    expect([ 1 ].my_reverse).to eq([1])
  end

  it "reverses the string" do
    expect([ "a", "b", "c" ].my_reverse).to eq(["c", "b", "a"])
  end

  it "does NOT call the built-in #inject method" do
      original_array = ["original array"]
      expect(original_array).not_to receive(:inject)
      original_array.my_inject {}
    end
end
            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/enumerables