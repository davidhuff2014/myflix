# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(full_name: 'Dave Huff', password: 'password', email: 'David.Huff@computer-critters.com', admin: 'true')

categories = Category.create([{ name: 'TV Commedies' }, { name: 'TV Dramas' }, { name: 'Reality TV' }])

Video.create(title: 'Monk', description: 'Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.', small_cover: File.open(File.join(Rails.root, '/spec/support/uploads/monk.jpg')), large_cover: File.open(File.join(Rails.root, '/spec/support/uploads/monk_large.jpg')), category_id: 2, video_url: 'https://s3-us-west-2.amazonaws.com/davidhuff2014-myflix/MONK+-+Extended+Intro-Rwz24jB96fY.mp4')

Video.create(title: 'Family Guy', description: 'In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.', small_cover: File.open(File.join(Rails.root, '/spec/support/uploads/family_guy.jpg')), large_cover: File.open(File.join(Rails.root, '/spec/support/uploads/family_guy_large.jpg')), category_id: 1, video_url: 'https://s3-us-west-2.amazonaws.com/davidhuff2014-myflix/Family+Guy+-+Simpsons+Crossover+-+Episode+-+%27OFFICIAL+TRAILER%27-TnhcbZmmB0U.mp4')

Video.create(title: 'Futurama', description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover: File.open(File.join(Rails.root, '/spec/support/uploads/futurama.jpg')), large_cover: File.open(File.join(Rails.root, '/spec/support/uploads/futurama_large.jpg')), category_id: 1, video_url: 'https://s3-us-west-2.amazonaws.com/davidhuff2014-myflix/Futurama+-+Bender%27s+Big+Score+Trailer-oEiJ3QA4kKs.mp4')

Video.create(title: 'South Park', description: 'Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.', small_cover: File.open(File.join(Rails.root,  '/spec/support/uploads/south_park.jpg')), large_cover: File.open(File.join(Rails.root, '/spec/support/uploads/south_park_large.jpg')), category_id: 1, video_url: 'https://s3-us-west-2.amazonaws.com/davidhuff2014-myflix/South+Park+-+The+Stick+of+Truth+E3+Official+Trailer-bkZHv-9e2ro.mp4')

