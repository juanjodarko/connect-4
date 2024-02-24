class Array
  def safe_transpose
    max_size = self.map(&:size).max
    self.dup.map{|a| a << nil while a.size < max_size; a}.transpose
  end
end
