feature 'the user is greeted' do
  scenario 'on loading the page' do
    visit '/'
    expect(page).to have_content 'Welcome to the Quiz!'
  end
end
