require 'spec_helper'

describe 'threatstackv1' do

  deploy_key = ENV['TS_DEPLOY_KEY'] ? ENV['TS_DEPLOY_KEY'] : "xKkRzesqg"
  feature_plan = ENV['TS_FEATURE_PLAN'] ? ENV['TS_FEATURE_PLAN'] : "monitor"

  context 'on Debian' do
    let(:facts) { {:osfamily => 'Debian'} }
    let(:params) { { :deploy_key => "#{deploy_key}", :feature_plan => "#{feature_plan}" } }

    it 'should compile' do should create_class('threatstackv1') end
    it { should contain_class('threatstackv1::package') }
    it { should contain_class('threatstackv1::configure') }

  end

  context 'on RedHat' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'RedHat' } }
    let(:params) { { :deploy_key => "#{deploy_key}", :feature_plan => "#{feature_plan}" } }

    it 'should compile' do should create_class('threatstackv1') end
    it { should contain_class('threatstackv1::package') }
    it { should contain_class('threatstackv1::configure') }

  end

  context 'on CentOS' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'CentOS'} }
    let(:params) { { :deploy_key => "#{deploy_key}", :feature_plan => "#{feature_plan}" } }

    it 'should compile' do should create_class('threatstackv1') end
    it { should contain_class('threatstackv1::package') }
    it { should contain_class('threatstackv1::configure') }

  end

  context 'on Amazon' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Amazon'} }
    let(:params) { { :deploy_key => "#{deploy_key}", :feature_plan => "#{feature_plan}" } }

    it 'should compile' do should create_class('threatstackv1') end
    it { should contain_class('threatstackv1::package') }
    it { should contain_class('threatstackv1::configure') }

  end



end
