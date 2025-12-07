use 5.036;
# day 7 https://adventofcode.com/2025/day/7
@ARGV = 'day7.txt' unless @ARGV;

chomp(my $tachyons = <>);
$tachyons =~ y/S./|\0/;

my $split_count = 0;
while (my $next_row = <>) {
    chomp $next_row;
    my $collision = $next_row ^. $tachyons;
    # '.'^.'|' -> 'R', '^'^.'|' -> '"'
    my $splits = $collision =~ y/"R.^/|\0/r;
    $split_count += $splits =~ y/|//;
    $tachyons = $collision =~ y/R.^"/|\0/r |. substr("\0$splits",0,-1) |. substr($splits, 1);
}
say $split_count;
