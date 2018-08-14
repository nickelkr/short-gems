Film.all.each do |film|
  film.update_attribute(:source, :youtube)
end
