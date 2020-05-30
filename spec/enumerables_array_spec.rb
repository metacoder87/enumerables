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
