require 'minitest/spec'
require 'minitest/autorun'
require './exercise.rb'

describe Exercise do
  describe "#marklar" do
    it "should return a marklar'd string" do
      _(Exercise.marklar("The quick brown fox")).must_equal "The marklar marklar fox"
    end

    it "should capitalize Marklar when replacing capitalized words" do
      _(Exercise.marklar("Down goes Frazier")).must_equal "Down goes Marklar"
      _(Exercise.marklar("Monday is Martin Luther King day")).must_equal "Marklar is Marklar Marklar King day"
    end

    it "should keep end-of-word punctuation intact" do
      _(Exercise.marklar("How is the weather today? I have not been outside.")).must_equal "How is the marklar marklar? I have not been marklar."
    end
    
    it "should keep end-of-word multi-character punctuation intact" do
      _(Exercise.marklar("How is the weather today!? I have not been outside...")).must_equal "How is the marklar marklar!? I have not been marklar..."
    end
  end

  describe "#Word Replace  " do
    it "should replace when passed a true condition" do
      _(Exercise.wordReplace("tabs", true, "wyoming")).must_equal "wyoming"
      _(Exercise.wordReplace("a", true, "wyoming")).must_equal "wyoming"
      _(Exercise.wordReplace("charity", true, "wyoming")).must_equal "wyoming"
    end
    
    
    it "should not replace when passed a false condition" do
      _(Exercise.wordReplace("tabs", false, "wyoming")).must_equal "tabs"
      _(Exercise.wordReplace("a", false, "wyoming")).must_equal "a"
      _(Exercise.wordReplace("charity", false, "wyoming")).must_equal "charity"
    end

    it "should preserve punctuation at the end of the word" do
      _(Exercise.wordReplace("tabs!", true, "wyoming")).must_equal "wyoming!"
      _(Exercise.wordReplace("a?!", true, "wyoming")).must_equal "wyoming?!"
      _(Exercise.wordReplace("charity...", true, "wyoming")).must_equal "wyoming..."
    end
    
    it "should capitalize the word if the input was capitalized" do
      _(Exercise.wordReplace("Tabs", true, "wyoming")).must_equal "Wyoming"
      _(Exercise.wordReplace("A", true, "wyoming")).must_equal "Wyoming"
      _(Exercise.wordReplace("Charity", true, "wyoming")).must_equal "Wyoming"
    end
    
    it "should replace punctuation in the middle of worlds" do
      _(Exercise.wordReplace("tab's", true, "wyoming")).must_equal "wyoming"
      _(Exercise.wordReplace("a-b", true, "wyoming")).must_equal "wyoming"
      _(Exercise.wordReplace("w!out", true, "wyoming")).must_equal "wyoming"
      _(Exercise.wordReplace("w!'-out", true, "wyoming")).must_equal "wyoming"
    end

  end



  describe "#Whitespace weaving function  " do
     it " weaves words first and alternates when not whitespace led" do
      _(Exercise.weave_marklar_space(
          ["All", "good", "dogs", "go", "to", "heaven" ],
          ["\t", " ", "\r", "\n", " "],
          false).join()).must_equal ["All", "\t", "good", " ", "dogs", "\r", "go", "\n", "to", " ", "heaven"].join()
    end
     it " weaves whitespace first and alternates whenwhitespace led" do
      _(Exercise.weave_marklar_space(
          ["All", "good", "dogs", "go", "to", "heaven" ],
          ["\t", " ", "\r", "\n", " "],
          true).join()).must_equal [ "\t", "All",  " ", "good", "\r", "dogs", "\n", "go", " ", "to", "heaven"].join()
    end
    
   
  end


  describe "#RegEx function  " do
  
    SETUP = begin
      RegEx = /[^\w]*[\w'-]{5,}[^\w]*/
    end

    it "should not match any word 4 leters or smaller" do
      _(Exercise.regExTest(RegEx, "tabs")).must_equal false
      _(Exercise.regExTest(RegEx, "a")).must_equal false
      _(Exercise.regExTest(RegEx, "tab")).must_equal false
      _(Exercise.regExTest(RegEx, "bs")).must_equal false
    end

    it "should not match any word 4 leters or smaller even if they have punctuation before and after that makes them long enough" do
      _(Exercise.regExTest(RegEx, "a!!!!!")).must_equal false
    end
    
    it " ' and - that appear within a word and are surrounded count as a character for that word" do
      _(Exercise.regExTest(RegEx, "tab's")).must_equal true
      _(Exercise.regExTest(RegEx, "all-nite")).must_equal true
      _(Exercise.regExTest(RegEx, "all-hollows-night")).must_equal true
      _(Exercise.regExTest(RegEx, "Mith'ran'de'al")).must_equal true
    end
    
    it "normal words longer than 4 characters should match" do
      _(Exercise.regExTest(RegEx, "quick")).must_equal true
      _(Exercise.regExTest(RegEx, "Brown")).must_equal true
      _(Exercise.regExTest(RegEx, "fizzbang")).must_equal true
    end
    
    it "empty strings should not match" do
      _(Exercise.regExTest(RegEx, "")).must_equal false
    
    end

  end

  describe "#generate fibonacci array " do
    it "should generate an array following sequence" do
      _(Exercise.get_fibo_array(1).join(" ")).must_equal [1].join(" ")
      _(Exercise.get_fibo_array(2).join(" ")).must_equal [1, 1].join(" ")
      _(Exercise.get_fibo_array(6).join(" ")).must_equal [1, 1, 2, 3, 5, 8].join(" ")
      _(Exercise.get_fibo_array(13).join(" ")).must_equal [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233].join(" ")
    end
  end

  describe "#even_fibonacci" do
    it "should sum the even numbers in a Fibonacci sequence" do
    
      _(Exercise.even_fibonacci(0)).must_equal 0
      _(Exercise.even_fibonacci(5)).must_equal 2
      _(Exercise.even_fibonacci(11)).must_equal 44
      _(Exercise.even_fibonacci(19)).must_equal 3382
     _( Exercise.even_fibonacci(35)).must_equal 4_613_732
    end
  end
end
