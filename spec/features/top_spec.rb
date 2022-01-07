require "rails_helper"

RSpec.describe "top", type: :feature do
  pending "add some examples to (or delete) #{__FILE__}"

  let!(:customer) { FactoryBot.create(:customer) }
  let!(:question) { FactoryBot.create(:question) }

  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
        expect(page).to have_link "", href: questions_path
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

end
