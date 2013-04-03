require 'spec_helper'

describe 'ngircd', :type => :class do

  describe 'ngircd::package' do
    context 'install ngircd' do
      it {
        should contain_package('ngircd').with_ensure('present')
      }
    end
  end

  describe 'ngircd::service' do
    context 'start service for ngircd' do
        let :params do {
          :ng_conf_dir => '/etc',
        }
      end
      it {
        should contain_service('ngircd').with(
            {
                :enable => 'true',
                :ensure => 'running',
            }
        )
      }
    end
  end

end