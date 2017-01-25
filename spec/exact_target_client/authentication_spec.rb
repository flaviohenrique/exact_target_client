RSpec.describe ExactTargetClient::Authentication do
  subject(:authentication) { described_class.new }

  describe '#token' do
    subject(:call_token) { authentication.token }

    let(:reponse_body) { '{ "accessToken" : "6JDkBg6GgFzni7HQ1d74xzvS", "expiresIn" : 3479 }' }

    before do
      stub_request(:post, described_class::AUTH_URL).to_return(body: reponse_body)
    end

    context 'with client' do
      let(:auth_data) do
        { clientId: '99999999999999999999999', clientSecret: '888888888888888888888888' }
      end

      it 'expect to call with id and secret' do
        call_token

        expect(a_request(:post, described_class::AUTH_URL)
          .with(body: auth_data.to_json))
          .to have_been_made.once
      end
    end

    context 'with api response' do
      it 'expect to return access token' do
        expect(call_token).to eq('6JDkBg6GgFzni7HQ1d74xzvS')
      end

    end
  end
end
