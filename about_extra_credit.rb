# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.
require './about_dice_project'
require './about_scoring_project'

class Player
  attr_reader :name
  attr_accessor :score, :dice

  def initialize(name, dice = nil)
    @name = name
    @dice = dice
  end
end

class Game
  def initialize(players)
    @players = players
    @dice_set = DiceSet.new
  end

  def play
    puts "\n!!!START GAME!!!"
    @players.each do |player|
      puts "---------------------------------"

      # it possible to use predefined dice as the second parameter for the testing
      # or generate random unless provide
      player.dice ||= @dice_set.roll(5)
      print "#{player.name} has rolls: #{player.dice}\n"

      player.score = score(player.dice)
      print "Total score is: #{player.score}\n"
      puts "---------------------------------\n"
    end

    announce_winner
    puts "\n!!!END GAME!!!"
  end

  public

    def announce_winner
      winners = get_winners
      if winners.size > 1
        puts "There is no single winner!"
        puts "#{winners.size} players have the same total score grater than zero:"
        winners.each { |winner| puts "#{winner[:name]} has score: #{winner[:score]}" }
      elsif winners.size == 1
        puts "And the winner is: #{winners.first[:name]}, with score: #{winners.first[:score]}"
      else
        puts "!!!NO WINNER THIS TIME!!!"
      end
    end

  private

    def tournament_table
      score_table = []
      @players.each do |p|
        score_table.push({ name: p.name, score: p.score })
      end
      score_table
    end

    def get_winners
      score_table = tournament_table
      scores = score_table.map { |h| h[:score] }
      max = scores.max
      return [] if max.zero?
      score_table.select { |s| s[:score] == max }
    end
end

## test examples to test edge cases with predefined players dices

# players = [
#     Player.new("Jhon", [4, 4, 3, 4, 2]),
#     Player.new("Bob", [3, 5, 5, 3, 3]),
#     Player.new("Jane", [2, 2, 1, 2, 4]),
#     Player.new("Alice",[3, 5, 1, 1, 1])
# ]


# players = [
#     Player.new("Jhon", [4, 6, 2, 2, 3]),
#     Player.new("Bob", [1, 6, 1, 2, 6]),
#     Player.new("Jane", [4, 2, 2, 6, 3]),
#     Player.new("Alice",[4, 3, 2, 1, 1])
# ]

# players = [
#     Player.new("Jhon", [4, 6, 2, 2, 3]),
#     Player.new("Bob", [4, 6, 2, 2, 3]),
#     Player.new("Jane", [4, 2, 2, 6, 3]),
#     Player.new("Alice",[4, 6, 2, 2, 3])
# ]
#


## all players will have randomly generated dices during the game
players = [
    Player.new("Jhon"),
    Player.new("Bob"),
    Player.new("Jane"),
    Player.new("Alice")
]

Game.new(players).play
