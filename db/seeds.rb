
Product.find_or_create_by!(name: "Gentle Shampoo") do |p|
  p.description = "Cleanses without stripping moisture"
end

Product.find_or_create_by!(name: "Hydrating Conditioner") do |p|
  p.description = "Softens and detangles hair"
end

puts "Seeded #{Product.count} products"
