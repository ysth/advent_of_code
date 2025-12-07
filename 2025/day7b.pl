use 5.036;
use List::Util 'sum';
# day 7 https://adventofcode.com/2025/day/7
@ARGV = 'day7.txt' unless @ARGV;

chomp(my $tachyons = <>);
$tachyons =~ y/S./|\0/;
my @worlds = map ord ? 1 : 0, split //, $tachyons;
while (my $next_row = <>) {
    chomp $next_row;
    my $collision = $next_row ^. $tachyons;
    # '.'^.'|' -> 'R', '^'^.'|' -> '"'
    my $splits = $collision =~ y/"R.^/|\0/r;
    while ($splits =~ /\|/g) {
        my $position = $-[0];
        $worlds[$position-1] += $worlds[$position];
        $worlds[$position+1] += $worlds[$position];
        $worlds[$position] = 0;
    }
    $tachyons = $collision =~ y/R.^"/|\0/r |. substr("\0$splits",0,-1) |. substr($splits, 1);
}
say sum @worlds;
