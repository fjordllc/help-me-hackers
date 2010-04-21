Given /^the following tops:$/ do |tops|
  Top.create!(tops.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) top$/ do |pos|
  visit tops_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following tops:$/ do |expected_tops_table|
  expected_tops_table.diff!(tableish('table tr', 'td,th'))
end
