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

  describe 'ngircd::config' do
    context 'generate example ngircd.conf file using variables' do
      let :params do {
          :adminemail => 'root@localhost.localdomain',
      }
      end
      it {
        should contain_file('/etc/ngircd.conf').with(
            {
                :ensure  => 'file',
                :notify  => 'Service[ngircd]'
            }
        )
        should contain_file('/etc/ngircd.conf').with_content(/root@localhost.localdomain/)
      }
    end
  end

end