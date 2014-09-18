# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(full_name: 'Dave Huff', password: 'password', email: 'David.Huff@computer-critters.com', admin: 'true')

categories = Category.create([{ name: 'TV Commedies' }, { name: 'TV Dramas' }, { name: 'Reality TV' }])

# TODO need to build up seed data for videos
Video.create(title: 'Breaking Bad - Pilot',
             description: 'A mild mannered teacher of high school chemistry learns he' +
                 'has contracted lung cancer and decides to undertake a new ' +
                 'career in the manufacture of crystal meth as a way of ' +
                 'guaranteeing financial solvency for his wife and son' +
                 'after his death.',
             small_cover: File.open(File.join(Rails.root, '/spec/support/uploads/breaking_bad_small.jpg')),
             large_cover: File.open(File.join(Rails.root, '/spec/support/uploads/breaking_bad_large.jpg')),
             category: drama,
             video_url: 'https://s3-us-west-1.amazonaws.com/brandons-myflix-dev/uploads/video/static/Authentic+Longfield+Super+Axles.mp4'
)

