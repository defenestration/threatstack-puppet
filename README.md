Threat Stack V1 Puppet Module
================

This is a fork of https://github.com/threatstack/threatstack-puppet at tag v1.8.1 as it supports the threatstack v1 client. The classes have been renamed so this can be used alongside the current module that supports v2 of the agent.  

It seems the rspec/travisci tests no longer work for the original branch and did not have luck fixing them so far. 

---

[travis]: https://travis-ci.org/threatstack/threatstack-puppet
[original module]: https://forge.puppetlabs.com/threatstack/threatstack

Puppet manifests to deploy the Threat Stack server agent.

Threat Stack is a continuous cloud security monitoring service. It aims to provide an organization greater security, compliance, and operational efficiency.  Threat Stack customers can use this module to deploy the agent and register hosts.

For more see https://www.threatstack.com.

Platforms
---------

* Amazon Linux
* CentOS
* RedHat
* Ubuntu

Classes
=======

* `threatstackv1` - Main class
* `threatstackv1::apt` (private) - Setup apt repository configuration and package install
* `threatstackv1::yum` (private) - Setup yum repository configuration and package install
* `threatstackv1::configure` (private) - Register and configure the agent with the Threat Stack service
* `threatstackv1::package` (private) - Install the Threat stack agent
* `threatstackv1::params` (private) - Default setup values
* `threatstackv1::site` (private) - Used by Puppet test-kitchen

Parameters
=====

* `threatstackv1::deploy_key` [required] - Set the deploy key for registering the agent.
* `threatstackv1::feature_plan` [required] - Threat Stack feature plan package. (https://www.threatstack.com/plans)
  * `investigate` - Investigate plan.
  * `monitor` - Monitor tier plan.
  * `legacy` - Legacy Basic, Advanced, and Pro plans.
* `threatstackv1::ruleset` [optional array] - Set the ruleset or rulesets the node will be added to (Defaults to 'Base Rule Set').
* `threatstackv1::configure_agent` [optiona bool] - Set to false to just install agent without configuring. Useful for image building.
* `threatstackv1::agent_config_args` [optional string] - Extra arguments to pass during agent activation.  Useful for enabling new platform features.

Example usage
=====
Below are some examples for how to use module.

Standard usage
===
Supply a your Threat Stack deploy key, and if you choose, an array of rulesets.
```
class { '::threatstackv1':
  deploy_key    => 'MyDeployKey',
  feature_plan  => 'investigate',
  ruleset       => ['MyRuleset']
}
```
Using a package mirror
===
If you manage your own package repository from which you deploy the agent package then supply `repo_url` and `gpg_key`.
```
class { '::threatstackv1':
  deploy_key    => 'MyDeployKey',
  feature_plan  => 'monitor',
  ruleset       => ['MyRuleset'],
  repo_url      => 'https://my-mirror.example.com/centos-6'
  gpg_key       => 'https://my-mirror.example.com/RPM-GPG-KEY-THREATSTACK'
}
```

Agent installation into golden image
===
If installing the agent into an image that will be deployed for multiple instances, configure the class to not configure the agent while creating the image.  If the agent is registered and configured in the golden image then events and alerting will not be correct.
```
class { '::threatstackv1':
  configure_agent => false,
}
```

Testing
=======
Run the following to perform basic spec testing.
```
bundle install
bundle exec rake spec
```

Integration testing requires setting `TS_DEPLOY_KEY` in the environment to a valid key value for tests to succeed.
```
export TS_DEPLOY_KEY='<deploy_key>'
bundle exec kitchen test
```

