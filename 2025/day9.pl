use 5.036;
use List::Util 'product';
# day 9 https://adventofcode.com/2025/day/9
@ARGV = 'day9.txt' unless @ARGV;

my @x;
my @y;
while (my $row = <>) {
    my ($x,$y) = $row=~ /^(\d+),(\d+)$/a
        or die "bad: $row";
    push @x, $x;
    push @y, $y;
}

my $max_area = 0;
for my $i (0..$#x) {
    for my $j (($i+1)..$#x) {
        my $area = (1+abs($x[$i]-$x[$j]))*(1+abs($y[$i]-$y[$j]));
        $max_area = $area if $area > $max_area;
    }
}

say $max_area;
