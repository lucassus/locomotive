# Usage:
#
# describe 'A feature' do
#   specify { page.should have_flash_message('foo') }
# end
RSpec::Matchers.define :display_flash_message do |text|
  match do
    within 'div.flash' do
      page.should have_content(text)
    end
  end

  description do
    "have the following flash message: '#{text.inspect}'"
  end
end
