# HTW Webtech - Functional tests

This repository contains a collection of functional software tests used for the assignments
to students of "Webtentwicklung" course of HTW-Berlin.


# Usage

~~~ ruby
run `rake exercise:dev` # for dev reporting
run `rake exercise:prd` # for prod reporting
run `rake` # to spec this code
~~~


# TODOS

- [ ] Third spec sould compare Strings, e.g.
  actual_string = page.find('.css-selector').content
  expect(actual_string).to eq 'Test'
  This way its easier to debug when a test fails.

- [ ] Add desc
- [ ] Extract TestReporting from running tests
- [ ] Extract TestReporter into gem?
- [ ] Write a spec against a simple web page


# License

http://grekko.mit-license.org/
