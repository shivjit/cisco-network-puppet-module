###############################################################################
# Copyright (c) 2014-2015 Cisco and/or its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################
# OSPFVRF Utility Library: 
# ------------------------
# ospfintflib.rb
#  
# This is the utility library for the OSPFINTF provider Beaker test cases that 
# contains the common methods used across the OSPFINTF testsuite's cases. The  
# library is implemented as a module with related methods and constants defined
# inside it for use as a namespace. All of the methods are defined as module 
# methods.
#
# Every Beaker OSPFINTF test case that runs an instance of Beaker::TestCase 
# requires OspfIntfLib module.
# 
# The module has a single set of methods:
# A. Methods to create manifests for cisco_intf_ospf Puppet provider test cases.
###############################################################################

# Require UtilityLib.rb path.
require File.expand_path("../../lib/utilitylib.rb", __FILE__)

module OspfIntfLib

  # Group of Constants used in negative tests for OSPFINTF provider.
  COST_NEGATIVE              = '-1'
  HELLOINTERVAL_NEGATIVE     = '-1'
  DEADINTERVAL_NEGATIVE      = '-1'
  PASSIVEINTF_NEGATIVE       = 'invalid'

  # A. Methods to create manifests for cisco_intf_ospf Puppet provider test cases.

  # Method to create a manifest for OSPFINTF resource attribute 'ensure' where
  # 'ensure' is set to present.
  # @param none [None] No input parameters exist. 
  # @result none [None] Returns no object.
  def OspfIntfLib.create_ospfintf_manifest_present()
    manifest_str = "cat <<EOF >#{UtilityLib::PUPPETMASTER_MANIFESTPATH}
node default {
  cisco_ospf { 'test':
    ensure                   => present,
  }

  cisco_interface { 'ethernet1/4':
    switchport_mode          => disabled,
  }

  cisco_interface_ospf { 'ethernet1/4 test':
    ensure                   => present,
    area                     => '1',
    cost                     => '1',
    hello_interval           => 'default',
    dead_interval            => 'default',
    passive_interface        => 'false',
  }
}
EOF"
    return manifest_str
  end

  # Method to configure the given area inside a manifest for ensure present
  # @param area is used to set the area for the manifest
  # @param intf is used to optionally specify the interface to use
  # @result manifest_str is the newly constructed manifest
  def OspfIntfLib.create_ospfintf_area_manifest(area, intf='ethernet1/4')
    manifest_str = "cat <<EOF >#{UtilityLib::PUPPETMASTER_MANIFESTPATH}
node default {
  cisco_ospf { 'test':
    ensure                   => present,
  }

  cisco_interface { '#{intf}':
    switchport_mode          => disabled,
  }

  cisco_interface_ospf { '#{intf} test':
    ensure                   => present,
    area                     => '#{area}',
  }
}
EOF"
    return manifest_str
  end

  # Method to create a manifest for OSPFINTF resource attribute 'ensure' where
  # 'ensure' is set to absent.
  # @param none [None] No input parameters exist. 
  # @result none [None] Returns no object.
  def OspfIntfLib.create_ospfintf_manifest_absent()
    manifest_str = "cat <<EOF >#{UtilityLib::PUPPETMASTER_MANIFESTPATH}
node default {
  cisco_interface_ospf { 'ethernet1/4 test':
    ensure                   => absent,
  }

  cisco_ospf { 'test':
    ensure                   => absent,
  }
}
EOF"
    return manifest_str
  end

  # Method to create a manifest for OSPFINTF resource attributes:
  # ensure, cost, dead_interval, hello_interval, area and passive_interface.
  # @param none [None] No input parameters exist. 
  # @result none [None] Returns no object.
  def OspfIntfLib.create_ospfintf_manifest_nondefaults()
    manifest_str = "cat <<EOF >#{UtilityLib::PUPPETMASTER_MANIFESTPATH}
node default {
  cisco_ospf { 'test':
    ensure                   => present,
  }

  cisco_interface { 'ethernet1/4':
    switchport_mode          => disabled,
  }

  cisco_interface_ospf { 'ethernet1/4 test':
    ensure                   => present,
    area                     => '100',
    cost                     => '100',
    hello_interval           => '20',
    dead_interval            => '80',
    passive_interface        => 'true',
  }
}
EOF"
    return manifest_str
  end

  # Method to create a manifest for OSPFINTF resource attribute 'cost'.
  # @param none [None] No input parameters exist. 
  # @result none [None] Returns no object.
  def OspfIntfLib.create_ospfintf_manifest_cost_negative()
    manifest_str = "cat <<EOF >#{UtilityLib::PUPPETMASTER_MANIFESTPATH}
node default {
  cisco_ospf { 'test':
    ensure                   => present,
  }

  cisco_interface { 'ethernet1/4':
    switchport_mode          => disabled,
  }

  cisco_interface_ospf { 'ethernet1/4 test':
    ensure                   => present,
    area                     => 1,
    cost                     => #{OspfIntfLib::COST_NEGATIVE},
  }
}
EOF"
    return manifest_str
  end

  # Method to create a manifest for OSPFINTF resource attribute 'hello_interval'.
  # @param none [None] No input parameters exist. 
  # @result none [None] Returns no object.
  def OspfIntfLib.create_ospfintf_manifest_hellointerval_negative()
    manifest_str = "cat <<EOF >#{UtilityLib::PUPPETMASTER_MANIFESTPATH}
node default {
  cisco_ospf { 'test':
    ensure                   => present,
  }

  cisco_interface { 'ethernet1/4':
    switchport_mode          => disabled,
  }

  cisco_interface_ospf { 'ethernet1/4 test':
    ensure                   => present,
    hello_interval           => #{OspfIntfLib::HELLOINTERVAL_NEGATIVE},
  }
}
EOF"
    return manifest_str
  end

  # Method to create a manifest for OSPFINTF resource attribute 'dead_interval'.
  # @param none [None] No input parameters exist. 
  # @result none [None] Returns no object.
  def OspfIntfLib.create_ospfintf_manifest_deadinterval_negative()
    manifest_str = "cat <<EOF >#{UtilityLib::PUPPETMASTER_MANIFESTPATH}
node default {
  cisco_ospf { 'test':
    ensure                   => present,
  }

  cisco_interface { 'ethernet1/4':
    switchport_mode          => disabled,
  }

  cisco_interface_ospf { 'ethernet1/4 test':
    ensure                   => present,
    dead_interval            => #{OspfIntfLib::DEADINTERVAL_NEGATIVE},
  }
}
EOF"
    return manifest_str
  end

  # Method to create a manifest for OSPFINTF resource attribute 'passive_intf'.
  # @param none [None] No input parameters exist. 
  # @result none [None] Returns no object.
  def OspfIntfLib.create_ospfintf_manifest_passiveintf_negative()
    manifest_str = "cat <<EOF >#{UtilityLib::PUPPETMASTER_MANIFESTPATH}
node default {
  cisco_ospf { 'test':
    ensure                   => present,
  }

  cisco_interface { 'ethernet1/4':
    switchport_mode          => disabled,
  }

  cisco_interface_ospf { 'ethernet1/4 test':
    ensure                   => present,
    passive_interface        => #{OspfIntfLib::PASSIVEINTF_NEGATIVE},
  }
}
EOF"
    return manifest_str
  end

end
