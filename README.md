# Sparrowdo::VSTS::YAML::Build::Assembly::Patch

Sparrowdo module to generate VSTS yaml build definition steps for assembly info patcher.

    $ cat sparrowfile

    module_run "VSTS::YAML::Build::Assembly::Patch", %(
      build-dir => ".build",
      version => "1.0.0" # version chunk, default value
    );

    $ sparrowdo --local_mode --no_sudo

# Author

Alexey Melezhik

