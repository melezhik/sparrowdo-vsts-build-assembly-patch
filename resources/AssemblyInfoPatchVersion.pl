use File::Find;
use File::Spec;

my $dir = shift or die "usage: AssemblyInfoPatchVersion.pl dir revision";
my $r = shift or die "usage: AssemblyInfoPatchVersion.pl dir revision";

find( { wanted => \&wanted ,  follow => 1 }, $dir );


sub wanted {

  my $f = File::Spec->rel2abs($_);


  # AssemblyFileVersion("2.5.0.0")

  if ($f=~/\.cs$/){
    print "patch  ", $f , " ...\n";
    my $cmd = 'perl -i -p -e "BEGIN { \$r = qq{'.$r.'} }; s{(AssemblyFileVersion.*\d+\.\d+\.\d+\.)(\d+)}[\$1\$r]g" '.$f;
    print "run cmd: $cmd\n";
    system( $cmd ) == 0 or die "cannot patch $f, error executing cmd $cmd: $!";
  }
}
