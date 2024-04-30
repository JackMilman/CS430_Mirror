#!usr/bin/env ruby
def run_tests(arbitrary_class)
  arbitrary = arbitrary_class.new()
  for m in arbitrary.methods
    if m[0..4].eql? "test_"
      arbitrary.send(m)
    end
  end
end

def assert_equal(expected, actual, message)
  if expected != actual
    STDERR.puts message
    STDERR.puts "  Expected: #{expected}"
    STDERR.puts "    Actual: #{actual}"
    STDERR.puts
  end
end
  
class MathTester
  def test_round
    assert_equal(6, 5.6.round, "I tried rounding a float, but I didn't get the value I expected.")
  end

  def helper
    raise 'You shouldn\'t see this message because this method should not be automatically called by the test runner.'
  end

  def test_max
    assert_equal(3.9, [-1.1, 3.9, 3.1].max, "I tried finding the max of some values, but I didn't get the max I expected.")
  end

  def test_plus
    assert_equal(13, 4 + 9, "I tried adding two values, but I didn't get the sum I expected.")
  end

  def test_pi
    # This test fails because it's a bad test.
    assert_equal(3, Math::PI, "I tried testing pi, but it wasn't the value I expected.")
  end

  def test_abs
    assert_equal(3, -2.abs, "I tried finding the absolute value of a negative number, but did not get that number's positive counterpart.")
  end

  def test_wrong
    assert_equal(1, 2, "This method is supposed to be wrong")
  end

  # ...
end

run_tests(MathTester)