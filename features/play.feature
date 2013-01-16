Feature: Play
  In order to experiment with my Evolve simulation
  I want to be able to play the simulation for a number of iterations
  So I can see the results

  Scenario: Play runs application
    When I successfully run `evolve play`
    Then the simulation should appear to run    

  Scenario: Adding the --info switch shows information messages when playing
    When I successfully run `evolve --info play`
    Then the output should contain:
      """
      Showing Information Messages
      """
    And the output should match:
      """
      Critter .* has died
      """

Scenario: Critters feed on environment
    When I successfully run `evolve --info play`
    Then the output should match:
      """
      Critter .* has fed (\d*)
      """

  @wip
  Scenario: There is a report of individual critters shown after all iterations
    When I successfully run `evolve play`
    Then the output should match:
      """
      Critter\s*HP\s*food
      """
    And the output should match:
      """
      Critter .*\s*\d+\/\d+\s*\d+\/\d+
      """
