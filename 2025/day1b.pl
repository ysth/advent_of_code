use 5.036;
# day 1 https://adventofcode.com/2025/day/1
# a 0-99 (clockwise) dial starts at 50
# inputs are Lxx or Rxx to turn it left or right the indicated number of positions
# count how many times it passes or turns to 0
@ARGV = 'day1.txt' unless @ARGV;
my $dial = 50;
my $times_zeroed = 0;
while (<>) {
    /^([LR])(\d+)$/ or die "bad: $_";
    if ($1 eq 'L') {
        $dial -= $2;
        $times_zeroed += int((100-$dial)/100) - ($dial == -$2);
    }
    else {
        $dial += $2;
        $times_zeroed += int($dial/100);
    }
    $dial %= 100;
}
say $times_zeroed;
