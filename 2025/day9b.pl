use 5.036;
use List::Util 'min', 'max';
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

my $max_x = max @x;
my $max_y = max @y;
my @grid = map ' ' x ($max_x+1), 0..$max_y;

for my $i (0..$#x) {
    if ($x[$i] == $x[$i-1]) {
        substr($grid[$_], $x[$i], 1, 'x') for min($y[$i],$y[$i-1])..max($y[$i],$y[$i-1]);
    }
    else {
        substr($grid[$y[$i]], $_, 1, 'x') for min($x[$i],$x[$i-1])..max($x[$i],$x[$i-1]);
    }
}

s/x +x/'x' x length $&/ge for @grid;

my $max_area = 0;
for my $i (0..$#x) {
    J:
    for my $j (($i+1)..$#x) {
        my $area = (1+abs($x[$i]-$x[$j]))*(1+abs($y[$i]-$y[$j]));
        if ($area > $max_area) {
            my $x_length = 1+abs($x[$i]-$x[$j]);
            my $x_start = min($x[$i],$x[$j]);
            my $row = 'x' x $x_length;
            for my $y (min($y[$i],$y[$j])..max($y[$i],$y[$j])) {
                next J if $row ne substr $grid[$y], $x_start, $x_length;
            }
            $max_area = $area;
        }
    }
}

say $max_area;
# 1516172795
