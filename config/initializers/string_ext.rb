class String
  def to_numeric_character_references
    self.unpack('U*').collect {|c| c >= 255 ? '&#' + c.to_s + ';' : c.chr }.join
  end
end
