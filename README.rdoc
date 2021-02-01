== Install

Add the following to your Gemfile

  gem "ruby-pardot"

== Usage

=== Authentication

In order to use this client, an access token retrieved from Salesforce OAuth must be specified. See
the [authetication documentation on developer.pardot.com](https://developer.pardot.com/kb/authentication/) for more information.

  require "ruby-pardot"

  version = 3 # or 4
  access_token = '<access_token>' # Retrieve an access token from Salesforce using OAuth
  business_unit_id = '<business_unit_id>' # Specify the Business Unit ID of the account to access
  client = Pardot::Client.new nil, nil, nil, version, access_token, business_unit_id

Usage of the username, password, and API key authentication is deprecated and will be removed in an upcoming release.

=== Object Types

The available objects are:

* custom_fields 
* emails
* lists
* opportunities
* prospects
* users
* visitor_activities
* visitors
* visits

=== Querying Objects

http://developer.pardot.com/kb/api-version-3/querying-prospects

Most objects accept limit, offset, sort_by, and sord_order parameters

  prospects = client.prospects.query(:assigned => false, :sort_by => "last_activity_at", :limit => 20)

  prospects["total_results"] # number of prospects found

  prospects["prospect"].each do |prospect|
    puts prospect["first_name"]
  end

=== Creating, editing, and reading objects

See each individual object's API reference page for available methods

http://developer.pardot.com/kb/api-version-3/using-prospects

  prospect = client.prospects.create("user@test.com", :first_name => "John", :last_name => "Doe")

  prospect.each do |key, value|
    puts "#{key} is #{value}"
  end

=== Emails

See each individual call's [API reference page](http://developer.pardot.com/kb/api-version-3/introduction-table-of-contents).

  # Sample usage
  @pardot.emails.read_by_id(email_id)
  @pardot.emails.send_to_list(:email_template_id => template_id, 'list_ids[]' => list_id, :campaign_id => campaign_id)
  @pardot.emails.send_to_prospect(prospect_id, :campaign_id => campaign_id, :email_template_id => template_id)

=== Output formats

  client.format = "simple" # default
  client.format = "mobile"
  client.format = "full"

=== Error handling

Pardot will respond with an error message when you provide invalid parameters

  begin
    prospect = client.prospects.create("user@test.com")
  rescue Pardot::ResponseError => e
    # the request went through, but Pardot responded with an error, possibly because this email is already in use
  end

Performing API calls across the internet is inherently unsafe, so be sure to catch the exceptions

  begin
    visitor = client.visitors.query(:id_greater_than => 200)
  rescue Pardot::NetError => e
    # the API request failed
    #   - socket broke before the request was completed
    #   - pi.pardot.com is under heavy load
    #   - many number of other reasons
  end

=== License
The MIT License (MIT)
Copyright (c) 2012 Pardot

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the 
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
