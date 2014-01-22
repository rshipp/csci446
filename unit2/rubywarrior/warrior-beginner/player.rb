# rubywarrior
# Function: line 11, instance var: line 8, constants: line 6, array:
# line 23, comments, everywhere. No hashes or class vars.
# Used http://langref.org/ruby/lists/testing/any

class Player
  # Use some constants and instance variables.
  MAX_HEALTH ||= 20
  SAFE_HEALTH ||= 10
  @health ||= MAX_HEALTH
  @needsrest ||= false
  @forward ||= false

  def should_shoot?
    # Is there a wizard directly in front of me? (not behind a
    # captive.)
    # Look, I'm using a function! And a comment!
#    ahead = @warrior.look
#    ahead.each { |space| space = space.to_s }
#    ahead.each { |string|
#      return true if string == "Wizard"
#      return false if string == "Captive"
#    }
#    false
    # Use an array.
    @warrior.look.any? { |space| space.enemy? }
  end

  def play_turn(warrior)
    # Set up some instance variables.
    @health ||= MAX_HEALTH
    @warrior ||= warrior

    # Check health, reset needsrest if necessary.
    if warrior.health == MAX_HEALTH
      @needsrest = false
    end

    # If at a wall, turn around.
    if warrior.feel.wall?
        warrior.pivot!
    # Check behind.
    elsif warrior.feel(:backward).empty? && !@forward && !warrior.feel(:backward).stairs?
        warrior.walk! :backward
    elsif warrior.feel(:backward).captive?
        warrior.rescue! :backward
    elsif warrior.look(:backward).any? { |space| space.enemy? }
        warrior.shoot! :backward
    # If I'm backing into stairs, move forward instead to get all the
    # points.
    elsif warrior.feel(:backward).stairs?
        @forward = true
        warrior.walk!
    # Scout ahead.
    elsif should_shoot?
        warrior.shoot!
    # Move forward.
    elsif warrior.feel.empty? && warrior.health < MAX_HEALTH && !(warrior.health < @health) && !warrior.feel.stairs?
      @needsrest = true
      warrior.rest!
    elsif warrior.feel.empty? && (warrior.health < @health) && warrior.health <= SAFE_HEALTH
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
