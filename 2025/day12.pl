use 5.042;

# day 12 https://adventofcode.com/2025/day/12

use ARGV::OrDATA;
use List::Util 'sum';

my @shape;
my @grid;
while (my $input = <>) {
    if ($input =~ /x/) {
        my ($x, $y, $counts) = $input =~ /^(\d+)x(\d+):((?: \d+)+)$/a
            or die "bad $input ";
        my @counts = split ' ', $counts;
        die "expected ".@shape." counts:$counts " if @counts != @shape;
        push @grid, {
            x => $x,
            y => $y,
            counts => \@counts,
        };
    }
    elsif ($input =~ /:/) {
        my ($shape_number) = $input =~ /^(\d+):$/a
            or die "bad $input ";
        die "expected shape number ".@shape.", got: $input " if $shape_number != @shape;
        push @shape, [];
    }
    elsif ($input =~ /./) {
        my ($shape_row) = $input =~ /^([#.]+)$/
            or die "bad shape row $input ";
        die "no shapes to add to" unless @shape;
        die "inconsistent shape width: $shape_row " if $shape[-1]->@* && length $shape[-1][-1] != length $shape_row;
        push $shape[-1]->@*, $shape_row;
    }
}

my @min_area = map join('',@$_)=~y/#//, @shape;

my $ok = 0;
my $nok = 0;
my $total = 0;
for my $grid (@grid) {
    ++$total;

    # impossible?
    if ($grid->{'x'} * $grid->{'y'} < sum(map $grid->{'counts'}[$_]*$min_area[$_], 0..$#shape)) {
        ++$nok;
    }
    # definitely ok? assumes 3x3
    elsif (int($grid->{'x'}/3) * int($grid->{'y'}/3) >= sum($grid->{'counts'}->@*)) {
        ++$ok;
    }
}
say "ok: $ok nok: $nok maybe: ",$total-$ok-$nok;

__DATA__
0:
###
##.
##.

1:
###
##.
.##

2:
.##
###
##.

3:
##.
###
##.

4:
###
#..
###

5:
###
.#.
###

4x4: 0 0 0 0 2 0
12x5: 1 0 1 0 2 2
12x5: 1 0 1 0 3 2


