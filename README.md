# chef_ec2_tags
Simple ruby module to use with chef to get AWS instance tags for use in
a chef cookbook

## Usage ##

Simply place "amazon_helpers.rb" into your "libraries" folder inside a
cookbook.

Then place the following code in your default recipe:

`extend Amazon::Helpers`


To use the "get_tag" method simply use:

`myvar = get_tag("tag_name")`

This is useful if you keep role or environment information inside EC2
tags.
