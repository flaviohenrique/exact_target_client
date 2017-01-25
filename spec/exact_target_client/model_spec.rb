RSpec.describe ExactTargetClient::Model do
  subject(:model) { described_class.new }


  describe '#save' do
    subject(:do_save) { model.save(table_name, data, valid_data) }

    let(:key) { '36C9226A-7406-4985-A316-719D0A3B8498' }

    let(:token) { 'some_token' }

    let!(:stub) { stub_request(:post, %r{https:\/\/www.exacttargetapis.com}) }

    let(:table_name) { 'orders' }
    let(:data) { { values: { name: '1' } } }
    let(:valid_data) { false }

    it 'expect to call client with key on url' do
      url = 'https://www.exacttargetapis.com/hub/v1/dataevents/' \
            'key:36C9226A-7406-4985-A316-719D0A3B8498/rowset'

      do_save

      expect(a_request(:post, url)).to have_been_made.once
    end

    it 'expect to call client with data as json array' do
      result = { values: { name: '1', valid: valid_data } }
      body = [result].to_json

      do_save

      expect(stub.with(body: body)).to have_been_made.once
    end

    context 'with pre generated token' do
      before do
        ExactTargetClient.cache.set('exact_target_api_token', token)
      end

      it 'expect to use token to authentication' do
        headers = { 'Authorization' => 'Bearer some_token' }

        do_save

        expect(stub.with(headers: headers)).to have_been_made.once
      end
    end

    context 'without pre generated token' do
      before do
        ExactTargetClient.cache.set('exact_target_api_token', nil)

        allow_any_instance_of(ExactTargetClient::Authentication).to receive(:token) { token }
      end

      it 'expect to dont use token to authentication' do
        headers = { 'Authorization' => 'Bearer' }

        do_save

        expect(stub.with(headers: headers)).to have_been_made.once
      end

      context 'when get an authentication error' do
        before do
          stub.to_return(status: 401)
        end

        it 'expect to retry tree times before raise error' do
          expect { do_save }.to raise_error(RestClient::Unauthorized)

          expect(stub).to have_been_made.times(3)
        end

        it 'expect to save a new token when retry' do
          ExactTargetClient.cache.set('exact_target_api_token', nil)

          expect { do_save }.to raise_error(RestClient::Unauthorized)

          expect(ExactTargetClient.cache.get('exact_target_api_token')).to eq token
        end

      end

      context 'when get an server error' do
        before do
          stub.to_return(status: 500)
        end

        it 'expect to retry dont retry before raise error' do
          expect { do_save }.to raise_error(RestClient::InternalServerError)

          expect(stub).to have_been_made.once
        end
      end
    end
  end
end
