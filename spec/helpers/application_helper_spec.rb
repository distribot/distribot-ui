require 'spec_helper'

describe ApplicationHelper do
  describe '#active_nav' do
    context 'when @active_nav' do
      context 'is matches the current' do
        before do
          @active_nav = :foo
        end
        it 'returns the active' do
          expect(helper.active_nav(:foo)).to eq 'active'
        end
      end
      context 'does not match' do
        before do
          @active_nav = :bar
        end
        it 'returns empty' do
          expect(helper.active_nav(:foo)).to eq ''
        end
      end
    end
  end
end
