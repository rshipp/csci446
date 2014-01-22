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

    # Check behind.
    if warrior.feel(:backward).empty? && !@forward
        warrior.walk! :backward
    elsif warrior.feel(:backward).captive?
        warrior.rescue! :backward
    # Move forward.
    elsif warrior.feel.empty? && warrior.health < MAX_HEALTH && !(warrior.health < @health)
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
