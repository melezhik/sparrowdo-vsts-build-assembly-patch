use File::Find;

finddepth(\&wanted);

my $r = shift or die "usage: AssemblyInfoPatchVersion.pl revision";

sub wanted {
  my $f = shift;

  # AssemblyFileVersion("2.5.0.0")

  if ($f=~/\.cs$/){
    print "patch $File::Find::fullname ...\n";
    my $cmd = 'perl -i -p -e "s{(AssemblyFileVersion.*\d+\.\d+\.\d+\.)(\d+)}[\$1\$r]g" '.$File::Find::fullname;
    system( $cmd ) == 0 or die "cannot patch $f, error executing cmd $cmd: $!";
  }
}
