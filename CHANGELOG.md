##2014-11-18 - Release 0.3.0
###Summary
This release primarily includes improvements to `git::config` and the addition of the `git_config` type&provider, along with much improved testing

####Features
- Add `user` and `scope` parameter to `git::config`
- Add `git_config` type
- Refactor `git::config` to use `git_config`
- Test improvements

####Bugfixes
- Redirect stderr to the correct place on windows

##2014-07-15 - Release 0.2.0
###Summary
This release updates metadata.json so the module can be uninstalled and
upgraded via the puppet module command.  It also lets you set the
`package_name`.

####Features
- Ability to set `package_name`

##2014-06-25 - Release 0.1.0
###Summary
This release adds git::subtree and git::config, as well as fixes up the
documentation and unit tests.

####Features
- README improvements.
- Add git::subtree class to install git-subtree.
- Add git::config resource

####Bugfixes
- Fix git_version fact.

##2011-06-03 - Release 0.0.1
- Initial commit
