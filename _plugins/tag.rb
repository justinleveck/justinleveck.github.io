class Tag
  def self.format(tag)
    tag.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end