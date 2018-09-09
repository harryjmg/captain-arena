# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Character.create(name: 'Luke', hp: 100, attack_points: 10, agility: 80 ,selfie_url: "https://cdn.icon-icons.com/icons2/1070/PNG/128/luke-skywalker_icon-icons.com_76939.png")
Character.create(name: 'Dark Vader', hp: 110, attack_points: 12, agility: 20, selfie_url: "https://cdn.icon-icons.com/icons2/1070/PNG/128/darth-vader_icon-icons.com_76959.png")
Character.create(name: 'Iron Man', hp: 110, attack_points: 15, agility: 50, selfie_url: "https://cdn.icon-icons.com/icons2/564/PNG/128/Iron_Man_icon-icons.com_54170.png")
Character.create(name: 'Hulk', hp: 120, attack_points: 15, agility: 0, selfie_url: "https://cdn.icon-icons.com/icons2/1412/PNG/128/comics-hulk-fist_97451.png")

Fight.create(first_fighter: Character.first, second_fighter: Character.second, p1_weapon: 'Excalibur', p2_weapon: 'Excalibur')
