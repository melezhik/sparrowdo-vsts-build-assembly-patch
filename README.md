# Sparrowdo::VSTS::YAML::Build::Assembly::Patch

Sparrowdo module to generate VSTS yaml build definition steps for assembly info patcher.

    $ cat sparrowfile

    module_run "VSTS::YAML::Build::Assembly::Patch", %(
      build-dir => ".build",
      version => "1.0.0" # version pattern, default value
    );

    $ sparrowdo --local_mode --no_sudo

# Setting version pattern.

Choose one of two options:

* `version` parameter

Sets version pattern.

* `version-from` parameter

Sets name of build variable from where version pattern is read.


# Author

Alexey Melezhik

