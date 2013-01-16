

When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

Then /^the simulation should appear to run$/ do
  step "the output should contain:", "Simulation Starting"
  step "the output should contain:", "Simulation Complete"
end 

# Add more step definitions here
