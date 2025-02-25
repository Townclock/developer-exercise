class Exercise

  @@marklar_regex = /(?:(?<=\w)[\W]+(?=\w)|[\w]){5,}/
      # find a substring that is constructed out of (non-word characters sandwiched between word characters) or (word characters) and match if its at least 5 characters long

  def self.get_marklar_regex()
    return @@marklar_regex
  end

  # Assume that "str" is a sequence of words separated by spaces.
  # Return a string in which every word in "str" that exceeds 4 characters is replaced with "marklar".
  # If the word being replaced has a capital first letter, it should instead be replaced with "Marklar".
  def self.marklar(str)
    source_array = str.split(/\s+/).filter{|e| e != ""}           # break input away into word tokens by splitting on whitespace             and filter out the empty character
    whitespace_array = str.split(/\S+/).filter{|e| e != ""}       # find and preserve the white space by splitting on non-whitespace         and filter out the empty character
    leads_with_space = /^\s$/.match?(str[0])                      # note if there was any leading whitespace
    
    target_array = Array.new      
    
    regex = @@marklar_regex
    
      
    source_array.each { |word| target_array.push(self.wordReplace(word, self.regExTest(regex, word), 'marklar'))}
    return self.weave_marklar_space(target_array, whitespace_array, leads_with_space).join();
    
  end
  
  # separated as a function for eas of testing
  def self.regExTest(regex, word)
    return regex.match?(word)
  end 
  
  # function to re-interpolate whitespace characters with updated words
  def self.weave_marklar_space(target_array, whitespace_array, leads_with_space)
    woven_array = Array.new
    if leads_with_space 
      lead_array = whitespace_array
      follow_array = target_array
    else
      lead_array = target_array
      follow_array = whitespace_array
    end
    while lead_array.length + follow_array.length > 0 do
      pick = lead_array.shift()
      if pick != nil 
       woven_array.push(pick) 
      end   
      pick = follow_array.shift()
      if pick != nil 
        woven_array.push(pick)
      end
    end
   return woven_array
  end
  
  
  
  # three unspecified edge cases are hyphenated words, 's possessive forms, and contractions: extra-fun,  freds', and don't.  
  def self.wordReplace(word, condition, replacement)
    if condition 
      
      partition = word.partition(/(?:(?<=\w)[\W]+(?=\w)|[\w])+/) 
      # find a substring that is constructed out of (non-word characters sandwiched between word characters) or (word characters)
      
      
      if /[A-Z].*/.match?(partition[1])                 # if the character portion is capitalized
        partition[1] = replacement.capitalize!          # replace with capitalized word
        return partition.join();
      else 
        partition[1] = replacement                      # replace with non-capitalized word 
        return partition.join();
      end   
    else 
        return word
    end
  end


  # Get an array from the nth fibonacci number
  def self.get_fibo_array(n) 
    array = Array.new
    for i in 1..n do
      if i <= 2 
        array.push(1)
      else
        array.push(array[i-2] + array[i-3])
      end
    end
    return array
  end
  
  # Sums all integers in an array.
  def self.sum_array(int_array)
    total = 0
    int_array.each{|int| total += int}
    return total
  end

  # Return the sum of all even numbers in the Fibonacci sequence, up to
  # the "nth" term in the sequence
  # eg. the Fibonacci sequence up to 6 terms is (1, 1, 2, 3, 5, 8),
  # and the sum of its even numbers is (2 + 8) = 10
  def self.even_fibonacci(nth)
  
  return sum_array(self.get_fibo_array(nth).select {|number| number.remainder(2)== 0})
  
  end

end


