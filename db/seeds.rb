# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts '== Start seeding'
puts `rails 'pug:add_contract[421614,0x0034607daf9c1dc6628f6e09e81bb232b6603a89]'`
puts `rails 'pug:add_contract[421614,0x007eed6207c9af3715964fb7f8b5f44e002a3498]'`
puts `rails 'pug:add_contract[421614,0x0002396f1d52323fcd1ae8079b38808f046882c3]'`
puts `rails 'pug:add_contract[421614,0x00945C032A37454333d7044a52a5A42Aa0f6c608]'`
puts `rails 'pug:add_contract[44,0x0034607daf9c1dc6628f6e09e81bb232b6603a89]'`
puts `rails 'pug:add_contract[44,0x007eed6207c9af3715964fb7f8b5f44e002a3498]'`
puts `rails 'pug:add_contract[44,0x0002396f1d52323fcd1ae8079b38808f046882c3]'`
puts `rails 'pug:add_contract[44,0x00945C032A37454333d7044a52a5A42Aa0f6c608]'`
