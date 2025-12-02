use 5.036;
# day 1 https://adventofcode.com/2025/day/1
# a 0-99 (clockwise) dial starts at 50
# inputs are Lxx or Rxx to turn it left or right the indicated number of positions
# count how many times it turns to 0
@ARGV = 'day1.txt' unless @ARGV;
my $dial = 50;
my $times_zeroed = 0;
while (<>) {
    /^([LR])(\d+)$/ or die "bad: $_";
    if ($1 eq 'L') {
        $dial -= $2;
    }
    else {
        $dial += $2;
    }
    ++$times_zeroed if $dial % 100 == 0;
}
say $times_zeroed;
