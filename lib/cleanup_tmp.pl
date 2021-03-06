#!/usr/bin/perl

use strict;
use Cwd;

$ENV{'PWD'} = getcwd();

if( $ENV{'TEST_DIR'} eq "" ){
	my $cwd = getcwd();
	if( $cwd =~ /^(.+)\/lib/ ){
		$ENV{'TEST_DIR'} = $1;
	}else{
		print "ERROR !! Incorrect Current Working Directory ! \n";
		exit(1);
	};
};


system("rm -f ../prerun/*.tmp");
system("rm -f ../postrun/*.tmp");
system("rm -f ../fallback/*.tmp");


opendir( THIS, "..") or die $!;
my @dirs = readdir(THIS);

foreach my $dir ( @dirs ) {

	if( $dir =~ /stage(\d+)/ ){
		my $index = $1;
		system("rm -f ../stage" . sprintf("%02d", $index) . "/*.tmp");
	};

};

closedir(THIS);

# when it deletes the .tmp file generated by its own timed_run(), it results in error
#system("rm -f ./*.tmp");


exit(0);


# <START_DESCRIPTION>
# NAME: _cleanup_tmp
# LANGUAGE: perl
# USAGE: _cleaup_tmp
# REQUIREMENT : NONE
# DESCRIPTION : This script cleans up all the temporary .tmp files created by timed_run() command in timed_run.pl script
# <END_DESCRIPTION> 
