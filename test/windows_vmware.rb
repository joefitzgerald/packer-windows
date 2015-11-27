require_relative 'spec_helper'

describe 'box' do
  describe 'windows box' do
    it 'should have a vagrant user' do
      expect(user 'vagrant').to exist
    end
  end

  # this tests if rsync (or at least the shared folder) works from bin/test-box-vcloud.bat
  describe file('c:/vagrant/testdir/testfile.txt') do
    it { should be_file }
    it { should contain "Works" }
  end

  # check SSH
  describe service('OpenSSH Server') do
    it { should be_installed  }
    it { should be_enabled  }
    it { should be_running  }
    it { should have_start_mode("Automatic")  }
  end
  describe port(22) do
    it { should be_listening  }
  end

  describe service('VMware Tools') do
    it { should be_installed  }
    it { should be_enabled  }
    it { should be_running  }
    it { should have_start_mode("Automatic")  }
  end

  # check WinRM
  describe port(5985) do
    it { should be_listening  }
  end

  # check RDP
  describe port(3389) do
    it { should be_listening  }
  end
  describe windows_registry_key('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\fDenyTSConnections') do
    it { should exist  }
    it { should have_property('dword value', :type_dword)  }
    it { should have_value('0')  }
  end
  describe windows_registry_key('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\UserAuthentication') do
    it { should exist  }
    it { should have_property('dword value', :type_dword)  }
    it { should have_value('0')  }
  end

  # no Windows Updates, just manual updates, but Windows updates service is running
  describe service('Windows Update') do
    it { should be_installed  }
    it { should be_enabled  }
    it { should be_running  }
    it { should have_start_mode("Automatic")  }
  end
  describe windows_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\AUOptions') do
    it { should exist  }
    it { should have_property('dword value', :type_dword)  }
    it { should have_value('1')  }
  end

  # check time zone
  describe command('& tzutil /g') do
      it { should return_stdout(/W. Europe Standard Time/)  }
  end
end
