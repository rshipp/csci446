# rubywarrior
# Used http://langref.org/ruby/lists/testing/any

class Player
  MAX_HEALTH = 20
  @health ||= MAX_HEALTH
  @needsrest ||= false
  @forward ||= false
    
  def play_turn(warrior)
    # Check health, reset needsrest if necessary.
    if warrior.health == MAX_HEALTH
      @needsrest = false
    end

    # If at a wall, turn around.
    if warrior.feel.wall?
        warrior.pivot!
    # Check behind.
    elsif warrior.feel(:backward).empty? && !@forward
        warrior.walk! :backward
    elsif warrior.feel(:backward).captive?
        warrior.rescue! :backward
    # Scout ahead.
    elsif warrior.look.any? { |space| space.enemy? }
        warrior.shoot!
    # Move forward.
    elsif warrior.feel.empty? && warrior.health < MAX_HEALTH && !(warrior.health < @health) && !warrior.feel.stairs?
      @needsrest = true
      warrior.rest!
    elsif warrior.feel.empty? && (warrior.health < @health) && warrior.health <= 10
      warrior.walk! :backward
    elsif warrior.feel.empty?
      @forward = true
      warrior.walk!
    elsif warrior.feel.captive?
      warrior.rescue!
    else
      warrior.attack!
    end

    @health = warrior.health
  end
end
