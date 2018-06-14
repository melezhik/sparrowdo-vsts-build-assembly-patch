use v6;

unit module Sparrowdo::VSTS::YAML::Build::Assembly::Patch:ver<0.0.2>;

use Sparrowdo;
use Sparrowdo::Core::DSL::Template;
use Sparrowdo::Core::DSL::File;
use Sparrowdo::Core::DSL::Directory;
use Sparrowdo::Core::DSL::Bash;

our sub tasks (%args) {


  my $build-dir = %args<build-dir> || die "usage module_run '{ ::?MODULE.^name }' ,%(build-dir => dir)";

  directory "$build-dir/.cache";
  directory "$build-dir/files";

  file "$build-dir/files/AssemblyInfoPatchVersion.ps1", %( content => slurp %?RESOURCES<AssemblyInfoPatchVersion.ps1>.Str );

  my $version;

  if %args<version> {
    my $v = %args<version>;
    $version = "'\"$v.\$(Build.BuildId)\"'"
  } elsif %args<version-from> {
    my $v = %args<version-from>;
    $version = "'\"\$($v).\$(Build.BuildId)\"'"
  } else {
    $version = "'\"0.0.1.\$(Build.BuildId)\"'"
  }

  template-create "$build-dir/.cache/build.yaml.sample", %(
    source => ( slurp %?RESOURCES<build.yaml> ),
    variables => %( 
      base_dir => "$build-dir/files",
      version => $version
    )
  );

  bash "cat $build-dir/.cache/build.yaml.sample >> $build-dir/build.yaml";

}


