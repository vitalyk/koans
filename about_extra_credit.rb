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
  attr_accessor :score

  def initialize(name)
    @name = name
  end
end

class Game
  def initialize(players)
    @players = players
    @dice_set = DiceSet.new
  end

  def play
    puts "!!!START GAME!!!"
    @players.each do |player|
      puts "---------------------------------"

      dice = @dice_set.roll(5)
      print "#{player.name} has rolls: #{dice}\n"

      player.score = score(dice)
      print "Total score is: #{player.score}\n"
      puts "---------------------------------\n"
    end

    show_winner
    puts "!!!END GAME!!!"
  end

  public

    def show_winner
      multiple_winners = check_if_more_than_one_winner

      if multiple_winners
        puts "There are #{multiple_winners.size} winners!"
        multiple_winners.each_with_index do |winner, index|
          puts "Winner #{index + 1 } is: #{winner[:name]} with score: #{winner[:score]}"
        end
      else
        winner = tournament_table.max_by {|table| table[:score] }
        puts "Winner is: #{winner[:name]} with score: #{winner[:score]}"
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

    def check_if_more_than_one_winner
      score_table = tournament_table
      scores = score_table.map { |h| h[:score] }
      the_same = scores.detect { |v| scores.count(v) > 1 }
      score_table.select { |s| s[:score] == the_same } if the_same
    end
end

players = [ Player.new("Jhon"), Player.new("Bob") ]
Game.new(players).play
