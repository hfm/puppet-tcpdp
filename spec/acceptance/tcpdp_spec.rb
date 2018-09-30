require 'spec_helper_acceptance'

describe 'tcpdp class' do
  let(:manifest) do
    <<-EOS
      include ::tcpdp
    EOS
  end

  it 'runs without errors' do
    expect(apply_manifest(manifest, catch_failures: true).exit_code).to eq 2
  end

  it 'runs a second time without changes' do
    expect(apply_manifest(manifest).exit_code).to be_zero
  end

  describe file('/usr/bin/tcpdp') do
    it { is_expected.to be_executable }
  end

  describe file('/etc/tcpdp.toml') do
    it { is_expected.to be_file }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into 'root' }
  end
end
