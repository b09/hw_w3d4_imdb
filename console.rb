require_relative('models/castings')
require_relative('models/movies')
require_relative('models/stars')

star1 = Star.new({'first_name' => 'Super', 'last_name' => 'Man'})
star2 = Star.new({'first_name' => 'Lex', 'last_name' => 'Luther'})
star3 = Star.new({'first_name' => 'Marry', 'last_name' => 'Poppins'})
star4 = Star.new({'first_name' => 'Thomas', 'last_name' => 'Anderson'})

movie1 = Movie.new({'title' => 'Bananas', 'genre' => 'comedy', 'rating' => '4'})
movie2 = Movie.new({'title' => 'Water Bottle', 'genre' => 'drama', 'rating' => '9'})
movie3 = Movie.new({'title' => 'Coffee Cup', 'genre' => 'horror', 'rating' => '8'})
movie4 = Movie.new({'title' => 'The Charger 2', 'genre' => 'comedy', 'rating' => '9'})

star1.save()
star2.save()
star3.save()
star4.save()

movie1.save()
movie2.save()
movie3.save()
movie4.save()

casting1 = Casting.new({'fee' => '15', 'movie_id' => movie1.id, 'star_id' => star1.id})
casting2 = Casting.new({'fee' => '18', 'movie_id' => movie2.id, 'star_id' => star2.id})
casting3 = Casting.new({'fee' => '10', 'movie_id' => movie3.id, 'star_id' => star3.id})
casting4 = Casting.new({'fee' => '10', 'movie_id' => movie4.id, 'star_id' => star4.id})

=begin
the casting.save method will not work properly until stars and movies have first been saved because the casting.save method populates the columns of star.id and movie.id with the ids only when those ids have been retrieved which doesn't happen until movie.save and star.save have been called
=end


casting1.save()
casting2.save()
casting3.save()
casting4.save()

# p Movie.view_all
# p Star.view_all
# p Casting.view_all

# star1.first_name = "Adam"
# star1.update
#
# movie1.title = "The Peanuts"
# movie1.update
#
# casting1.fee = "20"
# casting1.update

movie2.delete
