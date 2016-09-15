# encoding: UTF-8

make_names = %w(CHEVROLET CITROËN FIAT FORD HONDA HYUNDAI KIA MITSUBISHI NISSAN PEUGEOT RENAULT TOYOTA VOLKSWAGEN)

make_names.each do |name|
  Make.find_or_create_by name: name
end

puts "#{make_names.size} car makes created"
