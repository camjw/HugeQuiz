feature 'the user can enter their name and be greeted by it' do
  scenario 'on loading the page' do
    visit '/'
    fill_in(:player_name, with: 'Billy')
    click_button 'Play!'
    expect(page).to have_content 'Welcome to the Quiz, Billy!'
  end
end

feature 'the user can choose not to enter their name and still be greeted' do
  scenario 'on loading the page' do
    visit '/'
    click_button 'Play!'
    expect(page).to have_content 'Welcome to the Quiz, Stranger!'
  end
end
