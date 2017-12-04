# Domain Ownership Checker

Checks domain ownership through a text file and DNS CNAME-record

## Installation

Add gem to your Gemfile.

```ruby
gem 'domain_ownership_checker', git: 'git@github.com:RCNTEC/domain_ownership_checker.git'
```

Then run
```
    $ bundle install
```
## USAGE

First of all, you need to configure gem to use in development and test environments. For skiping real verification setup `skip_validation = true` (for default it's `false`):

```ruby
DomainOwnershipChecker.configure do |config|
  config.skip_validation = true
end
```

After that you can use gem - initialize object and call method '#verified?'. It returns true on success and false if not

```ruby
checker = DomainOwnershipChecker.new(domain: 'domain.tld', filename: 'file.txt', cname: 'cname', cname_alias: 'cname_alias')
checker.verified? #returns [Boolean] after checking
```
