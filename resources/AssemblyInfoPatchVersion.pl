use File::Find;

my $r = shift or die "usage: AssemblyInfoPatchVersion.pl revision";

find( { wanted => \&wanted ,  follow => 1 }, ".");


sub wanted {

  my $f = $_;


  # AssemblyFileVersion("2.5.0.0")

  if ($f=~/\.cs$/){
    print "patch  ", $File::Find::fullname , " ...\n";
    my $cmd = 'perl -i -p -e "BEGIN { \$r = qq{'.$r.'} }; s{(AssemblyFileVersion.*\d+\.\d+\.\d+\.)(\d+)}[\$1\$r]g" '.($File::Find::fullname);
    print "run cmd: $cmd\n";
    system( $cmd ) == 0 or die "cannot patch $f, error executing cmd $cmd: $!";
  }
}
