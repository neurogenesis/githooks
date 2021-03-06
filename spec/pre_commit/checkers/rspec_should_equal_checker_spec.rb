require "spec_helper"
require "support/shared_examples.rb"

load "pre_commit/checkers/rspec_should_equal_checker.rb"

RSpec.describe RspecShouldEqualChecker do
  let(:checker_class) { RspecShouldEqualChecker }

  context "code without any issues" do
    subject(:checker) { test_class_with_change(checker_class, "Hello") }
    it_should_behave_like "it finds no error"
  end

  context "code without any issues" do
    subject(:checker) { test_class_with_change(checker_class, "should eq") }
    it_should_behave_like "it finds no error"
  end

  context "code with a 'should =='" do
    subject(:checker) { test_class_with_change(checker_class, "  foo.should  == 3") }
    it_should_behave_like "it finds an error"
  end

  context "code with a 'should_not =='" do
    subject(:checker) { test_class_with_change(checker_class, "  foo.should_not  == 3") }
    it_should_behave_like "it finds an error"
  end

  context "code with an 'should !='" do
    subject(:checker) { test_class_with_change(checker_class, "  foo.should  != 3") }
    it_should_behave_like "it finds an error"
  end
end
